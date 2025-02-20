import { Component } from '@angular/core';
import { PaymentsList, PaymentsListResponse } from '../../../../core/models/payment.model';
import { debounceTime, distinctUntilChanged, Subject } from 'rxjs';
import { PaymentsService } from '../../../../core/services/payments/payments.service';
import { CommonModule } from '@angular/common';
import { Router, RouterModule } from '@angular/router';
import { MatDialogModule } from '@angular/material/dialog';


@Component({
  selector: 'app-list-payements',
  standalone: true,
  imports: [CommonModule, RouterModule, MatDialogModule],
  templateUrl: './list-payements.component.html',
  styleUrl: './list-payements.component.scss'
})
export class ListPayementsComponent {
   payments: PaymentsList[] = [];
    totalCount = 0;
    currentPage = 1;
    totalPages = 0;
    pageSize = 10;
    pageSizeOptions = [10, 50, 100];
    searchTerm = '';
    searchSubject = new Subject<string>();
  
    constructor(private payementService: PaymentsService, private router: Router) {
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
      this.payementService.getPayements(this.searchTerm, this.currentPage, this.pageSize)
        .subscribe((response: PaymentsListResponse) => {
          this.payments = response.payments;
          console.log(this.payments)
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
   
    openPaymentModal(){
      this.router.navigate(['/admin/customers'])
    }

}
