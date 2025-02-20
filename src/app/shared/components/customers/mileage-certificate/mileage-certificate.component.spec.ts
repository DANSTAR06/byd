import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MileageCertificateComponent } from './mileage-certificate.component';

describe('MileageCertificateComponent', () => {
  let component: MileageCertificateComponent;
  let fixture: ComponentFixture<MileageCertificateComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [MileageCertificateComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(MileageCertificateComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
