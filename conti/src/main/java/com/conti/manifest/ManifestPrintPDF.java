package com.conti.manifest;

import java.text.DateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.view.document.AbstractPdfView;

import com.conti.master.branch.BranchModel;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.settings.company.Company;
import com.conti.settings.company.CompanySettingDAO;
import com.itextpdf.text.Element;
import com.itextpdf.text.PageSize;
import com.lowagie.text.Cell;
import com.lowagie.text.Document;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
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
		
		/*Rectangle one = new Rectangle(0,0);
		document.setPageSize(one);
		*/
	 	float left = -50;
        float right =-50;
        float top = 20;
        float bottom =20;
		document.setMargins(left, right, top, bottom);
		document.open();
		
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
	      image.scaleAbsolute(80, 20);
	      
	      
	      Cell logoCell=new Cell(image);
	      logoCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	      logoCell.setHorizontalAlignment(Element.ALIGN_CENTER);
	      logoCell.setRowspan(2);		      
	      companyTable.addCell(logoCell);
		      
		      
	      //===== for company Name

		  
	      Cell nameCell=new Cell(company.getCompany_name());
	      nameCell.setBorder(Rectangle.NO_BORDER);
	      nameCell.setVerticalAlignment(Element.ALIGN_TOP);
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

		    
		    //detail table
		    Table detailTable = new Table(8);
		    detailTable.setBorderWidth(1);
		    detailTable.setPadding(4);
		    detailTable.setSpacing(0);
		    detailTable.setWidths(new float[]{1,3,3,3,2.5f,3,3,1.5f});
		    //detailTable.setWidths(new int[]{1,3,3,3,2,3,3,2});
		    
		    //serial No Heading
		    Cell serialNoHeading = new Cell(new Phrase("S. No", address_font));
		    serialNoHeading.setHorizontalAlignment(Element.ALIGN_CENTER);
		    serialNoHeading.setBorder(Rectangle.RIGHT);
		    detailTable.addCell(serialNoHeading);
		   
		    //LR No Heading
		    Cell lrNoHeading = new Cell(new Phrase("L.R No", address_font));
		    lrNoHeading.setHorizontalAlignment(Element.ALIGN_CENTER);
		    lrNoHeading.setBorder(Rectangle.RIGHT);
		    detailTable.addCell(lrNoHeading);
		    
		    //Party from Heading
		    Cell formPartyHeading = new Cell(new Phrase("Party\nSender    Consignee", address_font));
		    formPartyHeading.setHorizontalAlignment(Element.ALIGN_CENTER);
		    formPartyHeading.setBorder(Rectangle.RIGHT);
		    formPartyHeading.setColspan(2);
		    detailTable.addCell(formPartyHeading);
		
		  /*  //Party To Heading
		    Cell toPartyHeading = new Cell(new Phrase("Party(To)", address_font));
		    toPartyHeading.setHorizontalAlignment(Element.ALIGN_CENTER);
		    toPartyHeading.setBorder(Rectangle.RIGHT);
		    detailTable.addCell(toPartyHeading);*/
		    
		    
		    //no of article Heading
		    Cell noOfArticleHeading = new Cell(new Phrase("No Of Articles", address_font));
		    noOfArticleHeading.setHorizontalAlignment(Element.ALIGN_CENTER);
		    noOfArticleHeading.setBorder(Rectangle.RIGHT);		    
		    detailTable.addCell(noOfArticleHeading);

		    //Paid Heading
		    Cell paidHeading = new Cell(new Phrase("Paid", address_font));
		    paidHeading.setHorizontalAlignment(Element.ALIGN_CENTER);
		    paidHeading.setBorder(Rectangle.RIGHT);
		    detailTable.addCell(paidHeading);
		    
		    // To pay Heading
		    Cell toPayHeading = new Cell(new Phrase("To Pay", address_font));
		    toPayHeading.setHorizontalAlignment(Element.ALIGN_CENTER);
		    toPayHeading.setBorder(Rectangle.RIGHT);
		    detailTable.addCell(toPayHeading);
		    
		    //credit Heading
		    Cell creditHeading = new Cell(new Phrase("Credit", address_font));
		    creditHeading.setHorizontalAlignment(Element.ALIGN_CENTER);
		    creditHeading.setBorder(Rectangle.NO_BORDER);
		    detailTable.addCell(creditHeading);
		    
		    

		  //value table
		    Table valueTable = new Table(8);
		    valueTable.setBorderWidth(1);
		    valueTable.setPadding(4);
		    valueTable.setSpacing(0);
		    valueTable.setWidths(new float[]{1,3,3,3,2.5f,3,3,1.5f});
		  int totalArticles=0,paid=0,toPay=0;
		    
		    for(int i=0;i<manifestModel.getManifestDetailModel().size();i++){
		    	
		        //sno 
			    Cell sno = new Cell(new Phrase(String.valueOf(i+1), address_font));
			    sno.setHorizontalAlignment(Element.ALIGN_CENTER);
			    sno.setBorder(Rectangle.RIGHT);
			    valueTable.addCell(sno);
			    
			    
			     //lrno 
			    Cell lrno = new Cell(new Phrase(manifestModel.getManifestDetailModel().get(i).getShipmentModel().getLrno_prefix(), address_font));
			    lrno.setHorizontalAlignment(Element.ALIGN_CENTER);
			    lrno.setBorder(Rectangle.RIGHT);
			    valueTable.addCell(lrno);
			    
			    
			    //Customer Name From
			    Cell customerNameFrom = new Cell(new Phrase(manifestModel.getManifestDetailModel().get(i).getShipmentModel().getSender_customer().getCustomer_name(), address_font));
			    customerNameFrom.setHorizontalAlignment(Element.ALIGN_CENTER);
			    customerNameFrom.setBorder(Rectangle.RIGHT);
			    valueTable.addCell(customerNameFrom);
			    
			    
			    //Customer Name To
			    Cell customerNameTo = new Cell(new Phrase(manifestModel.getManifestDetailModel().get(i).getShipmentModel().getConsignee_customer().getCustomer_name(), address_font));
			    customerNameTo.setHorizontalAlignment(Element.ALIGN_CENTER);
			    customerNameTo.setBorder(Rectangle.RIGHT);
			    valueTable.addCell(customerNameTo);

			    
			    //Number Of Parcel
			    Cell noOfParcel = new Cell(new Phrase(String.valueOf(manifestModel.getManifestDetailModel().get(i).getShipmentModel().getNumberof_parcel()), address_font));
			    noOfParcel.setHorizontalAlignment(Element.ALIGN_CENTER);
			    noOfParcel.setBorder(Rectangle.RIGHT);
			    valueTable.addCell(noOfParcel);
			    
			    
			    Cell billTo ;
			   //Bill to
			    if(manifestModel.getManifestDetailModel().get(i).getShipmentModel().getBill_to().trim().equals(ConstantValues.PAID.trim())){
			    	  billTo = new Cell(new Phrase(String.valueOf(manifestModel.getManifestDetailModel().get(i).getShipmentModel().getTotal_charges()), address_font));
			    	  paid+=manifestModel.getManifestDetailModel().get(i).getShipmentModel().getTotal_charges();
			    }else{
			    	  billTo = new Cell(new Phrase(" ", address_font));
			    }
			    billTo.setHorizontalAlignment(Element.ALIGN_CENTER);
			    billTo.setBorder(Rectangle.RIGHT);
			    valueTable.addCell(billTo);
			    
			    
			    totalArticles+=manifestModel.getManifestDetailModel().get(i).getShipmentModel().getNumberof_parcel();
		    	
		    	
		    	
			    Cell billFrom ;
			   //Bill from
			    if(manifestModel.getManifestDetailModel().get(i).getShipmentModel().getBill_to().trim().equals(ConstantValues.TO_PAY.trim())){
			    	billFrom = new Cell(new Phrase(String.valueOf(manifestModel.getManifestDetailModel().get(i).getShipmentModel().getTotal_charges()), address_font));
			    	toPay+=manifestModel.getManifestDetailModel().get(i).getShipmentModel().getTotal_charges();
			    }else{
			    	billFrom = new Cell(new Phrase(" ", address_font));
			    }
			    billFrom.setHorizontalAlignment(Element.ALIGN_CENTER);
			    billFrom.setBorder(Rectangle.RIGHT);
			    valueTable.addCell(billFrom);
			    
			    
			    Cell payMode;
			    if(manifestModel.getManifestDetailModel().get(i).getShipmentModel().getPay_mode().trim().equals(ConstantValues.CREDIT)){
			    	payMode = new Cell(new Phrase("YES", address_font));
			    }else{
			    	payMode = new Cell(new Phrase("NO", address_font));
			    }
			    payMode.setHorizontalAlignment(Element.ALIGN_CENTER);
			    payMode.setBorder(Rectangle.RIGHT);
			    valueTable.addCell(payMode);
			    
		    }
		    
			  //value table
		    Table footerTable = new Table(8);
		    footerTable.setBorderWidth(1);
		    footerTable.setPadding(4);
		    footerTable.setSpacing(0);
		    footerTable.setWidths(new float[]{1,3,3,3,2.5f,3,3,1.5f});
		    
		    // Signature
		    Cell sign = new Cell (new Phrase ("For Conti Cargo Service"
		    		+ "\n\n\nSignature", address_font));
		    sign.setRowspan(3);
		    sign.setColspan(3);
		    sign.setHorizontalAlignment(Element.ALIGN_CENTER);
		    sign.setBorder(Rectangle.RIGHT);
		    footerTable.addCell(sign);
		    
		    
		    //Article Heading
		    Cell articleHeading= new Cell(new Phrase("Total No Of Articles", address_font));
		    articleHeading.setHorizontalAlignment(Element.ALIGN_CENTER);
		    articleHeading.setBorder(Rectangle.RIGHT | Rectangle.BOTTOM);
		    articleHeading.setColspan(3);
		    footerTable.addCell(articleHeading);
		    
		  
		    Cell totalArticle= new Cell(new Phrase(String.valueOf(totalArticles), address_font));
		    totalArticle.setHorizontalAlignment(Element.ALIGN_CENTER);
		    totalArticle.setBorder(Rectangle.BOTTOM);
		    totalArticle.setColspan(2);
		    footerTable.addCell(totalArticle);
		    
		    //Paid Heading
		    Cell totalPaidAmountHeading = new Cell(new Phrase("Total Paid Amount", address_font));
		    totalPaidAmountHeading.setHorizontalAlignment(Element.ALIGN_CENTER);
		    totalPaidAmountHeading.setBorder(Rectangle.RIGHT | Rectangle.BOTTOM);
		    totalPaidAmountHeading.setColspan(3);
		    footerTable.addCell(totalPaidAmountHeading);
		    
		    Cell totalPaidAmount = new Cell(new Phrase(String.valueOf(paid), address_font));
		    totalPaidAmount.setHorizontalAlignment(Element.ALIGN_CENTER);
		    totalPaidAmount.setBorder(Rectangle.BOTTOM);
		    totalPaidAmount.setColspan(2);
		    footerTable.addCell(totalPaidAmount);
		    
		    //To Pay Heading
		    Cell totalToPayHeading = new Cell(new Phrase("Total To Pay Amount", address_font));
		    totalToPayHeading.setHorizontalAlignment(Element.ALIGN_CENTER);
		    totalToPayHeading.setBorder(Rectangle.RIGHT);
		    totalToPayHeading.setColspan(3);
		    footerTable.addCell(totalToPayHeading);
		    
		    
		    Cell totalToPay = new Cell(new Phrase(String.valueOf(toPay), address_font));
		    totalToPay.setHorizontalAlignment(Element.ALIGN_CENTER);
		    totalToPay.setBorder(Rectangle.NO_BORDER);
		    totalToPay.setColspan(2);
		    footerTable.addCell(totalToPay);
		    
	      // Adding Table to document        
	      document.add(companyTable);
	      document.add(headingTable);
	      document.add(detailTable);
	      document.add(valueTable);
	      document.add(footerTable);
	      
	      

	      
	}

}
