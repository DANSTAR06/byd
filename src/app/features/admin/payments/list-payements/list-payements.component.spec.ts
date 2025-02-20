import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ListPayementsComponent } from './list-payements.component';

describe('ListPayementsComponent', () => {
  let component: ListPayementsComponent;
  let fixture: ComponentFixture<ListPayementsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ListPayementsComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ListPayementsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
