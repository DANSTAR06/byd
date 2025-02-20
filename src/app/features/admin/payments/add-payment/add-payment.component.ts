import { Component, Inject } from '@angular/core';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';

@Component({
  selector: 'app-add-payment',
  standalone: true,
  imports: [],
  templateUrl: './add-payment.component.html',
  styleUrl: './add-payment.component.scss'
})
export class AddPaymentComponent {
  userid: any
  name: any

   constructor(@Inject(MAT_DIALOG_DATA) public data: {userid: any, name: any}){
      this.userid = data.userid
      this.name = data.name
    }

}
