import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment.development';
import { HttpClient } from '@angular/common/http';
import { ApplicantPayment, PaymentSTKIntiator } from '../../models/payment.model';
import { catchError, map, Observable } from 'rxjs';
import { ToastService } from '../toast/toast.service';



@Injectable({
  providedIn: 'root'
})
export class PaymentsService {
  apiUrl = environment.apiUrl
  constructor(private http: HttpClient, private toast: ToastService) { }
  
  intiateSTK(payment: PaymentSTKIntiator): Observable<PaymentSTKIntiator> {
    return this.http.post<any>(this.apiUrl+'/makePayment', payment)
          .pipe(
            map(response => {
              // You might want to handle registration response differently
              return response;
            }),
            catchError(error => {
             console.error('Registration failed', error);
              
              throw error;
            })
          );

  }

  getApplicantTotalPayments(applicantId: any): Observable<number>{
    return this.http.get<ApplicantPayment[]>(`${this.apiUrl}/payments/byApplicant?applicant_id=${applicantId}`)
    .pipe(
      map(payments => payments ? payments.reduce((total, payment) => total + payment.amount_paid, 0) : 0)
    );
  }
}
