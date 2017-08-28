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
		String logo = (String) model.get("logo");
		
	
	      // Creating a table          
	      Table companyTable = new Table(3);    
	      
	      // Adding cells to the table      
	      companyTable.setBorderWidth(1);
	      companyTable.setPadding(10);
	      companyTable.setSpacing(0);
	      
	      //===== for company logo
	      Image image = Image.getInstance(company.getCompany_logo());
	      image.scaleAbsolute(80, 80);
		  
	      
	      Cell logoCell=new Cell(image);
		  logoCell.setBorder(Rectangle.BOTTOM | Rectangle.RIGHT);
	      logoCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	      logoCell.setHorizontalAlignment(Element.ALIGN_CENTER);
	      logoCell.setRowspan(2);
	      
	      companyTable.addCell(logoCell);
	      
	      
	      //===== for company Name
	      Cell nameCell=new Cell(company.getCompany_name());
	      nameCell.setBorder(Rectangle.BOTTOM | Rectangle.RIGHT);
	      nameCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	      nameCell.setHorizontalAlignment(Element.ALIGN_CENTER);
	       
	      companyTable.addCell(nameCell);
	      
	      
	      //=====for company address
		    Font address_font = new Font(Font.HELVETICA, 10);
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
		    companyTable.addCell(address_cell);
		    
		    
	         
	      
	      // Adding Table to document        
	      document.add(companyTable);   
	}

}
