import { ApplicationConfig } from '@angular/core';
import { provideRouter, withHashLocation } from '@angular/router';
import { routes } from './app.routes';
import { provideHttpClient, withInterceptors } from '@angular/common/http';
import { authInterceptor } from './core/interceptors/auth.interceptor';
import { provideAnimations } from '@angular/platform-browser/animations';
import { provideToastr } from 'ngx-toastr';
import { MatDialogModule } from '@angular/material/dialog';
import { provideCharts, withDefaultRegisterables } from 'ng2-charts';


import { CarouselModule } from 'ngx-owl-carousel-o';


export const appConfig: ApplicationConfig = {

  
  providers: [

    CarouselModule,
    provideRouter(routes),
    provideHttpClient(
      withInterceptors([authInterceptor])
    ),
    provideAnimations(), // required animations providers
    provideToastr({
      timeOut: 5000, // Toast visible duration
      positionClass: 'toast-bottom-right', // Position of toast
      preventDuplicates: true, // Prevent duplicate toasts
      progressBar: true, // Show progress bar
      closeButton: true // Show close button
    }), 
    { provide: MatDialogModule },
    provideCharts(withDefaultRegisterables()), provideRouter(routes, withHashLocation())
  ]
};