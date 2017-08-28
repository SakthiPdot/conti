package com.conti.manifest;

import java.text.DateFormat;
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
 * @Package_Name com.conti.manifest  com.conti.manifest
 * @File_name ManifestPrintPDF.java com.conti.manifest
 * @author Monu.C
 * @Created_date_time Aug 28, 2017 6:23:25 PM
 */
public class ManifestPrintPDF extends AbstractPdfView {

	@Autowired
	private CompanySettingDAO companySettingDAO;
	Loggerconf loggerconf = new Loggerconf();
	
	public ManifestPrintPDF() {
		setContentType("application/pdf");
	}

	@Override
	protected boolean generatesDownloadContent() {
		return true;
	}
	
	@Override
	protected void buildPdfDocument(Map<String, Object> model, Document document, PdfWriter writer,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		ManifestModel manifestModel=(ManifestModel)model.get("manifest");
		Company company = (Company) model.get("company");
		BranchModel branch = (BranchModel) model.get("branch");
		String logo = (String) model.get("logo");
		
		 // Creating a table          
	      Table companyTable = new Table(2); 
	      
		
	      // Adding cells to the table      
	      companyTable.setBorderWidth(1);
	      companyTable.setPadding(5);
	      companyTable.setSpacing(0);
	      companyTable.setWidths(new int[]{1,3});
	      
	      //===== for company logo
	      Image image = Image.getInstance(company.getCompany_logo());
	      image.scaleAbsolute(80, 80);
	      
	      
	      Cell logoCell=new Cell(image);
	      logoCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	      logoCell.setHorizontalAlignment(Element.ALIGN_CENTER);
	      logoCell.setRowspan(2);		      
	      companyTable.addCell(logoCell);
		      
		      
	      //===== for company Name

		  
	      Cell nameCell=new Cell(company.getCompany_name());
	      nameCell.setBorder(Rectangle.NO_BORDER);
	      nameCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	      nameCell.setHorizontalAlignment(Element.ALIGN_CENTER);
	       
	      companyTable.addCell(nameCell);
	      
	      
	     //=====for company address
	      Font address_font = new Font(Font.COURIER, 8);
		    Cell address_cell = new Cell(
		    		new Phrase(
		    		branch.getBranch_addressline1()+", "+
					/*branch.getBranch_addressline2()+", " +*/
					branch.location.getLocation_name()+". "+
					branch.location.address.getCity()+", "+
					branch.location.address.getState()+", "+
					branch.location.getPincode()+" \nPh: "+
					branch.getBranch_mobileno()+", Email: "+
					branch.getBranch_email()+", \nGSTIN Number: "+
					company.getGST_number()
					,address_font)
					);
		    
		    address_cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		    address_cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		    address_cell.setBorder(Rectangle.BOTTOM);
		    address_cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		    companyTable.addCell(address_cell);
		   
		    
		    //customer table
		    Table headingTable = new Table(6);
		    headingTable.setBorderWidth(1);
		    headingTable.setPadding(4);
		    headingTable.setSpacing(0);
		    
		    //Manifest No Heading
		    Cell manifestNoHeading = new Cell(new Phrase("Manifest No:", address_font));
		    manifestNoHeading.setHorizontalAlignment(Element.ALIGN_CENTER);
		    manifestNoHeading.setBorder(Rectangle.BOTTOM );
		    headingTable.addCell(manifestNoHeading);
		   
		    Cell manifestNo = new Cell(new Phrase(manifestModel.getManifest_prefix(), address_font));
		    manifestNo.setHorizontalAlignment(Element.ALIGN_CENTER);
		    manifestNo.setBorder(Rectangle.BOTTOM | Rectangle.RIGHT);
		    headingTable.addCell(manifestNo);
		    
		    //From branch
		    Cell formHeading = new Cell(new Phrase("From :", address_font));
		    formHeading.setHorizontalAlignment(Element.ALIGN_CENTER);
		    formHeading.setBorder(Rectangle.BOTTOM );
		    headingTable.addCell(formHeading);
		   
		    Cell from = new Cell(new Phrase(manifestModel.getBranchModel1().getBranch_name(), address_font));
		    from.setHorizontalAlignment(Element.ALIGN_CENTER);
		    from.setBorder(Rectangle.BOTTOM | Rectangle.RIGHT);
		    headingTable.addCell(from);

		    //To Branch
		    Cell toHeading = new Cell(new Phrase("To :", address_font));
		    toHeading.setHorizontalAlignment(Element.ALIGN_CENTER);
		    toHeading.setBorder(Rectangle.BOTTOM);
		    headingTable.addCell(toHeading);
		   
		    Cell to = new Cell(new Phrase(manifestModel.getBranchModel2().getBranch_name(), address_font));
		    to.setHorizontalAlignment(Element.ALIGN_CENTER);
		    to.setBorder(Rectangle.BOTTOM );
		    headingTable.addCell(to);



		    //Vehicle No
		    Cell vehicleNoHeader = new Cell(new Phrase("Vehicle No :", address_font));
		    vehicleNoHeader.setHorizontalAlignment(Element.ALIGN_CENTER);
		    vehicleNoHeader.setBorder(Rectangle.NO_BORDER);
		    headingTable.addCell(vehicleNoHeader);
		   
		    Cell vehicleNo = new Cell(new Phrase(manifestModel.getVehicleMaster().getVehicle_regno(), address_font));
		    vehicleNo.setHorizontalAlignment(Element.ALIGN_CENTER);
		    vehicleNo.setBorder(Rectangle.RIGHT);
		    headingTable.addCell(vehicleNo);


		    

		    //Driver
		    Cell driverHeading = new Cell(new Phrase("Driver :", address_font));
		    driverHeading.setHorizontalAlignment(Element.ALIGN_CENTER);
		    driverHeading.setBorder(Rectangle.NO_BORDER);
		    headingTable.addCell(driverHeading);
		   
		    Cell driver = new Cell(new Phrase(manifestModel.getEmployeeDriver().getEmp_name(), address_font));
		    driver.setHorizontalAlignment(Element.ALIGN_CENTER);
		    driver.setBorder(Rectangle.RIGHT);
		    headingTable.addCell(driver);



		    //Date
		    Cell dateHeading = new Cell(new Phrase("Date :", address_font));
		    dateHeading.setHorizontalAlignment(Element.ALIGN_CENTER);
		    dateHeading.setBorder(Rectangle.NO_BORDER);
		    headingTable.addCell(dateHeading);
		   
		    Cell date = new Cell(new Phrase(DateFormat.getTimeInstance().format(new Date()), address_font));
		    date.setHorizontalAlignment(Element.ALIGN_CENTER);
		    date.setBorder(Rectangle.NO_BORDER);
		    headingTable.addCell(date);

		    
		    //customer table
		    Table detailTable = new Table(7);
		    headingTable.setBorderWidth(1);
		    headingTable.setPadding(4);
		    headingTable.setSpacing(0);
		    
/*		    //Manifest No Heading
		    Cell manifestNoHeading = new Cell(new Phrase("Manifest No:", address_font));
		    manifestNoHeading.setHorizontalAlignment(Element.ALIGN_CENTER);
		    manifestNoHeading.setBorder(Rectangle.NO_BORDER);
		    headingTable.addCell(manifestNoHeading);
		   
		    Cell manifestNo = new Cell(new Phrase(manifestModel.getManifest_prefix(), address_font));
		    manifestNo.setHorizontalAlignment(Element.ALIGN_CENTER);
		    manifestNo.setBorder(Rectangle.NO_BORDER);
		    headingTable.addCell(manifestNo);
		    
		    //Manifest No Heading
		    Cell formHeading = new Cell(new Phrase("From :", address_font));
		    formHeading.setHorizontalAlignment(Element.ALIGN_CENTER);
		    formHeading.setBorder(Rectangle.NO_BORDER);
		    headingTable.addCell(formHeading);
		   
		    Cell from = new Cell(new Phrase(manifestModel.getBranchModel1().getBranch_name(), address_font));
		    from.setHorizontalAlignment(Element.ALIGN_CENTER);
		    from.setBorder(Rectangle.NO_BORDER);
		    headingTable.addCell(from);
*/
		    

	      // Adding Table to document        
	      document.add(companyTable);
	      document.add(headingTable);
	}

}
