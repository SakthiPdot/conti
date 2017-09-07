package com.conti.setting.usercontrol;

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
public class UserExcelBuilder extends AbstractExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
	
		@SuppressWarnings("unchecked")
		List<User> userList=(List<User>) model.get("userList");
		
		int rowcount=0;
		
		//create a new excel Sheet
		HSSFSheet sheet=workbook.createSheet("Users");
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
		header.createCell(2).setCellValue("Username");
		header.createCell(3).setCellValue("Role");
		header.createCell(4).setCellValue("Branch");
		
		header.getCell(0).setCellStyle(style);
		header.getCell(1).setCellStyle(style);
		header.getCell(2).setCellStyle(style);
		header.getCell(3).setCellStyle(style);
		header.getCell(4).setCellStyle(style);

		
		//decimal format
		DecimalFormat f=new DecimalFormat("##.00");		
		System.out.println(""+f);
		//detail
		for(User user:userList){
			HSSFRow row=sheet.createRow(rowcount++);
			row.createCell(0).setCellValue(user.getEmployeeMaster().getEmp_name());
			row.createCell(1).setCellValue(user.getEmployeeMaster().getEmp_code());
			row.createCell(2).setCellValue(user.getUsername());
			row.createCell(3).setCellValue(user.role.getRole_Name());
			row.createCell(4).setCellValue(user.getBranchModel().getBranch_name());
			
		}
		
	}
}
