import { CommonModule } from '@angular/common';
import { Component, Inject } from '@angular/core';
import { FormArray, FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { MAT_DIALOG_DATA, MatDialogModule, MatDialogRef } from '@angular/material/dialog';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { ToastService } from '../../../../core/services/toast/toast.service';

@Component({
  selector: 'app-edit-assessment',
  standalone: true,
  imports: [CommonModule, FormsModule, ReactiveFormsModule, MatButtonModule, MatDialogModule, MatCheckboxModule, MatFormFieldModule, MatInputModule],
  templateUrl: './edit-assessment.component.html',
  styleUrl: './edit-assessment.component.scss'
})
export class EditAssessmentComponent {

  questionForm: FormGroup;
  
  constructor(
    private fb: FormBuilder,
    private dialogRef: MatDialogRef<EditAssessmentComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private toast: ToastService
  ) {
    this.questionForm = this.fb.group({
      quiz_id: data.quiz_id,
      marks: [data.marks, Validators.required],
      questions: [data.questions, Validators.required],
      choices: this.fb.array(
        data.choices.map((choice: any) => this.fb.group({
          choice_id: [choice.choice_id],
          choice: [choice.choice, Validators.required],
          recommend: [choice.recommend]
        }))
      )
    });
  }

  get choicesFormArray() {
    return this.questionForm.get('choices') as FormArray;
  }

  hasCorrectAnswer(): boolean {
    return this.choicesFormArray.controls.some(choice => choice.get('recommend')?.value === true);
  }

  onSubmit() {
    if (this.questionForm.valid) {
      let hasAnswer = this.hasCorrectAnswer();
      if(hasAnswer)
      {
      this.dialogRef.close(this.questionForm.value);
      } else {
        this.toast.showError("No Answer Selected!", "Please select one Choice as the answer for this question") 
      }
    }
  }

  onCancel() {
    this.dialogRef.close();
  }

}
