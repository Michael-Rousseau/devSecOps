export interface ApodData {
    date: string;
    title: string;
    explanation: string;
    url: string;
    media_type: string;
    thumbnail_url?: string;
    copyright?: string;
}

export interface EonetEvent {
    id: string;
    title: string;
    categories: { title: string }[];
    sources: { id: string; url: string }[];
    geometries: { date: string; coordinates: number[] }[];
}

export interface Favorite {
    id: number;
    user_id: string;
    apod_date: string;
    title: string | null;
    url: string | null;
    created_at: Date;
}
