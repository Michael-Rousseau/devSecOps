import { Component, inject, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ApodComponent } from '../apod-component/apod-component';
import { EventListComponent } from '../event-list-component/event-list-component';
import { BackgroundMapComponent } from '../background-map/background-map';
import { EonetEvent, MoonLayer, NasaService } from '../../services/nasa.service';
import { Observable } from 'rxjs';

@Component({
    selector: 'app-dashboard-component',
    standalone: true,
    imports: [CommonModule, ApodComponent, EventListComponent, BackgroundMapComponent],
    templateUrl: './dashboard-component.html',
    styleUrls: ['./dashboard-component.css'],
})
export class DashboardComponent {
    private readonly nasa = inject(NasaService);

    apod$ = this.nasa.getApod();

    events$: Observable<{ events: EonetEvent[] }> = this.nasa.getNaturalEvents(100, 365);

    availableLayers = this.nasa.getAvailableLayers();
    currentLayer = signal<MoonLayer>(this.availableLayers[0]);

    refreshEvents() {
        // filtering done by client swide in event list
    }

    changeBg(event: Event) {
        const target = event.target as HTMLSelectElement;
        const selected = this.availableLayers.find((l) => l.id === target.value);
        if (selected) {
            this.currentLayer.set(selected);
        }
    }

    handleApodSearch(query: string) {
        //FIXME: implem search cannot be done by string...
        console.log('Search:', query);
    }
}
