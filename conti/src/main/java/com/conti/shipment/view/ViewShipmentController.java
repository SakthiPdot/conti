package com.conti.shipment.view;

import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.Base64;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.conti.manifest.ManifestDao;
import com.conti.manifest.ManifestModel;
import com.conti.master.branch.BranchDao;
import com.conti.master.branch.BranchModel;
import com.conti.master.employee.EmployeeMaster;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.NumberToWord;
import com.conti.others.UserInformation;
import com.conti.receipt.ReceiptDao;
import com.conti.receipt.ReceiptDetail;
import com.conti.setting.usercontrol.User;
import com.conti.setting.usercontrol.UsersDao;
import com.conti.settings.company.Company;
import com.conti.settings.company.CompanySettingDAO;
import com.conti.shipment.add.ShipmentDao;
import com.conti.shipment.add.ShipmentModel;

/**
 * @Project_Name conti
 * @Package_Name com.conti.shipment.view
 * @File_name ViewShipmentController.java
 * @author Sakthi
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 20, 2017 2:21:39 PM
 */

@RestController
public class ViewShipmentController{

	final Logger logger = LoggerFactory.getLogger(ViewShipmentController.class);

	@Autowired
	private UsersDao usersDao;
	@Autowired
	private ShipmentDao shipmentDao;
	@Autowired
	private CompanySettingDAO companySettingDAO;
	@Autowired
	private BranchDao branchDao;
	@Autowired
	private NumberToWord numberToWord;
	@Autowired
	private ManifestDao manifestDao;
	@Autowired
	private ReceiptDao receiptDao;
	Loggerconf loggerconf = new Loggerconf();
	UserInformation userInformation;
	ConstantValues constantVal = new ConstantValues();

