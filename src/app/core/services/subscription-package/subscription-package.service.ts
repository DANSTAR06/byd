import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { MileageService } from '../mileage/mileage.service';
import { catchError, forkJoin, map, Observable, of } from 'rxjs';
import { PayementsDetails } from '../../models/payment.model';
import { environment } from '../../../../environments/environment.development';
import { AuthService } from '../auth/auth.service';

interface PaymentExpiryInfo {
  lastPayment: PayementsDetails;
  expiryDate: string;
  daysRemaining: number;
}

@Injectable({
  providedIn: 'root'
})
export class SubscriptionPackageService {
  public packa2 = "no";
  apiUrl = environment.apiUrl
  basicPackage = environment.basicPackage
  basicPaid = 0;
  currenntUser: any
  userId: any


  constructor(private http: HttpClient, private mileageService: MileageService,private authService: AuthService) {
    this.currenntUser = this.authService.extractUser();
    this.userId = this.currenntUser.user_id
    
  }

  getUserSubscriptionPayments(customerId: string): Observable<PayementsDetails[] | null> {
    return this.http.get<PayementsDetails[]>(this.apiUrl+"/payments/userPackagePayments?account_number="+customerId+"&package_type=2").pipe(
      // Return null if the response is undefined or empty
      map(payments => payments && payments.length > 0 ? payments : null),
      // Catch any errors and return null
      catchError(() => of(null))
    );
  }

  calculateSubscriptionExpiry(payments: PayementsDetails[] | null): PaymentExpiryInfo | null {
    // Immediately return null if payments is null or empty
    if (!payments || payments.length === 0) {
      return null;
    }

    // Sort payments by date to get the most recent payment
    const sortedPayments = payments.sort((a, b) => 
      new Date(b.date_paid).getTime() - new Date(a.date_paid).getTime()
    );

    const lastPayment = sortedPayments[0];
    const paymentDate = new Date(lastPayment.date_paid);
    
    // Calculate expiry date (1 year from the last payment)
    const expiryDate = new Date(paymentDate);
    expiryDate.setFullYear(expiryDate.getFullYear() + 1);

    // Calculate days remaining
    const currentDate = new Date();
    const daysRemaining = Math.max(0, Math.ceil(
      (expiryDate.getTime() - currentDate.getTime()) / (1000 * 60 * 60 * 24)
    ));

    return {
      lastPayment,
      expiryDate: this.formatDate(expiryDate), // Format date to YYYY-MM-DD
      daysRemaining
    };
  }

  private formatDate(date: Date): string {
    return date.toISOString().split('T')[0];
  }
  
  getPremiumSubscriptionExpiryInfo(customerId: string): Observable<PaymentExpiryInfo | null> {
    return this.getUserSubscriptionPayments(customerId).pipe(
      map(payments => this.calculateSubscriptionExpiry(payments))
    );
  }


  getCustomerBasicSubscriptionBalance(customerId: number): Observable<number> {
    return forkJoin({
      expenses: this.mileageService.getCustomerReportsAndExpenses(customerId).pipe(
        catchError(() => of([]))  // Return empty array if expenses fetch fails
      ),
      payments: this.mileageService.getCustomerBasicPayments(customerId).pipe(
        catchError(() => of([]))  // Return empty array if payments fetch fails
      )
    }).pipe(
      map(result => {
        // Safely handle null or undefined arrays
        const totalExpenses = (result.expenses || []).reduce(
          (sum, expense) => sum + (expense?.amount_spent || 0), 
          0
        );

        const totalPayments = (result.payments || []).reduce(
          (sum, payment) => sum + (payment?.amount_paid || 0), 
          0
        );

        // Calculate and return balance
        return totalPayments - totalExpenses;
      })
    );
  }

  getExpiryStatus(startDate: Date): 'EXPIRED' | 'ACTIVE' {
    const currentDate = new Date();
    const expiryDate = this.calculateExpiryDate(startDate);
    
    return currentDate > expiryDate ? 'EXPIRED' : 'ACTIVE';
  }

  calculateExpiryDate(startDate: Date): Date {
    const expiryDate = new Date(startDate);
    expiryDate.setFullYear(expiryDate.getFullYear() + 1);
    return expiryDate;
  }
}
