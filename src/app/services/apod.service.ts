import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment';

export interface ApodData {
  date: string;
  title: string;
  explanation: string;
  url: string;
  media_type: string;
  thumbnail_url?: string;
  copyright?: string;
}

@Injectable({
  providedIn: 'root'
})
export class ApodService {
  private readonly http = inject(HttpClient);
  private readonly apiUrl = `${environment.apiBaseUrl}/apod`;

  getTodayApod(): Observable<ApodData> {
    return this.http.get<ApodData>(this.apiUrl);
  }

  getApodByDate(date: string): Observable<ApodData> {
    const params = new HttpParams().set('date', date);
    return this.http.get<ApodData>(this.apiUrl, { params });
  }

  getApodRange(startDate: string, endDate: string): Observable<ApodData[]> {
    const params = new HttpParams()
      .set('start_date', startDate)
      .set('end_date', endDate);
    return this.http.get<ApodData[]>(`${this.apiUrl}/range`, { params });
  }

  getRecentApods(days: number): Observable<ApodData[]> {
    const today = new Date();
    const startDate = new Date(today);
    startDate.setDate(today.getDate() - days);

    return this.getApodRange(
      this.formatDate(startDate),
      this.formatDate(today)
    );
  }

  private formatDate(date: Date): string {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
  }
}
