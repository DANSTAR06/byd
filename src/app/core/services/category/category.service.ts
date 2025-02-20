import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { catchError, map, Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class CategoryService {

  private apiUrl = environment.apiUrl;
  
    constructor(private http: HttpClient) { }

    getCategories(): Observable<any> {
      return this.http.get(this.apiUrl+"/categories");
    }

    saveApplicantCategories(data: any){
       return this.http.post<any>(this.apiUrl+"/applicantCategories", data)
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

    deleteUserCategories(applicantId: any): Observable<any> {
      return this.http.delete(this.apiUrl+"/applicantCategories/"+applicantId+"?id="+applicantId);
    }

    getApplicantAppliedCategory(applicantId: any) {
      return this.http.get(this.apiUrl+"/applicantCategories/byApplicant?applicant_id="+applicantId);
    }
  
}
