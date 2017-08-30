package com.conti.receipt;

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
	   /* Cell sender_add = new Cell(
	    		new Phrase(
	    				"Name : "+shipment.getSender_customer().getCustomer_name()+" "+
	    				"\nAddress : "+shipment.getSendercustomer_address1()+
	    							", "+shipment.getSender_customer().getCustomer_addressline2()+
	    							", "+shipment.getSender_location().getLocation_name()+
	    							", "+shipment.getSender_location().address.getCity()+
	    							" - "+shipment.getSender_location().getPincode()+
	    							", \nPh :"+shipment.getSender_customer().getCustomer_mobileno()+
	    							", \nEmail :"+shipment.getSender_customer().getCustomer_email()+
	    							", \nState :"+shipment.getSender_customer().location.address.getState()+
	    							", State Code :"+shipment.getSender_customer().location.address.getStateCode()+
	    							" \nGSTIN Number :"+shipment.getSender_customer().getGstin_number()
	    							
	    			,address_font)
	    		);*/
	   
	    document.add(company_tbl);
	}

}
