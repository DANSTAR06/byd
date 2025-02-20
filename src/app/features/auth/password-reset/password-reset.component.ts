import { Component } from '@angular/core';
import { FormGroup, FormControl, FormBuilder, Validators, ReactiveFormsModule } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';
import { User } from '../../../core/models/user.model';
import { AuthService } from '../../../core/services/auth/auth.service';
import { ToastService } from '../../../core/services/toast/toast.service';
import { CommonModule } from '@angular/common';
import { GeneralService } from '../../../core/services/general/general.service';

@Component({
  selector: 'app-password-reset',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule,RouterModule],
  templateUrl: './password-reset.component.html',
  styleUrl: './password-reset.component.scss'
})
export class PasswordResetComponent {
  passwordForm!: FormGroup;
  errorMessage: string = '';
  isLoading = false;
  sharedCode = 0;
  userEmail = "";
  showPasswordReset = false;
  showResetButton = true;
  
    constructor(
      private fb: FormBuilder,
      private authService: AuthService,
      private router: Router,
      private toast: ToastService,
      private genService: GeneralService
    ) {
  
  
    }
  
    ngOnInit() {
      this.passwordForm = this.fb.group({
        names: ['', [Validators.required]],
      });
    }
  
    onSubmit() {
      var email = this.passwordForm.value.names
      this.isLoading = true
      this.showResetButton = false
      this.authService.getUserByEmail(email).subscribe((res: any) =>{
        console.log(res)
        if(res == "Not Found") {
           this.toast.showError("Invalid Email", "The email entered is not registered.")
           this.isLoading = false
           this.showResetButton = true
        } else {

          //==================================== send email
          let resetCode = Math.floor(Math.random() * 9999) + 10000;
          this.sharedCode = resetCode;
          this.userEmail = email;
          let message = "Dear "+res.names+ ", Your code to reset password for AAKenya Best Driver Contest is:  "+resetCode
          this.genService.sendEmail(email,"Reset Password AAKenya Best Driver Contest",message).subscribe(res =>{
            this.toast.showSuccess("RESET CODE", "A code to reset pasword has been sent to your email")
            this.isLoading = false
            this.showPasswordReset = true
            this.showResetButton = false
          })

        }
      })
    }

    saveNewPassword(){
      var code = document.getElementById('sent_code') as HTMLInputElement;
      var enteredCode = Number(code.value)

      var pass = document.getElementById('password1') as HTMLInputElement;
      var password = pass.value

      var pass1 = document.getElementById('password2') as HTMLInputElement;
      var password1 = pass1.value

      if((enteredCode == 0) || (enteredCode == null) || password == ""){
        this.toast.showError("Invalid Code", "Please enter valid code sent to your email and ensure you enter your new prefered password")
      } else {
        if(enteredCode == this.sharedCode) {
          if(password1 == password) {
            //======================================= proceed to reset password
            this.authService.resetPassword(this.userEmail, password).subscribe(res =>{
              this.toast.showSuccess("Success", "Your password has been reset successifully. Please login now")
              this.router.navigate(['/login'])
            })

          } else {
            this.toast.showError("Password Mismatch", "The confimation password is not the same as the New password Entered")
          }

        } else {
           this.toast.showError("Invalid Code", "Please enter valid code")
        }
      }
   
    }
  
  
    // Getter methods for form controls to simplify template validation
    get names() { return this.passwordForm.get('names'); }
 
}
