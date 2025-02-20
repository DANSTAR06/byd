import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';

@Component({
  selector: 'app-video-gallery',
  templateUrl: './video-gallery.component.html',
  styleUrls: ['./video-gallery.component.scss','./../../../assets/webstyle/css/style.css'],
  imports: [CommonModule,FontAwesomeModule]
})
export class VideoGalleryComponent {

  videos: string[] = [
    // './../../../assets/webstyle/cover/coverr-a-girl-standing-in-the-house-holding-a-laptop-2405-1080p.mp4',
    // './../../../assets/webstyle/cover/coverr-a-girl-takes-photos-with-a-smartphone-of-her-monitor-8675-1080p.mp4',
    './../../../assets/webstyle/website/FIRST TRAILER FOR WEBSITE.mp4',
    // './../../../assets/webstyle/cover/Woman working on laptop outdoors - Free Stock Video Footage.mp4',
  ];
  currentVideoIndex: number = 0;

  playNextVideo() {
    this.currentVideoIndex = (this.currentVideoIndex + 1) % this.videos.length;
  }

  nextVideo() {
    this.currentVideoIndex = (this.currentVideoIndex + 1) % this.videos.length;
  }

  prevVideo() {
    this.currentVideoIndex = (this.currentVideoIndex - 1 + this.videos.length) % this.videos.length;
  }
}

