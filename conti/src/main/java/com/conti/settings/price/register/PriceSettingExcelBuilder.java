package com.conti.settings.price.register;

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

import com.conti.settings.price.PriceSetting;
import com.conti.settings.price.PriceSettingDetail;

/**
 * @Project_Name conti
 * @Package_Name com.conti.settings.price.register  
 * @File_name PriceSettingExcelBuilder.java 
 * @author Monu.C
 * @Created_date_time Jul 28, 2017 11:21:47 AM
 */
public class PriceSettingExcelBuilder extends AbstractExcelView{

	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		
		System.out.println("++ inside excel product");		
		List<PriceSetting> priceSettingList=(List<PriceSetting>) model.get("priceSettingList");
		
		int rowcount=0;
		
		//create a new excel Sheet
		HSSFSheet sheet=workbook.createSheet("Price Setting");
		sheet.setDefaultColumnWidth(35);
		
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
		
		header.createCell(0).setCellValue("From Branch");
		header.createCell(1).setCellValue("Service");
		header.createCell(2).setCellValue("Product");
		header.createCell(3).setCellValue("Product Type");
		header.createCell(4).setCellValue("Default Price");
		header.createCell(5).setCellValue("Default Handling Charges");
			
		
		header.getCell(0).setCellStyle(style);
		header.getCell(1).setCellStyle(style);
		header.getCell(2).setCellStyle(style);
		header.getCell(3).setCellStyle(style);
		header.getCell(4).setCellStyle(style);
		header.getCell(5).setCellStyle(style);
		
		//decimal format
		DecimalFormat f=new DecimalFormat("##.00");
		
		//detail
		for(PriceSetting priceSetting:priceSettingList){
			HSSFRow row=sheet.createRow(rowcount++);
			row.createCell(0).setCellValue(priceSetting.getBranch().getBranch_name());
			row.createCell(1).setCellValue(priceSetting.getService().getService_name());
			row.createCell(2).setCellValue(priceSetting.getProduct().getProduct_name());
			row.createCell(3).setCellValue(priceSetting.getProduct().getProduct_Type());
			row.createCell(4).setCellValue(priceSetting.getDefault_price());
			row.createCell(5).setCellValue(priceSetting.getDefaulthandling_charge());
		}
		
		
		int rowcountDetail=0;
		
		//create a new excel Sheet
				HSSFSheet detailSheet=workbook.createSheet("Price Setting Detail");
				detailSheet.setDefaultColumnWidth(40);
				
				//create style for header cells
				CellStyle detailStyle=workbook.createCellStyle();
				detailStyle.setFont(font);
				detailStyle.setFillForegroundColor(HSSFColor.BLUE.index);
				detailStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
				
				//header
				HSSFRow detailHeader=detailSheet.createRow(rowcountDetail++);
				
				detailHeader.createCell(0).setCellValue("From Branch");
				detailHeader.createCell(1).setCellValue("Product");
				detailHeader.createCell(2).setCellValue("To Branch");
				detailHeader.createCell(3).setCellValue("Weight(From)");
				detailHeader.createCell(4).setCellValue("Weight(To)");
				detailHeader.createCell(5).setCellValue("Price");
					
				
				detailHeader.getCell(0).setCellStyle(style);
				detailHeader.getCell(1).setCellStyle(style);
				detailHeader.getCell(2).setCellStyle(style);
				detailHeader.getCell(3).setCellStyle(style);
				detailHeader.getCell(4).setCellStyle(style);
				detailHeader.getCell(5).setCellStyle(style);
				
				
				//detail
				for(PriceSetting priceSetting:priceSettingList){
					if(priceSetting!=null){
						for(PriceSettingDetail priceSettingDetail:priceSetting.getPriceSettingDetail()){
							if(priceSettingDetail!=null){
							HSSFRow rowDetail=detailSheet.createRow(rowcountDetail++);
							rowDetail.createCell(0).setCellValue(priceSetting.getBranch().getBranch_name());
							rowDetail.createCell(1).setCellValue(priceSetting.getProduct().getProduct_name());
							
							if(priceSettingDetail.getBranch()!=null){
								rowDetail.createCell(2).setCellValue(priceSettingDetail.getBranch().getBranch_name());
							}else{
								rowDetail.createCell(2).setCellValue("");
							}
							rowDetail.createCell(3).setCellValue(f.format(priceSettingDetail.getPs_weightfrom()));
							rowDetail.createCell(4).setCellValue(f.format(priceSettingDetail.getPs_weightto()));
							rowDetail.createCell(5).setCellValue(f.format(priceSettingDetail.getPs_price()));
							}
						}	
					}
				}
		
	}

}
