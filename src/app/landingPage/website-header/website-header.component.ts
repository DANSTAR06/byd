import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { faBars, faHome, faImages, faInfoCircle, faVideo, faSignInAlt, faSignOutAlt, faQuestionCircle, faMoneyBillWave, faIcons, faUserAlt } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-website-header',
  imports: [RouterModule,CommonModule,FontAwesomeModule],
  templateUrl: './website-header.component.html',
  styleUrl: './website-header.component.scss'
})
export class WebsiteHeaderComponent {

    // FontAwesome icons
    faBars = faBars;
    faHome = faHome;
    faImages = faImages;
    faInfoCircle = faInfoCircle;
    faVideo = faVideo;
    faSignInAlt = faSignInAlt;
    faUserAlt = faUserAlt;
    faQuestionCircle = faQuestionCircle;
    faMoneyBillWave = faMoneyBillWave;

    menuOpen = false; // Toggle state for mobile menu

    toggleMenu() {
      this.menuOpen = !this.menuOpen;
    }


}

