package com.conti.reports;


import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.Base64;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.conti.config.SessionListener;
import com.conti.master.product.Product;
import com.conti.master.product.ProductDAO;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;
import com.conti.receipt.ReceiptDao;
import com.conti.receipt.ReceiptDetail;
import com.conti.receipt.ReceiptModel;
import com.conti.setting.usercontrol.User;
import com.conti.setting.usercontrol.UsersDao;
import com.conti.settings.company.Company;
import com.conti.settings.company.CompanySettingDAO;
import com.conti.shipment.add.ShipmentDao;
import com.conti.shipment.add.ShipmentModel;

import javassist.bytecode.Descriptor.Iterator;

/**
 * @Project_Name conti
 * @Package_Name com.conti.reports
 * @File_name ReportsController.java
 * @author Sakthi
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 20, 2017 2:21:39 PM
 */

@RestController
public class ReportsController {

	final Logger logger = LoggerFactory.getLogger(ReportsController.class);

	@Autowired
	private UsersDao usersDao;
		
	@Autowired
	@Qualifier("sessionRegistry")
	private SessionRegistry sessionRegistry;
	@Autowired
	private ShipmentDao shipmentDao;
	@Autowired
	private ReceiptDao receiptDao;
	@Autowired
	private ProductDAO productDao;
	@Autowired
	private CompanySettingDAO companySettingDao;
	UserInformation userInformation;
	ConstantValues constantVal = new ConstantValues();	
	Loggerconf loggerconf = new Loggerconf();
	SessionListener sessionListener = new SessionListener();

