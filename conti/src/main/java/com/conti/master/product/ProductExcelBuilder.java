package com.conti.master.product;

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
 * @Package_Name com.conti.master.product  com.conti.master.product
 * @File_name ProductExcelBuilder.java com.conti.master.product
 * @author Monu.C
 * @Created_date_time Jul 13, 2017 10:24:32 AM
 */
public class ProductExcelBuilder extends AbstractExcelView {


	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
	
		System.out.println("++ inside excel product");		
		@SuppressWarnings("unchecked")
		List<Product> productList=(List<Product>) model.get("ProductList");
		
		int rowcount=0;
		
		//create a new excel Sheet
		HSSFSheet sheet=workbook.createSheet("Products");
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
		
		
		header.createCell(0).setCellValue("Product Name");
		header.createCell(1).setCellValue("Product Code");
		header.createCell(2).setCellValue("Product Type");
		header.createCell(3).setCellValue("Max Weight");
		header.createCell(4).setCellValue("Max Height");
		header.createCell(5).setCellValue("Max Width");
		header.createCell(6).setCellValue("Max Length");
		
		
		header.getCell(0).setCellStyle(style);
		header.getCell(1).setCellStyle(style);
		header.getCell(2).setCellStyle(style);
		header.getCell(3).setCellStyle(style);
		header.getCell(4).setCellStyle(style);
		header.getCell(5).setCellStyle(style);
		header.getCell(6).setCellStyle(style);
		
		//decimal format
		DecimalFormat f=new DecimalFormat("##.00");		
		
		//detail
		for(Product product:productList){
			HSSFRow row=sheet.createRow(rowcount++);
			row.createCell(0).setCellValue(product.getProduct_name());
			row.createCell(1).setCellValue(product.getProduct_code());
			row.createCell(2).setCellValue(product.getProduct_Type());
			row.createCell(3).setCellValue(f.format(product.getMax_weight()));
			row.createCell(4).setCellValue(f.format(product.getMax_height()));
			row.createCell(5).setCellValue(f.format(product.getMax_width()));
			row.createCell(6).setCellValue(f.format(product.getMax_length()));
		}
		
	}

}
