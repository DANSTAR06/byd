import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment.development';
import { HttpClient, HttpParams } from '@angular/common/http';
import { catchError, map, Observable } from 'rxjs';
import { PayementsDetails } from '../../models/payment.model';
import { Reports, ReportsResponse } from '../../models/reports.model';

@Injectable({
  providedIn: 'root'
})
export class MileageService {
  apiUrl = environment.apiUrl

  constructor(private http: HttpClient) { }

  getExpiryDate(){
     // Get the current date
     const currentDate = new Date();
    
     // Create a new date for the 14th of the next month
     const expiryDate = new Date(
       currentDate.getFullYear(), 
       currentDate.getMonth() + 1, // Move to next month
       14 // Set day to 14th
     );
     
     // Handle year rollover
     if (currentDate.getMonth() === 11) { // December
       expiryDate.setFullYear(currentDate.getFullYear() + 1);
     }
     
     return expiryDate;
  }

  getFormattedExpiryDate(): string {
    return this.getExpiryDate().toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
  }

  getISOFormattedExpiryDate(): string {
    const expiryDate = this.getExpiryDate();
    
    // Get year, month, and day with leading zeros
    const year = expiryDate.getFullYear();
    const month = String(expiryDate.getMonth() + 1).padStart(2, '0');
    const day = String(expiryDate.getDate()).padStart(2, '0');
    
    return `${year}-${month}-${day}`;
  }

  calculateMileage(modelType: any,carCapacity: any,fuelType: any,vehicleType: any,manufacturerYear: any){
   return this.http.get(this.apiUrl+"/mileage-info?model_type="+modelType+"&car_capacity="+carCapacity+"&fuel_type="+fuelType+"&vehicle_type="+vehicleType+"&manufacture_year="+manufacturerYear)
  }

  saveReport(report: Reports): Observable<Reports> {
      return this.http.post<any>(this.apiUrl+'/generatedReports/create', report)
            .pipe(
              map(response => {
                return response;
              }),
              catchError(error => {
               console.error('Saving failed', error);
                
                throw error;
              })
            );
  
    }

  getCustomerBasicPayments(customerId: any): Observable<PayementsDetails[]>{
    return this.http.get<PayementsDetails[]>(this.apiUrl+"/payments/userPackagePayments?account_number="+customerId+"&package_type=1")
   }

   getCustomerReportsAndExpenses(customerId: any): Observable<any []>{
    return this.http.get<any []>(this.apiUrl+"/generatedReports/customer?customer_id="+customerId)
   }

   getReportById(id: any){
    return this.http.get(this.apiUrl+"/generatedReportById?id="+id)
   }

   getVariables(){
    return this.http.get(this.apiUrl+"/variableCosts")
   }

   saveVariables(data: any, id: any){
    return this.http.put(this.apiUrl+'/variableCosts/'+id, data)
   }

   getAllReports(search: string, page: number, pageSize: number): Observable<ReportsResponse> {
       let params = new HttpParams()
         .set('search', search)
         .set('page', page.toString())
         .set('pageSize', pageSize.toString());
   
       return this.http.get<ReportsResponse>(this.apiUrl+'/generatedReports', { params });
     }

     getReportsBetweenDates(startDate: string, endDate: string): Observable<any> {
      return this.http.get(`${this.apiUrl}/generatedReports/dateRage?startDate=${startDate}&endDate=${endDate}`);
    }

    getVehicleRates(){
      return this.http.get(this.apiUrl+"/mileageDetails")
    }

    saveFixedRates(data: any, id: any){
      return this.http.put(this.apiUrl+'/mileageDetails/'+id, data)
     }
}
