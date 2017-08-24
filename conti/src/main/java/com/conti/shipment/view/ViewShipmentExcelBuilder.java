package com.conti.shipment.view;

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
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.shipment.add.ShipmentDetailModel;
import com.conti.shipment.add.ShipmentHsnDetailModel;
import com.conti.shipment.add.ShipmentModel;

/**
 * @Project_Name conti
 * @Package_Name com.conti.manifest  com.conti.manifest
 * @File_name ShipmentExcelBuilder.java com.conti.manifest
 * @author Monu.C
 * @Created_date_time Aug 17, 2017 5:39:48 PM
 */
public class ViewShipmentExcelBuilder extends AbstractExcelView {


	
	Loggerconf loggerconf = new Loggerconf();
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		List<ShipmentModel>  shipmentList=(List<ShipmentModel>)model.get("shipmentList");
		
		int rowcount=0;
		
		//create a new excel Sheet
		HSSFSheet sheet=workbook.createSheet("Shipment");
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
		
		header.createCell(0).setCellValue("LR No");
		header.createCell(1).setCellValue("Origin");
		header.createCell(2).setCellValue("Destination");
		header.createCell(3).setCellValue("Sender");
		header.createCell(4).setCellValue("Consignee");
		header.createCell(5).setCellValue("TotalParcel");
		header.createCell(6).setCellValue("Service");
		header.createCell(7).setCellValue("Status");
		header.createCell(8).setCellValue("Date");
		

		header.getCell(0).setCellStyle(style);
		header.getCell(1).setCellStyle(style);
		header.getCell(2).setCellStyle(style);
		header.getCell(3).setCellStyle(style);
		header.getCell(4).setCellStyle(style);
		header.getCell(5).setCellStyle(style);
		header.getCell(6).setCellStyle(style);
		header.getCell(7).setCellStyle(style);
		header.getCell(8).setCellStyle(style);
		
		//decimal format
		DecimalFormat f=new DecimalFormat("##.00");
		
		
		//============================================Product Table initialization=======================================================
		int rowCountProduct=0;
		
		
		//create a new excel Sheet
		HSSFSheet detailSheet=workbook.createSheet("Shipment Products");
		detailSheet.setDefaultColumnWidth(30);
		
		//create style for header cells
		CellStyle detailStyle=workbook.createCellStyle();
		detailStyle.setFont(font);
		detailStyle.setFillForegroundColor(HSSFColor.BLUE.index);
		detailStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
		
		//header
		HSSFRow detailHeader=detailSheet.createRow(rowCountProduct++);
		
		String[] productHeadings={"LR NO","Product Name","Length","Width","Height","Weight","Quantity","Unit Price","Total Price"};
		
		for(int i=0;i<productHeadings.length;i++){
			detailHeader.createCell(i).setCellValue(productHeadings[i]);
			detailHeader.getCell(i).setCellStyle(style);	
		}
			
		//============================================Hsn Table initialization=======================================================
		int rowCountHsn=0;
		
		//create style for header cells
		CellStyle detailHsnStyle=workbook.createCellStyle();
		detailHsnStyle.setFont(font);
		detailHsnStyle.setFillForegroundColor(HSSFColor.BLUE.index);
		detailHsnStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
		
		//create a new excel Sheet
		HSSFSheet hsnDetailSheet=workbook.createSheet("HSN For Products");
		hsnDetailSheet.setDefaultColumnWidth(40);
		
		//header
		HSSFRow hsnHeader=hsnDetailSheet.createRow(rowCountHsn++);
		
		String[] detailHsnHeading={"LR NO","Product Name","HSN Code","HSN Description"};

		for(int j=0;j<detailHsnHeading.length;j++){
			System.err.println(detailHsnHeading[j]);
			hsnHeader.createCell(j).setCellValue(detailHsnHeading[j]);
			hsnHeader.getCell(j).setCellStyle(detailHsnStyle);
		}
		
