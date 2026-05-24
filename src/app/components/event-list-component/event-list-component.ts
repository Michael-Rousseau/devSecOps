import { Component, input, output, signal, computed } from '@angular/core';
import { CommonModule } from '@angular/common';
import { EonetEvent } from '../../services/nasa.service';

@Component({
    selector: 'app-event-list-component',
    standalone: true,
    imports: [CommonModule],
    templateUrl: './event-list-component.html',
    styleUrls: ['./event-list-component.css'],
})
export class EventListComponent {
    events = input<EonetEvent[]>([]);

    daysRequest = output<number>();

    filterText = signal('');
    categoryFilter = signal('all');
    sourceFilter = signal('all');
    dateRangeDays = signal<number>(30);
    sortBy = signal('date-desc');

    onDateChange(event: Event) {
        const value = (event.target as HTMLSelectElement).value;
        let days = 30;

        switch (value) {
            case 'today':
                days = 1;
                break;
            case 'week':
                days = 7;
                break;
            case 'month':
                days = 30;
                break;
            case 'year':
                days = 365;
                break;
            default:
                days = 30;
        }
        this.dateRangeDays.set(days);
        this.daysRequest.emit(days);
    }

    availableCategories = computed(() => {
        const categories = new Set<string>();
        this.events().forEach((e) => {
            if (e.categories[0]?.title) {
                categories.add(e.categories[0].title);
            }
        });
        return Array.from(categories).sort();
    });

    availableSources = computed(() => {
        const sources = new Set<string>();
        this.events().forEach((e) => {
            e.sources.forEach((s) => {
                if (s.id) {
                    sources.add(s.id);
                }
            });
        });
        return Array.from(sources).sort();
    });

    filteredEvents = computed(() => {
        let list = this.events();
        const text = this.filterText().toLowerCase();

        if (text) {
            list = list.filter((e) => e.title.toLowerCase().includes(text));
        }

        if (this.categoryFilter() !== 'all') {
            list = list.filter((e) => e.categories[0]?.title === this.categoryFilter());
        }

        if (this.sourceFilter() !== 'all') {
            list = list.filter((e) => e.sources.some((s) => s.id === this.sourceFilter()));
        }

        // Filter by actual event start date
        const days = this.dateRangeDays();
        const cutoffDate = new Date();
        cutoffDate.setDate(cutoffDate.getDate() - days);
        cutoffDate.setHours(0, 0, 0, 0);

        list = list.filter((e) => {
            if (!e.geometries || e.geometries.length === 0) return false;
            const eventDate = new Date(e.geometries[0].date);
            return eventDate >= cutoffDate;
        });

        const sortValue = this.sortBy();
        list = [...list].sort((a, b) => {
            switch (sortValue) {
                case 'date-desc':
                    return (
                        new Date(b.geometries[0]?.date).getTime() -
                        new Date(a.geometries[0]?.date).getTime()
                    );
                case 'date-asc':
                    return (
                        new Date(a.geometries[0]?.date).getTime() -
                        new Date(b.geometries[0]?.date).getTime()
                    );
                case 'title-asc':
                    return a.title.localeCompare(b.title);
                case 'title-desc':
                    return b.title.localeCompare(a.title);
                default:
                    return 0;
            }
        });

        return list;
    });
}

