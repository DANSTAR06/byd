
import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { CarouselModule, OwlOptions } from 'ngx-owl-carousel-o';  
@Component({
  selector: 'app-gallery',
  templateUrl: './gallery.component.html',
  styleUrls: ['./gallery.component.css','./../../../assets/webstyle/css/style.css'],
  imports: [CarouselModule,CommonModule],
})
export class GalleryComponent {
  images = [
    './../../../assets/webstyle/bg/2R6A9822.jpg',
    './../../../assets/webstyle/website/2R6A7772.JPG',
    './../../../assets/webstyle/bg/2R6A9839.jpg',
    './../../../assets/webstyle/website/IMG_0461.jpg',
    './../../../assets/webstyle/bg/2R6A9844.jpg',
    './../../../assets/webstyle/website/IMG_0790.jpg',
    './../../../assets/webstyle/bg/2R6A9904.jpg',
    './../../../assets/webstyle/bg/IMG_0085.jpg',
    './../../../assets/webstyle/website/IMG_0783.jpg',
    './../../../assets/webstyle/website/2R6A1583.jpg',
    './../../../assets/webstyle/website/2R6A7411.JPG',
    './../../../assets/webstyle/website/IMG_1354.JPG',
    './../../../assets/webstyle/website/IMG_1330.JPG',
    './../../../assets/webstyle/website/IMG_1355.JPG',
    './../../../assets/webstyle/website/IMG_9992.jpg',
    './../../../assets/webstyle/website/IMG_0623.jpg',
    './../../../assets/webstyle/website/IMG_0790.jpg',
    './../../../assets/webstyle/website/IMG_1333.JPG',
    

  ];


  customOptions: OwlOptions = {
    loop: true,
    margin: 10,
    autoplay: true,
    autoplayTimeout: 2000,  // Slide after 2 seconds
    autoplayHoverPause: false,
    nav: true,
    dots: true,
    items: 1,  // Set the number of items per slide


    responsive: {
      0: {
        items: 1,  // 1 item on mobile (<= 480px)
        autoplay: true
      },
      600: {
        items: 2,  // 2 items on tablet (>= 600px)
      },
      1000: {
        items: 3  // 3 items on larger screens (>= 1000px)
      }
    }
  };

  // ngAfterViewInit() {
  //   // This will trigger a refresh after the view is initialized, ensuring autoplay works
  //   setTimeout(() => {
  //     const owlCarousel = document.querySelector('owl-carousel-o');
  //     if (owlCarousel) {
  //       owlCarousel['carousel'].play();
  //     }"node_modules/ngx-owl-carousel-o/lib/styles/scss/owl.carousel.scss",
  //   }, 1000);
  // }

}

