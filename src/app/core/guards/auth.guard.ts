import { Injectable } from '@angular/core';
import { 
  CanActivate, 
  ActivatedRouteSnapshot, 
  RouterStateSnapshot, 
  Router 
} from '@angular/router';
import { AuthService } from '../services/auth/auth.service';
import { map, Observable } from 'rxjs';


@Injectable({
  providedIn: 'root'
})
export class AuthGuard implements CanActivate {
  constructor(
    private authService: AuthService,
    private router: Router
  ) {}

  canActivate(
    route: ActivatedRouteSnapshot, 
    state: RouterStateSnapshot
  ): Observable<boolean> {
    return this.authService.isAuthenticated$().pipe(
      map(isAuthenticated => {
        if (!isAuthenticated) {
          // Not authenticated, redirect to login
          this.router.navigate(['/login'], { 
            queryParams: { returnUrl: state.url } 
          });
          return false;
        }
  
        // Check if route is restricted by role
        const currentUser = this.authService.currentUserValue;
       
        if (route.data['roles'] && currentUser) {
          // Check if user's role matches required roles
          if (!route.data['roles'].includes(currentUser.role)) {
            // Role not authorized, redirect to login
            this.router.navigate(['/login']);
            return false;
          }
        }
        
        return true;
      })
    );
  }
}