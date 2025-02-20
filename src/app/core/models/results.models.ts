export interface Answer {
    answer_id: number;
    question: string;
    answer: string;
    verdict: boolean;
    marks: number;
  }
  
  export interface ResultsResponse {
    status: string;
    message: string;
    data: Answer[];
  }