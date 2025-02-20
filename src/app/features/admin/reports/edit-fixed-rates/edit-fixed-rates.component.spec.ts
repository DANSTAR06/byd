import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EditFixedRatesComponent } from './edit-fixed-rates.component';

describe('EditFixedRatesComponent', () => {
  let component: EditFixedRatesComponent;
  let fixture: ComponentFixture<EditFixedRatesComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [EditFixedRatesComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(EditFixedRatesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
