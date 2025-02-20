import { Routes } from '@angular/router';
import { AuthGuard } from '../../core/guards/auth.guard';
import { DashboardComponent } from './dashboard/dashboard.component';
import { DataResolverService } from '../../core/services/general/data-resolver.service';
export const CUSTOMER_ROUTES: Routes = [
  {path: '', 
    
    component: DashboardComponent,
   children: [
    {
      path: 'dashboard',
      canActivate: [AuthGuard],
      loadComponent: () => import('./home/home.component').then(m => m.HomeComponent)
    },
    {
      path: '',
      redirectTo: 'dashboard',
      pathMatch: 'full'
    },
    {
      path: 'profile',
      canActivate: [AuthGuard],
      loadComponent: () => import('./profile/profile.component').then(m => m.ProfileComponent)
    },
    {
      path: 'questions',
      canActivate: [AuthGuard],
      loadComponent: () => import('./questions/questions.component').then(m =>m.QuestionsComponent)
    },
    {
      path: 'payment',
      canActivate: [AuthGuard],
      loadComponent: () => import('./payment/payment.component').then(m =>m.PaymentComponent)
    }
   
   ]

  }
];