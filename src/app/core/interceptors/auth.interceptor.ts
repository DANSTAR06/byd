import { HttpInterceptorFn } from '@angular/common/http';
import { inject } from '@angular/core';
import { catchError} from 'rxjs/operators';
import { throwError } from 'rxjs';
import { Router } from '@angular/router';
import { AuthService } from '../services/auth/auth.service';

export const authInterceptor: HttpInterceptorFn = (req, next) => {
  const authService = inject(AuthService);
  const router = inject(Router);

  // Get the current user
  const currentUser = authService.currentUserValue;

  // Add authorization header with jwt token if available
  if (currentUser && currentUser.token) {
    req = req.clone({
      setHeaders: {
        Authorization: `Bearer ${currentUser.token}`
      }
    });
  }

  // Handle potential token-related errors
  return next(req).pipe(
    catchError((error) => {
      // Handle unauthorized errors (401)
      if (error.status === 401) {
        // Try to refresh token
        authService.isAuthenticated$().subscribe(validity =>{
          if(validity == false){
            authService.logout()
          }
        })
      }

      // For other errors, rethrow
      return throwError(() => error);
    })
  );
};