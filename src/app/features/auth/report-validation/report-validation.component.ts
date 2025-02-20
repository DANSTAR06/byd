import { Component } from '@angular/core';
import { MileageService } from '../../../core/services/mileage/mileage.service';
import { Reports } from '../../../core/models/reports.model';
import { CommonModule } from '@angular/common';
import { ActivatedRoute } from '@angular/router';
import { EncryptionService } from '../../../core/services/general/encryption.service';

@Component({
  selector: 'app-report-validation',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './report-validation.component.html',
  styleUrl: './report-validation.component.scss'
})
export class ReportValidationComponent {
  mileageReport: any;
  ExpiryDate: any;
  serialNo: any;
  dateCreated: any;
  reportId: any;
  reportStatus: any;
  customer = 0;
  test: any;
    constructor(private mileageService: MileageService,private activateRoute: ActivatedRoute, private encrypionService: EncryptionService) {
      this.activateRoute.queryParams.subscribe((params: any) =>{
        this.reportId = this.encrypionService.decryptData(params.key)
        this.getReportById(this.reportId)
       })
     
       this.test = encrypionService.encryptData(20);
       console.log(this.test)
       console.log(encrypionService.decryptData(this.test))
    }
  
    getReportById(reportId: any){
      this.mileageService.getReportById(reportId).subscribe((res: any) =>{

        this.mileageReport = res;
        this.customer = this.mileageReport.customer_id
        this.ExpiryDate = this.mileageReport.expiry_date
        this.dateCreated = this.mileageReport.date_created
        this.serialNo = 'AAK0/'+reportId+'/'+this.dateCreated;
        this.reportStatus = this.getStatusClass(this.ExpiryDate)
        console.log(this.mileageReport)
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

}
