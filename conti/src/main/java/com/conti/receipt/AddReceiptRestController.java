package com.conti.receipt;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.JsonMappingException;
import org.json.JSONException;
import org.json.JSONObject;
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
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.conti.config.SessionListener;
import com.conti.manifest.ManifestDao;
import com.conti.manifest.ManifestModel;
import com.conti.manifest.addManifestRestController;
import com.conti.master.branch.BranchDao;
import com.conti.master.branch.BranchModel;
import com.conti.master.employee.EmployeeMaster;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;
import com.conti.setting.usercontrol.User;
import com.conti.setting.usercontrol.UsersDao;
import com.conti.settings.company.Company;
import com.conti.settings.company.CompanySettingDAO;
import com.conti.shipment.add.ShipmentDao;
import com.conti.shipment.add.ShipmentModel;

/**
 * @Project_Name conti
 * @Package_Name com.conti.receipt
 * @File_name ViewReceiptGenerationController.java
 * @author Suresh
 * @Created_date_time Aug 11, 2017 2:21:39 PM
 * @Updated_date_time Aug 11, 2017 2:21:39 PM
 */
@RestController
public class AddReceiptRestController 
{
	@Autowired
	private UsersDao usersDao;
	
	@Autowired
	private ReceiptDao receiptDao;
	
	@Autowired
	private BranchDao branchDao;
	
	@Autowired
	private ShipmentDao shipmentDao;
		
	@Autowired
	private CompanySettingDAO companySettingDAO;
	
	@Autowired
	private UsersDao userDao;
	
	@Autowired
	private ManifestDao mDao;
	
	@Autowired
	@Qualifier("sessionRegistry")
	private SessionRegistry sessionRegistry;
	Loggerconf loggerconf = new Loggerconf();
	SessionListener sessionListener = new SessionListener();
	
	private UserInformation userInformation;
	
	addManifestRestController manifestController=new addManifestRestController();
//-----------------------------------------Open Generate Receipt page------------------------------------------------
	
