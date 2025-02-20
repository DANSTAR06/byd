import { Component } from '@angular/core';
import { FormGroup, FormBuilder, Validators, ReactiveFormsModule, FormControl } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';
import { CommonModule } from '@angular/common';
import { ToastService } from '../../../core/services/toast/toast.service';
import { CustomerService } from '../../../core/services/customer/customer.service';

@Component({
  selector: 'app-register',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule,RouterModule],
  templateUrl: './register.component.html',
  styleUrl: './register.component.scss'
})
export class RegisterComponent {
    registrationForm!: FormGroup;
    dlImageFile: File | null = null;
    idImageFile: File | null = null;
    loading = false;
    errorMessage = '';
    knwhow = [ 'AA Kenya Website', 'I am a past participant', 'AA Kenya Employee', 'Friend/Family Refarral', 'Social Media'];

    termsControl = new FormControl(false);
    isTermsAccepted: boolean = false;

  constructor(
    private fb: FormBuilder,
    private customerService: CustomerService,
    private toast: ToastService,
    private router: Router
  ) {
    this.termsControl.valueChanges.subscribe((value:any) => {
        this.isTermsAccepted = value;
      });


    this.registrationForm = this.fb.group({
      region_id: ['', Validators.required],
      full_name: ['', Validators.required],
      national_id: ['', Validators.required],
      email: ['', [Validators.required, Validators.email]],
      phone_number: ['', Validators.required],
      gender: ['', Validators.required],
      dob: ['', Validators.required],
      dl_no: ['', Validators.required],
      password: ['', [Validators.required, Validators.minLength(6)]],
      password1: ['', [Validators.required, Validators.minLength(6)]],
      knowhow: ['', [Validators.required]],
      role: ['1']
  });

  }

  onDLImageSelected(event: any): void {
    if (event.target.files.length > 0) {
        this.dlImageFile = event.target.files[0];
    }
}

onIDImageSelected(event: any): void {
    if (event.target.files.length > 0) {
        this.idImageFile = event.target.files[0];
    }
}

onSubmit(): void {
    
    if (this.registrationForm.valid && this.dlImageFile && this.idImageFile) {
        this.loading = true;
        this.errorMessage = '';
        
        let pass1 = this.registrationForm.value.password
        let pass2 = this.registrationForm.value.password1

        if(this.isTermsAccepted == true){
        if(pass1 === pass2){
         const formData = new FormData();
        formData.append('data', JSON.stringify(this.registrationForm.value));
        formData.append('dl_image', this.dlImageFile);
        formData.append('id_image', this.idImageFile);
        
        console.log(this.registrationForm.value)
        this.customerService.registerApplicant(formData).subscribe({
            next: (response) => {
                this.loading = false;
               this.toast.showSuccess("Success!","Your registration have been submitted successifully. Plese Login to apply for the contest")
                this.router.navigate(['/login']);
            },
            error: (error) => {
                this.loading = false;
               // this.errorMessage = error.message || 'Registration failed';
               console.log(error)
               this.toast.showError("Error!", "Unable to register: "+error.error)
            }
        });

            } else {
                this.toast.showError("Error!", "Wrong Confirmation Password. Please use password you can remember")
                this.loading = false;
            }

        } else {
            this.toast.showError("Error!", "Please Accept Terms & Conditions for the AAKenya Best Driver Contest")
            this.loading = false
        }
    }
}

// Getter methods for form controls to simplify template validation
get full_name() { return this.registrationForm.get('full_name'); }
get national_id() { return this.registrationForm.get('national_id'); }
get email() { return this.registrationForm.get('email'); }
get phone_number() { return this.registrationForm.get('phone_number'); }
get gender() { return this.registrationForm.get('gender'); }
get dob() { return this.registrationForm.get('dob'); }
get dl_no() { return this.registrationForm.get('dl_no'); }
get password() { return this.registrationForm.get('password'); }
get password1() { return this.registrationForm.get('password1'); }
get region_id() { return this.registrationForm.get('region_id'); }
get knowhow() { return this.registrationForm.get('knowhow'); }

}
