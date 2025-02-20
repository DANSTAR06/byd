import { Injectable } from '@angular/core';
import { ToastrService } from 'ngx-toastr';
import { Observable, Subject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ToastService {

  private subject = new Subject<any>();

  constructor(private toastr: ToastrService) { }

  showSuccess(title: any, message: any){
    this.toastr.success(message,title)
  }
  showError(title: any, message: any){
    this.toastr.error(message,title)
  }

  sendClickEvent() {
    this.subject.next(0)
  }
  
  getClickEvent(): Observable<any>{ 
    return this.subject.asObservable();
  }
}