	// ---------------------------------------------- VIEW SHIPMENT BEGIN
	@RequestMapping(value = "view_shipment", method = RequestMethod.GET)
	public ModelAndView adminPage(HttpServletRequest request) throws Exception {

		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		String userid = userInformation.getUserId();
		int branch_id = Integer.parseInt(userInformation.getUserBranchId());

		ModelAndView model = new ModelAndView();

		try {
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);

			model.addObject("branch_id", branch_id);
			model.addObject("title", "View Shipment");
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.setViewName("Shipment/view shipment");

		} catch (Exception exception) {
			loggerconf.saveLogger(username, "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;

	}
	// ---------------------------------------------- VIEW SHIPMENT END

	// ---------------------------------------------- FETCH SHIPMENT WITH THE
	// STATUS BEGIN
	@RequestMapping(value = "/fetchshipmentforview", method = RequestMethod.GET)
	public ResponseEntity<List<ShipmentModel>> fetchShipmentforView(HttpServletRequest request) {

		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		String userid = userInformation.getUserId();
		int branch_id = Integer.parseInt(userInformation.getUserBranchId());
		try {

			User user = usersDao.get(Integer.parseInt(userid));

			if (user.role.getRole_Name().equals(constantVal.ROLE_SADMIN)) { // block
																			// for
																			// SUPER
																			// ADMIN
				List<ShipmentModel> shipment = shipmentDao.fetchshipmentforView();
				if (shipment.isEmpty()) {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, null);
					return new ResponseEntity<List<ShipmentModel>>(HttpStatus.NOT_FOUND);
				} else {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
					return new ResponseEntity<List<ShipmentModel>>(shipment, HttpStatus.OK);
				}

			} else { // block for MANAGER AND USER
				List<ShipmentModel> shipment = shipmentDao.fetchshipmentforView(branch_id);
				if (shipment.isEmpty()) {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, null);
					return new ResponseEntity<List<ShipmentModel>>(HttpStatus.NOT_FOUND);
				} else {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
					return new ResponseEntity<List<ShipmentModel>>(shipment, HttpStatus.OK);
				}
			}

		} catch (Exception exception) {
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.LOGGER_STATUS_E, exception);
			return new ResponseEntity<List<ShipmentModel>>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

	}
	// ---------------------------------------------- FETCH SHIPMENT WITH THE
	// STATUS END

	// ---------------------------------------------- FILTER SHIPMENT FOR VIEW
	// BEGIN

	@RequestMapping(value = "/filter_shipment", method = RequestMethod.POST)
	public ResponseEntity <List<ShipmentModel>> filterShipemntforView(@RequestBody String viewShipment, HttpServletRequest request) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		String user_id = userInformation.getUserId();
		int branch_id = Integer.parseInt(userInformation.getUserBranchId());
		
		JSONObject viewshipment_json = new JSONObject(viewShipment);
		List<ShipmentModel> filterShipment = shipmentDao.filterViewShipment(
				viewshipment_json.get("from_branch").toString(), viewshipment_json.get("to_branch").toString(), 
				viewshipment_json.get("fromdate").toString(), viewshipment_json.getString("todate").toString(), 
				viewshipment_json.get("status").toString() );	
	
		String product = viewshipment_json.get("product_id").toString();
		List<ShipmentModel> filterShip = new ArrayList<ShipmentModel>();
		if( ! product.isEmpty() ) {
			
			if( ! filterShipment.isEmpty() ) {
				for(ShipmentModel shipment : filterShipment) {
					for(int i = 0; i < shipment.getShipmentDetail().size(); i++ ) {
						if( shipment.getShipmentDetail().get(i).getProduct().getProduct_id() == Integer.parseInt(product) ) {
							filterShip.add(shipment);
						}
					}
				}
			} else {
				filterShip.addAll(filterShipment);
			}
		} else {
			filterShip.addAll(filterShipment);
		}
		
		
		
		return new ResponseEntity<List<ShipmentModel>> (filterShip, HttpStatus.OK);
	}

	// ---------------------------------------------- FILTER SHIPMENT FOR VIEW
	
	//----------------------------------------------- SEARCH BY LRNO FOR VIEW SHIPMENT BEGIN
	
	@RequestMapping( value = "/shipment_searchbylr", method = RequestMethod.POST)
	public ResponseEntity <List<ShipmentModel>> shipment_searchbylr (@RequestBody String lrno, HttpServletRequest request) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		String user_id = userInformation.getUserId();
		int branch_id = Integer.parseInt(userInformation.getUserBranchId());
		
		try {
			List<ShipmentModel> shipmentList = shipmentDao.shipment_searchbyLR4ViewAdmin(lrno);
			
			if( shipmentList.isEmpty() ) {
				return new ResponseEntity<List<ShipmentModel>> (HttpStatus.NO_CONTENT);
			} else {
				return new ResponseEntity<List<ShipmentModel>> (shipmentList,HttpStatus.OK);			
			}	
		} catch (Exception e) {
			return new ResponseEntity<List<ShipmentModel>> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
		
	}
	
	//----------------------------------------------- SEARCH BY LRNO FOR VIEW SHIPMENT END
	
	//----------------------------------------------- MAKE CANCEL / DELETE ONE SHIPMENT BEGIN
	
	@RequestMapping(value = "delete_shipment/{id}", method = RequestMethod.DELETE, produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity <String> shipment_delete (@PathVariable ("id") int id, HttpServletRequest request) {
		
		userInformation = new UserInformation (request);
		int user_id = Integer.parseInt(userInformation.getUserId()); 
		String username = userInformation.getUserName();
		ShipmentModel shipment = shipmentDao.getShipmentModelById(id);
		int can_flag = 0;
		
		try {
			ManifestModel manifest = manifestDao.getManifestIdByShipmentId(id);
			ReceiptDetail receiptDetail = receiptDao.getReceiptbyShipment(id);
			
			if(manifest != null) {
				can_flag = 1;
			}
			if(receiptDetail != null) {
				can_flag = 2;
			}
			if( manifest != null && receiptDetail != null ) {
				can_flag = 3;
			}
			if(can_flag == 0) {
				if (shipment != null) {
					
					Date date = new Date();
					DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
					
					shipment.setUpdated_by(user_id);
					shipment.setUpdated_datetime(dateFormat.format(date));
					shipment.setObsolete("Y");
					shipment.setStatus("Cancelled");	
					shipmentDao.saveOrUpdate(shipment);
					loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.DELETE_SUCCESS, null);
					
					return new ResponseEntity<String>(HttpStatus.OK);
				} else {
					 
					loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.DELETE_NOT_SUCCESS + " record not found", null);
					return new ResponseEntity<String>(HttpStatus.NOT_FOUND);
				}
			} else {
				
				String referred = null;
				if(can_flag == 1) {
					referred = "Manifest";
				} else if(can_flag == 2) {
					referred = "Receipt";
				} else {
					referred = "Manifest & Receipt";
				}
				loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.DELETE_NOT_SUCCESS+" Referred in "+referred, null);
				return new ResponseEntity<String>(referred, HttpStatus.OK);
			}
			
			
		} catch(Exception exception ) {
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.DELETE_NOT_SUCCESS, exception);
			return new ResponseEntity<String>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
		
	}
	
	//----------------------------------------------- MAKE CANCEL / DELETE ONE SHIPMENT END
	//----------------------------------------------- MAKE CANCEL / DELETE MULTIPLE SHIPMENT BEGIN
	@RequestMapping(value = "make_cancel", method = RequestMethod.POST, produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> make_cancel(@RequestBody int[] id, HttpServletRequest request) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		int user_id = Integer.parseInt(userInformation.getUserId());
		String referred = "referred in Manifest or Receipt";
		int cancel_flag = 0;
		try {
			for(int i=0; i<id.length; i++) {
				ShipmentModel shipmentDB = shipmentDao.getShipmentModelById(id[i]);
				ManifestModel manifest = manifestDao.getManifestIdByShipmentId(id[i]);
				ReceiptDetail receiptDetail = receiptDao.getReceiptbyShipment(id[i]);
				if(manifest == null && receiptDetail == null) {
					loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.DELETE_SUCCESS, null);
				} else {
					loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.DELETE_NOT_SUCCESS+" "+referred , null);
					cancel_flag = 1;
				}
			}
			
			if( cancel_flag == 1 ) {
				return new ResponseEntity<String>(referred,HttpStatus.OK);
			} else {
				for(int i=0; i<id.length; i++) {
					ShipmentModel shipmentDB = shipmentDao.getShipmentModelById(id[i]);
					Date date = new Date();
					DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
					
					shipmentDB.setUpdated_by(user_id);
					shipmentDB.setUpdated_datetime(dateFormat.format(date));
					shipmentDB.setObsolete("Y");
					shipmentDB.setStatus("Cancelled");	
					shipmentDao.saveOrUpdate(shipmentDB);
				}
				
				return new ResponseEntity<String>(HttpStatus.OK);
			}
			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.DELETE_NOT_SUCCESS, exception);
			return new ResponseEntity<String> (HttpStatus.UNPROCESSABLE_ENTITY);
		}

	}
	//----------------------------------------------- MAKE CANCEL / DELETE MULTIPLE SHIPMENT END
	
	//----------------------------------------------- SHIPMENT REGISTER PRING BEGIN
	@RequestMapping(value = "/viewshipment_print", method = RequestMethod.POST)
	public ModelAndView shipmentPring(@RequestParam("shipment") String shipment, HttpServletRequest request)
	{
		JSONArray jsonArray = new JSONArray(shipment);
		String[] shipment_id = new String[jsonArray.length()];
		for(int i=0; i <jsonArray.length();i++) {
			JSONObject jsonObject = jsonArray.getJSONObject(i);
			shipment_id[i] = Integer.toString(jsonObject.getInt("shipment_id"));			
		}
		List<ShipmentModel> listshipment = new ArrayList<ShipmentModel>();
		for(int i=0; i<shipment_id.length; i++) {
			ShipmentModel shipmentDB = shipmentDao.getShipmentModelById(Integer.parseInt(shipment_id[i]));
			listshipment.add(shipmentDB);
		}
		Company company = companySettingDAO.getById(1);
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
		ModelAndView model = new ModelAndView("print/viewshipment_print");
		model.addObject("title", "Shipment");
		model.addObject("company", company);
		model.addObject("listshipment", listshipment);
		model.addObject("image",base64DataString);
		return model;
	}
	//----------------------------------------------- SHIPMENT REGISTER PRING END

	//----------------------------------------------- SHIPMENT EXCEL BEGIN
	//=================EXCEL DOWNLOAD=====================================
	@RequestMapping(value="downloadExcelForViewShpiment",method=RequestMethod.GET)
	public ModelAndView downloadExcelForAddManifest(HttpServletRequest request){
		
		//change to fetch all 
		String userid = userInformation.getUserId();
		User user =usersDao.get(Integer.parseInt(userid));
		List<ShipmentModel>  shipmentList;
		if(user.getRole().getRole_Name().trim().equals(ConstantValues.ROLE_SADMIN.trim())){
			  shipmentList=shipmentDao.fetchAllShipment();
		}else{
			  shipmentList=shipmentDao.fetchAllShipmentForStaff(user.getBranchModel().getBranch_id());
		}
		
		return new ModelAndView("ShipmentExcel","shipmentList",shipmentList);		
	}
	//----------------------------------------------- SHIPMENT EXCEL END
	
	//----------------------------------------------- Find record count begin
	@RequestMapping(value = "/shipment_record_count/", method = RequestMethod.GET)
	public ResponseEntity<String> recordCount(HttpServletRequest request) {
		String username = userInformation.getUserName();
		int user_id = Integer.parseInt(userInformation.getUserId());
		int branch_id = Integer.parseInt(userInformation.getUserBranchId());
		try {
			User user = usersDao.get(user_id);
			if(user.getRole().getRole_Name().equals(constantVal.ROLE_SADMIN)) {
				int rec_count = shipmentDao.shipmentCount();
				loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
				return new ResponseEntity<String>(Integer.toString(rec_count), HttpStatus.OK);
			} else {
				int rec_count = shipmentDao.shipmentCountStaff(branch_id);
				loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
				return new ResponseEntity<String>(Integer.toString(rec_count), HttpStatus.OK);
			}
		}catch(Exception exception) {
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<String> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}
	//----------------------------------------------- Find record count end
	
	//----------------------------------------------- PAGINATION BEGIN
	@RequestMapping(value = "shipment_pagination", method = RequestMethod.POST)
	public ResponseEntity<List<ShipmentModel>> ship_pagination(@RequestBody int page, HttpServletRequest request) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		int branch_id = Integer.parseInt(userInformation.getUserBranchId());
		int user_id = Integer.parseInt(userInformation.getUserId());
		try {
			int from_limit = 0, to_limit = 0;
			String order = "DESC";
			if(page == 1) { // First
				from_limit = 0;
				to_limit = page * 100;
			} else if ( page == 0 ) { // Last
				order = "ASC";
				from_limit = page;
				to_limit = 10;
			} else {
				from_limit = (page * 10) + 1;
				to_limit =  (page + 10 ) * 10;
			}
			User user = usersDao.get(user_id);
			List<ShipmentModel> shipmentList = new ArrayList<ShipmentModel>();
			if(user.getRole().getRole_Name().equals(constantVal.ROLE_SADMIN)) {
				shipmentList = shipmentDao.fetchShipmentWithLimit(from_limit, to_limit, order);
				if(shipmentList.isEmpty()) {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
					return new ResponseEntity<List<ShipmentModel>> (HttpStatus.NO_CONTENT);
				}else{
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
					return new ResponseEntity<List<ShipmentModel>> (shipmentList, HttpStatus.OK);	
				}
			} else {
				shipmentList = shipmentDao.fetchShipmentWithLimitStaff(from_limit, to_limit, order, branch_id);
				if(shipmentList.isEmpty()) {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
					return new ResponseEntity<List<ShipmentModel>> (HttpStatus.NO_CONTENT);
				}else{
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
					return new ResponseEntity<List<ShipmentModel>> (shipmentList, HttpStatus.OK);	
				}
			}
			
		}catch(Exception exception) {
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<List<ShipmentModel>> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	//----------------------------------------------- PAGINATION END
	
	//---------------------------------------------- LR PRINT BILL GENERATE PDF BEGIN
	@RequestMapping(value = "LR_print/{id}", method = RequestMethod.GET)
	public ModelAndView lrprint_pdf(@PathVariable ("id") int id, HttpServletRequest request){
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		int branch_id = Integer.parseInt(userInformation.getUserBranchId());
		
		BranchModel branch = branchDao.getBranchbyId(branch_id);
		
		ShipmentModel shipment = shipmentDao.getShipmentModelById(id);
		
		Company company = companySettingDAO.getById(1);	
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
		
		String total_charges = Float.toString(shipment.getTotal_charges());
	 	String[] total_charges_split = total_charges.split("\\.");
	 	
	 	String currency_rs = numberToWord.convert(Integer.parseInt(total_charges_split[0]));
	 	String currency_paise = numberToWord.convert(Integer.parseInt(total_charges_split[1]));
	 	String currency= currency_rs + " rupees " + currency_paise + " paise.";
	 	currency = currency.substring(0, 1).toUpperCase() + currency.substring(1);
		ModelAndView model = new ModelAndView("shipmentLRPrintPDF", "shipment", shipment);
		model.addObject("company",company);
		model.addObject("branch", branch);
		model.addObject("currency",currency);
		model.addObject("logo", base64DataString);
		return model;
	}
	
	//-------- Sort by column
	@RequestMapping(value = "sortShipment/{name}", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ShipmentModel>> sortShipment(@RequestBody String status, @PathVariable("name") String name, HttpServletRequest request) {
		userInformation = new UserInformation(request);
		int user_id = Integer.parseInt(userInformation.getUserId());
		int branch_id = Integer.parseInt(userInformation.getUserBranchId());
		String sortBy ="";
		switch(name.trim()){
			case "date" : sortBy = "shipment_date"; break;
			case "lrno" : sortBy = "lrno_prefix"; break;
			case "product" : sortBy = ""; break;
			case "origin" : sortBy = "sender_branch.branch_name"; break;
			case "destination" : sortBy = "consignee_branch.branch_name"; break;
			case "status" : sortBy = "status"; break;
		}
		List<ShipmentModel> shipment = new ArrayList<>();
		try{
			User user = usersDao.get(user_id);
			if(user.role.getRole_Name().equals(constantVal.ROLE_SADMIN)) {
				shipment = shipmentDao.getShipemntSorting1004SA(sortBy.trim(), status.trim().equals("ASC")?"ASC":"DESC");
				if(shipment.isEmpty()){
					loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, null);
					return new ResponseEntity<List<ShipmentModel>>(HttpStatus.NO_CONTENT);
				}else {
					loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
					return new ResponseEntity<List<ShipmentModel>>(shipment,HttpStatus.OK);
				}
			}else{
				shipment = shipmentDao.getShipemntSorting1004MS(sortBy.trim(), status.trim().equals("ASC")?"ASC":"DESC", branch_id);
				if(shipment.isEmpty()){
					loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, null);
					return new ResponseEntity<List<ShipmentModel>>(HttpStatus.NO_CONTENT);
				}else {
					loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
					return new ResponseEntity<List<ShipmentModel>>(shipment,HttpStatus.OK);
				}
				
			}
			
		}catch(Exception exception) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<List<ShipmentModel>> (HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
