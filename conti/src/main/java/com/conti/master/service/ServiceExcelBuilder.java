package com.conti.master.service;

import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.springframework.web.servlet.view.document.AbstractExcelView;

public class ServiceExcelBuilder extends AbstractExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		@SuppressWarnings("unchecked")
		List<ServiceMaster> serviceList = (List<ServiceMaster>) model.get("serviceList");
		
		int rowcount = 0;
		
		//create a new excel sheet
		
		HSSFSheet sheet = workbook.createSheet("Services");
		sheet.setDefaultColumnWidth(30);
		
		//create style  for header cells
		
		CellStyle style =workbook.createCellStyle();
		Font font = workbook.createFont();
		font.setFontName("Arial");
		font.setBoldweight(HSSFColor.WHITE.index);
		style.setFont(font);
		style.setFillForegroundColor(HSSFColor.BLUE.index);
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		
		//Header
		
		HSSFRow header = sheet.createRow(rowcount++);
		
		header.createCell(0).setCellValue("SERVICE NAME");
		header.createCell(1).setCellValue("SERVICE CODE");
		
		
		header.getCell(0).setCellStyle(style);
		header.getCell(1).setCellStyle(style);
		
		//Decimal Format 
		
		DecimalFormat f = new DecimalFormat("##.00");
		
		//Detail
		
		for(ServiceMaster service:serviceList){
			HSSFRow row = sheet.createRow(rowcount++);
				row.createCell(0).setCellValue(service.getService_name());
				row.createCell(1).setCellValue(service.getService_code());
				
			}
	
	}

}
