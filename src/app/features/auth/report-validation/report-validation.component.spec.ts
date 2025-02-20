import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ReportValidationComponent } from './report-validation.component';

describe('ReportValidationComponent', () => {
  let component: ReportValidationComponent;
  let fixture: ComponentFixture<ReportValidationComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ReportValidationComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ReportValidationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
