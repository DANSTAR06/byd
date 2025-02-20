import { Component } from '@angular/core';
import { MatDialogModule } from '@angular/material/dialog';
import { Router, RouterModule } from '@angular/router';
import { AuthService } from '../../../core/services/auth/auth.service';
import { CommonModule } from '@angular/common';
import { CategoryService } from '../../../core/services/category/category.service';
import { PaymentsService } from '../../../core/services/general/payments.service';
import { ToastService } from '../../../core/services/toast/toast.service';
import { CustomerService } from '../../../core/services/customer/customer.service';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule, RouterModule, MatDialogModule],
  templateUrl: './home.component.html',
  styleUrl: './home.component.scss'
})
export class HomeComponent {
  currenntUser: any
  userId: any
  applicantsDetails: any;
  dob: any;
  gender: any;
  age: any;

  categories: any[] = [];
  selectedCategory: any = null;

  savedCategory: any
  categoryName: any;
  categoryId: any
  categoryFees: any
  applicantTotalPayment: any

  constructor(private authService: AuthService,private toast: ToastService, private customerService: CustomerService,
    private categoryService: CategoryService, private router: Router,private paymentService: PaymentsService){
    this.currenntUser = this.authService.extractUser();
    this.userId = this.currenntUser.user_id
    this.getCustomerDetails(this.userId)

    this.categoryService.getApplicantAppliedCategory(this.userId).subscribe((res:any) => {

      if(res.data == null)
      {
        //===================================== No category
      } else {
      this.savedCategory = res;
      this.categoryId =  this.savedCategory.data[0].category_id
      this.categoryFees =  this.savedCategory.data[0].category.cat_fees

      this.paymentService.getApplicantTotalPayments(this.userId).subscribe(res => {
        this.applicantTotalPayment = res;
       
        if(this.applicantTotalPayment < this.categoryFees)
        {
          //============================ Go to payment
          this.router.navigate(['/driver/payment'])
        } else {
          //=============================== Go to assesment
          this.router.navigate(['/driver/questions'])
        }
      })
     
      }
    })

    this.getCategories();

   }

   getCustomerDetails(userId: any){
    this.customerService.getUserById(userId).subscribe(res =>{
       this.applicantsDetails = res;
       this.dob = this.applicantsDetails.dob;
       this.gender = this.applicantsDetails.gender;

       this.age = this.calculateAge(this.dob);

    })
   }

   getCategories(){
    this.categoryService.getCategories().subscribe(
      (response: any) => {
        if (response.status === 'success') {
          this.categories = response.data;
        }
      },
      (error) => {
        console.error('Error fetching categories:', error);
      }
    );
   }

   selectCategory(categoryId: any, catName: any, minAge: any, maxAge: any, amount: any, packageType: any, gender: any): void {
     
    if(gender == "Female") {
      if (this.gender == "female"){
        //============================== check female age
        if(this.age < minAge) {
          this.toast.showError("Age Issue!", "Your age of "+this.age+" Years does not fall withing the required age bracket for "+catName+" Category. Please apply for The Best Young Driver")
        } else {
          //================================ Proceed to apply
          let data = {
            applicant_id: Number(this.userId),
            category_id: Number(categoryId)
           }
      
           this.categoryService.saveApplicantCategories(data).subscribe(res =>{
            this.router.navigate(['/driver/payment'])
           })
          
        }

      } else {
        this.toast.showError("Gender Issue!","Sorry! This is a female only category")
      }

    } else {
      //======================= condition for all
      if(this.age < minAge || this.age > maxAge) {
        this.toast.showError("Age Issue!","Your age of "+this.age+" Years does not fall withing the required age bracket for "+catName+" Category")
      } else {
        //========================== Proceed to apply
        let data = {
          applicant_id: Number(this.userId),
          category_id: Number(categoryId)
         }
    
         this.categoryService.saveApplicantCategories(data).subscribe(res =>{
          this.router.navigate(['/driver/payment'])
         })

        
      }
      
    }

   
    
  } 
  
  calculateAge(dateOfBirth: string): number {

    const dateFormatRegex = /^\d{4}-\d{2}-\d{2}$/;
    if (!dateFormatRegex.test(dateOfBirth)) {
      throw new Error("Invalid date format. Please provide date in YYYY-MM-DD format");
    }

    const dob = new Date(dateOfBirth);
    const currentDate = new Date();
   
    let age = currentDate.getFullYear() - dob.getFullYear();
    const currentMonth = currentDate.getMonth();
    const birthMonth = dob.getMonth();
    
    if (
      birthMonth > currentMonth || 
      (birthMonth === currentMonth && dob.getDate() > currentDate.getDate())
    ) {
      age--;
    }
    
    return age;
  }

}
