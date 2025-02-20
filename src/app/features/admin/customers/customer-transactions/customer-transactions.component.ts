import { CommonModule } from '@angular/common';
import { Component, Inject } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialog } from '@angular/material/dialog';
import { MileageService } from '../../../../core/services/mileage/mileage.service';
import { PaymentsService } from '../../../../core/services/payments/payments.service';
import { Router, RouterModule } from '@angular/router';
import { DataResolverService } from '../../../../core/services/general/data-resolver.service';

@Component({
  selector: 'app-customer-transactions',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './customer-transactions.component.html',
  styleUrl: './customer-transactions.component.scss'
})
export class CustomerTransactionsComponent {

  customerId: any
  customerName: any
  customerReports: any
  payments: any

  constructor(@Inject(MAT_DIALOG_DATA) public data: {customerId:any,customerName:any}, 
  private mileageService: MileageService,private dataResolver: DataResolverService, 
  private payemntService: PaymentsService, private router: Router, private matDialog: MatDialog ) {
    this.customerId = data.customerId;
    this.customerName = data.customerName;

    this.getCustomerReports(this.customerId)
    this.getCustomerPayments(this.customerId)
  }

  getCustomerReports(cust_id: any){
    this.mileageService.getCustomerReportsAndExpenses(cust_id).subscribe((res: any) =>{
      console.log(res)
      this.customerReports = res;
    })
  }

  getCustomerPayments(cust_id: any) {
    this.payemntService.getCustomerPayments(cust_id).subscribe((res: any) =>{
      this.payments = res;
    })
  }

  isExpired(expiryDate: string): boolean {
    const expiry = new Date(expiryDate);
    const today = new Date();
  
    today.setHours(0, 0, 0, 0);
    expiry.setHours(0, 0, 0, 0);
    
    return expiry < today;
}

getStatusClass(expiryDate: string): string {
    return this.isExpired(expiryDate) ? 'expired' : 'active';
}

viewReport(capacity: any,make: any, model: any,fuel: any, years: any, rate: any, expiry_date: any,reportId: any,date_created: any){
  var certData = {
    reportId: reportId,
    date_created: date_created,
    capacity: capacity,
    make: make,          
    model: model,
    fuel: fuel,
    years: years,
    rate: rate,
    expiry_date: expiry_date          
  }
    this.dataResolver.setData(certData);
        this.router.navigate(['/admin/report-overview']).then(res =>{
         this.matDialog.closeAll();
      })
}

}
