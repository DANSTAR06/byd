// import { Component } from '@angular/core';
// import { RouterModule } from '@angular/router';

// @Component({
//   selector: 'app-web',
//   imports: [RouterModule],
//   templateUrl: './web.component.html',
//   styleUrl: './../../../assets/webstyle/css/style.css'
// })
// export class WebComponent {

// }
import { Component, OnInit, Renderer2, Inject, PLATFORM_ID } from '@angular/core';
import { isPlatformBrowser } from '@angular/common';
import { RouterModule } from '@angular/router';
import { Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { OwlOptions } from 'ngx-owl-carousel-o';
import { CarouselModule } from 'ngx-owl-carousel-o';
import { FaqsComponent } from '../faqs/faqs.component';
import { GalleryComponent } from '../gallery/gallery.component';
import { VideoGalleryComponent } from "../video-gallery/video-gallery.component";
import { WebsiteHeaderComponent } from "../website-header/website-header.component";
import { CountersComponent } from "../counters/counters.component";
import { EligibilityComponent } from "../eligibility/eligibility.component";
import { AdchallangeComponent } from '../adchallange/adchallange.component';



@Component({
  selector: 'app-web',
  imports: [RouterModule, CommonModule, CarouselModule, FaqsComponent, GalleryComponent, VideoGalleryComponent, WebsiteHeaderComponent, EligibilityComponent,AdchallangeComponent],
  templateUrl: './web.component.html',
  styleUrl: './../../../assets/webstyle/css/style.css'
})
export class WebComponent implements OnInit {
  title = 'AAK Best Driver';

  videos = [
    // { src: './../../../assets/coverr-a-girl-takes-photos-with-a-smartphone-of-her-monitor-8675-1080p.mp4' },
    // { src: './../../../assets/webstyle/cover/coverr-close-up-of-a-man-using-a-wireless-mouse-8923-1080p.mp4' },
    // { src: './../../../assets/webstyle/cover/coverr-close-up-of-a-man-using-a-wireless-mouse-8923-1080p.mp4' },

    { src: 'https://www.w3schools.com/html/mov_bbb.mp4' },
    { src: 'https://www.w3schools.com/html/movie.mp4' },
    { src: 'https://www.w3schools.com/html/mov_bbb.mp4' },
  ];

  carouselOptions: OwlOptions = {
    loop: true,
    margin: 10,
    autoplay: true,
    autoplayTimeout: 5000, // Change video every 5s
    autoplayHoverPause: true,
    nav: true,
    dots: true,
    items: 1, // One video at a time
   // video: true,
    lazyLoad: true,
    center: true,
  };


  constructor(private router: Router,
    private renderer: Renderer2,
    @Inject(PLATFORM_ID) private platformId: Object 
  ) {}


  isHomePage(): boolean {
    return this.router.url === '/';
  }





  

  ngOnInit(): void {
    if (isPlatformBrowser(this.platformId)) { // Run only on browser
      
      this.loadScript('./../../../assets/webstyle/js/main.js'); 
      this.loadScript('./../../../assets/webstyle/js/challangetransition.js');
      this.loadScript('./../../../assets/webstyle/lib/jquery/jquery.min.js');
      this.loadScript('./../../../assets/webstyle/lib/jquery/jquery-migrate.min.js');
      this.loadScript('./../../../assets/webstyle/lib/bootstrap/js/bootstrap.bundle.min.js');
      this.loadScript('./../../../assets/webstyle/lib/easing/easing.min.js');
      this.loadScript('./../../../assets/webstyle/lib/waypoints/waypoints.min.js');
      this.loadScript('./../../../assets/webstyle/lib/counterup/counterup.min.js');
      this.loadScript('./../../../assets/webstyle/lib/owlcarousel/owl.carousel.min.js');
      this.loadScript('./../../../assets/webstyle/lib/lightbox/js/lightbox.min.js');

      //cdn
      this.loadScript('https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js');
      this.loadScript('https://cdnjs.cloudflare.com/ajax/libs/waypoints/4.0.1/waypoints.min.js');
      this.loadScript('https://cdnjs.cloudflare.com/ajax/libs/Counterup/1.0.3/jquery.counterup.min.js');
      this.loadScript('https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js');
      this.loadScript('https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/js/lightbox.min.js');
      this.loadScript('https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js');
      this.loadScript('https://code.jquery.com/jquery-3.5.1.slim.min.js');
    }
  }

  loadScript(src: string) {
    const script = this.renderer.createElement('script');
    script.src = src;
    script.type = 'text/javascript';
    script.async = true;
    this.renderer.appendChild(document.body, script);
  }
}



