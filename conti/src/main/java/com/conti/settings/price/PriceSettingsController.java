package com.conti.settings.price;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.json.JSONException;
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
	private PriceSettingDao psDao;
	@Autowired
	private PriceSettingDetailDao psdDao;
	
	@Autowired
	@Qualifier("sessionRegistry")
	private SessionRegistry sessionRegistry;
		
	Loggerconf loggerconf = new Loggerconf();
	SessionListener sessionListener = new SessionListener();

	@RequestMapping(value =  "price_settings", method = RequestMethod.GET)
	public ModelAndView adminPage(HttpServletRequest request,@RequestParam(value="id", defaultValue = "0")int id) throws Exception {
		
		System.out.println("++ price setting "+id);
		
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
			
		
			if(id==0){
				model.addObject("saveOrNew", "NEW") ;
			}else{
				PriceSetting priceSetting=psDao.getPriceSettingById((int)id);
				if(priceSetting!=null){
					model.addObject("saveOrNew",id);
				}else{
					model.addObject("saveOrNew", "NEW") ;
				}
			}
			
			
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
		
		List<PriceSettingDetail> PriceSettingDetail=new ArrayList<>();
		
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
	
	//=================GET BRANCH USING STRING =====================================
	@RequestMapping(value="getBranchByStr/{str}", method = RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Map<String,List<BranchModel>>> fetchAllBranches(HttpServletRequest request,
			@PathVariable("str") String searchStr) throws JsonGenerationException, JsonMappingException, JSONException, IOException {
		
		List<BranchModel> branches = branchDao.searchbyeyBranchName(searchStr);

		 Map result = new HashMap();
		 result.put("Branch", branches);
		
		System.err.println(searchStr+"464644");
		return new ResponseEntity<Map<String,List<BranchModel>>> (result,HttpStatus.OK);
	}
	
	//=================GET SERVICE USING STRING =====================================
	@RequestMapping(value="getServiceByStr/{str}", method = RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Map<String,List<ServiceMaster>>> getServiceByStr(HttpServletRequest request,
			@PathVariable("str") String searchStr) throws JsonGenerationException, JsonMappingException, JSONException, IOException {
		
		List<ServiceMaster> services = serviceDao.searchbyServiceName(searchStr);

		 Map result = new HashMap();
		 result.put("Service", services);
		
		System.err.println(searchStr+"464644");
		return new ResponseEntity<Map<String,List<ServiceMaster>>> (result,HttpStatus.OK);
	}
	

	//=================GET PRODUCT USING STRING =====================================
	@RequestMapping(value="getProductByStr/{str}", method = RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Map<String,List<Product>>> getProductByStr(HttpServletRequest request,
			@PathVariable("str") String searchStr) throws JsonGenerationException, JsonMappingException, JSONException, IOException {
		
		List<Product> product = productDao.searchByProductName(searchStr);

		 Map result = new HashMap();
		 result.put("Product", product);
		
		System.err.println(searchStr+"464644");
		return new ResponseEntity<Map<String,List<Product>>> (result,HttpStatus.OK);
	}
	
	//=================SAVE =====================================	
	@RequestMapping(value="priceSettingSave",method=RequestMethod.POST,
	produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Void> priceSettingSave (@RequestBody PriceSetting priceSetting,HttpServletRequest request ){
			System.out.println("++ inside product setting save");
			
			//intialize	
			String userid=request.getSession().getAttribute("userid").toString();	
			Date date = new Date();
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
			
			//set variable
			priceSetting.setCreated_by(Integer.parseInt(userid));
			priceSetting.setUpdated_by(Integer.parseInt(userid));
			priceSetting.setCreated_datetime(dateFormat.format(date));
			priceSetting.setObsolete("N");
			priceSetting.setActive("Y");
	
			//set price setting for detailed table
			List<PriceSettingDetail> priceSettingDetailList=priceSetting.getPriceSettingDetail();			
			for(PriceSettingDetail psDetail:priceSettingDetailList){
				psDetail.setPriceSetting(priceSetting);
			}
			
			//save location
			try {
				psDao.saveOrUpdate(priceSetting);
				loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
				return new ResponseEntity<Void>(HttpStatus.CREATED);
			} catch (Exception e) {
				loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS,e);
				e.printStackTrace();
				return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
			}
	}
	
	//=================Update=====================================
	@RequestMapping(value="priceSettingUpdate/{id}",method=RequestMethod.PUT,
			produces=MediaType.APPLICATION_JSON_VALUE)
			public ResponseEntity<Void> priceSettingUpdate (@RequestBody PriceSetting priceSetting,
					@PathVariable("id") long id,HttpServletRequest request ){
				System.out.println("++ price setting "+id);
				PriceSetting priceSettingFromDB=psDao.getPriceSettingById((int)id);
				if(priceSettingFromDB==null){
					return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
				}
				
				//intialize		
				Date date = new Date();
				DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
				
				//set variable
				priceSetting.setUpdated_by(Integer.parseInt(request.getSession().getAttribute("userid").toString()));
				priceSetting.setUpdated_datetime(dateFormat.format(date));
		
				try {
					psDao.saveOrUpdate(priceSetting);
					return new ResponseEntity<Void>(HttpStatus.OK);	
				} catch (Exception e) {
					loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS,e);
					e.printStackTrace();
					return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
				}
	}
		
	//=================DELETE price setting by ID =====================================
	@RequestMapping(value="/priceSettingDelete/{id}",method=RequestMethod.DELETE,
			produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Void> priceSettingDelete(@PathVariable("id") long id,
			HttpServletRequest request){
		
		System.out.println("++ price setting "+id);
		PriceSetting priceSetting=psDao.getPriceSettingById((int)id);
		if(priceSetting==null){
			return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
		}
		
		//intialize		
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
		
		//set variable
		priceSetting.setUpdated_by(Integer.parseInt(request.getSession().getAttribute("userid").toString()));
		priceSetting.setUpdated_datetime(dateFormat.format(date));
		priceSetting.setObsolete("Y");
		priceSetting.setActive("N");
		
		try {
			psDao.saveOrUpdate(priceSetting);
			return new ResponseEntity<Void>(HttpStatus.OK);
		} catch (Exception e) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS,e);
			e.printStackTrace();
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		
	}
	//=================fetch price setting with id =====================================
	
	@RequestMapping(value="/PriceSettingWithID/{id}",method=RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<PriceSetting> PriceSettingWithID(@PathVariable("id") long id){
	
		
		System.out.println("++ price setting "+id);
		PriceSetting priceSetting=psDao.getPriceSettingById((int)id);
		if(priceSetting==null){
			return new ResponseEntity<PriceSetting>(HttpStatus.NOT_FOUND);
		}
		
		
		List<PriceSettingDetail> priceDetailList=new ArrayList<PriceSettingDetail>(psdDao.getPriceSettingDetailBypsId(priceSetting.getPricesetting_id()));
		
		if(priceDetailList!=null && !priceDetailList.isEmpty())
			priceSetting.setPriceSettingDetail( priceDetailList);
		
			
		return new ResponseEntity<PriceSetting>(priceSetting,HttpStatus.OK);
		
	}
	
	//=================UPDATE =====================================
	//priceSettingUpdate
	
}