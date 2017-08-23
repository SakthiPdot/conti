package com.conti.manifest;

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
import com.conti.others.Loggerconf;
import com.conti.manifest.ManifestModel;
import com.conti.others.ConstantValues;
import com.conti.manifest.ManifestDetailedModel;

/**
 * @Project_Name conti
 * @Package_Name com.conti.master.manifest
 * @File_name ManifestExcelBuilder.java
 * @author Suresh
 * @Created_date_time Aug 03, 2017 6:13:27 PM
 * @Updated_date_time Aug 03, 2017 6:13:27 PM
 */
public class ManifestExcelBuilder extends AbstractExcelView 
{
	Loggerconf loggerconf = new Loggerconf();
	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
	
		List<ManifestModel> manifestList=(List<ManifestModel>) model.get("manifestList");
		
		int rowcount=0;
		
		//create a new excel Sheet
		HSSFSheet sheet=workbook.createSheet("Manifest");
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
		
		
		header.createCell(0).setCellValue("Manifest Number");
		header.createCell(1).setCellValue("Manifest Origin");
		header.createCell(2).setCellValue("Manifest Destination");
		header.createCell(3).setCellValue("Vehicle Number");
		header.createCell(4).setCellValue("Driver name");
		header.createCell(5).setCellValue("Manifest Status");
		header.createCell(6).setCellValue("No of Articles");
		
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
		for(ManifestModel manifestModel:manifestList)
		{
			HSSFRow row=sheet.createRow(rowcount++);
			row.createCell(0).setCellValue(manifestModel.getManifest_number());
			row.createCell(1).setCellValue(manifestModel.getBranchModel1().getBranch_name());
			row.createCell(2).setCellValue(manifestModel.getBranchModel2().getBranch_name());
			row.createCell(3).setCellValue(manifestModel.getVehicleMaster().getVehicle_regno());
			row.createCell(4).setCellValue(manifestModel.getEmployeeDriver().getEmp_id());
			row.createCell(5).setCellValue(manifestModel.getManifest_status());
			row.createCell(6).setCellValue(manifestModel.getManifestDetailModel().size());
		}
		
		int rowcountDetail=0;
		//create new excel sheet
			HSSFSheet detailSheet=workbook.createSheet("Detailed Manifeest ");
			detailSheet.setDefaultColumnWidth(40);
			
		//Create style for header cells
			CellStyle detailStyle=workbook.createCellStyle();
			detailStyle.setFont(font);
			detailStyle.setFillBackgroundColor(HSSFColor.BLUE.index);
			detailStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
			
		//header
			HSSFRow detailHeader=detailSheet.createRow(rowcountDetail++);
			detailHeader.createCell(0).setCellValue("Manifest detailed_id");
			detailHeader.createCell(1).setCellValue("Manifest id");
			detailHeader.createCell(2).setCellValue("Shipment_id");
			
			detailHeader.getCell(0).setCellStyle(style);
			detailHeader.getCell(1).setCellStyle(style);
			detailHeader.getCell(2).setCellStyle(style);
			
			for(ManifestModel manifestModel:manifestList)
			{
				if(manifestModel!=null)
				{
					try
					{
						for(ManifestDetailedModel manifestDetailedModel:manifestModel.getManifestDetailModel())
						{
							if(manifestDetailedModel!=null)
							{
								HSSFRow rowDetail=detailSheet.createRow(rowcountDetail++);
								rowDetail.createCell(0).setCellValue(manifestDetailedModel.getManifestdetailed_id());
								rowDetail.createCell(1).setCellValue(manifestDetailedModel.getManifestModel().getManifest_number());
								rowDetail.createCell(1).setCellValue(manifestDetailedModel.getShipmentModel().getLrno_prefix());
							}
						}
					}
					catch(Exception e)
					{
						loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, e);
						e.printStackTrace();
					}
				}
			}
	}
}
