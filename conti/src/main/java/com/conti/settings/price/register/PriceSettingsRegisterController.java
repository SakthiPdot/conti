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
import com.conti.setting.usercontrol.UsersDao;
import com.conti.settings.company.Company;
import com.conti.settings.company.CompanySettingDAO;
import com.conti.settings.price.PriceSetting;
import com.conti.settings.price.PriceSettingDao;

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
	@Qualifier("sessionRegistry")
	private SessionRegistry sessionRegistry;
		
	Loggerconf loggerconf = new Loggerconf();
	SessionListener sessionListener = new SessionListener();

	

	//======================================get Record Count==========================================
	@RequestMapping(value = "/priceSettingRecordCount/", method = RequestMethod.GET)
	public ResponseEntity<String> priceSettingRecordCount(HttpServletRequest request) {
		try {	
			return new ResponseEntity<String> (String.valueOf(psDao.priceSettingCount()), HttpStatus.OK);			
		} catch (Exception exception) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<String> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	//======================================Pagination begin==========================================
	@RequestMapping(value = "paginationPriceSetting", method=RequestMethod.POST)
	public ResponseEntity<List<PriceSetting>> paginationPriceSetting(@RequestBody int page, HttpServletRequest request) {
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
		List<PriceSetting> priceSettinglist=psDao.getPriceSettingWithLimit(from_limit, to_limit, order); 
		return new ResponseEntity<List<PriceSetting>>(priceSettinglist,HttpStatus.OK);
	}
	//======================================search priceSetting by 4 strings==========================================
	@RequestMapping(value = "searchPriceSetting4String", method=RequestMethod.POST)
	public ResponseEntity<List<PriceSetting>> searchPriceSetting4String(@RequestBody String SearchString, HttpServletRequest request) {	
		System.out.println(SearchString+"123");
			List<PriceSetting> psList=psDao.searchByPriceSetting(SearchString) ;		
			return new ResponseEntity<List<PriceSetting>> (psList, HttpStatus.OK);		
	}
	//=================EXCEL DOWNLOAD=====================================
	@RequestMapping(value="downloadExcelPriceSetting",method=RequestMethod.GET)
	public ModelAndView downloadExcelProduct(){
		List<PriceSetting> priceSettingList=psDao.getPriceSetting(); 
		return new ModelAndView("priceSettingExcelView","priceSettingList",priceSettingList);
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
		
		ModelAndView model = new ModelAndView("print/priceSetting_print");		
		model.addObject("company", company);
		model.addObject("priceSettingList",priceSettingList);
		model.addObject("image",base64DataString);
		return model;
	
	}
	
	
	//=================FETCH ALL PRICE SETTING=====================================	
	@RequestMapping(value="fetchAllPriceSetting",method=RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<PriceSetting>>  fetchAllPriceSetting(){
		List<PriceSetting> priceSettingList=psDao.getPriceSettingBy100();
		if(priceSettingList.isEmpty()){
			return new ResponseEntity<List<PriceSetting>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<PriceSetting>>(priceSettingList,HttpStatus.OK);
	}
	
	//=================CHANGE ACTIVE STATUS=====================================
	@RequestMapping (value="PriceSettingStaus/{status}",method=RequestMethod.POST,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Void>  PriceSettingStaus(@RequestBody int[] idArray,@PathVariable("status") String status,HttpServletRequest request){
		
		System.out.println(status+"******status******");		
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

			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;

	}


}