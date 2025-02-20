import { Component } from '@angular/core';
import { ReportsListing, ReportsResponse } from '../../../../core/models/reports.model';
import { debounceTime, distinctUntilChanged, Subject } from 'rxjs';
import { MileageService } from '../../../../core/services/mileage/mileage.service';
import { CommonModule } from '@angular/common';
import { Router, RouterModule } from '@angular/router';
import { DataResolverService } from '../../../../core/services/general/data-resolver.service';
import { MatDialog, MatDialogModule } from '@angular/material/dialog';

@Component({
  selector: 'app-list-reports',
  standalone: true,
  imports: [CommonModule, RouterModule, MatDialogModule],
  templateUrl: './list-reports.component.html',
  styleUrl: './list-reports.component.scss'
})
export class ListReportsComponent {

    reports: ReportsListing[] = [];
    totalCount = 0;
    currentPage = 1;
    totalPages = 0;
    pageSize = 10;
    pageSizeOptions = [10, 50, 100];
    searchTerm = '';
    searchSubject = new Subject<string>();
  
    constructor(private mileageService: MileageService,private dataResolver: DataResolverService, private router: Router, private matDialog: MatDialog) {
      this.searchSubject
        .pipe(
          debounceTime(300),
          distinctUntilChanged()
        )
        .subscribe(() => {
          this.currentPage = 1;
          this.loadReports();
        });
    }
  
    ngOnInit(): void {
      this.loadReports();
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
  
    loadReports(): void {
      this.mileageService.getAllReports(this.searchTerm, this.currentPage, this.pageSize)
        .subscribe((response: ReportsResponse) => {
          this.reports = response.reports;
          console.log(this.reports)
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
      this.loadReports();
    }
  
    goToPage(page: number): void {
      if (page >= 1 && page <= this.totalPages) {
        this.currentPage = page;
        this.loadReports();
      }
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

}
