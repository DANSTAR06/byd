import { Component } from '@angular/core';
import { Router, RouterModule } from '@angular/router';
import { User } from '../../../core/models/user.model';
import { AuthService } from '../../../core/services/auth/auth.service';
import { CommonModule } from '@angular/common';
import { SideBarComponent } from "../../../shared/components/customers/side-bar/side-bar.component";
import { HeaderComponent } from "../../../shared/components/customers/header/header.component";
import { FooterComponent } from "../../../shared/components/customers/footer/footer.component";

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [CommonModule, RouterModule, SideBarComponent, FooterComponent,HeaderComponent],
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.scss'
})
export class DashboardComponent {
  currentUser: any;

  constructor(
    private authService: AuthService,
    private router: Router
  ) {
   this.currentUser = this.authService.extractUser();
  }

  ngOnInit() {
    
  }

  get userName(): string {
    return this.currentUser 
      ? `${this.currentUser.names}` 
      : 'customer';
  }

  viewProfile() {
    this.router.navigate(['/customer/profile']);
  }

  logout() {
    this.authService.logout();
    this.router.navigate(['/login']);
  }

}
