export interface Reports {
    customer_id : number
    vehicle_type : string
    capacity : string
    car_age  : number
    fuel_type : string
    model_type : string
	fuel_cost : number
    tyre_cost : number
    service_cost : number
    repair_cost : number
    opearation_cost : number
    fixed_cost : number
    total_running_cost : number
    amount_spent : number
    expiry_date : string
	subscription: number
    
}

export interface ReportsListing {
    id: number
    customer_id : number
    customer_name: any
    vehicle_type : string
    capacity : string
    car_age  : number
    fuel_type : string
    model_type : string
	fuel_cost : number
    tyre_cost : number
    service_cost : number
    repair_cost : number
    opearation_cost : number
    fixed_cost : number
    total_running_cost : number
    amount_spent : number
    expiry_date : string
    date_created: any
	subscription: number
    
}

 export interface ReportsResponse {
    reports: ReportsListing[];
    total_count: number;
    page: number;
    page_size: number;
    total_pages: number;
  }