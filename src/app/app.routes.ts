import { Routes } from '@angular/router';
import { AuthGuard } from './core/guards/auth.guard';

export const routes: Routes = [

  {
    path: 'bestdrivercontest',
    loadComponent: () => import('./landingPage/web/web.component').then(m=>m.WebComponent)
  },
  {
    path: 'login',
    loadComponent: () => import('./features/auth/login/login.component')
      .then(m => m.LoginComponent)
  },
  {
    path: 'password-reset',
    loadComponent: () => import('./features/auth/password-reset/password-reset.component')
      .then(m => m.PasswordResetComponent)
  },
  
  {
    path: 'register',
    loadComponent: () => import('./features/auth/register/register.component')
      .then(m => m.RegisterComponent)
  },
  
  {
    path: 'mileage-report/validation', 
    loadComponent: () => import('./features/auth/report-validation/report-validation.component')
    .then(m => m.ReportValidationComponent)
  },
  {
    path: 'driver',
    canActivate: [AuthGuard],
    data: {roles: ['1']},
    loadChildren: () => import('./features/customer/customer.routes')
      .then(m => m.CUSTOMER_ROUTES)
  },
  {
    path: 'admin',
    canActivate: [AuthGuard],
    data: {roles: ['2']},
    loadChildren: () => import('./features/admin/admin.routes')
      .then(m => m.ADMIN_ROUTES)
  },
  { path: '', redirectTo: 'bestdrivercontest', pathMatch: 'full' },
  { path: '**', redirectTo: 'bestdrivercontest' },
 
];