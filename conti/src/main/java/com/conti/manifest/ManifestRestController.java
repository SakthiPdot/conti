package com.conti.manifest;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.conti.config.SessionListener;
import com.conti.master.branch.BranchModel;
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
		
  //--------------------- TO get all manifest  list function start -------------------	
	
	@RequestMapping( value = "manifest", method = RequestMethod.GET)
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
					//System.out.println("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy "+manifestModel);
					return new ResponseEntity<List<ManifestModel>> (manifestModel, HttpStatus.OK);	
				}			
			} 
			catch (Exception exception) 
			{			
				loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
				return new ResponseEntity<List<ManifestModel>> (HttpStatus.UNPROCESSABLE_ENTITY);
			}
	}
	//--------------------- TO get all manifest  list function End ------------------------
	
	
	//----------------------To get all inward manifest list function start--------------------
	
	@RequestMapping(value="/inward_manifest", method=RequestMethod.GET)
	public ResponseEntity<List<ManifestModel>>inwardManifest(HttpServletRequest request)
	{
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		String branch_id = userInformation.getUserBranchId();
		try
		{
			loggerconf.saveLogger(username,request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			List<ManifestModel> manifestModel=manifestDao.getInwardManifest(Integer.parseInt( branch_id));
			if(manifestModel.isEmpty()) 
			{
				return new ResponseEntity<List<ManifestModel>> (HttpStatus.NO_CONTENT);
			}
			else 
			{
				return new ResponseEntity<List<ManifestModel>> (manifestModel, HttpStatus.OK);	
			}	
		}
		catch(Exception exception)
		{
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<List<ManifestModel>> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	//----------------------To get all inward manifest list function End--------------------	
	
	//----------------------To get all inward manifest list function start--------------------
	
		@RequestMapping(value="/outward_manifest", method=RequestMethod.GET)
		public ResponseEntity<List<ManifestModel>>outwardManifest(HttpServletRequest request)
		{
			userInformation = new UserInformation(request);
			String username = userInformation.getUserName();
			String branch_id = userInformation.getUserBranchId();
			try
			{
				loggerconf.saveLogger(username,request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
				List<ManifestModel> manifestModel=manifestDao.getOutwardManifest(Integer.parseInt( branch_id));
				if(manifestModel.isEmpty()) 
				{
					return new ResponseEntity<List<ManifestModel>> (HttpStatus.NO_CONTENT);
				}
				else 
				{
					return new ResponseEntity<List<ManifestModel>> (manifestModel, HttpStatus.OK);	
				}	
			}
			catch(Exception exception)
			{
				loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
				return new ResponseEntity<List<ManifestModel>> (HttpStatus.UNPROCESSABLE_ENTITY);
			}
		}
		//----------------------To get all inward manifest list function End--------------------	
	
	
	
	
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
		public ResponseEntity<List<ManifestModel>> manifestFilterbycondition(@RequestBody String manifest,HttpServletRequest request) throws JsonProcessingException, IOException 
		{
			HttpSession session = request.getSession();
			UserInformation userinfo = new UserInformation(request);
			String username = userinfo.getUserName();
			String userid = userinfo.getUserId();
			
			 ObjectMapper mapper = new ObjectMapper();
			 mapper.configure(Feature.AUTO_CLOSE_SOURCE, true);
			 JsonNode rootNode =mapper.readTree(manifest);
			 JsonNode frombranch = rootNode.path("frombranch");
			 JsonNode tobranch = rootNode.path("tobranch");
			 JsonNode fromdat = rootNode.path("fromdate");
			 JsonNode todat = rootNode.path("todate");
			 int frombranchid=frombranch.asInt();
			 int tobranchid=tobranch.asInt();
			 String fromdate=fromdat.asText();
			 String todate=todat.asText();
			 		
			try 
			{
				loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
				List<ManifestModel> manifestModel = manifestDao.getManifestByCondition(frombranchid,tobranchid,fromdate,todate);
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

		//--------------------Manifest Filter by condition End------------------------------
	
	//----------------------Manifest number search function start---------------------------------

		@RequestMapping(value="manifest_search", method=RequestMethod.POST)
		public ResponseEntity<List<ManifestModel>>manifestSearch(@RequestBody String searchkey,HttpServletRequest request)
		{
			List<ManifestModel> manifestModel=manifestDao.manifestSearch(searchkey);
			return new ResponseEntity<List<ManifestModel>> (manifestModel,HttpStatus.OK);
		}
	//----------------------Manifest number search function End---------------------------------
		
	//--------------------------------------Manifest print Start------------------------------------------
		@RequestMapping(value="/manifest_print", method=RequestMethod.POST)
		public ModelAndView manifestPrint(@RequestParam("manifest") String manifest, HttpServletRequest request)throws JsonProcessingException,IOException
		{
			JSONArray jsonArray=new JSONArray(manifest);
			String[] manifestid=new String[jsonArray.length()];
			for(int i=0;i<jsonArray.length();i++)
			{
				JSONObject jsonObject=jsonArray.getJSONObject(i);
				manifestid[i]=Integer.toString(jsonObject.getInt("manifest_id"));
			}
			
			List<ManifestModel> listManifest=new ArrayList<ManifestModel>();
			for(int i=0;i<manifestid.length;i++)
			{
				ManifestModel manifestModel=manifestDao.getManifestbyId(Integer.parseInt(manifestid[i]));
				listManifest.add(manifestModel);
			}
			Company company=companySettingDAO.getById(1);
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
			
			model.addObject("title","Manifest");
			model.addObject("company",company);
			model.addObject("listManifest",listManifest);
			model.addObject("image",base64DataString);
			return model;
		}
		
//------------------------------------------------------------------------------------------------
		
//------------------------------------Manifest delete function Start-------------------------------------
		
		@RequestMapping(value="delete_manifest/{id}", method=RequestMethod.DELETE)
		public ResponseEntity<ManifestModel>deleteManifest(@PathVariable("id") int[] id, HttpServletRequest request)
		{
			
			try
			{
				userInformation=new UserInformation(request);
			
			String username=userInformation.getUserName();
			int user_id=Integer.parseInt(userInformation.getUserId());
			int i=0;
			Date date=new Date();
			DateFormat dateformat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			for( i=0; i<id.length;i++)
			{
				System.out.print(" UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU  Delete id value : "+ id[i]);
				ManifestModel manifestModel=manifestDao.getManifestbyId(id[i]);
				manifestModel.setUpdated_by(user_id);
				manifestModel.setUpdated_datetime(dateformat.format(date));
				manifestModel.setObsolete("Y");
				manifestDao.saveOrUpdate(manifestModel);
			}
			return new ResponseEntity<ManifestModel>(HttpStatus.INTERNAL_SERVER_ERROR);
			}
			catch(Exception exception) 
			{
				return new ResponseEntity<ManifestModel>(HttpStatus.INTERNAL_SERVER_ERROR);
			}
		}
	//----------------------------------------------------------------------------------------------------------------------
		
	//==========================================Manifest Detailed Controller START==============================================================
		
	//------------------------------To get Manifest detailed data--------------------------------------
	
		@RequestMapping(value="manifest_detailed", method=RequestMethod.POST)
		public ResponseEntity<List<ManifestDetailedModel>>fetchAllDetailedManifest(@RequestBody int id,HttpServletRequest request)
		{
			userInformation = new UserInformation(request);
			String username = userInformation.getUserName();
			System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"+id);
			//String branch_id = userInformation.getUserBranchId();
//			try
//			{
				loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
				List<ManifestDetailedModel> manifestDetailedModel = manifestDao.getAllManifestDetailes(id);
				
				if(manifestDetailedModel.isEmpty()) 
				{
					return new ResponseEntity<List<ManifestDetailedModel>> (HttpStatus.NO_CONTENT);
				}
				else 
				{
					return new ResponseEntity<List<ManifestDetailedModel>> (manifestDetailedModel, HttpStatus.OK);	
				}			
//			} 
//			catch (Exception exception) 
//			{			
//				loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
//				return new ResponseEntity<List<ManifestDetailedModel>> (HttpStatus.UNPROCESSABLE_ENTITY);
//			}
		}
	//---------------------------------------------------------------------------------------------------
		
	//-----------------------------to display Detailed Manifest Screen---------------------------------------
		
		@RequestMapping(value =  "detailed_manifest", method = RequestMethod.GET)
		public ModelAndView detailed_manifest(@RequestParam(value="id", required = false) int id,HttpServletRequest request) throws Exception 
		{
			HttpSession session = request.getSession();
			UserInformation userinfo = new UserInformation(request);
			String username = userinfo.getUserName();
			String userid = userinfo.getUserId();
			
			session.setAttribute("username", username);
			session.setAttribute("userid", userid);
			int manifest_id=id;
			ModelAndView model = new ModelAndView();
			try
			{
				loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
				model.addObject("title", "View Manifest");
				model.addObject("m_id",manifest_id);
				model.addObject("message", "This page is for ROLE_ADMIN only!");
				model.setViewName("Manifest/view_detailed_manifest");
			} 
			catch (Exception exception) 
			{
				loggerconf.saveLogger(username,  "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
			}
			return model;
		}
	//--------------------------------------------------------------------------------------------------------------
		
		
	//=====================================================================================================================================
}