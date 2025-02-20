import { Component } from '@angular/core';
import { MileageService } from '../../../../core/services/mileage/mileage.service';
import { MatDialog, MatDialogModule } from '@angular/material/dialog';
import { EditFuelComponent } from '../edit-fuel/edit-fuel.component';
import { CommonModule } from '@angular/common';
import { EditFixedRatesComponent } from '../edit-fixed-rates/edit-fixed-rates.component';

@Component({
  selector: 'app-parameters',
  standalone: true,
  imports: [CommonModule, MatDialogModule],
  templateUrl: './parameters.component.html',
  styleUrl: './parameters.component.scss'
})
export class ParametersComponent {

  variableParameters: any;
  vehicleRates: any;

  constructor(private mileageService: MileageService, private matDialog: MatDialog){
    this.getValues();
    this.getVehiclerates();
  }

  getValues(){
    this.mileageService.getVariables().subscribe(res =>{
      this.variableParameters = res;
    })
  }

  getVehiclerates(){
    this.mileageService.getVehicleRates().subscribe(res =>{
      this.vehicleRates = res;
      console.log(this.vehicleRates)
    })
  }

  editFixedRates(id:any,vehicle_type:any,car_capacity:any,fuel_type:any,kml_petrol:any,kml_diesel:any,vehicle_value:any,service_cost:any,repair_cost:any,tyres_cost :any){
    let dialog = this.matDialog.open(EditFixedRatesComponent, {
      data: {id: id, vehicle_type: vehicle_type,car_capacity: car_capacity,fuel_type: fuel_type,kml_petrol: kml_petrol,kml_diesel: kml_diesel,vehicle_value: vehicle_value,service_cost: service_cost,repair_cost: repair_cost,tyres_cost :tyres_cost}
     })
  
     dialog.afterClosed().subscribe(res =>{
      this.getVehiclerates();
     })

  }

  editFuel(id: any, petrol: any, diasel: any, oil: any, service: any, repairs: any, tyres: any){
   let dialog = this.matDialog.open(EditFuelComponent, {
    data: {id: id, petrol: petrol, diasel: diasel, oil: oil, service: service, repairs: repairs, tyres: tyres}
   })

   dialog.afterClosed().subscribe(res =>{
    this.getValues();
   })
  }


}
