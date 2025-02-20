import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { HttpClient, HttpParams } from '@angular/common/http';
import { PaymentsList, PaymentsListResponse } from '../../models/payment.model';
import { forkJoin, map, Observable } from 'rxjs';
import moment from 'moment';

interface Payment01 {
  amount_paid: number;
  date_paid: string;
}

interface PaymentResponse {
  payments: Payment01[];
  totalAmount: number;
}

interface MonthlyTotal {
  month: string;
  amount: number;
}

@Injectable({
  providedIn: 'root'
})
export class PaymentsService {

  private apiUrl = environment.apiUrl+"/payments";
  
    constructor(private http: HttpClient) { }
  
    getPayements(search: string, page: number, pageSize: number): Observable<PaymentsListResponse> {
      let params = new HttpParams()
        .set('search', search)
        .set('page', page.toString())
        .set('pageSize', pageSize.toString());
  
      return this.http.get<PaymentsListResponse>(this.apiUrl, { params });
    }

    getPremiumPayements(search: string, page: number, pageSize: number, packageType: any): Observable<PaymentsListResponse> {
      let params = new HttpParams()
        .set('search', search)
        .set('page', page.toString())
        .set('pageSize', pageSize.toString());
  
      return this.http.get<PaymentsListResponse>(this.apiUrl+'/byPackage?package='+packageType, { params })
    }

    getCustomerPayments(custId: any){
      return this.http.get<PaymentsListResponse>(this.apiUrl+'/byAccount?account_number='+custId);
    }

    getPaymentsBetweenDates(startDate: string, endDate: string): Observable<any> {
      return this.http.get(`${this.apiUrl}/dateRage?startDate=${startDate}&endDate=${endDate}`);
    }

    // getActivePremiunPayments(startDate: string, endDate: string): Observable<any> {
    //   return this.http.get(`${this.apiUrl}/dateRage?startDate=${startDate}&endDate=${endDate}`)
    //   .pipe(
    //     map((response:any) => response.payments.filter((payment:any) => 
    //         payment.subscription === 'Premium'
    //     ))
    // );
  //}

  

   
}
