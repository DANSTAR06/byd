import { Component, OnInit } from '@angular/core';
import { Customer, UserResponse } from '../../../../core/models/user.model';
import { debounceTime, distinctUntilChanged, Subject } from 'rxjs';
import { CustomerService } from '../../../../core/services/customer/customer.service';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { MatDialog, MatDialogModule } from '@angular/material/dialog';
import { CustomerTransactionsComponent } from '../customer-transactions/customer-transactions.component';
import { AddPaymentComponent } from '../../payments/add-payment/add-payment.component';

@Component({
  selector: 'app-list-customers',
  standalone: true,
  imports: [CommonModule, RouterModule, MatDialogModule],
  templateUrl: './list-customers.component.html',
  styleUrl: './list-customers.component.scss'
})
export class ListCustomersComponent implements OnInit {

  users: Customer[] = [];
  totalCount = 0;
  currentPage = 1;
  totalPages = 0;
  pageSize = 10;
  pageSizeOptions = [10, 50, 100];
  searchTerm = '';
  searchSubject = new Subject<string>();

  constructor(private userService: CustomerService, private matDialog: MatDialog) {
    this.searchSubject
      .pipe(
        debounceTime(300),
        distinctUntilChanged()
      )
      .subscribe(() => {
        this.currentPage = 1;
        this.loadUsers();
      });
  }

  ngOnInit(): void {
    this.loadUsers();
  }

  openCustomerPanel(custId: any,customerName: any){
    this.matDialog.open(CustomerTransactionsComponent,{
      data: {customerId: custId, customerName: customerName}
    })
  }

  openPaymentModal(userid: any,name: any){
    let dialog = this.matDialog.open(AddPaymentComponent, {
      data: {userid: userid, name: name}
    })

     dialog.afterClosed().subscribe(res =>{
      this.loadUsers();
     })
  }

  loadUsers(): void {
    this.userService.getUsers(this.searchTerm, this.currentPage, this.pageSize)
      .subscribe((response: UserResponse) => {
        console.log(response)
        this.users = response.users;
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
    this.loadUsers();
  }

  goToPage(page: number): void {
    if (page >= 1 && page <= this.totalPages) {
      this.currentPage = page;
      this.loadUsers();
    }
  }

}
