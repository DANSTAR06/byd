import { CommonModule } from '@angular/common';
import { Component, ElementRef, ViewChild } from '@angular/core';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import html2pdf from 'html2pdf.js';
import QRCode from 'qrcode';
import { EncryptionService } from '../../../../core/services/general/encryption.service';
import { environment } from '../../../../../environments/environment.development';

@Component({
  selector: 'app-mileage-certificate',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './mileage-certificate.component.html',
  styleUrl: './mileage-certificate.component.scss'
})
export class MileageCertificateComponent {
  @ViewChild('certificateTemplate', { static: false }) certificateTemplate!: ElementRef;
  @ViewChild('qrCanvas') qrCanvas!: ElementRef<HTMLCanvasElement>;

  certData: any;
  qrCodeData: string = '';
  validityLink = environment.appBaseUrl+'/mileage-report/validation'
  reportId: any;
  encryptedId: any;
  dateCreated: any;
  serialNo: any;

  constructor(private route: ActivatedRoute, private encryptionService: EncryptionService, private router: Router){

    this.certData = this.route.snapshot.data['data'];
   
    if(this.certData === undefined)
    {
      this.router.navigate(['/customer/my-reports'])
    } else {
    this.reportId = this.certData.reportId
    this.encryptedId = this.encryptionService.encryptData(this.reportId)
    this.dateCreated = this.certData.date_created
    this.serialNo = 'AAK0/'+this.reportId+'/'+this.dateCreated;
    }

    
  }

  ngOnInit() {
    this.generateQRCodeData();
  }

  ngAfterViewInit() {
    this.generateQRCode();
  }

  generateQRCodeData() {
    // Create URL with query parameters containing certificate data
    const baseUrl = this.validityLink;
    const params = new URLSearchParams({
      key: this.encryptedId
    });

    // Combine base URL with query parameters
    const url = `${baseUrl}?${params.toString()}`;
    this.qrCodeData = url;
    
    this.generateQRCode();
  }

  async generateQRCode() {
    if (this.qrCanvas && this.qrCodeData) {
      try {
        await QRCode.toCanvas(this.qrCanvas.nativeElement, this.qrCodeData, {
          width: 100,
          margin: 2,
          errorCorrectionLevel: 'M'
        });
      } catch (err) {
        console.error('Error generating QR code:', err);
      }
    }
  }

  generateCertificate() {
    const element = this.certificateTemplate.nativeElement;
    
    if (!element) {
      console.error('Certificate template element not found');
      return;
    }

    const opt: any = {
      margin: [0, 0, 0, 0],
      filename: 'certificate.pdf',
      image: { 
        type: 'jpeg', 
        quality: 1 
      },
      html2canvas: { 
        scale: 3, 
        useCORS: true,
        logging: false,
        windowWidth: 1200,
        windowHeight: 1700
      },
      jsPDF: { 
        unit: 'mm', 
        format: 'a5', 
        orientation: 'portrait',
        putOnlyUsedFonts: true
      }
    };

    try {
      html2pdf()
        .set(opt)
        .from(element)
        .save();
    } catch (error) {
      console.error('Error generating PDF:', error);
    }
  }
}
