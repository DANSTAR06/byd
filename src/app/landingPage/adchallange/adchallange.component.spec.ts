import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AdchallangeComponent } from './adchallange.component';

describe('AdchallangeComponent', () => {
  let component: AdchallangeComponent;
  let fixture: ComponentFixture<AdchallangeComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AdchallangeComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AdchallangeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
