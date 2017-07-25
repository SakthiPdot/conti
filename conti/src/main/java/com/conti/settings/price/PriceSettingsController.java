package com.conti.settings.price;


import java.io.IOException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.conti.address.AddressModel;
import com.conti.config.SessionListener;
import com.conti.master.branch.BranchDao;
import com.conti.master.branch.BranchModel;
import com.conti.master.location.Location;
import com.conti.master.product.Product;
import com.conti.master.product.ProductDAO;
import com.conti.master.service.ServiceDao;
import com.conti.master.service.ServiceMaster;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;
import com.conti.setting.usercontrol.UsersDao;

/**
 * @Project_Name conti
 * @Package_Name com.conti.settings.price
 * @File_name PriceSettingsController.java
 * @author Sakthi
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 20, 2017 2:21:39 PM
 */

@RestController
public class PriceSettingsController {

	final Logger logger = LoggerFactory.getLogger(PriceSettingsController.class);

	@Autowired
	private UsersDao usersDao;
	@Autowired
	private ProductDAO productDao;
	@Autowired
	private BranchDao branchDao;
	@Autowired
	private ServiceDao serviceDao;
	
	
	@Autowired
	@Qualifier("sessionRegistry")
	private SessionRegistry sessionRegistry;
		
	Loggerconf loggerconf = new Loggerconf();
	SessionListener sessionListener = new SessionListener();

	@RequestMapping(value =  "price_settings", method = RequestMethod.GET)
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
			
			model.addObject("title", "Price Settings");
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.setViewName("Settings/price settings");

			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;

	}

	//=================GET PRICE SETTING MODEL=====================================
	@RequestMapping(value="getPriceSettingModel",method=RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
//	public ResponseEntity<PriceSettingDetail> getPriceSettingModel(){
//	
//		PriceSettingDetail priceSettingDetail =new PriceSettingDetail();
//		
//		PriceSetting priceSetting=new PriceSetting();
//		priceSetting.setProduct(new Product());
//		priceSetting.setService(new ServiceMaster());
//		priceSetting.setBranch(new BranchModel());
//		
//		priceSettingDetail.setPriceSetting(priceSetting);
//		priceSettingDetail.setBranch(new BranchModel());
//		
//		return new  ResponseEntity<PriceSettingDetail>(priceSettingDetail,HttpStatus.CREATED);
//	}
	
		public ResponseEntity<PriceSetting> getPriceSettingModel(){
		
		Location location=new Location();
		AddressModel address=new AddressModel();
		location.setAddress(address);
		
		PriceSetting priceSetting=new PriceSetting();
		
		Set<PriceSettingDetail> PriceSettingDetail=new HashSet<>();
		
		PriceSettingDetail priceSettingDetail =new PriceSettingDetail();
		priceSettingDetail.setBranch(new BranchModel());
		PriceSettingDetail priceSettingDetail1 =new PriceSettingDetail();
		priceSettingDetail1.setBranch(new BranchModel());
		
		PriceSettingDetail.add(priceSettingDetail);
		PriceSettingDetail.add(priceSettingDetail1);
		
		priceSetting.setPriceSettingDetail(PriceSettingDetail);
		priceSetting.setProduct(new Product());
		priceSetting.setService(new ServiceMaster());
		priceSetting.setBranch(new BranchModel());
		
		return new  ResponseEntity<PriceSetting>(priceSetting,HttpStatus.CREATED);
	}
	
	@RequestMapping(value="getBranchByStr/{str}", method = RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Map<String,List<BranchModel>>> fetchAllBranches(HttpServletRequest request,
			@PathVariable("str") String searchStr) throws JsonGenerationException, JsonMappingException, JSONException, IOException {
		
		List<BranchModel> branches = branchDao.searchbyeyBranchName(searchStr);

		 Map result = new HashMap();
		 result.put("Branch", branches);
		
		System.err.println(searchStr+"464644");
		return new ResponseEntity<Map<String,List<BranchModel>>> (result,HttpStatus.OK);
	}
	
	
	@RequestMapping(value="getServiceByStr/{str}", method = RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Map<String,List<ServiceMaster>>> getServiceByStr(HttpServletRequest request,
			@PathVariable("str") String searchStr) throws JsonGenerationException, JsonMappingException, JSONException, IOException {
		
		List<ServiceMaster> services = serviceDao.searchbyServiceName(searchStr);

		 Map result = new HashMap();
		 result.put("Service", services);
		
		System.err.println(searchStr+"464644");
		return new ResponseEntity<Map<String,List<ServiceMaster>>> (result,HttpStatus.OK);
	}
	
	
	@RequestMapping(value="getProductByStr/{str}", method = RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Map<String,List<Product>>> getProductByStr(HttpServletRequest request,
			@PathVariable("str") String searchStr) throws JsonGenerationException, JsonMappingException, JSONException, IOException {
		
		List<Product> product = productDao.searchByProductName(searchStr);

		 Map result = new HashMap();
		 result.put("Product", product);
		
		System.err.println(searchStr+"464644");
		return new ResponseEntity<Map<String,List<Product>>> (result,HttpStatus.OK);
	}

}