import { Component } from '@angular/core';
import { PaymentsList, PaymentsListResponse } from '../../../../core/models/payment.model';
import { debounceTime, distinctUntilChanged, Subject } from 'rxjs';
import { PaymentsService } from '../../../../core/services/payments/payments.service';
import { Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { SubscriptionPackageService } from '../../../../core/services/subscription-package/subscription-package.service';

@Component({
  selector: 'app-subscriptions',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './subscriptions.component.html',
  styleUrl: './subscriptions.component.scss'
})
export class SubscriptionsComponent {

      payments: PaymentsList[] = [];
      totalCount = 0;
      currentPage = 1;
      totalPages = 0;
      pageSize = 10;
      pageSizeOptions = [10, 50, 100];
      searchTerm = '';
      searchSubject = new Subject<string>();

      constructor(private payementService: PaymentsService, private subscriptionService: SubscriptionPackageService) {
            this.searchSubject
              .pipe(
                debounceTime(300),
                distinctUntilChanged()
              )
              .subscribe(() => {
                this.currentPage = 1;
                this.loadPayments();
              });
          }
        
          ngOnInit(): void {
            this.loadPayments();
          }
        
          loadPayments(): void {
            this.payementService.getPremiumPayements(this.searchTerm, this.currentPage, this.pageSize,2)
              .subscribe((response: any) => {
                console.log(response)
                this.payments = response.payments;
                this.totalCount = response.total_count;
                this.totalPages = response.total_pages;
              });
          }
        
          onSearch(event: any): void {
            this.searchTerm = event.target.value;
            this.searchSubject.next(this.searchTerm);
          }
        
          onPageSizeChange(event: any): void {
            this.pageSize = parseInt(event.target.value);
            this.currentPage = 1;
            this.loadPayments();
          }
        
          goToPage(page: number): void {
            if (page >= 1 && page <= this.totalPages) {
              this.currentPage = page;
              this.loadPayments();
            }
          }

          getEpiryDate(date: any){
           return this.subscriptionService.calculateExpiryDate(date)
          }

}
