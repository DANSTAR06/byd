import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormArray, FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { MatDialogModule } from '@angular/material/dialog';
import { ToastService } from '../../../../core/services/toast/toast.service';
import { QuizService } from '../../../../core/services/question/quiz.service';

@Component({
  selector: 'app-add-assessment',
  standalone: true,
  imports: [CommonModule, FormsModule, ReactiveFormsModule, MatButtonModule, MatDialogModule],
  templateUrl: './add-assessment.component.html',
  styleUrl: './add-assessment.component.scss'
})
export class AddAssessmentComponent {

  questionForm: FormGroup;
  submittedQuestion: any = null;
  showNoCorrectAnswerError = false;

  constructor(private fb: FormBuilder, private toast: ToastService, private quizService: QuizService) {
    this.questionForm = this.fb.group({
      question: ['', Validators.required],
      marks: ['', Validators.required],
      choices: this.fb.array([
        this.createChoice(),
        this.createChoice(),
        this.createChoice(),
        this.createChoice()
      ])
    });
  }

  get choices() {
    return this.questionForm.get('choices') as FormArray;
  }

  createChoice() {
    return this.fb.group({
      text: ['', Validators.required],
      isCorrect: [false]
    });
  }

  onSubmit() {
  if (this.questionForm.valid) {
   let checkAnswer = this.hasCorrectAnswer();
   if(checkAnswer){
    //=====================submit question
    this.submittedQuestion = this.questionForm.value;
    let quiz = {
      assesment_cat_id: 1,
      questions: this.submittedQuestion.question,
      marks: this.submittedQuestion.marks
    }

    this.quizService.submitQuestion(quiz).subscribe((res: any) =>{
      let question_id = res.data.quiz_id;

      for (let index = 0; index < this.submittedQuestion.choices.length; index++) {
        const choice = this.submittedQuestion.choices[index].text;
        const asnswer = this.submittedQuestion.choices[index].isCorrect;
        
        let choiceData = {
          question_id: question_id,
          choice: choice,
          recommend: asnswer

        }

        this.quizService.submitQuestionChoice(choiceData).subscribe(res =>{})
        
      }

      this.toast.showSuccess("Success","Question Submitted Successifully")
      this.toast.sendClickEvent();
      this.resetForm();
      
    })


   } else {
    //=====================No answer given
    this.toast.showError("No Answer Selected!", "Please select one Choice as the answer for this question")

   }
   
    }
  }

  resetForm() {
    this.questionForm.reset();
    this.choices.controls.forEach((choice, index) => {
      choice.reset({
        text: '',
        isCorrect: false
      });
    });
    this.showNoCorrectAnswerError = false;
    this.submittedQuestion = null;
  }

  hasCorrectAnswer(): boolean {
    return this.choices.controls.some(choice => choice.get('isCorrect')?.value === true);
  }

  onChoiceCheckChange() {
    this.showNoCorrectAnswerError = false;
  }

}
