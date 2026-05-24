import { ComponentFixture, TestBed } from '@angular/core/testing';
import { BackgroundMapComponent } from './background-map';
import { MoonLayer } from '../../services/nasa.service';

describe('BackgroundMapComponent', () => {
    let component: BackgroundMapComponent;
    let fixture: ComponentFixture<BackgroundMapComponent>;

    const mockLayer: MoonLayer = {
        id: 'test',
        name: 'Test Layer',
        urlTemplate: 'https://example.com/{z}/{y}/{x}.jpg',
        attribution: 'Test',
    };

    beforeEach(async () => {
        await TestBed.configureTestingModule({
            imports: [BackgroundMapComponent],
        }).compileComponents();

        fixture = TestBed.createComponent(BackgroundMapComponent);
        fixture.componentRef.setInput('activeLayer', mockLayer);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});
