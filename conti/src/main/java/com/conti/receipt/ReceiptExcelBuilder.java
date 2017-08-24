package com.conti.receipt;

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

import com.conti.manifest.ManifestModel;
import com.conti.manifest.ManifestDetailedModel;

/**
 * @Project_Name conti
 * @Package_Name com.conti.master.receipt
 * @File_name ReceiptExcelBuilder.java
 * @author Suresh
 * @Created_date_time Aug 10, 2017 11:13:27 AM
 * @Updated_date_time Aug 10, 2017 11:13:27 AM
 */
public class ReceiptExcelBuilder extends AbstractExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
	
		List<ReceiptModel> receiptList=(List<ReceiptModel>) model.get("receiptList");
		
		int rowcount=0;
		
		//create a new excel Sheet
		HSSFSheet sheet=workbook.createSheet("Receipt");
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
		
		
		header.createCell(0).setCellValue("SL no");
		header.createCell(1).setCellValue("Date");
		header.createCell(2).setCellValue("LR Number");
		header.createCell(3).setCellValue("Receipt");
		header.createCell(4).setCellValue("Product");
		header.createCell(5).setCellValue("Origin");
		header.createCell(6).setCellValue("Destination");
		header.createCell(7).setCellValue("Sender");
		header.createCell(8).setCellValue("Consignee");
		header.createCell(9).setCellValue("Manifest");
		header.createCell(10).setCellValue("Status");
		
		
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
		header.getCell(10).setCellStyle(style);
		

		
		//decimal format
		DecimalFormat f=new DecimalFormat("##.00");		
		
		//detail
		for(ReceiptModel receiptModel:receiptList){
			HSSFRow row=sheet.createRow(rowcount++);
		/*	//row.createCell(0).setCellValue(receiptModel.shipmentModel.getCreated_datetime());
			row.createCell(1).setCellValue(receiptModel.shipmentModel.getCreated_datetime());
			row.createCell(2).setCellValue(receiptModel.shipmentModel.getLr_number());
			row.createCell(3).setCellValue(receiptModel.receipt_number);
			row.createCell(4).setCellValue(receiptModel.shipmentModel.getLr_number());
			row.createCell(5).setCellValue(receiptModel.manifestModel.branchModel1.getBranch_name());
			row.createCell(6).setCellValue(receiptModel.manifestModel.branchModel2.getBranch_name());
			row.createCell(7).setCellValue(receiptModel.shipmentModel.getSendercustomer_address1());
			row.createCell(8).setCellValue(receiptModel.shipmentModel.getSendercustomer_address2());
			row.createCell(9).setCellValue(receiptModel.manifestModel.getManifest_number());
			row.createCell(10).setCellValue(receiptModel.shipmentModel.getStatus());
		*/}
		
	}
}
