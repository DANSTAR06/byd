import { Routes } from "@angular/router";
import { AdminDashboardComponent } from "./admin-dashboard/admin-dashboard.component";
import { AuthGuard } from "../../core/guards/auth.guard";

export const ADMIN_ROUTES: Routes = [
 {path: '', component: AdminDashboardComponent,
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
      path: 'assessments',
      canActivate: [AuthGuard],
      loadComponent: () => import('./assessments/list-assessments/list-assessments.component').then(m => m.ListAssessmentsComponent)
    }
   
   ]
  }
];