package com.conti.settings.price;


import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.session.SessionAuthenticationException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.conti.address.AddressModel;
import com.conti.config.SessionListener;
import com.conti.master.branch.BranchModel;
import com.conti.master.location.Location;
import com.conti.master.product.Product;
import com.conti.master.service.ServiceMaster;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;
import com.conti.setting.usercontrol.RoleDao;
import com.conti.setting.usercontrol.User;
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
	public ResponseEntity<PriceSettingDetail> getPriceSettingModel(){
	
		PriceSettingDetail priceSettingDetail =new PriceSettingDetail();
		
		PriceSetting priceSetting=new PriceSetting();
		priceSetting.setProduct(new Product());
		priceSetting.setService(new ServiceMaster());
		priceSetting.setBranch(new BranchModel());
		
		priceSettingDetail.setPriceSetting(priceSetting);
		priceSettingDetail.setBranch(new BranchModel());
		
		return new  ResponseEntity<PriceSettingDetail>(priceSettingDetail,HttpStatus.CREATED);
	}
	
	//	public ResponseEntity<PriceSetting> getPriceSettingModel(){
//		
//		Location location=new Location();
//		AddressModel address=new AddressModel();
//		location.setAddress(address);
//		
//		PriceSetting priceSetting=new PriceSetting();
//		
//		Set<PriceSettingDetail> PriceSettingDetail=new HashSet<>();
//		
//		PriceSettingDetail priceSettingDetail =new PriceSettingDetail();
//		priceSettingDetail.setBranch(new BranchModel());
//		PriceSettingDetail priceSettingDetail1 =new PriceSettingDetail();
//		priceSettingDetail1.setBranch(new BranchModel());
//		
//		PriceSettingDetail.add(priceSettingDetail);
//		PriceSettingDetail.add(priceSettingDetail1);
//		
//		priceSetting.setPriceSettingDetail(PriceSettingDetail);
//		priceSetting.setProduct(new Product());
//		priceSetting.setService(new ServiceMaster());
//		priceSetting.setBranch(new BranchModel());
//		
//		return new  ResponseEntity<PriceSetting>(priceSetting,HttpStatus.CREATED);
//	}
	

}