	@RequestMapping(value =  "report", method = RequestMethod.GET)
	public ModelAndView adminPage(HttpServletRequest request) throws Exception {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		String userid = userInformation.getUserId();
		ModelAndView model = new ModelAndView();
		try
		{
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			model.addObject("userid",userid);
			model.addObject("title", "Reports");
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.setViewName("Reports/reports");
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;

	}

	@RequestMapping(value="/fetch4all", method=RequestMethod.POST)
	public ResponseEntity<List<ShipmentModel>> fetch4all(@RequestBody String shipment, HttpServletRequest request){
		userInformation = new UserInformation(request);
		/*try{*/

		JSONObject json = new JSONObject(shipment);
			List<ShipmentModel> filterShip = new ArrayList<ShipmentModel>();
			
			if(json.get("billto").toString().equals("Paid")){ 
				List<ShipmentModel> shipmentList = shipmentDao.getShipment4Report(json.get("fromtoday").toString(), json.get("todate").toString(), 
						json.get("datecondition").toString(), json.get("frombranch").toString(), json.get("tobranch").toString(), json.get("branchcondition").toString(), 
						json.get("from_lrno").toString(), json.get("to_lrno").toString(), json.get("lrcondition").toString(), json.get("product_id").toString(), 
						json.get("paymentmode").toString(), json.get("status").toString(), json.get("billto").toString(), json.get("username").toString());
				
				if(!json.get("product_id").toString().isEmpty()){
					if(!shipmentList.isEmpty()){
						for(ShipmentModel shipmentM : shipmentList){
							for(int i=0; i<shipmentM.getShipmentDetail().size();i++){
								if(shipmentM.getShipmentDetail().get(i).getProduct().getProduct_id() == Integer.parseInt(json.get("product_id").toString())){
									filterShip.add(shipmentM);
								}
							}
						}
					}else{
						filterShip.addAll(shipmentList);
					}
					
				} else {
					filterShip.addAll(shipmentList);
				}
			}else{
				
				List<ShipmentModel> receiptShipment = new ArrayList<ShipmentModel>();
				List<ReceiptModel> receiptList = receiptDao.getReceiptbyDate((json.get("fromtoday").toString()),Integer.parseInt(json.get("username").toString()));
				for(ReceiptModel receipt : receiptList){
					for(int i=0; i < receipt.getReceiptDetailList().size(); i++){
						receiptShipment.add(receipt.getReceiptDetailList().get(i).shipmentModel);
					}
				}
				
				java.util.Iterator<ShipmentModel> shipIte = receiptShipment.iterator();
				while(shipIte.hasNext()){
					ShipmentModel shipNext = shipIte.next();
					if(shipNext.getSender_branch().getBranch_id() != Integer.parseInt(json.get("frombranch").toString()) ||
					   shipNext.getConsignee_branch().getBranch_id() != Integer.parseInt(json.get("tobranch").toString())){
						shipIte.remove();
					}
				}
				//receiptShipment.removeIf(ship->ship.getSender_branch().equals(json.get("frombranch").toString()));
				filterShip.addAll(receiptShipment);
				
			}
			
			
			if(filterShip.size() != 0){
				for(int i=0;i<filterShip.size();i++){
					ReceiptDetail receiptDetail = receiptDao.getReceiptbyShipment(filterShip.get(i).getShipment_id());
					if(receiptDetail!=null){
						
						ReceiptModel receipt = receiptDao.getReceiptbyId(receiptDetail.receiptModel.receipt_id);
						if(receipt!=null){
							filterShip.get(i).setReceipt_date(receipt.getCreated_datetime());
							filterShip.get(i).setReceipt_no(receipt.getReceipt_prefix());
							filterShip.get(i).setReceipt_charge(receipt.getReceipt_total());
							filterShip.get(i).setReceipt_handling(receiptDetail.getHandling_charge());
							filterShip.get(i).setReceipt_transport(receipt.getLocal_transport());
						}else{
							filterShip.get(i).setReceipt_date("Nil");
							filterShip.get(i).setReceipt_no("Nil");
							filterShip.get(i).setReceipt_charge(0);
							filterShip.get(i).setHandling_charge(0);
							filterShip.get(i).setReceipt_transport(0);
						}
						
					}else {
						filterShip.get(i).setReceipt_date("Nil");
						filterShip.get(i).setReceipt_no("Nil");
						filterShip.get(i).setReceipt_charge(0);
						filterShip.get(i).setHandling_charge(0);
						filterShip.get(i).setReceipt_transport(0);
					}
				}
				
			}
			if(filterShip.size()!=0){
				if(json.get("fromtoday").toString().isEmpty()){
					filterShip.get(0).setFilter_frmDate("All");	
				}else{
					filterShip.get(0).setFilter_frmDate(json.get("fromtoday").toString());
				}
				if(json.get("todate").toString().isEmpty()){
					filterShip.get(0).setFilter_toDate("All");
				}else{
					filterShip.get(0).setFilter_toDate(json.get("todate").toString());
				}
				if(json.get("frombranch").toString().isEmpty()){
					filterShip.get(0).setFilter_frmBranch("All");
				}else{
					filterShip.get(0).setFilter_frmBranch(filterShip.get(0).getSender_branch().getBranch_name());
				}
				if(json.get("tobranch").toString().isEmpty()){
					filterShip.get(0).setFilter_toBranch("All");
				}else{
					filterShip.get(0).setFilter_toBranch(filterShip.get(0).getConsignee_branch().getBranch_name());
				}
				if(json.get("from_lrno").toString().isEmpty()){
					filterShip.get(0).setFilter_frmlr("All");
				}else{
					filterShip.get(0).setFilter_frmlr(json.get("from_lrno").toString());
				}
				if(json.get("to_lrno").toString().isEmpty()){
					filterShip.get(0).setFilter_tolr("All");
				}else{
					filterShip.get(0).setFilter_frmlr(json.get("to_lrno").toString());
				}
				if(json.get("product_id").toString().isEmpty()){
					filterShip.get(0).setFilter_product("All");
				}else{
					Product product = productDao.getProduct(Integer.parseInt(json.get("product_id").toString()));
					filterShip.get(0).setFilter_product(product.getProduct_name());
				}
				if(json.get("paymentmode").toString().isEmpty()){
					filterShip.get(0).setFilter_paymode("All");
				}else{
					filterShip.get(0).setFilter_paymode(json.get("paymentmode").toString());
				}
				if(json.get("status").toString().isEmpty()){
					filterShip.get(0).setFilter_status("All");
				}else{
					filterShip.get(0).setFilter_status(json.get("status").toString());
				}
				if(json.get("billto").toString().isEmpty()){
					filterShip.get(0).setFilter_pay("All");
				}else{
					filterShip.get(0).setFilter_pay(json.get("billto").toString());
				}
				if(json.get("username").toString().isEmpty()){
					filterShip.get(0).setFilter_user("All");
				}else{
					User user = usersDao.get(Integer.parseInt(json.get("username").toString()));
					filterShip.get(0).setFilter_user(user.getUsername());
				}
			}
			

		/*	for sort  
		 * Collections.sort(filterShip, new Comparator<ShipmentModel>(){
			  public int compare(ShipmentModel sm1, ShipmentModel sm2){
			    return sm1.getReceipt_date().compareTo(sm2.getReceipt_date());
			  }
			});
			Collections.sort(filterShip, (ShipmentModel sm1, ShipmentModel sm2) -> sm1.getReceipt_date().compareTo(sm2.getReceipt_date()));*/
			return new ResponseEntity<List<ShipmentModel>> (filterShip, HttpStatus.OK);

		/*}catch(Exception e){
			return new ResponseEntity<List<ShipmentModel>> (HttpStatus.UNPROCESSABLE_ENTITY);
		}*/
	}
	
	//=================EXCEL DOWNLOAD=====================================
	@RequestMapping(value="downloadExcelForReport",method=RequestMethod.POST, params={"excel","!print"})
	public ModelAndView downloadExcelForReport(@RequestParam("filterShip") String shipment,HttpServletRequest request) throws JsonParseException, JsonMappingException, IOException{
		
		//change to fetch all 
		String userid = userInformation.getUserId();
		User user =usersDao.get(Integer.parseInt(userid));
		ObjectMapper mapper = new ObjectMapper();
		List<ShipmentModel>  shipmentList = mapper.readValue(shipment, new TypeReference<List<ShipmentModel>>(){});
		
		return new ModelAndView("ReportExcel","shipmentList",shipmentList);		
	}
	//----------------------------------------------- SHIPMENT EXCEL END
	//=================PDf DOWNLOAD=====================================
	@RequestMapping(value="downloadExcelForReport",method=RequestMethod.POST, params={"print","!excel"})
	public ModelAndView downloadpdfForReport(@RequestParam("filterShip") String shipment,HttpServletRequest request) throws JsonParseException, JsonMappingException, IOException, ParseException{
		
		//change to fetch all 
		String userid = userInformation.getUserId();
		User user =usersDao.get(Integer.parseInt(userid));
		ObjectMapper mapper = new ObjectMapper();
		List<ShipmentModel>  shipmentList = mapper.readValue(shipment, new TypeReference<List<ShipmentModel>>(){});
		SimpleDateFormat dateFmt = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat dateFmt1 = new SimpleDateFormat("dd/MM/yyyy");
		Date fildate = null;
		if(!shipmentList.get(0).getFilter_frmDate().equals(null)){
			fildate = dateFmt.parse(shipmentList.get(0).getFilter_frmDate());
			shipmentList.get(0).setFilter_frmDate(dateFmt1.format(fildate)); 
		} else {
			shipmentList.get(0).setFilter_frmDate(shipmentList.get(0).getFilter_frmDate());
		}
		
		
		Company company = companySettingDao.getById(1);
		String base64DataString ="";
		if(company!=null && company.getCompany_logo()!=null){
			byte[] encodeBase64 = Base64.encodeBase64(company.getCompany_logo());
			try {
				 base64DataString = new String(encodeBase64 , "UTF-8");
			} catch (UnsupportedEncodingException e) {
				loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), "Image support error", e);
			}		
		}else{
			base64DataString = ConstantValues.NO_IMAGE;	
		}
		
		ModelAndView model = new ModelAndView("print/report_print");
		model.addObject("title", "Shipment");
		model.addObject("company", company);
		model.addObject("shipmentList", shipmentList);
		model.addObject("image",base64DataString);
		return model;		
	}
	//----------------------------------------------- PDf DOWNLOAD END
	
	@RequestMapping(value="getshipment4report/{lr}", method = RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Map<String,List<ShipmentModel>>> getshipment4report(HttpServletRequest request,
			@PathVariable("lr") String lr) throws JsonGenerationException, JsonMappingException, JSONException, IOException {
		
		List<ShipmentModel> shipment = shipmentDao.getShipment4ReportByLRAdmin(lr);

		 Map result = new HashMap();
		 result.put("shipment", shipment);
		 
		return new ResponseEntity<Map<String,List<ShipmentModel>>> (result,HttpStatus.OK);
	}

}