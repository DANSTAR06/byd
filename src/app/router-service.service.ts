import { Injectable } from "@angular/core";
import { Router } from "@angular/router";

@Injectable({
    providedIn : 'root'
})
export class RouterService{
    constructor(private router: Router){
        window.navigateTo = this.navigate.bind(this);
    }
    navigate(route: string){
        this.router.navigate([route])
    }
}
