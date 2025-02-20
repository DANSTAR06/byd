import { CommonModule } from '@angular/common';
import { Component, Inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';
import { MileageService } from '../../../../core/services/mileage/mileage.service';
import { ToastService } from '../../../../core/services/toast/toast.service';

@Component({
  selector: 'app-edit-fuel',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './edit-fuel.component.html',
  styleUrl: './edit-fuel.component.scss'
})
export class EditFuelComponent {
  id: any;
  petrol: any;
  diasel: any;
  oil: any;
  service: any;
  repairs: any;
  tyres: any
  constructor(@Inject(MAT_DIALOG_DATA) public data: {id: any, petrol: any, diasel: any, oil: any, service: any, repairs: any, tyres: any}, 
  private mileageService: MileageService, private toast : ToastService){
    this.id = data.id
    this.petrol = data.petrol
    this.diasel = data.diasel
    this.oil = data.oil
    this.service = data.service
    this.repairs = data.repairs
    this.tyres = data.tyres
  }

  saveChanges(){
    let data = {
      id: this.id,
      diesel_price: this.diasel,
      petrol_price: this.petrol,
      oil: this.oil,
      service: this.service,
      repairs: this.repairs,
      tyres_tubes: this.tyres
    }
   
    this.mileageService.saveVariables(data,this.id).subscribe(res =>{
      this.toast.showSuccess("Success","Prices Edited Successifully")
    })

  }

}
