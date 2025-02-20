import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';

@Component({
  selector: 'app-faqs',
  imports: [CommonModule],
  templateUrl: './faqs.component.html',
  styleUrl: './../../../assets/webstyle/css/style.css'
})
export class FaqsComponent {


  faqs = [
    {
      question: "How to participate?",
      answer: "Click/Tap on Register Link on the navigation bar, fill in the required fields and submit your application.",
      open: false
    },
    {
      question: "How much does it cost?",
      answer: 'Check the <a href="#pay">Contest charges section.</a> Fees vary per category.',
      open: false
    },
    {
      question: "How do I pay?",
      answer: "After successful registration, you will log in, select the category you want, then choose either pay by initiating STK push to type in your PIN or use Paybill as you will see displayed on your screen.",
      open: false
    }
  ];

  toggleFaq(index: number) {
    this.faqs[index].open = !this.faqs[index].open;
  }
}

