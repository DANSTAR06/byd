export interface User {
    id?: number;
    email: string;
    phone: string
    password?: string;
    password2?: string;
    names: string;
    role: '1' | '2';
    token?: string;
  }

  export interface Customer {
    id?: number;
    email: string;
    phone: string
    names: string;
    role: "1" | "2";
    creation_date: any
  }

  export interface UserResponse {
    users: Customer[];
    total_count: number;
    page: number;
    page_size: number;
    total_pages: number;
  }

  export interface Applicant {
    region_id: number;
    full_name: string;
    national_id: string;
    email: string;
    phone_number: string;
    gender: string;
    dob: string;
    dl_no: string;
    password: string;
    role: string;
   // knowhow: string
}

  

   