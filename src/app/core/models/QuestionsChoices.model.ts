 export interface Choice {
    choice_id: number;
    question_id: number;
    choice: string;
    recommend: boolean;
  }
  
  export interface Question {
    quiz_id: number;
    cat_name: string;
    questions: string;
    marks: number;
    choices: Choice[];
  }
  
  export interface Pagination {
    current_page: number;
    page_size: number;
    total_items: number;
    total_pages: number;
  }
  
  export interface ApiResponse {
    status: string;
    message: string;
    data: {
      data: Question[];
      pagination: Pagination;
    };
  }