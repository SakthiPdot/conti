package com.conti.shipment.view;

import java.text.DateFormat;
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
import com.conti.others.NumberToWord;
import com.conti.settings.company.Company;
import com.conti.settings.company.CompanySettingDAO;
import com.conti.shipment.add.ShipmentModel;
import com.lowagie.text.Cell;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.Table;
import com.lowagie.text.pdf.CMYKColor;
import com.lowagie.text.pdf.PdfWriter;

public class ShipmentLRPrintPDF extends AbstractPdfView{

	@Autowired
	private CompanySettingDAO companySettingDAO;
	@Autowired 
	private NumberToWord numberToWord;
	Loggerconf loggerconf = new Loggerconf();	
	public ShipmentLRPrintPDF() {
        setContentType("application/pdf");
    }
	 @Override
    protected boolean generatesDownloadContent() {
        return true;
    }
	 
	@Override
	protected void buildPdfDocument(Map<String, Object> model, Document document, PdfWriter writer,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		ShipmentModel shipment = (ShipmentModel) model.get("shipment");
		Company company = (Company) model.get("company");
		BranchModel branch = (BranchModel) model.get("branch");
		String logo = (String) model.get("logo");
		
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
	    Font company_font = new Font(Font.HELVETICA, 12, Font.BOLD,new CMYKColor(255, 0, 0, 0));
	    Paragraph p = new Paragraph(company.getCompany_name(), company_font);
	    logo_cell.addElement(p);
	    logo_cell.setBorder(Rectangle.BOTTOM | Rectangle.RIGHT);
	    logo_cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    logo_cell.setHorizontalAlignment(Element.ALIGN_CENTER);
	    logo_cell.setRowspan(2);
	    company_tbl.addCell(logo_cell);
	    
	    //for company name
	   /* Cell companyname_cell = new Cell(company.getCompany_name());
	    companyname_cell.setBorder(Rectangle.BOTTOM | Rectangle.RIGHT);	
	    companyname_cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    companyname_cell.setHorizontalAlignment(Element.ALIGN_CENTER);
	    company_tbl.addCell(companyname_cell);*/
	    
	    //for company address
	    Font address_font = new Font(Font.COURIER, 8);
	    Font font_bold = new Font(Font.COURIER, 8, Font.BOLD);
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
	    address_cell.setBorder(Rectangle.BOTTOM | Rectangle.RIGHT);
	    
	    address_cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    company_tbl.addCell(address_cell);
	    
	  //for company mobile
	    Font companymob_font = new Font(Font.COURIER, 8);
	    Cell companymob_cell = new Cell(
	    		new Phrase(
	    		"Coimbatore: Peelamedu\n875400783 / 9244433609\n"+
	    		"Chennai: Egmore\n044 - 28553205 / 43521322\n"+		
	    		"Bangalore: Richmond road\n080 - 22211632 / 40988922"
				,companymob_font)
				);
	   
	    companymob_cell.setBorder(Rectangle.BOTTOM);
	    companymob_cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    company_tbl.addCell(companymob_cell);
	    
	  //for GSTIN number
	 
	    Cell getin_cell = new Cell(
	    		new Phrase("GSTIN Number: "+company.getGST_number()
		+ " Tax is payable on reverse charges: " + shipment.getTaxin_payable(), address_font));
	    company_tbl.addCell(getin_cell);
	    
	    //for LR number
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    String shipment_date = shipment.getShipment_date().toString();
	    Date date = dateFormat.parse(shipment_date.substring(0, shipment_date.length()-2));
	    
	    SimpleDateFormat dateFormat1 = new SimpleDateFormat("dd/MM/yyyy HH:mm a");
	    	    //shipment.getShipment_date() font_bold
	    Cell lrno_cell = new Cell(
	    		new Phrase("L.R. No: "+shipment.getLrno_prefix(), font_bold));
	    lrno_cell.addElement(
	    		new Phrase("\nDate: " + dateFormat1.format(date), address_font));
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
	    String send_add1 = "", send_add2="", send_loc="", send_state="";
	    
	    if(shipment.getSendercustomer_address1()!=null){
	    	send_add1="\nAddress : "+shipment.getSendercustomer_address1();
	    }
	    if(shipment.getSendercustomer_address2()!=null){
	    	send_add2=", "+shipment.getSendercustomer_address2();
	    }
	    if(shipment.getSender_location()!=null){
	    	send_loc=", "+shipment.getSender_location().getLocation_name()+
					",\n"+shipment.getSender_location().address.getCity()+
					" - "+shipment.getSender_location().getPincode();
	    	send_state=", \nState :"+shipment.getSender_customer().location.address.getState()+
					", State Code :"+shipment.getSender_customer().location.address.getStateCode();
	    }else{
	    	send_loc=",\n"+shipment.getSender_city().getCity();
	    	send_state=", \nState :"+shipment.getSender_city().getState() +
					", State Code :"+shipment.getSender_city().getStateCode();
	    }
	    
	    if(shipment.getSender_customer().getGstin_number() != null) {
	    	
	    	send_cus = "Name : "+shipment.getSender_customer().getCustomer_name()+" "+
	    			send_add1+send_add2+send_loc+
					", \nPh :"+shipment.getSender_customer().getCustomer_mobileno()+
					/*", \nEmail :"+shipment.getSender_customer().getCustomer_email()+*/
					send_state+"\nGSTIN Number :"+shipment.getSender_customer().getGstin_number();
	    } else {
	    	send_cus = "Name : "+shipment.getSender_customer().getCustomer_name()+" "+
	    			send_add1+send_add2+send_loc+
					", \nPh :"+shipment.getSender_customer().getCustomer_mobileno()+
					/*", \nEmail :"+shipment.getSender_customer().getCustomer_email()+*/
					send_state;
	    }
	    String consignee_add1 = "", consignee_add2="", consignee_loc="", consignee_state="";
	    if(shipment.getConsigneecustomer_address1()!=null){
	    	consignee_add1="\nAddress : "+shipment.getConsigneecustomer_address1();
	    }
	    if(shipment.getSendercustomer_address2()!=null){
	    	consignee_add2=", "+shipment.getConsigneecustomer_address2();
	    }
	    if(shipment.getConsignee_location()!=null){
	    	consignee_loc=", "+shipment.getConsignee_location().getLocation_name()+
					",\n"+shipment.getConsignee_location().address.getCity()+
					" - "+shipment.getConsignee_location().getPincode();
	    	consignee_state=", \nState :"+shipment.getConsignee_location().address.getState()+
					", State Code :"+shipment.getConsignee_location().address.getStateCode();
	    }else{
	    	consignee_loc=",\n"+shipment.getConsignee_city().getCity();
	    	consignee_state=", \nState :"+shipment.getConsignee_city().getState() +
					", State Code :"+shipment.getConsignee_city().getStateCode();
	    }
	    
	    Cell sender_add = new Cell(
	    		new Phrase(send_cus ,address_font)
	    		);
	    
	    if(shipment.getConsignee_customer().getGstin_number() != null) {
	    	consignee_cus = "Name : "+shipment.getConsignee_customer().getCustomer_name()+" "+
	    			consignee_add1+consignee_add2+consignee_loc+
					", \nPh :"+shipment.getConsignee_customer().getCustomer_mobileno()+
					/*", \nEmail :"+shipment.getConsignee_customer().getCustomer_email()+*/
					consignee_state+"\nGSTIN Number :"+shipment.getConsignee_customer().getGstin_number();
	    } else {
	    	consignee_cus = "Name : "+shipment.getConsignee_customer().getCustomer_name()+" "+
	    			consignee_add1+consignee_add2+consignee_loc+
					", \nPh :"+shipment.getConsignee_customer().getCustomer_mobileno()+
					/*", \nEmail :"+shipment.getConsignee_customer().getCustomer_email()+*/
					consignee_state;
	    }
	    Cell consignee_add = new Cell(
	    		new Phrase(consignee_cus,address_font));
	    customer_tbl.addCell(sender_add);
	    customer_tbl.addCell(consignee_add);
	    
	  //desc table
	    Table desc_tbl = new Table(5);
	    desc_tbl.setWidths(new int[] {1,3,1,2,1});
	    desc_tbl.setBorderWidth(1);
	    desc_tbl.setPadding(4);
	    desc_tbl.setSpacing(0);
	    //sno
	    Cell sno = new Cell(new Phrase("S.No", address_font));
	    sno.setHorizontalAlignment(Element.ALIGN_CENTER);
	    desc_tbl.addCell(sno);
	    //Description of Goods
	    Cell desc_goods = new Cell(new Phrase("Description of Goods", address_font));
	    desc_goods.setHorizontalAlignment(Element.ALIGN_CENTER);
	    desc_tbl.addCell(desc_goods);
	    //Quantity
	    Cell qty = new Cell(new Phrase("Qty", address_font));
	    qty.setHorizontalAlignment(Element.ALIGN_CENTER);
	    desc_tbl.addCell(qty);
	    //Rate
	    Cell rate = new Cell(new Phrase("Rate", address_font));
	    rate.setHorizontalAlignment(Element.ALIGN_CENTER);
	    desc_tbl.addCell(rate);
	    //Total
	    Cell total = new Cell(new Phrase("Total", address_font));
	    total.setHorizontalAlignment(Element.ALIGN_CENTER);
	    desc_tbl.addCell(total);
	    
	    for(int i =0; i<shipment.getShipmentDetail().size();i++){
	    	Cell count = new Cell(new Phrase(Integer.toString(1+i), address_font));
	    	count.setHorizontalAlignment(Element.ALIGN_CENTER);
	    	desc_tbl.addCell(count);
	    	
	    	Cell goods = new Cell(new Phrase(
	    			shipment.getShipmentDetail().get(i).getProduct().getProduct_name(),
	    			address_font));
	    	goods.setHorizontalAlignment(Element.ALIGN_CENTER);
	    	desc_tbl.addCell(goods);
	    	
	    	Cell quantity = new Cell(new Phrase(
	    			Integer.toString(shipment.getShipmentDetail().get(i).getQuantity()), address_font));
	    	quantity.setHorizontalAlignment(Element.ALIGN_CENTER);
	    	desc_tbl.addCell(quantity);
	    	
	    	Cell unitprice = new Cell(new Phrase(
	    			df.format(shipment.getShipmentDetail().get(i).getUnit_price()), address_font));
	    	unitprice.setHorizontalAlignment(Element.ALIGN_CENTER);
	    	desc_tbl.addCell(unitprice);
	    	
	    	Cell totalPrice = new Cell(new Phrase(
	    			df.format(shipment.getShipmentDetail().get(i).getTotal_price()), address_font));
	    	totalPrice.setHorizontalAlignment(Element.ALIGN_RIGHT);
	    	desc_tbl.addCell(totalPrice);
	    }
	    
	    if(shipment.getDiscount_percentage() != 0) {
	    	Cell discount = new Cell (new Phrase ("Discount "+
		    		Float.toString(shipment.getDiscount_percentage())+"%", address_font));
		    discount.setColspan(4);
		    discount.setHorizontalAlignment(Element.ALIGN_CENTER);
		    desc_tbl.addCell(discount);
		    
		    Cell discount_amt = new Cell (new Phrase (
		    		df.format(shipment.getDiscount_amount()), address_font));
		    discount_amt.setHorizontalAlignment(Element.ALIGN_RIGHT);
		    desc_tbl.addCell(discount_amt);
	    }
	    
	    if(shipment.getCgst() != 0) {
	    	 Cell cgst = new Cell (new Phrase ("CGST "+
	 	    		df.format(company.getCGST())+"%", address_font));
	 	    cgst.setColspan(4);
	 	    cgst.setHorizontalAlignment(Element.ALIGN_CENTER);
	 	    desc_tbl.addCell(cgst);
	 	    
	 	    Cell cgst_amt = new Cell (new Phrase (
	 	    		df.format(shipment.getCgst()), address_font));
	 	    cgst_amt.setHorizontalAlignment(Element.ALIGN_RIGHT);
	 	    desc_tbl.addCell(cgst_amt);
	    }
	   
	    if(shipment.getSgst() != 0) {
	    	Cell sgst = new Cell (new Phrase ("SGST "+
	    			df.format(company.getSGST())+"%", address_font));
		    sgst.setColspan(4);
		    sgst.setHorizontalAlignment(Element.ALIGN_CENTER);
		    desc_tbl.addCell(sgst);
		    
		    Cell sgst_amt = new Cell (new Phrase (
		    		df.format(shipment.getSgst()), address_font));
		    sgst_amt.setHorizontalAlignment(Element.ALIGN_RIGHT);
		    desc_tbl.addCell(sgst_amt);
	    }
	    
	    if(shipment.getIgst() != 0) {
	    	Cell igst = new Cell (new Phrase ("IGST "+
	    			df.format(company.getIGST())+"%", address_font));
		    igst.setColspan(4);
		    igst.setHorizontalAlignment(Element.ALIGN_CENTER);
		    desc_tbl.addCell(igst);
		    
		    Cell igst_amt = new Cell (new Phrase (
		    		df.format(shipment.getIgst()), address_font));
		    igst_amt.setHorizontalAlignment(Element.ALIGN_RIGHT);
		    desc_tbl.addCell(igst_amt);
	    }
	    
	    
	   
	   
	    
	    String currency= (String) model.get("currency");
	   	
		
	    Cell amtWord = new Cell (new Phrase ("Amounts in words : "+
	    		currency, address_font));
	    amtWord.setColspan(3);
	    desc_tbl.addCell(amtWord);
	    
	    Cell total_amt = new Cell (new Phrase ("Net Amount", font_bold));
	    total_amt.setHorizontalAlignment(Element.ALIGN_CENTER);
	    desc_tbl.addCell(total_amt);
	    Cell total_amtno = new Cell (new Phrase (df.format(shipment.getTotal_charges()), font_bold));
	    total_amtno.setHorizontalAlignment(Element.ALIGN_RIGHT);
	    desc_tbl.addCell(total_amtno);
	    
	    Cell sign = new Cell (new Phrase ("For Conti Cargo Service"
	    		+ "\n\nSignature", address_font));
	    sign.setColspan(2);
	    
	    desc_tbl.addCell(sign);
	    
	    Cell service = new Cell (new Phrase (shipment.getService().getService_name(), address_font));
	    service.setHorizontalAlignment(Element.ALIGN_CENTER);
	    service.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    desc_tbl.addCell(service);
	    
	    String bill_to = null;
	    	    
	    Cell topay = new Cell (new Phrase (shipment.getBill_to(), address_font));
	    topay.setHorizontalAlignment(Element.ALIGN_CENTER);
	    topay.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    desc_tbl.addCell(topay);
	    
	    Cell payMode = new Cell (new Phrase (shipment.getPay_mode(), address_font));
	    payMode.setHorizontalAlignment(Element.ALIGN_CENTER);
	    payMode.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    desc_tbl.addCell(payMode);
	    
	    document.add(company_tbl);
	    document.add(customer_tbl);
	    document.add(desc_tbl);

	}

}
