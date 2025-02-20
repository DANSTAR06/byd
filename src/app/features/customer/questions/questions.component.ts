import { Component } from '@angular/core';
import { Pagination, Question } from '../../../core/models/quiz.model';
import { QuizService } from '../../../core/services/question/quiz.service';
import { CommonModule } from '@angular/common';
import { MatDialog, MatDialogModule } from '@angular/material/dialog';
import {MatProgressBarModule} from '@angular/material/progress-bar';

import { ToastService } from '../../../core/services/toast/toast.service';
import { AuthService } from '../../../core/services/auth/auth.service';
import { ConfirmModalComponent } from '../confirm-modal/confirm-modal.component';
import { Answer } from '../../../core/models/results.models';
import { CategoryService } from '../../../core/services/category/category.service';
import { PaymentsService } from '../../../core/services/general/payments.service';
import { Router } from '@angular/router';


@Component({
  selector: 'app-questions',
  standalone: true,
  imports: [CommonModule, MatDialogModule, MatProgressBarModule],
  templateUrl: './questions.component.html',
  styleUrl: './questions.component.scss'
})
export class QuestionsComponent {

  questions: Question[] = [];
  pagination!: Pagination;
  loading = false;
  error: string | null = null;
  currenntUser: any
  userId: any
  submitting = false;
  numberOfSubmissions = 0;
  timeCount = 0;
  retakeAllowed = false;

  answers: Answer[] = [];
  loadingResults = false;
  totalMarks = 0;
  scoredMarks = 0;

  savedCategory: any
  categoryName: any;
  categoryId: any
  categoryFees: any
  applicantTotalPayment: any

  constructor(private quizService: QuizService, private matDialog: MatDialog,private paymentService: PaymentsService, 
    private toast: ToastService, private authService: AuthService,private categoryService: CategoryService, private router: Router) {
    this.currenntUser = this.authService.extractUser();
    this.userId = this.currenntUser.user_id


    this.categoryService.getApplicantAppliedCategory(this.userId).subscribe((res:any) => {

      if(res.data == null)
      {
        //===================================== No category
        this.router.navigate(['/driver/dashboard'])
      } else {
      this.savedCategory = res;
      this.categoryId =  this.savedCategory.data[0].category_id
      this.categoryFees =  this.savedCategory.data[0].category.cat_fees

      this.paymentService.getApplicantTotalPayments(this.userId).subscribe(res => {
        this.applicantTotalPayment = res;
       
        if(this.applicantTotalPayment < this.categoryFees)
        {
          //============================ Go to payment
          this.router.navigate(['/driver/payment'])
        } else {
          //=============================== Go to assesment
          
        }
      })
     
      }
    })


    this.loadResults()
    this.checkNoOfSubmissions();

  }

  ngOnInit() {
    this.loadQuestions(1);
  }

  loadQuestions(page: number) {
    this.loading = true;
    this.error = null;

    this.quizService.getQuestions(1, 1, page).subscribe({
      next: (response) => {
        this.questions = response.data.data;
        this.pagination = response.data.pagination;
        this.loading = false;
      },
      error: (error) => {
        this.error = 'Failed to load questions. Please try again.';
        this.loading = false;
      }
    });
  }

  onAnswerSelected(questionId: number, choiceId: number) {
    this.quizService.setAnswer(questionId, choiceId);
  }

  isAnswerSelected(questionId: number, choiceId: number): boolean {
    return this.quizService.getAnswer(questionId) === choiceId;
  }

  onSubmit() {
    const answers = this.quizService.getAllAnswers();
    let questionsAnswered = answers.length
   
    if(questionsAnswered < this.pagination.total_items)
    {
      this.toast.showError("Uncomplete Assigment","Please complete your assignment before submission. You have done "+questionsAnswered+" of "+ this.pagination.total_items+" Questions")
    } else {
    const dialogRef = this.matDialog.open(ConfirmModalComponent, 
      {
      width: '350px',
      data: { 
        message: 'Are you sure you want to submit your work?',
        title: 'Confirm Submission' 
      }
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result) {
        this.submitting = true
        this.countToTen();
        for (let index = 0; index < questionsAnswered; index++) {
          const element = answers[index];
          const quizId = element.questionId;
          const choiceId = element.selectedChoiceId;
    
          let data = {
            applicant_id: this.userId,
            question_id: quizId,
            choice_id: choiceId
           }
           
          //================================================= answer submission
          this.sumbimitAnswerToServer(data)
        }
       
        this.createSubmission();

        const delayedFunction = (): void => {
          this.submitting = false
          this.loadResults()
      };
        setTimeout(delayedFunction, 4000);
      }
    });

  }
  
  }

async  countToTen(): Promise<void> {
    for (let i = 1; i <= this.pagination.total_items; i++) {
        await new Promise(resolve => setTimeout(resolve, 500));
        this.timeCount = i;
    }
 
}

 createSubmission(){
  const d = new Date("2021-03-25")
  let today = d.getDate()+'-'+d.getMonth()+'-'+d.getFullYear();
  let data = {
   applicant_id: this.userId,
   s_count: 1,
   date_submitted: today
  }
  this.quizService.craeteSubmission(data).subscribe(res =>{})
 }

  sumbimitAnswerToServer(data:any){
    this.quizService.subAnswers(data).subscribe(res =>{ })
  }
  goToPage(page: number) {
    if (page >= 1 && page <= this.pagination.total_pages) {
      this.loadQuestions(page);
    }
  }

  isLastPage(): boolean {
    return this.pagination?.current_page === this.pagination?.total_pages;
  }

 //============================================================== results
 loadResults() {
  this.loadingResults = true;
  this.error = null;

  this.quizService.getResults(this.userId).subscribe({
    next: (response) => {
      this.answers = response.data;
      this.calculateTotalMarks();
      this.loadingResults = false;
    },
    error: (error) => {
      this.error = 'Failed to load results. Please try again.';
      this.loadingResults = false;
    }
  });
}

retakeAssesment() {
  this.quizService.deleteApplicantAnswers(this.userId).subscribe(res =>{
    this.router.navigate(['/driver/dashboard'])
  })
}

checkNoOfSubmissions(){
  this.quizService.getSubmissions(this.userId).subscribe(res =>{
    this.numberOfSubmissions = res.data?.length

  })
}

private calculateTotalMarks() {
  this.totalMarks = this.answers.reduce((sum, answer) => sum + answer.marks, 0);
  this.scoredMarks = this.answers.reduce((sum, answer) => 
    sum + (answer.verdict ? answer.marks : 0), 0);
}

getScorePercentage(): number {
  return (this.scoredMarks / this.totalMarks) * 100;
}

getScoreColor(): string {
  const percentage = this.getScorePercentage();
  if (percentage >= 50) return '#4CAF50';
  if (percentage >= 30) return '#FFA726';
  return '#F44336';
}  

}
