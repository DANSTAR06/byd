import { Component } from '@angular/core';
import { AuthService } from '../../../../core/services/auth/auth.service';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-side-bar',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './side-bar.component.html',
  styleUrl: './side-bar.component.scss'
})
export class SideBarComponent {

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
