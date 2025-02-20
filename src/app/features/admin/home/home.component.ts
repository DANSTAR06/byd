// home.component.ts
import { CommonModule, DatePipe } from '@angular/common';
import { Component, OnInit, ViewChild } from '@angular/core'; // Changed from Input to OnInit
import { BaseChartDirective } from 'ng2-charts';
import { ChartConfiguration, ChartData} from 'chart.js';
import 'chart.js/auto';
import { PaymentsService } from '../../../core/services/payments/payments.service';
import { FormsModule } from '@angular/forms';
import { CurrencyFormatPipe } from '../../../shared/pipes/currency-format.pipe';
import { MileageService } from '../../../core/services/mileage/mileage.service';
import { CustomerService } from '../../../core/services/customer/customer.service';
import { UserResponse } from '../../../core/models/user.model';

export interface DailySales {
  date: string;
  amount: number;
}

export interface MonthDailySales {
  month: string;
  sales: DailySales[];
}

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule, BaseChartDirective, FormsModule],
  providers: [DatePipe],
  templateUrl: './home.component.html',
  styleUrl: './home.component.scss'
})
export class HomeComponent implements OnInit { 
  monthStatics: any;
  @ViewChild(BaseChartDirective) chart?: BaseChartDirective;

  payments: any[] = [];
  monthReports: any;
  monthTotalAmount: number = 0;
  annualTotalAmount: number = 0;
  selectedMonth: any;
  selectedYear = '0';
  monthlyTotals: any;
  error: string = '';
  availableYears = ['2023','2024','2025']
  totalCustomers: any
  totalReports: any
  date1: any;
  date2: any;

  monthDailySales: MonthDailySales[] = [];
  private currencyPipe = new CurrencyFormatPipe();

  public barChartOptions: ChartConfiguration['options'] = {
    responsive: true,
    scales: {
      x: {
        title: {
          display: true,
          text: 'Days of Month'
        }
      },
      y: {
        min: 0,
        title: {
          display: true,
          text: 'Sales Amount (KES)'
        }
      }
    },
    plugins: {
      legend: {
        display: true,
        position: 'top'
      },
      title: {
        display: true,
        text: ''
      }
    }
  };

  public barChartData: ChartData<'bar'> = {
    labels: [],
    datasets: []
  };

  //================================================================= pie chart
  public pieChartData: ChartConfiguration<'pie'>['data'] = {
    labels: ['BYD', 'Legends', 'Masters', 'Ladies'],
    datasets: [{
      data: [300, 500, 200, 250],
      backgroundColor: [
        'rgb(255, 99, 132)',
        'rgb(255, 206, 86)',
        'rgb(75, 192, 192)',
        'rgb(153, 102, 255)'
      ],
      hoverOffset: 4
    }]
  };

  public pieChartOptions: ChartConfiguration<'pie'>['options'] = {
    responsive: true,
    plugins: {
      legend: {
        display: true,
        position: 'top',
      },
      title: {
        display: true,
        text: 'Categories Registrations'
      }
    }
  };

  constructor(private paymentService: PaymentsService, private datePipe: DatePipe, 
    private mileageService: MileageService, private userService: CustomerService) {
    const currentDate = new Date();
    this.selectedMonth = this.datePipe.transform(currentDate, 'MM') || '';
    this.selectedYear = this.datePipe.transform(currentDate, 'yyyy') || '';

    this.monthStatics =  currentDate.toLocaleString('en-US', { month: 'long', year: 'numeric' });

    this.loadPayments();
    this.loadCustomers()


  }

  ngOnInit() {}

  loadCustomers(): void {
      this.userService.getUsers('',1,0)
        .subscribe((response: UserResponse) => {
          this.totalCustomers = response.total_count;
        });
    }

  loadPayments(): void {
    const startDate = `${this.selectedMonth}/01/${this.selectedYear}`;
    const endDate = `${this.selectedMonth}/31/${this.selectedYear}`;

    this.paymentService.getPaymentsBetweenDates(startDate, endDate).subscribe((response: any) => {
      this.payments = response.payments;
      this.monthTotalAmount = response.totalAmount;
      console.log(this.payments)
      this.monthDailySales = this.transformPaymentsToMonthDailySales(this.payments);
      console.log(this.monthDailySales)
     
      this.updateChartData();
    });
  }

  private transformPaymentsToMonthDailySales(payments: any[]): { month: string, sales: { date: string, amount: number }[] }[] {
    const groupedByMonth: { [key: string]: { [key: string]: number } } = {};
  
    // Group payments by month and date, summing amounts for each date
    payments.forEach(payment => {
      const datePaid = new Date(payment.date_paid);
      const monthKey = datePaid.toLocaleString('default', { month: 'long', year: 'numeric' }); // e.g., "February 2025"
      const dateKey = payment.date_paid.split(' ')[0]; // Extract date part (YYYY-MM-DD)
  
      if (!groupedByMonth[monthKey]) {
        groupedByMonth[monthKey] = {};
      }
  
      if (!groupedByMonth[monthKey][dateKey]) {
        groupedByMonth[monthKey][dateKey] = 0;
      }
  
      groupedByMonth[monthKey][dateKey] += payment.amount_paid;
    });
  
    // Convert grouped data into the desired format
    return Object.keys(groupedByMonth).map(month => ({
      month: month,
      sales: Object.keys(groupedByMonth[month]).map(date => ({
        date: date,
        amount: groupedByMonth[month][date]
      }))
    }));
  }

  onMonthChange(event: any): void {
    let monthYear = event.target.value;
    const [year, month] = monthYear.split('-');

    this.selectedMonth = month;
    this.selectedYear = year;

    this.loadPayments();
  }

 

//---------------------------------------------Month Cahrt
  private updateChartData(): void {
    // Get all unique days from the first month to set as labels
    const daysInMonth = this.monthDailySales[0]?.sales.map(sale => sale.date
    ) || [];

    // Create datasets for each month
    const datasets = this.monthDailySales.map(monthData => ({
      data: monthData.sales.map(sale => sale.amount),
      label: 'Total '+this.formatPrice(this.annualTotalAmount), 
      backgroundColor: this.getRandomColor(0.2),
      borderColor: this.getRandomColor(1),
      borderWidth: 1
    }));

    this.barChartData = {
      labels: daysInMonth,
      datasets: datasets
    };

    // Update the chart
    if (this.chart) {
      this.chart.update();
    }
  }

  

  private getRandomColor(alpha: number): string {
    const r = Math.floor(Math.random() * 255);
    const g = Math.floor(Math.random() * 255);
    const b = Math.floor(Math.random() * 255);
    return `rgba(${r}, ${g}, ${b}, ${alpha})`;
  }

  formatPrice(value: number): string {
    return this.currencyPipe.transform(value);
  }


}