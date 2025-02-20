import { CommonModule } from '@angular/common';
import { Component, AfterViewInit,OnInit, ChangeDetectorRef } from '@angular/core';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faHeart, faUsers, faClock, faFlag } from '@fortawesome/free-solid-svg-icons';
declare var $: any; // Declare jQuery globally

@Component({
  selector: 'app-counters',
  templateUrl: './counters.component.html',
  styleUrls: ['./counters.component.css','./../../../assets/webstyle/css/style.css'],
  imports: [CommonModule,FontAwesomeModule]
})
export class CountersComponent implements AfterViewInit {
  // FontAwesome Icons
  faHeart = faHeart;
  faUsers = faUsers;
  faClock = faClock;
  faFlag = faFlag;

  counters = [
    { icon: this.faHeart, target: 100, label: 'Awards' },
    { icon: this.faUsers, target: 50, label: 'Partners' },
    { icon: this.faClock, target: 3, label: 'Eliminations' },
    { icon: this.faFlag, target: 20, label: 'Challenges' }
  ];

  ngAfterViewInit(): void {
    this.startCounting();
  }

  startCounting() {
    $('.counter').each(function (this: HTMLElement) {
      let $this = $(this); // Properly typing "this" for jQuery
      let target = Number($this.attr('data-target')); // Convert to number
      let count = 0;
      let increment = Math.ceil(target / 100);
      let interval = setInterval(() => {
        count += increment;
        if (count >= target) {
          $this.text(target);
          clearInterval(interval);
        } else {
          $this.text(count);
        }
      }, 20); // Adjust speed here
    });
  }
}


