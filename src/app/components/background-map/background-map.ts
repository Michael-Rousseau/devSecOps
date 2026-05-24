import {
    Component,
    input,
    effect,
    ElementRef,
    viewChild,
    OnDestroy,
    AfterViewInit,
} from '@angular/core';
import { CommonModule } from '@angular/common';
import * as L from 'leaflet';
import { MoonLayer } from '../../services/nasa.service';

@Component({
    selector: 'app-background-map',
    standalone: true,
    imports: [CommonModule],
    template: `<div #mapContainer class="map-container"></div>`,
    styles: [
        `
            .map-container {
                position: fixed;
                top: 0;
                left: 0;
                width: 100vw;
                height: 100vh;
                z-index: 0;
                background: #000;
            }
        `,
    ],
})
export class BackgroundMapComponent implements AfterViewInit, OnDestroy {
    activeLayer = input.required<MoonLayer>();

    private mapContainer = viewChild.required<ElementRef>('mapContainer');
    private map: L.Map | undefined;
    private tileLayer: L.TileLayer | undefined;

    constructor() {
        effect(() => {
            const layer = this.activeLayer();
            if (this.map) {
                this.updateLayer(layer);
            }
        });
    }

    ngAfterViewInit() {
        this.initMap();
    }

    private initMap() {
        this.map = L.map(this.mapContainer().nativeElement, {
            crs: L.CRS.EPSG4326,
            zoomControl: false,
            attributionControl: false,
            scrollWheelZoom: false,
            doubleClickZoom: false,
            dragging: true,
            center: [0, 0],
            zoom: 2,
            minZoom: 0,
            maxZoom: 5,
            maxBounds: [
                [-90, -180],
                [90, 180],
            ],
        });

        this.updateLayer(this.activeLayer());
    }

    private updateLayer(layer: MoonLayer) {
        if (!this.map) return;

        if (this.tileLayer) {
            this.map.removeLayer(this.tileLayer);
        }

        this.tileLayer = L.tileLayer(layer.urlTemplate, {
            noWrap: true,
            bounds: [
                [-90, -180],
                [90, 180],
            ],
            minZoom: 0,
            maxZoom: 5,
            tileSize: 256,
            errorTileUrl: '',
        }).addTo(this.map);
    }

    ngOnDestroy() {
        if (this.map) {
            this.map.remove();
        }
    }
}
