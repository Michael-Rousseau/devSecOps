import { ComponentFixture, TestBed } from '@angular/core/testing';
import { EventListComponent } from './event-list-component';
import { EonetEvent } from '../../services/nasa.service';

describe('EventListComponent', () => {
    let component: EventListComponent;
    let fixture: ComponentFixture<EventListComponent>;

    const now = new Date();
    const yesterday = new Date(now);
    yesterday.setDate(now.getDate() - 1);
    const twoDaysAgo = new Date(now);
    twoDaysAgo.setDate(now.getDate() - 2);
    const fiveDaysAgo = new Date(now);
    fiveDaysAgo.setDate(now.getDate() - 5);

    const mockEvents: EonetEvent[] = [
        {
            id: '1',
            title: 'Volcano Eruption',
            categories: [{ title: 'Volcanoes' }],
            sources: [{ id: 'S1', url: 'url1' }],
            geometries: [{ date: fiveDaysAgo.toISOString(), coordinates: [0, 0] }],
        },
        {
            id: '2',
            title: 'Wildfire',
            categories: [{ title: 'Wildfires' }],
            sources: [{ id: 'S2', url: 'url2' }],
            geometries: [{ date: yesterday.toISOString(), coordinates: [0, 0] }],
        },
        {
            id: '3',
            title: 'Alpha Storm',
            categories: [{ title: 'Severe Storms' }],
            sources: [{ id: 'S1', url: 'url3' }],
            geometries: [{ date: twoDaysAgo.toISOString(), coordinates: [0, 0] }],
        },
    ];

    beforeEach(async () => {
        await TestBed.configureTestingModule({
            imports: [EventListComponent],
        }).compileComponents();

        fixture = TestBed.createComponent(EventListComponent);
        component = fixture.componentInstance;

        fixture.componentRef.setInput('events', mockEvents);
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });

    it('should display all events by default', () => {
        expect(component.filteredEvents().length).toBe(3);
    });

    it('should filter events by text search (case insensitive)', () => {
        component.filterText.set('volcano');
        fixture.detectChanges();

        const events = component.filteredEvents();
        expect(events.length).toBe(1);
        expect(events[0].title).toBe('Volcano Eruption');
    });

    it('should filter events by category', () => {
        component.categoryFilter.set('Wildfires');
        fixture.detectChanges();

        const events = component.filteredEvents();
        expect(events.length).toBe(1);
        expect(events[0].title).toBe('Wildfire');
    });

    it('should filter events by source', () => {
        component.sourceFilter.set('S1');
        fixture.detectChanges();

        const events = component.filteredEvents();
        expect(events.length).toBe(2);
    });

    it('should sort events by date descending by default', () => {
        const events = component.filteredEvents();
        expect(events[0].title).toBe('Wildfire');
        expect(events[1].title).toBe('Alpha Storm');
        expect(events[2].title).toBe('Volcano Eruption');
    });

    it('should sort events by title ascending', () => {
        component.sortBy.set('title-asc');
        fixture.detectChanges();

        const events = component.filteredEvents();
        expect(events[0].title).toBe('Alpha Storm');
        expect(events[1].title).toBe('Volcano Eruption');
        expect(events[2].title).toBe('Wildfire');
    });
});
