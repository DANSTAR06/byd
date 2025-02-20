import { Injectable } from '@angular/core';
import { QuizResponse, UserAnswer } from '../../models/quiz.model';
import { HttpClient } from '@angular/common/http';
import { catchError, map, Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ResultsResponse } from '../../models/results.models';
import { ApiResponse } from '../../models/QuestionsChoices.model';

@Injectable({
  providedIn: 'root'
})
export class QuizService {

  private baseUrl = environment.apiUrl;
  private userAnswers: UserAnswer[] = [];

  constructor(private http: HttpClient) {}

  getQuestions(categoryId: number, pageSize: number, page: number): Observable<QuizResponse> {
    return this.http.get<QuizResponse>(
      `${this.baseUrl}/questions/withChoices?category_id=${categoryId}&page_size=${pageSize}&page=${page}`
    );
  }

  setAnswer(questionId: number, choiceId: number) {
    const existingAnswerIndex = this.userAnswers.findIndex(
      answer => answer.questionId === questionId
    );

    if (existingAnswerIndex !== -1) {
      this.userAnswers[existingAnswerIndex].selectedChoiceId = choiceId;
    } else {
      this.userAnswers.push({ questionId, selectedChoiceId: choiceId });
    }
  }

  getAnswer(questionId: number): number | null {
    const answer = this.userAnswers.find(a => a.questionId === questionId);
    return answer ? answer.selectedChoiceId : null;
  }

  getAllAnswers(): UserAnswer[] {
    return [...this.userAnswers];
  }

  subAnswers(data: any){

    return this.http.post<any>(this.baseUrl+'/answers', data)
                .pipe(
                  map(response => {
                    return response;
                  }),
                  catchError(error => {
                   console.error('Saving failed', error);
                    
                    throw error;
                  })
                );

  }

  getResults(applicantId: number): Observable<ResultsResponse> {
    return this.http.get<ResultsResponse>(
      `${this.baseUrl}/answers/byApplicant?applicant_id=${applicantId}`
    );
  }

  getAllQuestionsWithChoices(page: number, pageSize: number): Observable<ApiResponse> {
    const params = {
      category_id: '1',
      page: page.toString(),
      page_size: pageSize.toString()
    };
    return this.http.get<ApiResponse>(this.baseUrl+'/questions/withChoices', { params });
  }

  getAllQuestionsWithoutChoices(): Observable<any> {
    return this.http.get<ApiResponse>(this.baseUrl+'/questions/byCategory?category_id=1');
  }

  updateQuestion(data: any, quiz_id: any){
    return this.http.put<any>(this.baseUrl+'/questions/'+quiz_id, data)
  }

  updateChoice(data: any, choice_id: any){
    return this.http.put<any>(this.baseUrl+'/choices/'+choice_id, data)
  }

  submitQuestion(data: any){

    return this.http.post<any>(this.baseUrl+'/questions', data)
    .pipe(
      map(response => {
        return response;
      }),
      catchError(error => {
       console.error('Saving failed', error);
        
        throw error;
      })
    );

  }

  submitQuestionChoice(data: any){
    return this.http.post<any>(this.baseUrl+'/choices', data)
    .pipe(
      map(response => {
        return response;
      }),
      catchError(error => {
       console.error('Saving failed', error);
        
        throw error;
      })
    );
  }

  craeteSubmission(data: any){
    return this.http.post<any>(this.baseUrl+'/submissions', data)
    .pipe(
      map(response => {
        return response;
      }),
      catchError(error => {
       console.error('Saving failed', error);
        
        throw error;
      })
    );
  }

  getSubmissions(applicantId: number): Observable<any> {
    return this.http.get<any>(
      `${this.baseUrl}/submissions?id=${applicantId}`
    );
  }

  deleteApplicantAnswers(applicantId: number) {
    return this.http.delete(
      `${this.baseUrl}/answers/${applicantId}?applicant_id=${applicantId}`
    );
  }
}
