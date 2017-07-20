package com.conti.master.branch;

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

import com.conti.master.customer.CustomerModel;

/**
 * @Project_Name conti
 * @Package_Name com.conti.master.employee
 * @File_name EmployeeExcelBuilder.java
 * @author Sankar
 * @Created_date_time Jul 13, 2017 6:13:27 PM
 * @Updated_date_time Jul 13, 2017 6:13:27 PM
 */
public class BranchExcelBuilder extends AbstractExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
	
		List<BranchModel> branchList=(List<BranchModel>) model.get("branchList");
		
		int rowcount=0;
		
		//create a new excel Sheet
		HSSFSheet sheet=workbook.createSheet("Employees");
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
		
		
		header.createCell(0).setCellValue("Branch Name");
		header.createCell(1).setCellValue("Branch Code");
		header.createCell(2).setCellValue("Address");
		header.createCell(3).setCellValue("Contact Person");
		header.createCell(4).setCellValue("Contact Number");
		header.createCell(5).setCellValue("Contact Email");
		
		
		header.getCell(0).setCellStyle(style);
		header.getCell(1).setCellStyle(style);
		header.getCell(2).setCellStyle(style);
		header.getCell(3).setCellStyle(style);
		header.getCell(4).setCellStyle(style);
		header.getCell(5).setCellStyle(style);
		

		
		//decimal format
		DecimalFormat f=new DecimalFormat("##.00");		
		
		//detail
		for(BranchModel branchModel:branchList){
			HSSFRow row=sheet.createRow(rowcount++);
			row.createCell(0).setCellValue(branchModel.getBranch_name());
			row.createCell(1).setCellValue(branchModel.getBranch_code());
		
			
			row.createCell(2).setCellValue(branchModel.getBranch_addressline1()+", "+branchModel.getBranch_addressline2()
									+", "+branchModel.getLocation().getLocation_name()
									+", "+branchModel.getLocation().getAddress().getCity()
									+", "+branchModel.getLocation().getAddress().getDistrict()
									+", "+branchModel.getLocation().getAddress().getState());
			row.createCell(3).setCellValue(branchModel.getBranch_contactperson());
			row.createCell(4).setCellValue(branchModel.getBranch_mobileno());
			row.createCell(5).setCellValue(branchModel.getBranch_email());
			
		}
		
	}
}
