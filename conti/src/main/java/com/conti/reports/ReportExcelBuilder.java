package com.conti.reports;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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

import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.shipment.add.ShipmentModel;

/**
 * @Project_Name conti
 * @Package_Name com.conti.manifest  com.conti.manifest
 * @File_name ShipmentExcelBuilder.java com.conti.manifest
 * @author Monu.C
 * @Created_date_time Aug 17, 2017 5:39:48 PM
 */
public class ReportExcelBuilder extends AbstractExcelView {


	
	Loggerconf loggerconf = new Loggerconf();
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		List<ShipmentModel>  shipmentList=(List<ShipmentModel>)model.get("shipmentList");
		
		int rowcount=0;
		
		//create a new excel Sheet
		HSSFSheet sheet=workbook.createSheet("Report");
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
		
		header.createCell(0).setCellValue("S.No.");
		header.createCell(1).setCellValue("Shipment date");
		header.createCell(2).setCellValue("LR number");
		header.createCell(3).setCellValue("Product");
		header.createCell(4).setCellValue("Origin");
		header.createCell(5).setCellValue("Destination");
		header.createCell(6).setCellValue("Sender");
		header.createCell(7).setCellValue("Consignee");
		header.createCell(8).setCellValue("No.of Parcel");
		header.createCell(9).setCellValue("Service");
		header.createCell(10).setCellValue("Receipt Date");
		header.createCell(11).setCellValue("Receipt No.");
		header.createCell(12).setCellValue("Pay mode");
		header.createCell(13).setCellValue("Bill To");
		header.createCell(14).setCellValue("L.R. Freight Charge");
		header.createCell(15).setCellValue("Total Handling Charge");
		header.createCell(16).setCellValue("Local Transport charge");
		header.createCell(17).setCellValue("Receipt Net Charge");
		header.createCell(18).setCellValue("Status");
		
		
		for(int i=0;i<19;i++){
			header.getCell(i).setCellStyle(style);	
		}
		
		//decimal format
		DecimalFormat f=new DecimalFormat("##.00");
		
		
		//============================================Product Table initialization=======================================================
		/*int rowCountProduct=0;
		
		
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
			*/
		//============================================Hsn Table initialization=======================================================
		/*int rowCountHsn=0;
		
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
		*/
		//============================================ Initialization End=======================================================
		for(ShipmentModel shipmentModel:shipmentList){
			HSSFRow row=sheet.createRow(rowcount++);			
			try {
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				SimpleDateFormat dateFormat1 = new SimpleDateFormat("dd/MM/yyyy HH:mm a");
			    /*String shipment_date = shipment.getShipment_date().toString();
			    Date date = dateFormat.parse(shipment_date.substring(0, shipment_date.length()-2));
			    
			    SimpleDateFormat dateFormat1 = new SimpleDateFormat("dd/MM/yyyy HH:mm a");*/
			    
			    
				row.createCell(0).setCellValue(rowcount-1);
				String[] shipment_date = shipmentModel.getShipment_date().split("\\.");
				Date date = dateFormat.parse(shipment_date[0]);
				row.createCell(1).setCellValue(dateFormat1.format(date));
				
				row.createCell(2).setCellValue(shipmentModel.getLrno_prefix());
				StringBuilder sb_product = new StringBuilder();
				for(int i=0;i<shipmentModel.getShipmentDetail().size();i++){
					sb_product.append(shipmentModel.getShipmentDetail().get(i).getProduct().getProduct_name());
					if(shipmentModel.getShipmentDetail().size()-1 != i){
						sb_product.append(", ");	
					}
					
				}
				row.createCell(3).setCellValue(sb_product.toString());
				row.createCell(4).setCellValue(shipmentModel.getSender_branch().getBranch_name());
				row.createCell(5).setCellValue(shipmentModel.getConsignee_branch().getBranch_name());
				row.createCell(6).setCellValue(shipmentModel.getSender_customer().getCustomer_name());
				row.createCell(7).setCellValue(shipmentModel.getConsignee_customer().getCustomer_name());
				row.createCell(8).setCellValue(shipmentModel.getNumberof_parcel());
				row.createCell(9).setCellValue(shipmentModel.getService().getService_name());
				
				String[] receipt_date = shipmentModel.getReceipt_date().split("\\.");
				Date dateRecpt = dateFormat.parse(receipt_date[0]);
				row.createCell(10).setCellValue(dateFormat1.format(dateRecpt));
				row.createCell(11).setCellValue(shipmentModel.getReceipt_no());
				row.createCell(12).setCellValue(shipmentModel.getPay_mode());
				row.createCell(13).setCellValue(shipmentModel.getBill_to());
				row.createCell(14).setCellValue(f.format(shipmentModel.getTotal_charges()));
				row.createCell(15).setCellValue(f.format(shipmentModel.getHandling_charge()));
				row.createCell(16).setCellValue(f.format(shipmentModel.getReceipt_transport()));
				row.createCell(17).setCellValue(f.format(shipmentModel.getReceipt_charge()));
				row.createCell(18).setCellValue(shipmentModel.getStatus());

				
				
				//============================================Product Table =======================================================
				/*try {
					for(ShipmentDetailModel shipmentDetailModel:shipmentModel.getShipmentDetail()){
						if(shipmentDetailModel!=null){
							HSSFRow rowProduct=detailSheet.createRow(rowCountProduct++);
							rowProduct.createCell(0).setCellValue(shipmentModel.getLrno_prefix());
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

										rowHSN.createCell(0).setCellValue(shipmentModel.getLrno_prefix());
										
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
				}*/
				
				
				
			} catch (Exception e) {
				loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS+"shipment excel error", e);
				e.printStackTrace();
			}
			
		}
		

		
		
		
	}

}