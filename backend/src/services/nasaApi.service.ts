import { config } from '../config/index.js';
import type { ApodData, EonetEvent } from '../types/index.js';

const NASA_BASE = 'https://api.nasa.gov';
const EONET_BASE = 'https://eonet.gsfc.nasa.gov/api/v2.1';

export async function fetchApod(date?: string): Promise<ApodData> {
    const params = new URLSearchParams({ api_key: config.nasaApiKey });
    if (date) params.set('date', date);
    const res = await fetch(`${NASA_BASE}/planetary/apod?${params}`);
    if (!res.ok) throw new Error(`NASA APOD error: ${res.status}`);
    return res.json() as Promise<ApodData>;
}

export async function fetchApodRange(startDate: string, endDate: string): Promise<ApodData[]> {
    const params = new URLSearchParams({
        api_key: config.nasaApiKey,
        start_date: startDate,
        end_date: endDate,
    });
    const res = await fetch(`${NASA_BASE}/planetary/apod?${params}`);
    if (!res.ok) throw new Error(`NASA APOD range error: ${res.status}`);
    return res.json() as Promise<ApodData[]>;
}

export async function fetchApodRandom(count: number): Promise<ApodData[]> {
    const params = new URLSearchParams({
        api_key: config.nasaApiKey,
        count: String(count),
    });
    const res = await fetch(`${NASA_BASE}/planetary/apod?${params}`);
    if (!res.ok) throw new Error(`NASA APOD random error: ${res.status}`);
    return res.json() as Promise<ApodData[]>;
}

export async function fetchNaturalEvents(
    limit: number,
    days: number,
): Promise<{ events: EonetEvent[] }> {
    const res = await fetch(`${EONET_BASE}/events?limit=${limit}&days=${days}`);
    if (!res.ok) throw new Error(`EONET error: ${res.status}`);
    const data = (await res.json()) as { events: EonetEvent[] };
    return { events: data.events.slice(0, limit) };
}
