package com.conti.manifest;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.JsonParser.Feature;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.conti.config.SessionListener;
import com.conti.master.customer.CustomerModel;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;
import com.conti.setting.usercontrol.UsersDao;
import com.conti.settings.company.Company;
import com.conti.settings.company.CompanySettingDAO;

/**
 * @Project_Name conti
 * @Package_Name com.conti.master.manifest.add
 * @File_name AddManifestDaoImpl.java
 * @author Suresh
 * @Created_date_time July 24, 2017 3:31:53 PM
 * @Updated_date_time Jly 24, 2017 3:31:53 PM
 */
@RestController
public class ManifestRestController 
{
	final Logger logger = LoggerFactory.getLogger(ManifestRestController.class);

	@Autowired
	private UsersDao usersDao;
	
	@Autowired
	private ManifestDao manifestDao;
	
	@Autowired
	private CompanySettingDAO companySettingDAO;
		
	@Autowired
	@Qualifier("sessionRegistry")
	private SessionRegistry sessionRegistry;
		
	Loggerconf loggerconf = new Loggerconf();
	SessionListener sessionListener = new SessionListener();

	private UserInformation userInformation;

	
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
		
		
		try
		{
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			
			model.addObject("title", "Add Manifest");
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.setViewName("Manifest/add_manifest");

			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;
	}
	
	
	
	//========================== to display View Manifest Screen==========================
	
	@RequestMapping(value =  "view_manifest", method = RequestMethod.GET)
	public ModelAndView view_manifest(HttpServletRequest request) throws Exception {
		
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
			
			model.addObject("title", "View Manifest");
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.setViewName("Manifest/view_manifest");

			
		} 
		catch (Exception exception) 
		{
			loggerconf.saveLogger(username,  "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;
	}
		
		
		@RequestMapping( value = "/manifest/", method = RequestMethod.GET)
		public ResponseEntity<List<ManifestModel>> fetchAllManifest(HttpServletRequest request) 
		{
			userInformation = new UserInformation(request);
			String username = userInformation.getUserName();
			String branch_id = userInformation.getUserBranchId();
			try 
			{
				loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
				List<ManifestModel> manifestModel = manifestDao.getAllManifest(Integer.parseInt(branch_id));
				
				if(manifestModel.isEmpty()) 
				{
					return new ResponseEntity<List<ManifestModel>> (HttpStatus.NO_CONTENT);
				}
				else 
				{
					return new ResponseEntity<List<ManifestModel>> (manifestModel, HttpStatus.OK);	
				}			
			} 
			catch (Exception exception) 
			{			
				loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
				return new ResponseEntity<List<ManifestModel>> (HttpStatus.UNPROCESSABLE_ENTITY);
			}
				
				
			
		}

		
		//======================================Excel begin==========================================
		@RequestMapping(value="downloadExcelManifest",method=RequestMethod.GET)
		public ModelAndView downloadExcelManifest()
		{
			String branch_id = userInformation.getUserBranchId();
			List<ManifestModel> manifestList=manifestDao.getAllManifests(Integer.parseInt(branch_id));
			return new ModelAndView("manifestExcelView","manifestList",manifestList);
		}
		
//		@RequestMapping(value = "register_search_customer", method=RequestMethod.POST)
//		public ResponseEntity<List<CustomerModel>> register_search_customer(@RequestBody String searchkey, HttpServletRequest request) 
//		{
//			
//			List<CustomerModel> customerList = customerDao.searchbyeyCustomer(searchkey);
//			return new ResponseEntity<List<CustomerModel>> (customerList, HttpStatus.OK);
//		}
		//======================================Excel end==========================================
		
		/* ------------------------- Print in Customer begin ------------------------------------- */	
		@RequestMapping(value = "/Manifest_print", method = RequestMethod.POST)
		public ModelAndView farmPrint(@RequestParam("cust") String manifest, HttpServletRequest request) throws JsonProcessingException, IOException{

			JSONArray jsonArray = new JSONArray(manifest);
			String[] manifestid = new String[jsonArray.length()];
			for(int i=0; i <jsonArray.length();i++) {
				JSONObject jsonObject = jsonArray.getJSONObject(i);
				manifestid[i] = Integer.toString(jsonObject.getInt("manifest_id"));			
			}
			
			List<ManifestModel> listManifest = new ArrayList<ManifestModel> ();
			for(int i=0; i<manifestid.length;i++) {
				ManifestModel manifestModel = manifestDao.getManifestbyId(Integer.parseInt(manifestid[i]));
				listManifest.add(manifestModel);
			}
			Company company = companySettingDAO.getById(1);
			ModelAndView model = new ModelAndView("print/manifest_print");

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
			
			model.addObject("title", "Customer");
			model.addObject("company", company);
			model.addObject("listCust", listManifest);
			model.addObject("image",base64DataString);
				
			return model;
		}
		/* ------------------------- Print in Employee end ------------------------------------- */	

	//--------------------Manifest Filter by condition start------------------------------
		
		@RequestMapping( value = "manifest_filter", method = RequestMethod.POST)
		public ResponseEntity<List<ManifestModel>> manifestFilterbycondition(String manifest,HttpServletRequest request) throws JsonProcessingException, IOException 
		{
//			JSONArray jsonArray=new JSONArray(manifest);
//			String[] filterdetail=new String[jsonArray.length()];
			
			 ObjectMapper mapper = new ObjectMapper();
			 mapper.configure(Feature.AUTO_CLOSE_SOURCE, true);
			 JsonNode rootNode =mapper.readTree(manifest);
			 JsonNode nameNode = rootNode.path("fromdate");
			 System.out.println("the from date value is:  "+nameNode);
			
			
//			try 
//			{
//				loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
//				List<ManifestModel> manifestModel1 = manifestDao.getManifestByCondition(Integer.parseInt(frombranch_id),tobranchid,fromdate,todate);
//				
//				if(manifestModel.isEmpty()) 
//				{
//					return new ResponseEntity<List<ManifestModel>> (HttpStatus.NO_CONTENT);
//				}
//				else 
//				{
//					return new ResponseEntity<List<ManifestModel>> (manifestModel, HttpStatus.OK);	
//				}			
//			} 
//			catch (Exception exception) 
//			{			
//				loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
				return new ResponseEntity<List<ManifestModel>> (HttpStatus.UNPROCESSABLE_ENTITY);
//			}
//				
				
			
		}

		//--------------------Manifest Filter by condition End------------------------------
	
	
}