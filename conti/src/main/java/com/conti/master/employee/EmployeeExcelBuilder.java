package com.conti.master.employee;

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

import com.conti.master.product.Product;

/**
 * @Project_Name conti
 * @Package_Name com.conti.master.employee
 * @File_name EmployeeExcelBuilder.java
 * @author Sankar
 * @Created_date_time Jul 13, 2017 6:13:27 PM
 * @Updated_date_time Jul 13, 2017 6:13:27 PM
 */
public class EmployeeExcelBuilder extends AbstractExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
	
		List<EmployeeMaster> employeeList=(List<EmployeeMaster>) model.get("employeeList");
		
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
		
		
		header.createCell(0).setCellValue("Employee Name");
		header.createCell(1).setCellValue("Employee Code");
		header.createCell(2).setCellValue("Employee Category");
		header.createCell(3).setCellValue("DOB");
		header.createCell(4).setCellValue("DOJ");
		header.createCell(5).setCellValue("Branch");
		header.createCell(6).setCellValue("Address");
		header.createCell(7).setCellValue("Date of joining");
		header.createCell(8).setCellValue("Mobileno");
		header.createCell(9).setCellValue("Email");
		
		
		header.getCell(0).setCellStyle(style);
		header.getCell(1).setCellStyle(style);
		header.getCell(2).setCellStyle(style);
		header.getCell(3).setCellStyle(style);
		header.getCell(4).setCellStyle(style);
		header.getCell(5).setCellStyle(style);
		header.getCell(6).setCellStyle(style);
		header.getCell(7).setCellStyle(style);
		header.getCell(8).setCellStyle(style);
		header.getCell(9).setCellStyle(style);

		
		//decimal format
		DecimalFormat f=new DecimalFormat("##.00");		
		
		//detail
		for(EmployeeMaster employee:employeeList){
			HSSFRow row=sheet.createRow(rowcount++);
			row.createCell(0).setCellValue(employee.getEmp_name());
			row.createCell(1).setCellValue(employee.getEmp_code());
			row.createCell(2).setCellValue(employee.getEmpcategory());
			row.createCell(3).setCellValue(employee.getDob());
			row.createCell(4).setCellValue(employee.getDoj());
			row.createCell(5).setCellValue(employee.getBranchModel().getBranch_name());			
			row.createCell(6).setCellValue(employee.getEmp_address1()+", "+employee.getEmp_address2()
									+", "+employee.getLocation().getLocation_name()
									+", "+employee.getLocation().getAddress().getCity()
									+", "+employee.getLocation().getAddress().getDistrict()
									+", "+employee.getLocation().getAddress().getState());
			row.createCell(7).setCellValue(employee.getDoj());
			row.createCell(8).setCellValue(employee.getEmp_phoneno());
			row.createCell(9).setCellValue(employee.getEmp_email());
		}
		
	}
}
