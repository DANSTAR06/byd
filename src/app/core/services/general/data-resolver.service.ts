import { Injectable } from '@angular/core';
import { Resolve } from '@angular/router';

@Injectable({
  providedIn: 'root'
})
export class DataResolverService implements Resolve<any> {
  private sharedData: any;

  setData(data: any) {
    this.sharedData = data;
  }

  resolve(): any {
    return this.sharedData;
  }
}
