export interface PaymentSTKIntiator {
  amount: number
  phone: string
  description: string
  accountName: string
  callBackUrl: string
  status: string

}

export interface PayementsDetails {
  id: number;
  customer_id: string;
  mpesa_reference: string;
  checkout_id: string;
  phone: string;
  amount_paid: number;
  date_paid: string;
}

export interface PaymentsList {
  id: number;
  customer: string;
  account_number: string;
  mpesa_reference: string;
  checkout_id: string;
  phone: string;
  amount_paid: number;
  date_paid: string;
  subscription: string;

}

export interface PaymentsListResponse {
    payments: PaymentsList[];
    total_count: number;
    page: number;
    page_size: number;
    total_pages: number;
  }

  export interface ApplicantPayment {
    pay_id: number;
    invoice_id: string;
    amount_paid: number;
    reference: string;
    phone: string;
    date_paid: string;
  }

