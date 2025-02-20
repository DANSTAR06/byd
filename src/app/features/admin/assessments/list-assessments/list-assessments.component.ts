import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { QuizService } from '../../../../core/services/question/quiz.service';
import { FormsModule } from '@angular/forms';
import { MatDialog, MatDialogModule } from '@angular/material/dialog';
import { AddAssessmentComponent } from '../add-assessment/add-assessment.component';
import { Subscription } from 'rxjs';
import { ToastService } from '../../../../core/services/toast/toast.service';
import { EditAssessmentComponent } from '../edit-assessment/edit-assessment.component';

@Component({
  selector: 'app-list-assessments',
  standalone: true,
  imports: [CommonModule, FormsModule, MatDialogModule],
  templateUrl: './list-assessments.component.html',
  styleUrl: './list-assessments.component.scss'
})
export class ListAssessmentsComponent {

  questions: any[] = [];
  pagination: any;
  currentPage = 1;
  pageSize = 5;
  pageSizeOptions = [5, 10, 20, 50, 100];

  clickEventsubscription:Subscription | undefined;
  allQuestions: any;

  constructor(private questionsService: QuizService, private matDialog: MatDialog, private toast: ToastService) {
    this.clickEventsubscription =   this.toast.getClickEvent().subscribe(()=>{
      this.loadPage(this.currentPage);
      this.getAllQuestions();
     })
  }

  ngOnInit() {
    this.loadPage(this.currentPage);
  }

  loadPage(page: number) {
    this.questionsService.getAllQuestionsWithChoices(page, this.pageSize)
      .subscribe(response => {
        if (response.status === 'success') {
          this.questions = response.data.data;
          this.pagination = response.data.pagination;
          this.currentPage = page;
        }
      });

      this.getAllQuestions();
  }

  getAllQuestions(){
    this.questionsService.getAllQuestionsWithoutChoices()
    .subscribe((response:any) => {
      this.allQuestions = response.data.questions
    
    });
  }

  getCorrectAnswer(choices: any[]): string {
    const correctChoice = choices.find(choice => choice.recommend);
    return correctChoice ? correctChoice.choice : '';
  }

  calculateTotalMarks(): number {
    return this.allQuestions.reduce((total :any, question: any) => total + question?.marks, 0);
  }

  onEdit(question: any) {
    const dialogRef = this.matDialog.open(EditAssessmentComponent, {
      width: '600px',
      data: question
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result) {
        
    let quiz = {
      quiz_id: Number(result.quiz_id),
      assesment_cat_id: 1,
      questions: result.questions,
      marks: Number(result.marks)
    }
     
    this.questionsService.updateQuestion(quiz,result.quiz_id).subscribe(res =>{})
  
      for (let index = 0; index < result.choices.length; index++) {
        const choice = result.choices[index].choice;
        const asnswer = result.choices[index].recommend;
        const choice_id = result.choices[index].choice_id;
        
        let choiceData = {
          question_id: quiz.quiz_id,
          choice_id: Number(choice_id),
          choice: choice,
          recommend: asnswer

        }

        this.questionsService.updateChoice(choiceData,choice_id).subscribe(res =>{})

      }
      
      this.toast.showSuccess("Success","Question Updated Successifully")
      this.getAllQuestions();
      this.loadPage(this.currentPage)
  
      }
    });
  }

  onPageSizeChange() {
    this.currentPage = 1;
    this.loadPage(this.currentPage);
  }

  addQuestion(){
   let dialog = this.matDialog.open(AddAssessmentComponent)
  }

}