		//============================================ Initialization End=======================================================
		for(ShipmentModel shipmentModel:shipmentList){
			HSSFRow row=sheet.createRow(rowcount++);			
			try {
				row.createCell(0).setCellValue(shipmentModel.getLrno_prefix());
				
				if(shipmentModel.getSender_branch()!=null){
					row.createCell(1).setCellValue(shipmentModel.getSender_branch().getBranch_name());
				}else{
					row.createCell(1).setCellValue("");
				}
				
				if(shipmentModel.getConsignee_branch()!=null){
					row.createCell(2).setCellValue(shipmentModel.getConsignee_branch().getBranch_name());	
				}else{
					row.createCell(2).setCellValue("");
				}
				
				if(shipmentModel.getSender_customer()!=null){
					row.createCell(3).setCellValue(shipmentModel.getSender_customer().getCustomer_name());
				}else{
					row.createCell(3).setCellValue("");
				}
				
				if(shipmentModel.getConsignee_customer()!=null){
					row.createCell(4).setCellValue(shipmentModel.getConsignee_customer().getCustomer_name());
				}else{
					row.createCell(4).setCellValue("");
				}
				
				row.createCell(5).setCellValue(shipmentModel.getNumberof_parcel());

				//row.createCell(6).setCellValue(f.format(shipmentModel.getChargeable_weight()));
				
				if(shipmentModel.getService()!=null){
					row.createCell(6).setCellValue(shipmentModel.getService().getService_name());
				}else{
					row.createCell(6).setCellValue("");
				}
				row.createCell(7).setCellValue(shipmentModel.getStatus());
				row.createCell(8).setCellValue(shipmentModel.getUpdated_datetime());
				
				//============================================Product Table =======================================================
				try {
					for(ShipmentDetailModel shipmentDetailModel:shipmentModel.getShipmentDetail()){
						if(shipmentDetailModel!=null){
							HSSFRow rowProduct=detailSheet.createRow(rowCountProduct++);
							rowProduct.createCell(0).setCellValue(shipmentModel.getLr_number());
							if(shipmentDetailModel.getProduct()!=null){
								rowProduct.createCell(1).setCellValue(shipmentDetailModel.getProduct().getProduct_name());	
							}else{
								rowProduct.createCell(1).setCellValue("");
							}						
							rowProduct.createCell(2).setCellValue(shipmentDetailModel.getLength());
							rowProduct.createCell(3).setCellValue(shipmentDetailModel.getWidth());
							rowProduct.createCell(4).setCellValue(shipmentDetailModel.getHeight());
							rowProduct.createCell(5).setCellValue(shipmentDetailModel.getWeight());
							rowProduct.createCell(6).setCellValue(shipmentDetailModel.getQuantity());
							rowProduct.createCell(7).setCellValue(shipmentDetailModel.getUnit_price());
							rowProduct.createCell(8).setCellValue(shipmentDetailModel.getTotal_price());
							
							
							
							//============================================hsn Table=======================================================
							try {
								for(ShipmentHsnDetailModel shipmentHsnDetailModel:shipmentDetailModel.getShipmentHsnDetail()){
									if(shipmentHsnDetailModel!=null){
										HSSFRow rowHSN=hsnDetailSheet.createRow(rowCountHsn++);

										rowHSN.createCell(0).setCellValue(shipmentModel.getLr_number());
										
										if(shipmentDetailModel.getProduct()!=null){
											rowHSN.createCell(1).setCellValue(shipmentDetailModel.getProduct().getProduct_name());	
										}else{
											rowHSN.createCell(1).setCellValue("");
										}
										
										if(shipmentHsnDetailModel.getHsn()!=null){
											rowHSN.createCell(2).setCellValue(shipmentHsnDetailModel.getHsn().getHsn_code());
											rowHSN.createCell(3).setCellValue(shipmentHsnDetailModel.getHsn().getHsn_description());
											rowHSN.createCell(4).setCellValue(shipmentHsnDetailModel.getHsn().getHsn_shortdescription());
										}else{
											rowHSN.createCell(2).setCellValue("");
											rowHSN.createCell(3).setCellValue("");
											rowHSN.createCell(4).setCellValue("");
										}
									}
								}
							} catch (Exception e) {
								loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS+"shipment detail hsn excel error", e);
								e.printStackTrace();
							}
							
							
							
						}
						
					}
				} catch (Exception e) {
					loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS+"shipment product excel error", e);
					e.printStackTrace();
				}
				
				
				
			} catch (Exception e) {
				loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS+"shipment excel error", e);
				e.printStackTrace();
			}
			
		}
		

		
		
		
	}

}
