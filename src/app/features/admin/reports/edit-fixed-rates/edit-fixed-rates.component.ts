import { Component, Inject } from '@angular/core';
import { MileageService } from '../../../../core/services/mileage/mileage.service';
import { ToastService } from '../../../../core/services/toast/toast.service';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-edit-fixed-rates',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './edit-fixed-rates.component.html',
  styleUrl: './edit-fixed-rates.component.scss'
})
export class EditFixedRatesComponent {

  id:any;
  vehicle_type:any
  car_capacity:any
  fuel_type:any
  kml_petrol:any
  kml_diesel:any
  vehicle_value:any
  service_cost:any
  repair_cost:any
  tyres_cost :any

  constructor(@Inject(MAT_DIALOG_DATA) public data: {id:any,vehicle_type:any,car_capacity:any,fuel_type:any,kml_petrol:any,kml_diesel:any,vehicle_value:any,service_cost:any,repair_cost:any,tyres_cost :any}, 
    private mileageService: MileageService, private toast : ToastService){
      this.id = data.id
      this.vehicle_type = data.vehicle_type
      this.car_capacity = data.car_capacity
      this.fuel_type = data.fuel_type
      this.kml_petrol = data.kml_petrol
      this.kml_diesel  = data.kml_diesel
      this.vehicle_value = data.vehicle_value
      this.service_cost = data.service_cost
      this.repair_cost = data.repair_cost
      this.tyres_cost = data.tyres_cost
    }

    saveChanges(){
      let data = {
        id: this.id,
        kml_petrol: this.kml_petrol,
        kml_diesel: this.kml_diesel,
        vehicle_value: this.vehicle_value,
        service_cost: this.service_cost,
        repair_cost: this.repair_cost,
        tyres_cost : this.tyres_cost

      }
     
      this.mileageService.saveFixedRates(data,this.id).subscribe(res =>{
        this.toast.showSuccess("Success","Data Edited Successifully")
      })
    }

}
