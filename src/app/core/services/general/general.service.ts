import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment.development';
import { HttpClient } from '@angular/common/http';
import { MileageCostingDetail } from '../../models/MileageCostingDetail.model';
import { map, Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class GeneralService {
  apiUrl = environment.apiUrl
  constructor(private http: HttpClient) { }

  getMileageDetails(): Observable<MileageCostingDetail[]> {
    return this.http.get<MileageCostingDetail[]>(this.apiUrl+'/mileageDetails');
  }

  filterMileageDetails(
    modelType: string, 
    fuelType: string, 
    vehicleType: string
  ): Observable<MileageCostingDetail[]> {
    return this.getMileageDetails().pipe(
      map(details => details.filter(detail => 
        detail.model_type === modelType &&
        detail.fuel_type === fuelType &&
        detail.vehicle_type === vehicleType
      ))
    );
  }

  getUniqueEngineCapacities(
    modelType: string, 
    fuelType: string, 
    vehicleType: string
  ): Observable<string[]> {
    return this.filterMileageDetails(modelType, fuelType, vehicleType).pipe(
      map(details => [...new Set(details.map(detail => detail.car_capacity))])
    );
  }

  sendEmail(to: any, subject: any, body: any) {

    let emailData = {
      host: environment.host,
      username : environment.username,
      password: environment.password,
      secure: environment.secure,
      port: environment.port,
      to: to,
      subject: subject,
      body: body
  }

  return this.http.post(this.apiUrl+"/sendEmail", emailData)

  }
}
