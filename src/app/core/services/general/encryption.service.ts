import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment.development';
import * as CryptoJS from 'crypto-js';

@Injectable({
  providedIn: 'root'
})
export class EncryptionService {

  encryptSecretKey = environment.encryptSecretKey;

  constructor() { }

  encryptData(data: any) {
    return CryptoJS.AES.encrypt(JSON.stringify(data), this.encryptSecretKey).toString();
}

decryptData(data: any) {

  try {
    const bytes = CryptoJS.AES.decrypt(data, this.encryptSecretKey);
    if (bytes.toString()) {
      return JSON.parse(bytes.toString(CryptoJS.enc.Utf8));
    }
    return data;
  } catch (e) {
    //console.log(e);
  }
}
}
