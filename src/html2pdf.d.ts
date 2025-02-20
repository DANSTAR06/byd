declare module 'html2pdf.js' {
  interface Html2PdfOptions {
    margin?: number | [number, number, number, number];
    filename?: string;
    image?: {
      type?: string;
      quality?: number;
    };
    html2canvas?: {
      scale?: number;
      useCORS?: boolean;
      logging?: boolean;
      width?: number;
      height?: number;
    };
    jsPDF?: {
      unit?: 'pt' | 'px' | 'in' | 'mm' | 'cm';
      format?: string | number[];
      orientation?: 'portrait' | 'landscape';
    };
  }

  interface Html2PdfInstance {
    set(options: Html2PdfOptions): Html2PdfInstance;
    from(element: HTMLElement | string): Html2PdfInstance;
    save(): void;
    output(type?: string): string;
  }

  function html2pdf(): Html2PdfInstance;

  export = html2pdf;
}