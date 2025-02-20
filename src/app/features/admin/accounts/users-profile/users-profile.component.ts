import { Component } from '@angular/core';
import { AuthService } from '../../../../core/services/auth/auth.service';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-users-profile',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './users-profile.component.html',
  styleUrl: './users-profile.component.scss'
})
export class UsersProfileComponent {
   userData: any
  
    constructor(private authService: AuthService) {
      this.userData = this.authService.extractUser()
      console.log(this.userData)
  
    }
  
    ngOnInit() {
     
    }

    changePassword(){
      alert("Coming soon...")
    }

    addUser(){
      alert("Coming soon...")
    }

}
