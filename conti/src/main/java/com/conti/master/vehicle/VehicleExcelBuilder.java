package com.conti.master.vehicle;

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

public class VehicleExcelBuilder extends AbstractExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		List<VehicleMaster> vehicleList = (List<VehicleMaster>) model.get("vehicleList");
		
		int rowcount = 0;
		
		//Create a new Excel Sheet
		
		HSSFSheet sheet = workbook.createSheet("Vehicles");
		sheet.setDefaultColumnWidth(30);
		
		//Create Style for Header Cells
		
		CellStyle style = workbook.createCellStyle();
		Font font = workbook.createFont();
		font.setFontName("Arial");
		font.setBoldweight(HSSFColor.WHITE.index);
		style.setFont(font);
		style.setFillForegroundColor(HSSFColor.BLUE.index);
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		
		//Header
		
		
		HSSFRow header = sheet.createRow(rowcount++);
		
		header.createCell(0).setCellValue("VEHICLE REG NO");
		header.createCell(1).setCellValue("VEHICLE CODE");
		header.createCell(2).setCellValue("BRANCH NAME");
		header.createCell(3).setCellValue("VEHICLE MODEL NO");
		header.createCell(4).setCellValue("VEHICLE TYPE");
		
		header.getCell(0).setCellStyle(style);
		header.getCell(1).setCellStyle(style);
		header.getCell(2).setCellStyle(style);
		header.getCell(3).setCellStyle(style);
		header.getCell(4).setCellStyle(style);
		
		//Decimal Format
		
		DecimalFormat f = new DecimalFormat("##.00");
		
		//Details
		
		for(VehicleMaster vehicle:vehicleList){
			HSSFRow row = sheet.createRow(rowcount++);
			row.createCell(0).setCellValue(vehicle.getVehicle_regno());
			row.createCell(1).setCellValue(vehicle.getVehicle_code());
			row.createCell(2).setCellValue(vehicle.getBranchModel().getBranch_name());
			row.createCell(3).setCellValue(vehicle.getVehicle_modelno());
			row.createCell(4).setCellValue(vehicle.getVehicle_type());
		}
		
	}

}
