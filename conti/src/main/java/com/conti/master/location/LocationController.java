package com.conti.master.location;


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

import com.conti.address.AddressDao;
import com.conti.address.AddressModel;
import com.conti.config.SessionListener;
import com.conti.master.branch.BranchDao;
import com.conti.master.branch.BranchModel;
import com.conti.master.customer.CustomerDao;
import com.conti.master.customer.CustomerModel;
import com.conti.master.employee.EmployeeDao;
import com.conti.master.employee.EmployeeMaster;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;
import com.conti.settings.company.Company;
import com.conti.settings.company.CompanySettingDAO;
import com.conti.shipment.add.ShipmentDao;
import com.conti.shipment.add.ShipmentModel;


/**
 * @Project_Name conti
 * @Package_Name com.conti.master.location
 * @File_name LocationController.java
 * @author Sakthi
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 20, 2017 2:21:39 PM
 */


@RestController
public class LocationController {

	final Logger logger = LoggerFactory.getLogger(LocationController.class);

	
	
	@Autowired
	private AddressDao addressDao;
	
	@Autowired 
	private LocationDao locationDao; 
	
	@Autowired
	private CompanySettingDAO companySettingDAO;
	@Autowired
	private ShipmentDao shipmentDao;
	@Autowired
	private BranchDao branchDao;
	@Autowired
	private CustomerDao customerDao;
	@Autowired
	private EmployeeDao employeeDao;
	
		
	Loggerconf loggerconf = new Loggerconf();
	SessionListener sessionListener = new SessionListener();
	UserInformation userInformation;

