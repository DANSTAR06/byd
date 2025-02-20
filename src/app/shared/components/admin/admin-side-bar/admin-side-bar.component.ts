import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { AuthService } from '../../../../core/services/auth/auth.service';

@Component({
  selector: 'app-admin-side-bar',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './admin-side-bar.component.html',
  styleUrl: './admin-side-bar.component.scss'
})
export class AdminSideBarComponent {

  currenntUser: any
  
    constructor(private authService: AuthService){
      this.currenntUser = authService.extractUser()
    }
  
    ngOnInit() {
    
    }
  
    logout(){
      this.authService.logout()
    }

}
