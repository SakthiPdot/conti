package com.conti.manifest;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
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

import com.conti.master.branch.BranchModel;
import com.conti.master.employee.EmployeeDao;
import com.conti.master.employee.EmployeeMaster;
import com.conti.master.vehicle.VehicleDao;
import com.conti.master.vehicle.VehicleMaster;
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
 * @Package_Name com.conti.manifest  com.conti.manifest
 * @File_name addManifestRestController.java com.conti.manifest
 * @author Monu.C
 * @Created_date_time Aug 8, 2017 3:19:48 PM
 */


@RestController
public class addManifestRestController {


	@Autowired
	private ShipmentDao shipmentDao;
	
	@Autowired
	private ManifestDao mDao;

	@Autowired
	private VehicleDao vehicleDao;
	
	@Autowired
	private ShipmentDao sDao;

	@Autowired
	private EmployeeDao employeeDao;

	@Autowired
	private UsersDao userDao;
	
	@Autowired
	private CompanySettingDAO companySettingDAO;
		
	
	Loggerconf loggerconf = new Loggerconf();
	UserInformation userInformation;
	
	
	//========================== to display Add Manifest Screen==========================
	
	@RequestMapping(value =  "add_manifest", method = RequestMethod.GET)
	public ModelAndView add_manifest(HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		
		UserInformation userinfo = new UserInformation(request);
		String username = userinfo.getUserName();
		
		String userid = userinfo.getUserId();
		
		session.setAttribute("username", username);
		session.setAttribute("userid", userid);
		
		
		ModelAndView model = new ModelAndView();
		
		User user =userDao.get(Integer.parseInt(userid));
		
		ObjectMapper mapper =new ObjectMapper();
		String defaultBranch=mapper.writeValueAsString(user.getBranchModel());
		try
		{
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			

			model.addObject("title", "Add Manifest");
			model.addObject("defaultBranch",defaultBranch);
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.setViewName("Manifest/add_manifest");

			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;
	}
	
	//=================get user branch=====================================
	@RequestMapping(value="getUserBranchDetails",produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<BranchModel> getUserBranchDetails(HttpServletRequest request){
		
		
		HttpSession session = request.getSession();
		UserInformation userinfo = new UserInformation(request);
		String userid = userinfo.getUserId();
		User user =userDao.get(Integer.parseInt(userid));		
		return new ResponseEntity<BranchModel> (user.getBranchModel(), HttpStatus.OK);
		
		
		//change to fetch all 	
	}
	
	//======================================search shipment  by lr==========================================
	@RequestMapping(value = "searchLRShipment", method=RequestMethod.POST)
	public ResponseEntity<List<ShipmentModel>> searchLRShipment(@RequestBody String searchString, HttpServletRequest request) {				
			

			UserInformation userinfo = new UserInformation(request);
			String userid = userinfo.getUserId();
			User user =userDao.get(Integer.parseInt(userid));
			List<ShipmentModel> shipmentList;
			
			if(user.getRole().getRole_Name().trim().equals(ConstantValues.ROLE_SADMIN.trim())){	
				shipmentList=sDao.fetchShipmentByLRAdmin(searchString);
			}else{
				shipmentList=sDao.fetchShipmentByLR(searchString,user.getBranchModel().getBranch_id());
			}
				
			
			return new ResponseEntity<List<ShipmentModel>> (shipmentList, HttpStatus.OK);		
	}
	
	//===========================To get all Employee name for Searching================================
	@RequestMapping(value="getEmployeeDriver4Search/{str}", method = RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Map<String,List<EmployeeMaster>>> getEmployeeDriver4Search(HttpServletRequest request,
			@PathVariable("str") String searchStr) throws JsonGenerationException, JsonMappingException, JSONException, IOException 
	{
		List<EmployeeMaster> employees = employeeDao.searchDriver(searchStr);
		Map result = new HashMap();	
		result.put("Employees",employees);
		return new ResponseEntity<Map<String,List<EmployeeMaster>>> (result,HttpStatus.OK);
	}
	
	//=================PRINT=====================================
	@RequestMapping(value="shipmentPrint",method=RequestMethod.POST)
	public ModelAndView shipmentPrint(HttpServletRequest request,
			@RequestParam("selectedShipment") String selectedShipment) throws IOException{
		
		ObjectMapper mapper=new ObjectMapper();
		List<ShipmentModel> ShipmentList=null;
		
		try {
			JSONArray jsonShipmentArray=new JSONArray(selectedShipment);
			ShipmentList=new ArrayList<ShipmentModel>();
			
			for(int i=0;i<jsonShipmentArray.length();i++){
				JSONObject shipmentObject=jsonShipmentArray.getJSONObject(i);
				ShipmentModel shipmentModel=sDao.getShipmentModelById(shipmentObject.getInt("shipment_id"));
				ShipmentList.add(shipmentModel);
			}
			
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		
		ModelAndView model = new ModelAndView("print/shipment_print");
		
		Company company = companySettingDAO.getById(1);
		String base64DataString = "";
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
		
		model.addObject("title", "Shipment");
		model.addObject("company", company);
		model.addObject("ShipmentList",ShipmentList);
		model.addObject("image",base64DataString);
		return model;
		
	}
	//========================== fetch last manifest no==========================
	@RequestMapping(value="/fetchLastManifestNo/",method=RequestMethod.GET,produces=MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> fetchLastManifestNo(HttpServletRequest request){		
		try {
			ManifestModel manifestModel=mDao.getLastManifestModel();
			if(manifestModel!=null){
				String lastManNo=manifestModel.getBranchModel1().getBranch_code()+
						manifestModel.getBranchModel2().getBranch_code()+padManifestNumber(Integer.parseInt(manifestModel.getManifest_number()), 5);
				System.err.println(lastManNo);
				return new ResponseEntity<String>(lastManNo,HttpStatus.CREATED);
			}else{
				return new ResponseEntity<String>("No Manifest Found",HttpStatus.OK);
			}			
		} catch (Exception e) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, e);
			return new ResponseEntity<String> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	public String padManifestNumber(int num,int size){
		String manNo=String.valueOf(num);
		while (manNo.length()<size){
			manNo="0"+manNo;
		}
		return manNo;
	}
	

	//=================test==========================
	@RequestMapping(value ="fetchManifest",method=RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<ManifestModel> fetchManifest(){
	/*	ManifestModel manifest =new ManifestModel();
		manifest.setManifest_id(1);
		
		
		List<ManifestDetailedModel> detailedList=new ArrayList<ManifestDetailedModel>();
		ManifestDetailedModel det1=new ManifestDetailedModel();
		det1.setShipmentModel(new  ShipmentModel());
		det1.setManifestModel(new ManifestModel());
		detailedList.add(det1);
		
		
		manifest.setManifestDetailModel(detailedList);*/
		
		return new ResponseEntity<>(mDao.getManifestByID(1),HttpStatus.OK);
		
	}
	//=================== Pagination Function End ================//
	
	@RequestMapping(value = "vehicleRegNo/{str}", method = RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Map<String,List<VehicleMaster>>> vehicleRegNo(HttpServletRequest request,
			@PathVariable("str") String searchStr) throws JsonGenerationException, JsonMappingException, JSONException, IOException  {
			
				
		   List <VehicleMaster> vehicletype = vehicleDao.searchforVehicleRegNo(searchStr);
		
		    Map result = new HashMap();		
			result.put("VehicleType", vehicletype);
			
			
			System.err.println("@@$$WWWW$"+ searchStr);
			return new ResponseEntity<Map<String,List<VehicleMaster>>> (result,HttpStatus.OK);
	}

	
	
	
	//========================== sortByManifest==========================
	@RequestMapping(value="sortByManifest/{name}",method=RequestMethod.POST,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ShipmentModel>> sortByManifest(@RequestBody String status,@PathVariable("name")String name,
			HttpServletRequest request){
		
		
		System.err.println("inside sorting");
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
			default:
			break;
		}
		
		
		UserInformation userinfo = new UserInformation(request);
		String userid = userinfo.getUserId();
		User user =userDao.get(Integer.parseInt(userid));
		
		List<ShipmentModel> shipmentList=new ArrayList<>();
		try {
			if(user.getRole().getRole_Name().trim().equals(ConstantValues.ROLE_SADMIN.trim())){				
				shipmentList=shipmentDao.getShipmentBySorting100ManifestAdmin(sortBy.trim(),status.trim().equals("ASC")?"ASC":"DESC");
			}else{
				shipmentList=shipmentDao.getShipmentBySorting100Manifest(sortBy.trim(),status.trim().equals("ASC")?"ASC":"DESC", user.getBranchModel().getBranch_id());
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
	
	
	//========================== save Manifest==========================
	@RequestMapping(value="manifestSave",method=RequestMethod.POST,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> manifestSave(HttpServletRequest request,@RequestBody ManifestModel manifest){

		
		//intialize	
		String userid = request.getSession().getAttribute("userid").toString();		
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
		
		
		//set variable
		manifest.setCreated_by(Integer.parseInt(userid));
		manifest.setUpdated_by(Integer.parseInt(userid));
		manifest.setCreated_datetime(dateFormat.format(date));
		manifest.setUpdated_datetime(dateFormat.format(date));
		manifest.setObsolete("N");
		

		//set shipment and manifest status (Intransit) and set manifest id manually
		manifest.setManifest_status(ConstantValues.INTRANSIT);
		for(ManifestDetailedModel manifestDetailModel:manifest.getManifestDetailModel()){
			manifestDetailModel.setManifestModel(manifest);
			manifestDetailModel.getShipmentModel().setStatus(ConstantValues.INTRANSIT);
		}
		

		
		JSONObject manifestNo=new JSONObject();
		
		try {
			
			//generate manifest number
			int lastManNo=mDao.fetchLastManifestNoWithOriginAndDestination(manifest.branchModel1.getBranch_id(), manifest.branchModel2.getBranch_id());		
			if(lastManNo!=0 ){
				manifest.setManifest_number(String.valueOf(lastManNo+1));
				manifest.setManifest_prefix(manifest.branchModel1.getBranch_code()+manifest.branchModel2.getBranch_code()+
						padManifestNumber(Integer.parseInt(manifest.getManifest_number()), 4));
			}else{
				manifest.setManifest_number(String.valueOf(1));
				manifest.setManifest_prefix(manifest.branchModel1.getBranch_code()+manifest.branchModel2.getBranch_code()+
						padManifestNumber(Integer.parseInt(manifest.getManifest_number()), 4));
			}
			
			
			
			mDao.saveOrUpdate(manifest);
			manifestNo.put("ManifestNo",manifest.getManifest_prefix());
			loggerconf.saveLogger(request.getUserPrincipal().getName(),request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
			return new ResponseEntity<String>(manifestNo.toString(),HttpStatus.CREATED);
		} catch (Exception e) {
			manifestNo.put("ManifestNo","Error Creating Manifest No");
			loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, e);
			return new ResponseEntity<String>("",HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	//==================================Fetch all shipment(100)============================
	@RequestMapping(value="fetchAllShipmentManifest",method=RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ShipmentModel>>  fetchAllShipmentManifest(HttpServletRequest request){
	
		UserInformation userinfo = new UserInformation(request);
		String userid = userinfo.getUserId();
		User user =userDao.get(Integer.parseInt(userid));
		
		List<ShipmentModel> shipment;
		if(user.getRole().getRole_Name().trim().equals(ConstantValues.ROLE_SADMIN.trim())){
			 shipment=shipmentDao.fetchAllShipment100Admin();
		}else{
			 shipment=shipmentDao.fetchAllShipment100Manifest(user.getBranchModel().getBranch_id());
		}
		
		
		if(shipment.isEmpty()){
			return new ResponseEntity<List<ShipmentModel>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<ShipmentModel>>(shipment,HttpStatus.OK);
	}
	
	
	//=================EXCEL DOWNLOAD=====================================
	@RequestMapping(value="downloadExcelForAddManifest",method=RequestMethod.GET)
	public ModelAndView downloadExcelForAddManifest(HttpServletRequest request){
		
		//change to fetch all 
		UserInformation userinfo = new UserInformation(request);
		String userid = userinfo.getUserId();
		User user =userDao.get(Integer.parseInt(userid));
		List<ShipmentModel>  shipmentList;
		if(user.getRole().getRole_Name().trim().equals(ConstantValues.ROLE_SADMIN.trim())){
			  shipmentList=sDao.fetchAllShipment();
		}else{
			  shipmentList=sDao.fetchAllShipmentForStaff(user.getBranchModel().getBranch_id());
		}
		
		return new ModelAndView("ShipmentExcelView","shipmentList",shipmentList);		
	}

		
	
	
	
	//======================================get Record Count==========================================
	@RequestMapping(value = "/manifestRecordCount/", method = RequestMethod.GET)
	public ResponseEntity<String> manifestRecordCount(HttpServletRequest request) {
		
		UserInformation userinfo = new UserInformation(request);
		String userid = userinfo.getUserId();
		User user =userDao.get(Integer.parseInt(userid));
		
		try {	
			if(user.getRole().getRole_Name().trim().equals(ConstantValues.ROLE_SADMIN.trim())){
				return new ResponseEntity<String> (String.valueOf(sDao.shipmentCount()), HttpStatus.OK);	
			}else{
				return new ResponseEntity<String> (String.valueOf(sDao.shipmentCountStaff(user.getBranchModel().getBranch_id())), HttpStatus.OK);	
			}
					
		} catch (Exception exception) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<String> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	
	//======================================Pagination begin==========================================
	@RequestMapping(value="paginationManifest",method=RequestMethod.POST)
	public ResponseEntity<List<ShipmentModel>> paginationManifest(@RequestBody int page,HttpServletRequest request){
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
				shipmentList=sDao.fetchShipmentWithLimit(from_limit, to_limit, order);
			}else{
				shipmentList=sDao.fetchShipmentWithLimitStaff(from_limit, to_limit, order,user.getBranchModel().getBranch_id());	
			}				
			return new ResponseEntity<List<ShipmentModel>>(shipmentList,HttpStatus.OK);
		} catch (Exception exception) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<List<ShipmentModel>> (HttpStatus.NO_CONTENT);
		}
	}

	//========================== filter Shipment==========================
	@RequestMapping(value="/filterShipment/",method=RequestMethod.POST,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ShipmentModel>>  filterShipment(@RequestBody String filterValues,HttpServletRequest request){
		
		JSONObject filterValueObject=new JSONObject(filterValues);
		
		try
		{
			
			List<ShipmentModel> shipmentList=sDao.filterShipment(filterValueObject.get("fromBranch").toString(), filterValueObject.get("toBranch").toString(),
					filterValueObject.get("fromDate").toString(), filterValueObject.get("toDate").toString(), filterValueObject.get("status").toString());			
			
			loggerconf.saveLogger(request.getUserPrincipal().getName(),request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			
			return (shipmentList.isEmpty()) ? new ResponseEntity<List<ShipmentModel>> (HttpStatus.NO_CONTENT) :new ResponseEntity<List<ShipmentModel>> (shipmentList, HttpStatus.OK);
		
		}
		catch(Exception exception)
		{
			exception.printStackTrace();
			loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<List<ShipmentModel>> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}
}