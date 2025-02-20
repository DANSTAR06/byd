import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { BehaviorSubject, Observable, of } from 'rxjs';
import { map, catchError } from 'rxjs/operators';
import { jwtDecode } from 'jwt-decode';
import { environment } from '../../../../environments/environment.development';
import { ToastService } from '../toast/toast.service';
import { Router } from '@angular/router';

export interface User {
  id?: number;
  email: string;
  names: string;
  phone: any;
  role: '1' | '2';
  token?: string;
}

interface JwtPayload {
  sub: string;
  email: string;
  role: any;
  exp: number;
  iat: number;
}

@Injectable({
  providedIn: 'root'
})


export class AuthService {
  currentUserSubject: BehaviorSubject<User | null>;
  public currentUser: Observable<User | null>;
  apiURL = environment.apiUrl
  
  constructor(private http: HttpClient, private toast: ToastService,private router: Router) {
    this.currentUserSubject = new BehaviorSubject<User | null>(this.getValidatedStoredUser());
    this.currentUser = this.currentUserSubject.asObservable();
  }

  private verifyTokenWithBackend(token: any) {
    return this.http.post(this.apiURL+'/verify-token',{token: token},{
        headers: new HttpHeaders().set('Content-Type','application/json')
      })
  }

  public isAuthenticated$(): Observable<boolean> {
    const user = this.currentUserValue;
    
    if (!user) return of(false);
  
    return this.verifyTokenWithBackend(user?.token).pipe(
      map((res: any) => res?.valid && this.isTokenValid(user.token || '')),
      catchError(() => of(false))
    );
  }

  // Validate and retrieve stored user
 getValidatedStoredUser(): User | null {
    const storedUser = localStorage.getItem('currentUser');
    if (!storedUser) return null;

    try {
      const user: User = JSON.parse(storedUser);
      // Validate token if exists
      if (user.token && this.isTokenValid(user.token)) {
        return user;
      }
      
      // Remove invalid token
      this.logout();
      return null;
    } catch (error) {
      // Remove invalid storage
      localStorage.removeItem('currentUser');
      return null;
    }
  }

  extractUser(): any{
    const storedUser = localStorage.getItem('currentUser');
    if (!storedUser) return null;
    try {
    const user: any = JSON.parse(storedUser); 
    const decodedToken: any = jwtDecode<JwtPayload>(user?.token);
    return decodedToken;
  } catch (error) {
    // Token is invalid or malformed
    return false;
  }
  }

  // Check if token is valid
  isTokenValid(token: any): boolean {
    try {
      const decodedToken = jwtDecode<JwtPayload>(token);
      
      // Check token expiration
      const currentTime = Math.floor(Date.now() / 1000);
      const isNotExpired = decodedToken.exp > currentTime;
      
      // Optional: Add additional validation checks
      const hasRequiredClaims = 
        !!decodedToken.email && 
        !!decodedToken.role;
     
      return isNotExpired && hasRequiredClaims;
    } catch (error) {
      // Token is invalid or malformed
      return false;
    }
  }

  // Login method with token validation
  login(email: string, password: string): Observable<User> {
    return this.http.post<any>(this.apiURL+'/login', { email, password })
      .pipe(
        map(response => {
          // Validate the received token
          if (response.token && this.isTokenValid(response.token)) {
            const userDetails = jwtDecode<JwtPayload>(response.token)
            // Construct user object
            const user: User = {
              phone: response.phone,
              email: response.email,
              names: response.names,
              role: userDetails.role,
              token: response.token
            };

            // Store user in local storage
            localStorage.setItem('currentUser', JSON.stringify(user));
            
            // Update current user subject
            this.currentUserSubject.next(user);
            
            return user;
          } else {
            throw new Error('Invalid token received');
          }
        }),
        catchError(error => {
          // Handle login errors
          //console.error('Login failed', error.error);
          this.toast.showError("Login Failed","Invalid Credentials. ")
          throw error;
        })
      );
  }

  // Register method
  register(user: User): Observable<User> {
    return this.http.post<any>(this.apiURL+'/register', user)
      .pipe(
        map(response => {
          console.log(response)
          return response;
        }),
        catchError(error => {
          console.log('Registration failed', error);
          console.error('Registration failed', error);
          throw error;
        })
      );
  }

  // Logout method
  logout() {
   
    localStorage.removeItem('currentUser');
    this.currentUserSubject.next(null);
    this.router.navigate(['../'])
  }

  getUserByEmail(email: any){
    return this.http.get(this.apiURL+'/checkAccount?email='+email)
    .pipe(
      map(response => {
        // You might want to handle registration response differently
        return response;
      }),
      catchError(error => {
        console.error('Failed', error);
        throw error;
      })
    );
  }

  resetPassword(email: any, password: any){

    let data = {email: email, password: password}
    
    return this.http.post<any>(this.apiURL+'/resetPassword', data)
    .pipe(
      map(response => {
        return response;
      }),
      catchError(error => {
        console.error('Failed to reset password', error);
        throw error;
      })
    );
  }

  // Getter for current user value
  public get currentUserValue(): User | null {
    return this.currentUserSubject.value;
  }

}