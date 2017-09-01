package com.conti.settings.price.register;


import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONArray;
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
import com.conti.master.location.Location;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;
import com.conti.setting.usercontrol.User;
import com.conti.setting.usercontrol.UsersDao;
import com.conti.settings.company.Company;
import com.conti.settings.company.CompanySettingDAO;
import com.conti.settings.price.PriceSetting;
import com.conti.settings.price.PriceSettingDao;
import com.conti.settings.price.PriceSettingDetail;
import com.conti.settings.price.PriceSettingDetailDao;

/**
 * @Project_Name conti
 * @Package_Name com.conti.settings.price
 * @File_name PriceSettingsRegisterController.java
 * @author Sakthi
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 20, 2017 2:21:39 PM
 */

@RestController
public class PriceSettingsRegisterController {

	final Logger logger = LoggerFactory.getLogger(PriceSettingsRegisterController.class);

	@Autowired
	private UsersDao usersDao;

	@Autowired
	private PriceSettingDao psDao;
	
	@Autowired
	private CompanySettingDAO companySettingDAO;
		
	@Autowired
	private PriceSettingDetailDao psdDAo;
	@Autowired
	@Qualifier("sessionRegistry")
	private SessionRegistry sessionRegistry;
		
	Loggerconf loggerconf = new Loggerconf();
	SessionListener sessionListener = new SessionListener();

	
	//======================================sort by==========================================
	@RequestMapping(value="sortByPS/{name}",method=RequestMethod.POST,produces=MediaType.APPLICATION_JSON_VALUE)
	public  ResponseEntity<List<PriceSetting>>  sortByPS(@RequestBody String status,@PathVariable("name") String name,HttpServletRequest request){
		

		UserInformation userinfo = new UserInformation(request);
		String userid = userinfo.getUserId();
		User user =usersDao.get(Integer.parseInt(userid));
		
		String sortBy="";		
		
		switch(name.trim()){
		case "FromBranch":
		    sortBy="branch.branch_name";
			break;
		case "serviceName":
		    sortBy="service.service_name";
			break;	
		case "productName":
		    sortBy="product.product_name";
			break;	
		case "productType":
		    sortBy="product.product_Type";
			break;	
		case "defaultPrice":
		    sortBy="default_price";
			break;	
		case "defaultHandlingCharges":
		    sortBy="defaulthandling_charge";
			break;	
		case "psActive":
		    sortBy="active";
			break;	
		default:
			break;
		}
		
		List<PriceSetting> priceSettingList=new ArrayList<>();
		try{		
			if (user.getRole().getRole_Name().trim().equals(ConstantValues.ROLE_SADMIN.trim())) {
				priceSettingList=psDao.gePriceSettingSorting100(sortBy.trim(),status.trim().equals("ASC")?"ASC":"DESC");
			}else{
				priceSettingList=psDao.gePriceSettingSorting100Staff(sortBy.trim(),status.trim().equals("ASC")?"ASC":"DESC",user.getBranchModel().getBranch_id());
			}
			
			if(priceSettingList.isEmpty()){
				return new ResponseEntity<List<PriceSetting>>(HttpStatus.NO_CONTENT);
			}
			return new ResponseEntity<List<PriceSetting>>(priceSettingList,HttpStatus.OK);				
		}catch(Exception e){
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS,e);
			e.printStackTrace();
			return new ResponseEntity<List<PriceSetting>>(HttpStatus.INTERNAL_SERVER_ERROR);
			}
	
		
	}

	//======================================Pagination begin==========================================
	@RequestMapping(value = "paginationPriceSetting", method=RequestMethod.POST)
	public ResponseEntity<List<PriceSetting>> paginationPriceSetting(@RequestBody int page, HttpServletRequest request) {
		System.err.println(String.valueOf(page)+"++++++++++++++++++++++++++++++++++++++++");
		//intialize	
		int from_limit = 0, to_limit = 0;
		String order = "DESC";
		UserInformation userinfo = new UserInformation(request);
		String userid = userinfo.getUserId();
		User user =usersDao.get(Integer.parseInt(userid));
		List<PriceSetting> priceSettinglist;
		
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
	
		try {
			if(user.getRole().getRole_Name().trim().equals(ConstantValues.ROLE_SADMIN.trim())){
				priceSettinglist=psDao.getPriceSettingWithLimit(from_limit, to_limit, order); 
			}else{
				priceSettinglist=psDao.getPriceSettingWithLimitStaff(from_limit, to_limit, order,user.getBranchModel().getBranch_id());
			}
			return new ResponseEntity<List<PriceSetting>>(priceSettinglist,HttpStatus.OK);
		} catch (Exception e) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, e);
			return new ResponseEntity<List<PriceSetting>> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	//======================================search priceSetting by 4 strings==========================================
	@RequestMapping(value = "searchPriceSetting4String", method=RequestMethod.POST)
	public ResponseEntity<List<PriceSetting>> searchPriceSetting4String(@RequestBody String SearchString, HttpServletRequest request) {	
		
		UserInformation userinfo = new UserInformation(request);
		String userid = userinfo.getUserId();
		User user =usersDao.get(Integer.parseInt(userid));
		List<PriceSetting> psList;
		
			try {
				
				if(user.getRole().getRole_Name().trim().equals(ConstantValues.ROLE_SADMIN.trim())){
					psList=psDao.searchByPriceSetting(SearchString) ;	
				}else{
					psList=psDao.searchByPriceSetting(SearchString) ;
				}
						
				return new ResponseEntity<List<PriceSetting>> (psList, HttpStatus.OK);
			} catch (Exception e) {
				loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, e);
				return new ResponseEntity<List<PriceSetting>> (HttpStatus.UNPROCESSABLE_ENTITY);
			}	
			
	}
	//=================EXCEL DOWNLOAD=====================================
	@RequestMapping(value="downloadExcelPriceSetting",method=RequestMethod.GET)
	public ModelAndView downloadExcelProduct(HttpServletRequest request){
	
	//intitialize	
	UserInformation userinfo = new UserInformation(request);
	String userid = userinfo.getUserId();
	User user =usersDao.get(Integer.parseInt(userid));
	List<PriceSetting> priceSettingList=null;
	
	try{
		
		if(user.getRole().getRole_Name().trim().equals(ConstantValues.ROLE_SADMIN.trim())){
			priceSettingList=psDao.getPriceSetting(); 
		}else{
			priceSettingList=psDao.getPriceSettingStaff(user.getBranchModel().getBranch_id()); 
		}
		
		return new ModelAndView("priceSettingExcelView","priceSettingList",priceSettingList);
	} catch (Exception e) {
		loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, e);
		return new ModelAndView("priceSettingExcelView","priceSettingList",priceSettingList);
	}
	
		
	}
	//=================PRINT=====================================
	@RequestMapping(value="priceSetting_Print",method=RequestMethod.POST)
	public ModelAndView priceSetting_Print(HttpServletRequest request,
			@RequestParam("SelectedPriceSetting") String SelectedPriceSetting) throws IOException{
		
		ObjectMapper mapper=new ObjectMapper();		
		List<PriceSetting> priceSettingList=null;	
		
		try {
			JSONArray jsonProductArray=new JSONArray(SelectedPriceSetting);
			String[] priceSetting_id=new String[jsonProductArray.length()];
			priceSettingList = new ArrayList<PriceSetting>();			
			for(int i=0;i<jsonProductArray.length();i++){
				JSONObject psObject=jsonProductArray.getJSONObject(i);
				PriceSetting priceSetting=psDao.getPriceSettingById(psObject.getInt("pricesetting_id"));
				priceSettingList.add(priceSetting);
			}
			
		} catch (Exception e1) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), "Json parse error", e1);
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
		
		ModelAndView model = new ModelAndView("print/priceSetting_print");		
		model.addObject("company", company);
		model.addObject("priceSettingList",priceSettingList);
		model.addObject("image",base64DataString);
		return model;
	
	}
	
	
	//=================FETCH ALL PRICE SETTING=====================================	
	@RequestMapping(value="fetchAllPriceSetting",method=RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<PriceSetting>>  fetchAllPriceSetting(HttpServletRequest request){
		
		UserInformation userinfo = new UserInformation(request);
		String userid = userinfo.getUserId();
		User user =usersDao.get(Integer.parseInt(userid));
		
		
		try {
			List<PriceSetting> priceSettingList;
			if (user.getRole().getRole_Name().trim().equals(ConstantValues.ROLE_SADMIN.trim())) {
				priceSettingList = psDao.getPriceSettingBy100();
			} else {
				priceSettingList = psDao.getPriceSettingBy100staff(user.getBranchModel().getBranch_id());
			}
			if (priceSettingList.isEmpty()) {
				return new ResponseEntity<List<PriceSetting>>(HttpStatus.NO_CONTENT);
			}

			return new ResponseEntity<List<PriceSetting>>(priceSettingList, HttpStatus.OK);
		} catch (Exception e) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(),
					ConstantValues.SAVE_NOT_SUCCESS, e);
			return new ResponseEntity<List<PriceSetting>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
	}
	
	//======================================get Record Count==========================================
	@RequestMapping(value = "/priceSettingRecordCount/", method = RequestMethod.GET)
	public ResponseEntity<String> priceSettingRecordCount(HttpServletRequest request) {
		
		
		UserInformation userinfo = new UserInformation(request);
		String userid = userinfo.getUserId();
		User user =usersDao.get(Integer.parseInt(userid));
		
		try {
			if (user.getRole().getRole_Name().trim().equals(ConstantValues.ROLE_SADMIN.trim())) {
				return new ResponseEntity<String> (String.valueOf(psDao.priceSettingCount()), HttpStatus.OK);
			}else{
				return new ResponseEntity<String> (String.valueOf(psDao.priceSettingCount()), HttpStatus.OK);
			}
		} catch (Exception exception) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<String> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	//=================CHANGE ACTIVE STATUS=====================================
	@RequestMapping (value="PriceSettingStaus/{status}",method=RequestMethod.POST,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Void>  PriceSettingStaus(@RequestBody int[] idArray,@PathVariable("status") String status,HttpServletRequest request){
		
				
		//intialize		
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
		
		try{
			for(int i=0;i<idArray.length;i++){
				PriceSetting priceSetting=psDao.getPriceSettingById(idArray[i]);				
				if(status.trim().equals("InActive") ||status.trim()=="InActive" ){
					priceSetting.setActive("N");
				}else{
					priceSetting.setActive("Y");
				}				
				//set variable
				priceSetting.setUpdated_by(Integer.parseInt(request.getSession().getAttribute("userid").toString()));
				priceSetting.setUpdated_datetime(dateFormat.format(date));
				psDao.saveOrUpdate(priceSetting);				
			}
			return new ResponseEntity<Void>(HttpStatus.OK);
		} catch (Exception e) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS,e);
			e.printStackTrace();
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		
	}
	//=================PRICE SETTING REGISTER PAGE OPEN=====================================	
	@RequestMapping(value =  "price_settings_register", method = RequestMethod.GET)
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
			
			model.addObject("title", "Price Settings Register");
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.setViewName("Settings/price settings_register");
			model.addObject("homePage",request.getContextPath());

			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;

	}

	
	//--------------------------------- Fetch price by from branch OR to branch and service and product writen by sankar
	@RequestMapping(value = "fetch_priceforShipment", method = RequestMethod.POST)
	public ResponseEntity<String> fetch_priceforShipment (@RequestBody String product_info, HttpServletRequest request) {
		
		JSONObject json = new JSONObject(product_info);
		int from_branch = json.getInt("from_branch_id");
		int to_branch = json.getInt("to_branch_id");
		int product = json.getInt("product_id");
		int service = json.getInt("service_id");
		int max_weight = json.getInt("max_weight");
		
		PriceSetting priceSetting = psDao.fetchprice(from_branch, product, service);
		
		JSONObject json1 = new JSONObject();
		
		if(priceSetting != null) {
			
			json1.put("handling_charges", priceSetting.getDefaulthandling_charge());
			
			if(priceSetting.getDefault_price() != 0 ) {
				json1.put("price", priceSetting.getDefault_price());
				
				return new ResponseEntity<String>(json1.toString() , HttpStatus.OK);
			} else {
				
				PriceSettingDetail priceSettingDetail = psdDAo.fetchprice(priceSetting.getPricesetting_id(), to_branch, max_weight);
				
				if( priceSettingDetail != null ) {
					json1.put("price", priceSettingDetail.getPs_price());
					return new ResponseEntity<String>(json1.toString() , HttpStatus.OK);
				} else {
					json1.put("price", "");
					return new ResponseEntity<String>(json1.toString(), HttpStatus.OK);
				}
			}
			
		} else {
			return new ResponseEntity<String>(HttpStatus.NO_CONTENT);
		}
		
	}
	
	
}