	@RequestMapping(value =  "receipt_generate", method = RequestMethod.GET)
	public ModelAndView adminPage(HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		
		UserInformation userinfo = new UserInformation(request);
		String username = userinfo.getUserName();
		String userid = userinfo.getUserId();
		
		session.setAttribute("username", username);
		session.setAttribute("userid", userid);
		BranchModel branchModel=branchDao.getBranchbyId(Integer.parseInt(userinfo.getUserBranchId()));
		String branch_name=branchModel.getBranch_name();
		int branch_id=branchModel.getBranch_id();
		String lr_prefix=branchModel.getLrno_prefix();
		ModelAndView model = new ModelAndView();
		try
		{
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			
			model.addObject("title", "Receipt Generation");
			model.addObject("branch_name",branch_name);
			model.addObject("branch_id", branch_id);
			model.addObject("lr_prefix",lr_prefix);
			model.addObject("branch_id",Integer.parseInt(userinfo.getUserBranchId()));
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.addObject("paid",ConstantValues.PAID);
			model.addObject("to_pay",ConstantValues.TO_PAY);
			model.setViewName("Receipt/receipt_generation");

			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;
	}
	
	
	//========================== sortByManifest==========================
		@RequestMapping(value="sortByReceipt/{name}",method=RequestMethod.POST,produces=MediaType.APPLICATION_JSON_VALUE)
		public ResponseEntity<List<ShipmentModel>> sortByManifest(@RequestBody String status,@PathVariable("name")String name,
				HttpServletRequest request){
			
			
			String sortBy="";
			switch(name.trim()){
				case "lrno":
					sortBy="lr_number";
				break;
				case "origin":
					sortBy="sender_branch.branch_name";
				break;
				case "destination":
					sortBy="consignee_branch.branch_name";
				break;
				case "sender":
					sortBy="sender_customer.customer_name";
				break;
				case "consignee":
					sortBy="consignee_customer.customer_name";
				break;
				case "totalParcel":
					sortBy="numberof_parcel";
				break;
				case "weight":
					sortBy="chargeable_weight";
				break;
				case "service":
					sortBy="service.service_name";
				break;
				case "status":
					sortBy="status";
				break;
				case "date":
					sortBy="updated_datetime";
				break;
				case "pm":
					sortBy="pay_mode";
				break;
				default:
				break;
			}
			
			
			UserInformation userinfo = new UserInformation(request);
			String userid = userinfo.getUserId();
			User user =userDao.get(Integer.parseInt(userid));
			
			List<ShipmentModel> shipmentList=new ArrayList<>();
			try {
				if(user.getRole().getRole_Name().trim().equals(ConstantValues.ROLE_SADMIN.trim())){				
					shipmentList=shipmentDao.getShipmentBySorting100ReceiptAdmin(sortBy.trim(),status.trim().equals("ASC")?"ASC":"DESC");
				}else{
					shipmentList=shipmentDao.getShipmentBySorting100Receipt(sortBy.trim(),status.trim().equals("ASC")?"ASC":"DESC", user.getBranchModel().getBranch_id());
				}
				if(shipmentList.isEmpty()){
					return new ResponseEntity<List<ShipmentModel>>(HttpStatus.NO_CONTENT);
				}
				return new ResponseEntity<List<ShipmentModel>>(shipmentList,HttpStatus.OK);
			} catch (Exception e) {
				loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS,e);
				e.printStackTrace();
				return new ResponseEntity<List<ShipmentModel>>(HttpStatus.INTERNAL_SERVER_ERROR);
			}		
		}
		
		
		//======================================Pagination begin==========================================
		@RequestMapping(value="paginationReceipt",method=RequestMethod.POST)
		public ResponseEntity<List<ShipmentModel>> paginationReceipt(@RequestBody int page,HttpServletRequest request){
			userInformation = new UserInformation(request);
			System.err.println(String.valueOf(page)+"++++++++++++++++++++++++++++++++++++++++");
			//intialize	
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
			
			UserInformation userinfo = new UserInformation(request);
			String userid = userinfo.getUserId();
			User user =userDao.get(Integer.parseInt(userid));
			
			List<ShipmentModel> shipmentList;
			try {	
				if(user.getRole().getRole_Name().trim().equals(ConstantValues.ROLE_SADMIN.trim())){
					shipmentList=shipmentDao.fetchShipmentWithLimitReceipt(from_limit, to_limit, order);
				}else{
					shipmentList=shipmentDao.fetchShipmentWithLimitStaffReceipt(from_limit, to_limit, order,user.getBranchModel().getBranch_id());	
				}				
				return new ResponseEntity<List<ShipmentModel>>(shipmentList,HttpStatus.OK);
			} catch (Exception exception) {
				loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
				return new ResponseEntity<List<ShipmentModel>> (HttpStatus.NO_CONTENT);
			}
		}

	
		//======================================get Record Count==========================================
		@RequestMapping(value = "/receiptRecordCount/", method = RequestMethod.GET)
		public ResponseEntity<String> receiptRecordCount(HttpServletRequest request) {
			
			UserInformation userinfo = new UserInformation(request);
			String userid = userinfo.getUserId();
			User user =userDao.get(Integer.parseInt(userid));
			
			try {	
				if(user.getRole().getRole_Name().trim().equals(ConstantValues.ROLE_SADMIN.trim())){
					return new ResponseEntity<String> (String.valueOf(shipmentDao.shipmentCountReceipt()), HttpStatus.OK);	
				}else{
					return new ResponseEntity<String> (String.valueOf(shipmentDao.shipmentCountStaffReceipt(user.getBranchModel().getBranch_id())), HttpStatus.OK);	
				}
						
			} catch (Exception exception) {
				loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
				return new ResponseEntity<String> (HttpStatus.UNPROCESSABLE_ENTITY);
			}
		}

		
	//=================EXCEL DOWNLOAD=====================================
	@RequestMapping(value="downloadExcelForAddReceipt",method=RequestMethod.GET)
	public ModelAndView downloadExcelForAddManifest(HttpServletRequest request){
		
		//change to fetch all 
		UserInformation userinfo = new UserInformation(request);
		String userid = userinfo.getUserId();
		User user =userDao.get(Integer.parseInt(userid));
		
		List<ShipmentModel>  shipmentList;
		if(user.getRole().getRole_Name().trim().equals(ConstantValues.ROLE_SADMIN.trim())){
			  shipmentList=shipmentDao.fetchAllShipmentForReceipt();
		}else{
			  shipmentList=shipmentDao.fetchAllShipmentForStaffForReceipt(user.getBranchModel().getBranch_id());
		}
		
		return new ModelAndView("ShipmentExcelView","shipmentList",shipmentList);		
	}
	
	
	
