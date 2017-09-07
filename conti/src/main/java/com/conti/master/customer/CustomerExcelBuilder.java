package com.conti.master.customer;

import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.springframework.web.servlet.view.document.AbstractExcelView;


/**
 * @Project_Name conti
 * @Package_Name com.conti.master.employee
 * @File_name EmployeeExcelBuilder.java
 * @author Sankar
 * @Created_date_time Jul 13, 2017 6:13:27 PM
 * @Updated_date_time Jul 13, 2017 6:13:27 PM
 */
public class CustomerExcelBuilder extends AbstractExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
	
		@SuppressWarnings("unchecked")
		List<CustomerModel> customerList=(List<CustomerModel>) model.get("customerList");
		
		int rowcount=0;
		
		//create a new excel Sheet
		HSSFSheet sheet=workbook.createSheet("Customers");
		sheet.setDefaultColumnWidth(30);
		
		//create style for header cells
		CellStyle style=workbook.createCellStyle();
		Font font=workbook.createFont();
		font.setFontName("Arial");
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setColor(HSSFColor.WHITE.index);
		style.setFont(font);
		style.setFillForegroundColor(HSSFColor.BLUE.index);
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		
		//header
		HSSFRow header=sheet.createRow(rowcount++);
		
		
		header.createCell(0).setCellValue("Customer Name");
		header.createCell(1).setCellValue("Customer Code");
		header.createCell(2).setCellValue("Branch Name");
		header.createCell(3).setCellValue("Address");
		header.createCell(4).setCellValue("Customer type");
		header.createCell(5).setCellValue("Email");
		
		
		header.getCell(0).setCellStyle(style);
		header.getCell(1).setCellStyle(style);
		header.getCell(2).setCellStyle(style);
		header.getCell(3).setCellStyle(style);
		header.getCell(4).setCellStyle(style);
		header.getCell(5).setCellStyle(style);
		

		
		//decimal format
		DecimalFormat f=new DecimalFormat("##.00");	
		System.out.println(f);
		
		//detail
		for(CustomerModel customerModel:customerList){
			HSSFRow row=sheet.createRow(rowcount++);
			row.createCell(0).setCellValue(customerModel.getCustomer_name());
			row.createCell(1).setCellValue(customerModel.getCustomer_code());
		
			row.createCell(2).setCellValue(customerModel.getBranchModel().getBranch_name());			
			row.createCell(3).setCellValue(customerModel.getCustomer_addressline1()+", "+customerModel.getCustomer_addressline2()
									+", "+customerModel.getLocation().getLocation_name()
									+", "+customerModel.getLocation().getAddress().getCity()
									+", "+customerModel.getLocation().getAddress().getDistrict()
									+", "+customerModel.getLocation().getAddress().getState());
			row.createCell(4).setCellValue(customerModel.getCustomer_type());
			row.createCell(5).setCellValue(customerModel.getCustomer_email());
			
		}
		
	}
}
