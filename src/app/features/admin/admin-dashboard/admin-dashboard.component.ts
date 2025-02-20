import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { AdminHeaderComponent } from '../../../shared/components/admin/admin-header/admin-header.component';
import { AdminSideBarComponent } from '../../../shared/components/admin/admin-side-bar/admin-side-bar.component';
import { FooterComponent } from '../../../shared/components/customers/footer/footer.component';

@Component({
  selector: 'app-admin-dashboard',
  standalone: true,
  imports: [CommonModule, RouterModule, AdminHeaderComponent, AdminSideBarComponent, FooterComponent],
  templateUrl: './admin-dashboard.component.html',
  styleUrl: './admin-dashboard.component.scss'
})
export class AdminDashboardComponent {
  
  
}
