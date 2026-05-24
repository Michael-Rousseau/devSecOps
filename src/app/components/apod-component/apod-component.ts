import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ApodService, ApodData } from '../../services/apod.service';

@Component({
  selector: 'app-apod-component',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './apod-component.html',
  styleUrls: ['./apod-component.css']
})
export class ApodComponent implements OnInit {
  private readonly apodService = inject(ApodService);

  mainApod: ApodData | null = null;
  recentApods: ApodData[] = [];
  searchDate = '';
  showFilterMenu = false;
  isLoading = false;
  errorMessage = '';

  // wait for component initialization to perform API calls
  ngOnInit(): void {
    this.loadTodayApod();
    this.loadRecentApods();
  }

  loadTodayApod(): void {
    this.isLoading = true;
    this.errorMessage = '';
    this.mainApod = null;    
    this.apodService.getTodayApod().subscribe({
      next: (data) => {
        this.mainApod = data;
        this.searchDate = data.date;
        this.isLoading = false;
        },
      error: (error) => {
        this.errorMessage = 'Erreur lors du chargement de l\'image du jour';
        console.error(error);
        this.isLoading = false;
        }
    });
  }

  loadRecentApods(): void {
    this.apodService.getRecentApods(5).subscribe({
      next: (data) => {
        this.recentApods = data.slice(-6, -1).reverse();
        },
      error: (error) => {
        console.error('Erreur lors du chargement des APODs récents', error);
      }
    });
  }

  searchByDate(): void {
    if (!this.searchDate) {
      this.loadTodayApod();
      return;
    }
    
    this.isLoading = true;
    this.errorMessage = '';
    this.mainApod = null;    
    this.apodService.getApodByDate(this.searchDate).subscribe({
      next: (data) => {
        this.mainApod = data;
        this.isLoading = false;
        },
      error: (error) => {
        this.errorMessage = 'Aucune image trouvée pour cette date';
        console.error(error);
        this.isLoading = false;
        }
    });
  }

  loadApod(apod: ApodData): void {
    this.mainApod = apod;
    this.searchDate = apod.date;
  }

  formatDisplayDate(dateStr: string): string {
    const date = new Date(dateStr);
    return date.toLocaleDateString('fr-FR', { 
      day: '2-digit', 
      month: '2-digit', 
      year: 'numeric' 
    });
  }
}