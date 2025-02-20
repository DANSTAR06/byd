import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment.development';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { UserResponse } from '../../models/user.model';

@Injectable({
  providedIn: 'root'
})
export class CustomerService {

  private apiUrl = environment.apiUrl;

  constructor(private http: HttpClient) { }

  getUsers(search: string, page: number, pageSize: number): Observable<UserResponse> {
    let params = new HttpParams()
      .set('search', search)
      .set('page', page.toString())
      .set('pageSize', pageSize.toString());

    return this.http.get<UserResponse>(this.apiUrl+"/users", { params });
  }

  getUserById(userId: any){
    return this.http.get<any>(this.apiUrl+"/users/"+userId);
  }

  registerApplicant(formData: FormData): Observable<any> {
    return this.http.post(`${this.apiUrl}/register`, formData);
}
}