	//===========================To get all Employee name for Searching================================
	@RequestMapping(value="getStaffManifest4Search/{str}", method = RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Map<String,List<EmployeeMaster>>> getEmployeeDriver4Search(HttpServletRequest request,
			@PathVariable("str") String searchStr) throws JsonGenerationException, JsonMappingException, JSONException, IOException 
	{
		
		UserInformation userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		String branch_id = userInformation.getUserBranchId();
		
		User user =userDao.get(Integer.parseInt(userInformation.getUserId()));
		
		
		List<ReceiptModel> receiptList ;
		if(user.getRole().getRole_Name().trim().equals(ConstantValues.ROLE_SADMIN.trim())){	
			receiptList = receiptDao.searchStaff(searchStr);
		}else{
			receiptList = receiptDao.searchStaff(searchStr);
		}
		
		

		Map result = new HashMap();	
		result.put("staff",receiptList);
		
		return new ResponseEntity<Map<String,List<EmployeeMaster>>> (result,HttpStatus.OK);
	}
		
	private <T> Predicate<T> distinctByKey(Function<? super T, Object> keyExtractor){
	    Map<Object, Boolean> map = new ConcurrentHashMap<>();
	    return t -> map.putIfAbsent(keyExtractor.apply(t), Boolean.TRUE) == null;
	}
	
	//=====================================Get All Receipt  for default loaded in Add Receipt===============================================
		
	@RequestMapping(value="add_receipt_preload", method=RequestMethod.GET)
		public ResponseEntity<List<ShipmentModel>>fetchAllReceipt_add(HttpServletRequest request)
		{
		UserInformation userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		String branch_id = userInformation.getUserBranchId();
		
		User user =userDao.get(Integer.parseInt(userInformation.getUserId()));
		
		List<ShipmentModel> shipmentModel;
		try {
			if(user.getRole().getRole_Name().trim().equals(ConstantValues.ROLE_SADMIN.trim())){	
				shipmentModel = shipmentDao.fetchAllShipment4receiptAdmin();
			}else{
				shipmentModel = shipmentDao.fetchAllShipment4receipt(Integer.parseInt(branch_id));
			}
			
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			if (shipmentModel.isEmpty()) {
				return new ResponseEntity<List<ShipmentModel>>(HttpStatus.NO_CONTENT);
			} else {
				return new ResponseEntity<List<ShipmentModel>>(shipmentModel, HttpStatus.OK);
			}

		} catch (Exception exception) {
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<List<ShipmentModel>>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
		}

	  
	//========================================Add Receipt filter function start==================================================
	
	@RequestMapping( value = "add_receipt_filter", method = RequestMethod.POST)
	public ResponseEntity<List<ShipmentModel>> addreceiptFilterbycondition(@RequestBody String filter,HttpServletRequest request) 
			throws JsonProcessingException, IOException 
	{
		HttpSession session = request.getSession();
		UserInformation userinfo = new UserInformation(request);
		String username = userinfo.getUserName();
		
		
		JSONObject obj=new JSONObject(filter);
	
		try 
		{
			
			List<ShipmentModel> shipmentModel = shipmentDao.getShipmentByCondition(obj.get("fromBranch").toString(),obj.get("toBranch").toString(),
					obj.get("fromDate").toString(),obj.get("toDate").toString(),obj.get("service").toString(),obj.get("paymentMode").toString());
			
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			
			return (shipmentModel.isEmpty()) ?	 new ResponseEntity<List<ShipmentModel>> (HttpStatus.NO_CONTENT):	
				 new ResponseEntity<List<ShipmentModel>> (shipmentModel, HttpStatus.OK);	
				
		} 
		catch (Exception exception) 
		{			
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<List<ShipmentModel>> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	
	
	
	//=============================================add receipt======================================
	@RequestMapping(value="receiptSave",method=RequestMethod.POST,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> receiptSave(HttpServletRequest request,@RequestBody ReceiptModel receipt){
	
		//intialize	
		UserInformation userinfo = new UserInformation(request);
		String userid = userinfo.getUserId();
		User user =userDao.get(Integer.parseInt(userid));
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
		JSONObject receiptNo=new JSONObject();
		float receiptTotal=receipt.getLocal_transport();
		ShipmentModel shipmentModel;
		
		//set variable
		receipt.setCreated_by(Integer.parseInt(userid));
		receipt.setUpdated_by(Integer.parseInt(userid));
		receipt.setCreated_datetime(dateFormat.format(date));
		receipt.setUpdated_datetime(dateFormat.format(date));
		receipt.setObsolete("N");
		receipt.setBranchModel(user.getBranchModel());
		
		
		
		//set shipment and receipt status (Delivered) and set manifest id manually
		for(ReceiptDetail receiptDetail:receipt.getReceiptDetailList()){

		    shipmentModel=receiptDetail.getShipmentModel();
		    
			//set receipt id
			receiptDetail.setReceiptModel(receipt);

			//set manifest id for shipment id
			//receiptDetail.setManifestModel(mDao.getManifestIdByShipmentId(shipmentModel.getShipment_id()));

			//set freight charge if to pay
			if (shipmentModel.getPay_mode().trim().equals(ConstantValues.TO_PAY.trim())) {
				receiptDetail.setNet_freight_charges(shipmentModel.getTotal_charges());
				receiptTotal+=receiptDetail.getNet_freight_charges();
			}
			
			//set status
			shipmentModel.setStatus(ConstantValues.DELIVERED);	
			
		}
		
		//set receipt total cost
		receipt.setReceipt_total(receiptTotal);
		
		
		
		try{
			
			//generate receipt number
			int lastReceiptNo=receiptDao.getLastReceiptNoWithBranch(receipt.getBranchModel().getBranch_id());
			if(lastReceiptNo!=0){
				receipt.setReceipt_number(lastReceiptNo+1);
			}else{
				receipt.setReceipt_number(lastReceiptNo+1);
			}


			receipt.setReceipt_prefix(receipt.getBranchModel().getReceiptno_prefix()+
					manifestController.padManifestNumber(receipt.getReceipt_number(), 5));
		
		
			receiptDao.saveOrUpdate(receipt);			
			receiptNo.put("Receipt_NO", receipt.getReceipt_prefix());
			loggerconf.saveLogger(request.getUserPrincipal().getName(),request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
			return new ResponseEntity<String>(receiptNo.toString(),HttpStatus.CREATED);	
		}catch(Exception e){
			receiptNo.put("Receipt NO","Error Creating Receipt No");
			loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, e);
			return new ResponseEntity<String>("",HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	//--------------------------------------------------------------------------------------------------------------------------
	
	
	//========================== fetch last manifest no==========================
	@RequestMapping(value="/getLastReceiptNo/",method=RequestMethod.GET,produces=MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> getLastReceiptNo(HttpServletRequest request){
		
		
		UserInformation userinfo = new UserInformation(request);
		String userid = userinfo.getUserId();
		User user =userDao.get(Integer.parseInt(userid));
		
	
		try {
			String lastReceiptNo;
			if(user.getRole().getRole_Name().trim().equals(ConstantValues.ROLE_SADMIN.trim())){	
				lastReceiptNo=user.getBranchModel().getReceiptno_prefix()+
					manifestController.padManifestNumber(receiptDao.getLastReceiptNoWithBranch(user.getBranchModel().getBranch_id()),5);
			}else{
				lastReceiptNo=user.getBranchModel().getReceiptno_prefix()+
					manifestController.padManifestNumber(receiptDao.getLastReceiptNoWithBranch(user.getBranchModel().getBranch_id()),5);			
			}			
			return new ResponseEntity<String>(String.valueOf(lastReceiptNo),HttpStatus.CREATED);
		} catch (Exception e) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, e);
			return new ResponseEntity<String> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	
	@RequestMapping(value="checkCourierStaffUnique", method=RequestMethod.POST)
	public ResponseEntity<String> checkCourierStaffUnique(@RequestBody String staffName,HttpServletRequest request){
		
		
		UserInformation userinfo = new UserInformation(request);
		String userid = userinfo.getUserId();
		User user =userDao.get(Integer.parseInt(userid));
		
		try {
			boolean  isUnique ;
			if(user.getRole().getRole_Name().trim().equals(ConstantValues.ROLE_SADMIN.trim())){	
				isUnique = receiptDao.checkCourierStaffUnique(staffName);
			}else{
				isUnique = receiptDao.checkCourierStaffUnique(staffName);
			}
			return new ResponseEntity<String> (String.valueOf(isUnique), HttpStatus.OK);
		} catch (Exception e) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, e);
			return new ResponseEntity<String> (HttpStatus.UNPROCESSABLE_ENTITY);
		}	
	}
	
	
	@RequestMapping(value="getContactNumber", method=RequestMethod.POST)
	public ResponseEntity<List<ReceiptModel>> getContactNumber(@RequestBody String staff,HttpServletRequest request){
		
		
		UserInformation userinfo = new UserInformation(request);
		String userid = userinfo.getUserId();
		User user =userDao.get(Integer.parseInt(userid));
		
		try {
			List<ReceiptModel> receiptList ;
			if(user.getRole().getRole_Name().trim().equals(ConstantValues.ROLE_SADMIN.trim())){	
				receiptList = receiptDao.getContactNumberByName(staff);
			}else{
				receiptList = receiptDao.getContactNumberByName(staff);
			}
			return new ResponseEntity<List<ReceiptModel>> (receiptList, HttpStatus.OK);
		} catch (Exception e) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, e);
			return new ResponseEntity<List<ReceiptModel>> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}
	
	//======================LR Number search start==================================
	
	@RequestMapping(value="search_lrnumber", method=RequestMethod.POST)
	public ResponseEntity<List<ShipmentModel>> receipt_search(@RequestBody String searchkey,HttpServletRequest request){
		
		UserInformation userinfo = new UserInformation(request);
		String userid = userinfo.getUserId();
		User user =userDao.get(Integer.parseInt(userid));
		List<ShipmentModel> shipmentList;
		
		try {
			if(user.getRole().getRole_Name().trim().equals(ConstantValues.ROLE_SADMIN.trim())){	
				shipmentList=shipmentDao.fetchShipmentByLRAdminReceipt(searchkey);
			}else{
				shipmentList=shipmentDao.fetchShipmentByLRReceipt(searchkey,user.getBranchModel().getBranch_id());
			}
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			return new ResponseEntity<List<ShipmentModel>> (shipmentList, HttpStatus.OK);
		} catch (Exception e) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, e);
			return new ResponseEntity<List<ShipmentModel>> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
			
		
			
	}
	
	//===========================Receipt Print
	@RequestMapping(value = "Receipt_print/{id}", method = RequestMethod.GET)
	public ModelAndView Receipt_print(@PathVariable ("id") int id, HttpServletRequest request){
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		int branch_id = Integer.parseInt(userInformation.getUserBranchId());
		
		BranchModel branch = branchDao.getBranchbyId(branch_id);
		
		ReceiptModel receipt = receiptDao.getReceiptbyId(id);
		
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
		
		ModelAndView model = new ModelAndView("receiptPrintPDF", "receipt", receipt);
		model.addObject("company",company);
		model.addObject("branch", branch);
		model.addObject("logo", base64DataString);
		return model;
		
	}
	
	//======================Get Receipt Model==================================
	@RequestMapping(value="getReceiptModel",method=RequestMethod.GET)
	public  ResponseEntity<ReceiptModel> shipmentModel(){
		ReceiptModel receiptModel=new ReceiptModel();
		
		List<ReceiptDetail> receiptDetailList=new ArrayList<>();
		
		ReceiptDetail receiptDetail=new ReceiptDetail();
		receiptDetail.setManifestModel(new ManifestModel());
		receiptDetail.setShipmentModel(new ShipmentModel());
		receiptDetail.setReceiptModel(new ReceiptModel());
		
		receiptDetailList.add(receiptDetail);
		
		receiptModel.setReceiptDetailList(receiptDetailList);
		
		return new ResponseEntity<>(receiptModel,HttpStatus.OK);		
	}
}
