import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';

@Component({
  selector: 'app-eligibility',
  templateUrl: './eligibility.component.html',
  styleUrls: ['./eligibility.component.scss'],
  imports:[FontAwesomeModule,CommonModule]
})
export class EligibilityComponent {
  requirements: string[] = [
    "Be of Age 18 years and Above.",
    "Have a valid driving License (Class B Vehicle).",
    "Be free of conviction of serious road offenses like death or serious injury of other road users.",
    "Be Kenyan or an Official resident of Kenya.",
    "Not be a winner from previous similar competitions or a participant in the previous year's finals.",
    "Pay the Registration Fees as per the category you want to participate in."
  ];

  schedule: { location: string; date: string }[] = [
    { location: "Eldoret, Eldoret Sports Club", date: "10th May" },
    { location: "Mombasa, Mama Ngina Drive", date: "31st May" },
    { location: "Nairobi, The Carnivore", date: "21st June" },
    { location: "Finals, Whistling Moran", date: "19th July" }
  ];
}
