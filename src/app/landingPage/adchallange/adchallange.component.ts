import { CommonModule } from '@angular/common';
import { Component,Input  } from '@angular/core';

@Component({
  selector: 'app-adchallange',
  imports: [CommonModule],
  templateUrl: './adchallange.component.html',
  styleUrls: [ './adchallange.component.scss','./../../../assets/webstyle/css/style.css']
})
export class AdchallangeComponent {

  @Input() imageUrl1: string = './../../../assets/webstyle/website/IMG_0461.jpg';
  @Input() imageTitle1: string = 'Off Road Terrain Challenge';
  @Input() imageUrl2: string = './../../../assets/webstyle/website/IMG_9992.jpg';
  @Input() imageTitle2: string = 'Roll Car Challenge';
  @Input() imageUrl3: string = './../../../assets/webstyle/website/IMG_0790.jpg';
  @Input() imageTitle3: string = 'Timed Slalom';
  @Input() youtubeLink: string = 'https://youtu.be/Cv_UEH5SNbk?si=pyCQ4sXAeZDsBdDJ';
}


