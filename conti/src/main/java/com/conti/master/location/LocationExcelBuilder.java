package com.conti.master.location;

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
 * @Package_Name com.conti.master.location  
 * @File_name LocationExcelBuilder.java 
 * @author Monu.C
 * @Created_date_time Jul 13, 2017 4:32:19 PM
 */
public class LocationExcelBuilder extends AbstractExcelView	 {


	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		System.out.println("++ inside excel product");		
		@SuppressWarnings("unchecked")
		List<Location> locationList=(List<Location>) model.get("locationList");
		
		int rowcount=0;
		
		//create a new excel Sheet
		HSSFSheet sheet=workbook.createSheet("Location");
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
		
		
		header.createCell(0).setCellValue("Location Name");
		header.createCell(1).setCellValue("City Name");
		header.createCell(2).setCellValue("District Name");
		header.createCell(3).setCellValue("State Name");
		header.createCell(4).setCellValue("Country Name");
		header.createCell(5).setCellValue("PinCode");
		
		
		header.getCell(0).setCellStyle(style);
		header.getCell(1).setCellStyle(style);
		header.getCell(2).setCellStyle(style);
		header.getCell(3).setCellStyle(style);
		header.getCell(4).setCellStyle(style);
		header.getCell(5).setCellStyle(style);
		
		//decimal format
		DecimalFormat f=new DecimalFormat("##.00");	
		
		//detail
		for(Location location:locationList){
			HSSFRow row=sheet.createRow(rowcount++);
			row.createCell(0).setCellValue(location.getLocation_name());
			row.createCell(1).setCellValue(location.getAddress().getCity());
			row.createCell(2).setCellValue(location.getAddress().getDistrict());
			row.createCell(3).setCellValue(location.getAddress().getState());
			row.createCell(4).setCellValue(location.getAddress().getCountry());
			row.createCell(5).setCellValue(location.getPincode());
		}
		
	}

}