	@RequestMapping(value =  "location", method = RequestMethod.GET)
	public ModelAndView adminPage(HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		
		UserInformation userinfo = new UserInformation(request);
		String username = userinfo.getUserName();
		
		String userid = userinfo.getUserId();
		
		session.setAttribute("username", username);
		session.setAttribute("userid", userid);
		
		
		ModelAndView model = new ModelAndView();
		
		
		try
		{
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			
			model.addObject("title", "Location Master");
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.setViewName("Masters/location");
			model.addObject("homePage",request.getContextPath());
			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;

	}
	//======================================sort by==========================================
	@RequestMapping(value="sortByLocation/{name}",method=RequestMethod.POST,produces=MediaType.APPLICATION_JSON_VALUE)
	public  ResponseEntity<List<Location>>  sortByLocation(@RequestBody String status,@PathVariable("name") String name,HttpServletRequest request){
	
		String sortBy="";
			
		switch(name.trim()){
		case "locationName":
			 sortBy="location_name";
			break;
		case "locationCode":
			 sortBy="location_code";
			break;
		case "abbreviation":
			 sortBy="abbreviation";
			break;
		case "locationCity":
			 sortBy="address.city";
			break;
		case "locationState":
			 sortBy="address.state";
			break;
		case "locationCountry":
			 sortBy="address.country";
			break;			
		case "locationPincode":
			 sortBy="pincode";
			break;			
		case "locationActive":
			 sortBy="active";
			break;			
		default:
			break;
		}
		List<Location> locationList=new ArrayList<>();
		
		try{
			locationList=locationDao.getLocationSorting100(sortBy.trim(),status.trim().equals("ASC")?"ASC":"DESC");
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			if(locationList.isEmpty()){
				return new ResponseEntity<List<Location>>(HttpStatus.NO_CONTENT);
			}
			return new ResponseEntity<List<Location>>(locationList,HttpStatus.OK);
		}catch(Exception e){
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS,e);
			e.printStackTrace();
			return new ResponseEntity<List<Location>>(HttpStatus.INTERNAL_SERVER_ERROR);
			
		}
		
		
	}
	//======================================get Record Count==========================================
	@RequestMapping(value = "/locationRecordCount/", method = RequestMethod.GET)
	public ResponseEntity<String> locationRecordCount(HttpServletRequest request) {
		try {	
			return new ResponseEntity<String> (String.valueOf(locationDao.locationSettingCount()), HttpStatus.OK);			
		} catch (Exception exception) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<String> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	
	
	//=================PRINT=====================================
	@RequestMapping(value="location_print",method=RequestMethod.POST)
	public ModelAndView location_print(HttpServletRequest request,
			@RequestParam("SelectedLocation") String SelectedLocation) throws IOException{
	
		ObjectMapper mapper=new ObjectMapper();
		
		List<Location> locationList=null;
		
		
		try {
			JSONArray jsonProductArray=new JSONArray(SelectedLocation);
			
			
			String[] location_id=new String[jsonProductArray.length()];
			locationList = new ArrayList<Location>();
			
			for(int i=0;i<jsonProductArray.length();i++){
				JSONObject LocationObject=jsonProductArray.getJSONObject(i);
				Location location=locationDao.getLocationById(LocationObject.getInt("location_id"));
				locationList.add(location);
			}
		} catch (Exception e1) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), "Json parse error", e1);
			e1.printStackTrace();
		}
		
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
		ModelAndView model = new ModelAndView("print/Location_print");
		
		model.addObject("title", "Location");
		model.addObject("company", company);
		model.addObject("locationList",locationList);
		model.addObject("image",base64DataString);
		return model;
	}

	
	



	//======================================Pagination begin==========================================
	@RequestMapping(value = "paginationLocation", method=RequestMethod.POST)
	public ResponseEntity<List<Location>> paginationLocation(@RequestBody int page, HttpServletRequest request) {
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
		
		System.err.println(String.valueOf(from_limit)+String.valueOf(to_limit)+"++++++++++++++++++++++++++++++++++++++++");
		
		List<Location> Locationlist=locationDao.getLocationWithLimit(from_limit, to_limit, order); 
		return new ResponseEntity<List<Location>>(Locationlist,HttpStatus.OK);
		
	}
	
	//======================================search location by 4 strings==========================================
		@RequestMapping(value = "searchLocation4String", method=RequestMethod.POST)
		public ResponseEntity<List<Location>> searchProuct4String(@RequestBody String SearchString, HttpServletRequest request) {				
				List<Location> locationList=locationDao.searchByLocation(SearchString) ;		
				return new ResponseEntity<List<Location>> (locationList, HttpStatus.OK);		
		}
	//=================CHECK LOCATION NAME=====================================
	@RequestMapping(value="checkLocationName",method=RequestMethod.POST,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Void> checkProductName(@RequestBody String name,HttpServletRequest request){
		return (locationDao.checkLocationName(name.trim())=="AVAILABLE")? new ResponseEntity<Void>(HttpStatus.NO_CONTENT):new ResponseEntity<Void>(HttpStatus.OK);	
	}
	
	//=================CHANGE ACTIVE STATUS=====================================
	@RequestMapping (value="locationStaus/{status}",method=RequestMethod.POST,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Void>  LocationStatus(@RequestBody int[] idArray,@PathVariable("status") String status,HttpServletRequest request){
		
		System.out.println(status+"******status******");		
		//intialize		
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
		
		try {
			for(int i=0;i<idArray.length;i++){
				Location location =locationDao.getLocationById(idArray[i]);
				//set variable	
				if(status.trim().equals("InActive") ||status.trim()=="InActive" ){
					location.setActive("N");					
				}else{
					location.setActive("Y");
				}
				location.setUpdated_by(Integer.parseInt(request.getSession().getAttribute("userid").toString()));
				location.setUpdated_datetime(dateFormat.format(date));
				locationDao.saveOrUpdate(location);
			}
			return new ResponseEntity<Void>(HttpStatus.OK);
		} catch (Exception e) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS,e);
			e.printStackTrace();
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
	}
	//=================EXCEL DOWNLOAD=====================================
	@RequestMapping(value="downloadExcelLocation",method=RequestMethod.GET)
	public ModelAndView downloadExcelProduct(){
		List<Location> locationList=locationDao.fetchAllLocation(); 
		return new ModelAndView("locationExcelView","locationList",locationList);
	}
	
	//=================FETCH ALL LOCATION=====================================	
	@RequestMapping(value="fetchAllLocation",method=RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<Location>>  getAllLocation(){
		List<Location> locations=locationDao.getLocation();
		if(locations.isEmpty()){
			return new ResponseEntity<List<Location>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<Location>>(locations,HttpStatus.OK);
	}
	
	//=================GET LOCATION MODEL=====================================	
	@RequestMapping(value="LocationModel",method=RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Location> getLocationModel(){
		
		Location location=new Location();
		AddressModel address=new AddressModel();
		location.setAddress(address);
		return new  ResponseEntity<Location>(location,HttpStatus.CREATED);
	}
	//=================SAVE =====================================
	@RequestMapping(value="locationSave",method=RequestMethod.POST,
			produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Void> saveLocation (@RequestBody Location location,
			HttpServletRequest request ){
		System.out.println("++ inside location save");
		
		//intialize	
		String userid = request.getSession().getAttribute("userid").toString();		
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
		
		//set variable
		location.setCreated_by(Integer.parseInt(userid));
		location.setUpdated_by(Integer.parseInt(userid));
		location.setCreated_datetime(dateFormat.format(date));
		location.setUpdated_datetime(dateFormat.format(date));
		location.setObsolete("N");
		location.setActive("Y");
		
		
		
		//save location
		try {
			locationDao.saveOrUpdate(location);
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
			return new ResponseEntity<Void>(HttpStatus.CREATED);
		} catch (Exception e) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS,e);
			e.printStackTrace();
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}		
	}
	
	//=================GET ADDRESS USING TYPE BY STRING =====================================
	@RequestMapping(value="getAddressTypeByStr/{str}", method = RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Map<String,List<AddressModel>>> getAddressTypeByStr(HttpServletRequest request,
			@PathVariable("str") String searchStr) throws JsonGenerationException, JsonMappingException, JSONException, IOException {
		
		List<AddressModel> address = addressDao.searchByAddressName(searchStr);

		 Map result = new HashMap();
		 result.put("Address", address);
		
		System.err.println(searchStr+"464644");
		return new ResponseEntity<Map<String,List<AddressModel>>> (result,HttpStatus.OK);
	}
	
	//=================DELETE LOCATION ID =====================================
	@RequestMapping(value="/locationDelete/{id}",method=RequestMethod.DELETE,
			produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> deleteLocation(@PathVariable("id") long id,
			HttpServletRequest request){
		
		System.out.println("++ delete user "+id);
		Location locationFromDb=locationDao.getLocationById((int)id);
		ShipmentModel shipmentModel = shipmentDao.getLocationId((int)id, (int)id);
		BranchModel branchModel = branchDao.getLocationbyId((int)id);
		CustomerModel customerModel = customerDao.getLocationId((int)id);
		EmployeeMaster employeeMaster = employeeDao.getLocationId((int)id);
		Company company = companySettingDAO.getLocationId((int)id);
		if(locationFromDb==null){
			return new ResponseEntity<String>(HttpStatus.NOT_FOUND);
		}
		
		
		
		//intialize		
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
				
		//set variable
		locationFromDb.setUpdated_by(Integer.parseInt(request.getSession().getAttribute("userid").toString()));		
		locationFromDb.setUpdated_datetime(dateFormat.format(date));
		locationFromDb.setObsolete("Y");
		locationFromDb.setActive("N");
		
		
		try {
			if(shipmentModel == null && branchModel == null && customerModel == null && employeeMaster == null && company == null) {
				locationDao.saveOrUpdate(locationFromDb);
				return new ResponseEntity<String>(HttpStatus.OK);
			} else {
				System.out.println("location else ========================");
				return new ResponseEntity<String>("referred someone table",HttpStatus.IM_USED);
			}
			
		} catch (Exception e) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS,e);
			e.printStackTrace();
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
	}
	
	//=========================UPDATE USER===========================
	@RequestMapping(value="/updateLocation/{id}",method=RequestMethod.PUT)
	public ResponseEntity<Void> updateLocation(@PathVariable("id") long id,
			HttpServletRequest request,@RequestBody Location location){
		
		System.out.println("++ updating Location "+id);
		Location locationFromDb=locationDao.getLocationById((int)id);
		if(locationFromDb==null){
			return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
		}
		
		//intialize		
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
				
		//set variable
		location.setUpdated_by(Integer.parseInt(request.getSession().getAttribute("userid").toString()));		
		location.setUpdated_datetime(dateFormat.format(date));
		
		

		try {
			locationDao.saveOrUpdate(location);
			return new ResponseEntity<Void>(HttpStatus.OK);	
		} catch (Exception e) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS,e);
			e.printStackTrace();
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}	
	}
}