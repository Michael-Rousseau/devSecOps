import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment';

export interface ApodResult {
    title: string;
    explanation: string;
    url: string;
    media_type: string;
    date: string;
}

export interface EonetEvent {
    id: string;
    title: string;
    categories: { title: string }[];
    sources: { id: string; url: string }[];
    geometries: { date: string; coordinates: number[] }[];
}

export interface MoonLayer {
    id: string;
    name: string;
    urlTemplate: string;
    attribution: string;
}

@Injectable({ providedIn: 'root' })
export class NasaService {
    private readonly http = inject(HttpClient);
    private readonly apiUrl = environment.apiBaseUrl;

    private readonly moonLayers: MoonLayer[] = [
        {
            id: 'LRO_WAC',
            name: 'Moon (LRO WAC Mosaic)',
            urlTemplate:
                'https://trek.nasa.gov/tiles/Moon/EQ/LRO_WAC_Mosaic_Global_303ppd_v02/1.0.0/default/default028mm/{z}/{y}/{x}.jpg',
            attribution: 'NASA/LRO WAC',
        },
    ];
    getAvailableLayers(): MoonLayer[] {
        return this.moonLayers;
    }

    getApod(): Observable<ApodResult> {
        return this.http.get<ApodResult>(`${this.apiUrl}/apod`);
    }

    getApodGallery(): Observable<ApodResult[]> {
        return this.http.get<ApodResult[]>(`${this.apiUrl}/apod/random?count=6`);
    }

    getNaturalEvents(limit = 20, days = 20): Observable<{ events: EonetEvent[] }> {
        return this.http.get<{ events: EonetEvent[] }>(
            `${this.apiUrl}/events?limit=${limit}&days=${days}`,
        );
    }
}
