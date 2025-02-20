import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { EncryptionService } from '../../../core/services/general/encryption.service';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { AuthService } from '../../../core/services/auth/auth.service';
import { CustomerService } from '../../../core/services/customer/customer.service';
import { PaymentsService } from '../../../core/services/general/payments.service';
import { PaymentSTKIntiator } from '../../../core/models/payment.model';
import { environment } from '../../../../environments/environment';
import { ToastService } from '../../../core/services/toast/toast.service';
import { CategoryService } from '../../../core/services/category/category.service';

@Component({
  selector: 'app-payment',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './payment.component.html',
  styleUrl: './payment.component.scss'
})
export class PaymentComponent {

  savedCategory: any
  categoryName: any;
  categoryId: any
  categoryFees: any;
  packageType: any
  applicantTotalPayment: any

  currentUser: any;
  phone: any;
  userId: any;

  amountToPay: any;
  isIntiating = false
  isWaitingPayment = false

  apiURL = environment.apiUrl

  constructor(private paymentService: PaymentsService,private categoryService: CategoryService, 
    private router: Router, private authService: AuthService, private customerService: CustomerService, private toast: ToastService){
    this.currentUser = this.authService.extractUser();
    this.phone = this.currentUser?.phone
    this.userId = this.currentUser?.user_id

    this.customerService.getUserById(this.userId).subscribe(res =>{
      this.phone = res.phone_number;
    })

    this.paymentService.getApplicantTotalPayments(this.userId).subscribe(res => {
      this.applicantTotalPayment = res;
    })

    this.categoryService.getApplicantAppliedCategory(this.userId).subscribe((res:any) => {
      this.savedCategory = res;
      this.categoryId =  this.savedCategory.data[0].category_id
      this.categoryFees =  this.savedCategory.data[0].category.cat_fees
      this.categoryName =  this.savedCategory.data[0].category.cat_name
      if(this.categoryId == 1) {this.packageType = "BYDA"}if(this.categoryId == 2) {this.packageType = "BYDB"}
      if(this.categoryId == 3) {this.packageType = "BYDC"}if(this.categoryId == 4) {this.packageType = "BYDD"}
      if(this.categoryId == 5) {this.packageType = "BYDE"}
    })
    
  }

  changeCategory(){
    this.categoryService.deleteUserCategories(this.userId).subscribe(res =>{
      this.router.navigate(['/driver/dashboard'])
    })
   
  }

  goToAssesment() {
    this.router.navigate(['/driver/questions'])
  }

  payNow(amount: number){

      const paymentdata: PaymentSTKIntiator = {
        amount: amount,
        phone: this.phone.toString(),
        description: "Payement for Best Driver Competitions",
        accountName: this.packageType+(this.userId).toString(),
        callBackUrl: this.apiURL+"/mpesaCallBack",
        status: "SENT"
      }
   
      this.isIntiating = true
      this.isWaitingPayment = false;
      this.paymentService.intiateSTK(paymentdata).subscribe(res =>{
       this.isIntiating = false;
       this.isWaitingPayment = true;
       if(res?.status == "PENDING"){
         this.toast.showSuccess("STK Intiated", "Please check phone "+paymentdata.phone+" and complete the payment")
       } else {
         this.toast.showError("STK not Intiated","Please check your phone number. Use your actual phone number")
       }
      
      // 
      })
  
  }

  completePayment(){

  }

}


