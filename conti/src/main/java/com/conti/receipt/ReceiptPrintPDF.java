package com.conti.receipt;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.view.document.AbstractPdfView;

import com.conti.master.branch.BranchModel;
import com.conti.others.Loggerconf;
import com.conti.settings.company.Company;
import com.conti.settings.company.CompanySettingDAO;
import com.itextpdf.text.Element;
import com.itextpdf.text.Rectangle;
import com.lowagie.text.Cell;
import com.lowagie.text.Document;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.Phrase;
import com.lowagie.text.Table;
import com.lowagie.text.pdf.PdfWriter;

/**
 * @Project_Name conti
 * @Package_Name com.conti.receipt  com.conti.receipt
 * @File_name ReceiptPrintPDF.java com.conti.receipt
 * @author Monu.C
 * @Created_date_time Aug 28, 2017 4:41:25 PM
 */
public class ReceiptPrintPDF extends AbstractPdfView {

	@Autowired
	private CompanySettingDAO companySettingDAO;
	Loggerconf loggerconf = new Loggerconf();
	
	public ReceiptPrintPDF() {
		setContentType("application/pdf");
	}

	@Override
	protected boolean generatesDownloadContent() {
		return true;
	}
	
	@Override
	protected void buildPdfDocument(Map<String, Object> model, Document document, PdfWriter writer,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		ReceiptModel receiptModel=(ReceiptModel)model.get("receipt");
		Company company = (Company) model.get("company");
		BranchModel branch = (BranchModel) model.get("branch");
		
		DecimalFormat df = new DecimalFormat("####0.00");
		
		document.setMargins(-50, -50, 20, 20);
		document.open();
		
		
		Table company_tbl = new Table(3);
//		table.setTableFitsPage(true);
//	    table.setCellsFitPage(true);
		company_tbl.setBorderWidth(1);
		company_tbl.setPadding(4);
		company_tbl.setSpacing(0);
		
	    // for company logo
	    Image image = null;
	    image = Image.getInstance(company.getCompany_logo());
	    image.scaleAbsolute(150, 30);
	    Cell logo_cell = new Cell(image);
	    logo_cell.setBorder(Rectangle.BOTTOM | Rectangle.RIGHT);
	    logo_cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    logo_cell.setHorizontalAlignment(Element.ALIGN_CENTER);
	    logo_cell.setRowspan(2);
	    company_tbl.addCell(logo_cell);
	    
	    //for company name
	    Cell companyname_cell = new Cell(company.getCompany_name());
	    companyname_cell.setBorder(Rectangle.BOTTOM | Rectangle.RIGHT);	
	    companyname_cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    companyname_cell.setHorizontalAlignment(Element.ALIGN_CENTER);
	    company_tbl.addCell(companyname_cell);
	    
	    //for company address
	    Font address_font = new Font(Font.COURIER, 8);
	    Cell address_cell = new Cell(
	    		new Phrase(
	    		branch.getBranch_addressline1()+", "+
				/*branch.getBranch_addressline2()+", " +*/
				branch.location.getLocation_name()+". "+
				branch.location.address.getCity()+", "+
				branch.location.address.getState()+", "+
				branch.location.getPincode()+" \nPh: "+
				branch.getBranch_mobileno()+", \nEmail: "+
				branch.getBranch_email()
				,address_font)
				);
	   
	    address_cell.setBorder(Rectangle.BOTTOM);
	    address_cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    company_tbl.addCell(address_cell);
	 
	  //for GSTIN number
		Cell getin_cell = new Cell(
	    		new Phrase("GSTIN Number: "+company.getGST_number()
	    		, address_font));
	    company_tbl.addCell(getin_cell);
	    
	    //for Receipt number
	    
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    String receipt_date = receiptModel.getUpdated_datetime() .toString();
	    Date date = dateFormat.parse(receipt_date.substring(0, receipt_date.length()-2));
	    
	    SimpleDateFormat dateFormat1 = new SimpleDateFormat("dd/MM/yyyy HH:mm a");
	    	    //shipment.getShipment_date()
	    Cell lrno_cell = new Cell(
	    		new Phrase(
	    				"Receipt No. : " + receiptModel.getReceipt_prefix() +
	    				"\nDate: " + dateFormat1.format(date), 
	    				address_font));
	    
	    company_tbl.addCell(lrno_cell);
	    
	  //customer table
	    Table customer_tbl = new Table(2);
	    customer_tbl.setBorderWidth(1);
	    customer_tbl.setPadding(4);
	    customer_tbl.setSpacing(0);
	    Cell sender = new Cell(new Phrase("From", address_font));
	    sender.setHorizontalAlignment(Element.ALIGN_CENTER);
	    customer_tbl.addCell(sender);
	    Cell consignee = new Cell(new Phrase("To", address_font));
	    consignee.setHorizontalAlignment(Element.ALIGN_CENTER);
	    customer_tbl.addCell(consignee);
	    
	    String send_cus = null, consignee_cus = null; 
	    
	    if(receiptModel.getReceiptDetailList().get(0)
	    		.shipmentModel.getSender_customer().getGstin_number() != null) {
	    	send_cus = "Name : "+receiptModel.getReceiptDetailList().get(0)
    			 	.shipmentModel.getSender_customer().getCustomer_name()+
    			 "\nAddress : "+receiptModel.getReceiptDetailList().get(0)
    			 	.shipmentModel.getSendercustomer_address1().toString()+
    			 ",\n"+receiptModel.getReceiptDetailList().get(0)
    			 	.shipmentModel.getSender_location().getLocation_name()+
    			 ", "+receiptModel.getReceiptDetailList().get(0)
    			 	.shipmentModel.getSender_location().address.getCity()+
    			 " - "+receiptModel.getReceiptDetailList().get(0)
    			 	.shipmentModel.getSender_location().getPincode()+
			 	"\n"+receiptModel.getReceiptDetailList().get(0)
			 	.shipmentModel.getSender_location().address.getState()+	
			 	" - "+receiptModel.getReceiptDetailList().get(0)
			 	.shipmentModel.getSender_location().address.getStateCode()+	
    			 "\nPh : "+receiptModel.getReceiptDetailList().get(0)
    			 	.shipmentModel.getSender_customer().getCustomer_mobileno()+	
    			 "\nGSTIN Number :"+receiptModel.getReceiptDetailList().get(0)
    			 	.shipmentModel.getSender_customer().getGstin_number();
	    } else {
	    	send_cus = "Name : "+receiptModel.getReceiptDetailList().get(0)
    			 	.shipmentModel.getSender_customer().getCustomer_name()+
    			 "\nAddress : "+receiptModel.getReceiptDetailList().get(0)
    			 	.shipmentModel.getSendercustomer_address1().toString()+
    			 ",\n"+receiptModel.getReceiptDetailList().get(0)
    			 	.shipmentModel.getSender_location().getLocation_name()+
    			 ", "+receiptModel.getReceiptDetailList().get(0)
    			 	.shipmentModel.getSender_location().address.getCity()+
    			 " - "+receiptModel.getReceiptDetailList().get(0)
    			 	.shipmentModel.getSender_location().getPincode()+
			 	"\n"+receiptModel.getReceiptDetailList().get(0)
			 	.shipmentModel.getSender_location().address.getState()+	
			 	" - "+receiptModel.getReceiptDetailList().get(0)
			 	.shipmentModel.getSender_location().address.getStateCode()+	
    			 "\nPh : "+receiptModel.getReceiptDetailList().get(0)
    			 	.shipmentModel.getSender_customer().getCustomer_mobileno();
	    }
	    
    	 Cell sender_add = new Cell(new Phrase(send_cus,address_font));
    	 customer_tbl.addCell(sender_add);
	    
    	 if(receiptModel.getReceiptDetailList().get(0)
 			 	.shipmentModel.getConsignee_customer().getGstin_number() !=  null){
    		 consignee_cus = "Name : "+receiptModel.getReceiptDetailList().get(0)
     			 	.shipmentModel.getConsignee_customer().getCustomer_name()+
       			 "\nAddress : "+receiptModel.getReceiptDetailList().get(0)
       			 	.shipmentModel.getConsigneecustomer_address1().toString()+
       			 ",\n"+receiptModel.getReceiptDetailList().get(0)
       			 	.shipmentModel.getConsignee_location().getLocation_name()+
       			 ", "+receiptModel.getReceiptDetailList().get(0)
       			 	.shipmentModel.getConsignee_location().address.getCity()+
       			 " - "+receiptModel.getReceiptDetailList().get(0)
       			 	.shipmentModel.getConsignee_location().getPincode()+
   			 	"\n"+receiptModel.getReceiptDetailList().get(0)
   			 	.shipmentModel.getConsignee_location().address.getState()+	
   			 	" - "+receiptModel.getReceiptDetailList().get(0)
   			 	.shipmentModel.getConsignee_location().address.getStateCode()+		
       			 "\nPh : "+receiptModel.getReceiptDetailList().get(0)
       			 	.shipmentModel.getSender_customer().getCustomer_mobileno()+	
       			 "\nGSTIN Number :"+receiptModel.getReceiptDetailList().get(0)
       			 	.shipmentModel.getConsignee_customer().getGstin_number();
    	 } else {
    		 consignee_cus = "Name : "+receiptModel.getReceiptDetailList().get(0)
      			 	.shipmentModel.getConsignee_customer().getCustomer_name()+
        			 "\nAddress : "+receiptModel.getReceiptDetailList().get(0)
        			 	.shipmentModel.getConsigneecustomer_address1().toString()+
        			 ",\n"+receiptModel.getReceiptDetailList().get(0)
        			 	.shipmentModel.getConsignee_location().getLocation_name()+
        			 ", "+receiptModel.getReceiptDetailList().get(0)
        			 	.shipmentModel.getConsignee_location().address.getCity()+
        			 " - "+receiptModel.getReceiptDetailList().get(0)
        			 	.shipmentModel.getConsignee_location().getPincode()+
    			 	"\n"+receiptModel.getReceiptDetailList().get(0)
    			 	.shipmentModel.getConsignee_location().address.getState()+	
    			 	" - "+receiptModel.getReceiptDetailList().get(0)
    			 	.shipmentModel.getConsignee_location().address.getStateCode()+		
        			 "\nPh : "+receiptModel.getReceiptDetailList().get(0)
        			 	.shipmentModel.getSender_customer().getCustomer_mobileno();
    	 }
    	 
    	 Cell consignee_add = new Cell(new Phrase(consignee_cus,address_font));
    	 customer_tbl.addCell(consignee_add);
	    
    	//desc table
 	    Table desc_tbl = new Table(6);
 	    desc_tbl.setWidths(new int[] {1,3,1,2,2,2});
 	    desc_tbl.setBorderWidth(1);
 	    desc_tbl.setPadding(4);
 	    desc_tbl.setSpacing(0);
 	    //sno
 	    Cell sno = new Cell(new Phrase("S.No", address_font));
 	    sno.setHorizontalAlignment(Element.ALIGN_CENTER);
 	    desc_tbl.addCell(sno);
 	    //Description of Goods
 	    Cell lr = new Cell(new Phrase("LR Details", address_font));
 	    lr.setHorizontalAlignment(Element.ALIGN_CENTER);
 	    desc_tbl.addCell(lr);
 	    //Quantity
 	    Cell article = new Cell(new Phrase("No.Of Article", address_font));
 	    article.setHorizontalAlignment(Element.ALIGN_CENTER);
 	    desc_tbl.addCell(article);
 	    //Rate
 	    Cell freight = new Cell(new Phrase("Freight Charge", address_font));
 	    freight.setHorizontalAlignment(Element.ALIGN_CENTER);
 	    desc_tbl.addCell(freight);
 	    //Total
 	    Cell handling = new Cell(new Phrase("Handling Charge", address_font));
 	    handling.setHorizontalAlignment(Element.ALIGN_CENTER);
 	    desc_tbl.addCell(handling);
 	    //Total
 	    Cell total = new Cell(new Phrase("Total Charge", address_font));
 	    total.setHorizontalAlignment(Element.ALIGN_CENTER);
 	    desc_tbl.addCell(total);
 	   float grand_total = 0;
 	    for(int i=0; i<receiptModel.receiptDetailList.size(); i++) {
 	    	Cell count = new Cell(new Phrase(Integer.toString(1+i), address_font));
	    	count.setHorizontalAlignment(Element.ALIGN_CENTER);
	    	desc_tbl.addCell(count);
	    	
	    	 Cell lrno = new Cell(new Phrase(
	    			 receiptModel.receiptDetailList.get(i).shipmentModel.getLrno_prefix()
	    			 , address_font));
	    	 lrno.setHorizontalAlignment(Element.ALIGN_CENTER);
	  	     desc_tbl.addCell(lrno);
	  	     
	  	   Cell qty = new Cell(new Phrase(
	    			 Integer.toString(receiptModel.receiptDetailList.get(i).shipmentModel.getNumberof_parcel())
	    			 , address_font));
	  	   	 qty.setHorizontalAlignment(Element.ALIGN_CENTER);
	  	     desc_tbl.addCell(qty);
	  	     
	  	   Cell freight_charge = new Cell(new Phrase(
	  			 df.format(receiptModel.receiptDetailList.get(i).getNet_freight_charges())
	    			 , address_font));
	  	   	 freight_charge.setHorizontalAlignment(Element.ALIGN_CENTER);
	  	     desc_tbl.addCell(freight_charge);
	  	   
	  	   Cell handling_charge = new Cell(new Phrase(
	  			 df.format(receiptModel.receiptDetailList.get(i).getHandling_charge())
	    			 , address_font));
	  	   	handling_charge.setHorizontalAlignment(Element.ALIGN_CENTER);
	  	    desc_tbl.addCell(handling_charge);
	  	    
	  	    Cell total_charge = new Cell(new Phrase(
	  	    		df.format( (receiptModel.receiptDetailList.get(i).getNet_freight_charges()) + 
	    					 (receiptModel.receiptDetailList.get(i).getHandling_charge()) )
	    			 , address_font));
	  	  	total_charge.setHorizontalAlignment(Element.ALIGN_CENTER);
	  	    desc_tbl.addCell(total_charge);
	  	    
	  	  grand_total = (grand_total) + (receiptModel.receiptDetailList.get(i).getNet_freight_charges()) + 
					 (receiptModel.receiptDetailList.get(i).getHandling_charge());
	  	    
 	    }
 	    
 	   Cell total_blank = new Cell(new Phrase("",address_font));
 	   total_blank.setHorizontalAlignment(Element.ALIGN_CENTER);
 	   total_blank.setColspan(4);
 	   total_blank.setRowspan(3);
	   desc_tbl.addCell(total_blank);
	    
	   Cell total_charge = new Cell(new Phrase("Total",address_font));
	   total_charge.setHorizontalAlignment(Element.ALIGN_CENTER);
	   desc_tbl.addCell(total_charge);
	    
	   Cell total_amt = new Cell(new Phrase(
			   df.format(grand_total)
			   ,address_font));
	   total_amt.setHorizontalAlignment(Element.ALIGN_CENTER);
	   desc_tbl.addCell(total_amt);
	   
	  /* Cell trans_blank = new Cell(new Phrase("",address_font));
	   trans_blank.setHorizontalAlignment(Element.ALIGN_CENTER);
	   trans_blank.setColspan(4);
	   desc_tbl.addCell(trans_blank);*/
	   
	   Cell trans_charge = new Cell(new Phrase("Local Transport Charge ",address_font));
	   trans_charge.setHorizontalAlignment(Element.ALIGN_CENTER);
	   desc_tbl.addCell(trans_charge);
	   
	   Cell trans_amt = new Cell(new Phrase(
			   /*Float.toString(receiptModel.getLocal_transport())*/
			   df.format(receiptModel.getLocal_transport())
			   ,address_font));
	   trans_amt.setHorizontalAlignment(Element.ALIGN_CENTER);
	   desc_tbl.addCell(trans_amt);
	   
	  /* Cell net_blank = new Cell(new Phrase("",address_font));
	   net_blank.setHorizontalAlignment(Element.ALIGN_CENTER);
	   net_blank.setColspan(4);
	   desc_tbl.addCell(net_blank);*/
	   
	   Cell net_charge = new Cell(new Phrase("Net Charge ",address_font));
	   net_charge.setHorizontalAlignment(Element.ALIGN_CENTER);
	   desc_tbl.addCell(net_charge);
	   
	   
	   
	   Cell net_amt = new Cell(new Phrase(
			   /*Float.toString(receiptModel.getReceipt_total())*/
			   df.format(receiptModel.getReceipt_total())
			   ,address_font));
	   net_amt.setHorizontalAlignment(Element.ALIGN_CENTER);
	   desc_tbl.addCell(net_amt);
	   
	    document.add(company_tbl);
	    document.add(customer_tbl);
	    document.add(desc_tbl);
	}

}
