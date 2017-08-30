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
import com.conti.master.branch.BranchModel;
import com.conti.master.customer.CustomerModel;
import com.conti.master.product.Product;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;
import com.conti.setting.usercontrol.UsersDao;
import com.conti.settings.company.Company;
import com.conti.settings.company.CompanySettingDAO;
import com.conti.shipment.add.ShipmentDao;
import com.conti.shipment.add.ShipmentModel;

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
	private ShipmentDao shipmentDao;
	
	@Autowired
	private CompanySettingDAO companySettingDAO;
		
	@Autowired
	@Qualifier("sessionRegistry")
	private SessionRegistry sessionRegistry;
		
	Loggerconf loggerconf = new Loggerconf();
	SessionListener sessionListener = new SessionListener();
	
	
	private ConstantValues constantValues;
	private UserInformation userInformation;

	
	
	
	
	//============================================= to display View Manifest Screen============================================
	
	@RequestMapping(value =  "view_manifest", method = RequestMethod.GET)
	public ModelAndView view_manifest(HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		
		UserInformation userinfo = new UserInformation(request);
		String username = userinfo.getUserName();
		String branch_id=userinfo.getUserBranchId();
		String userid = userinfo.getUserId();
		
		session.setAttribute("username", username);
		session.setAttribute("userid", userid);
		
		ModelAndView model = new ModelAndView();
		try
		{
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			
			model.addObject("title", "View Manifest");
			model.addObject("branch_id", branch_id);
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.setViewName("Manifest/view_manifest");
		} 
		catch (Exception exception) 
		{
			loggerconf.saveLogger(username,  "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;
	}
	//------------------------------------------------------------------------------------------------------------------------	
  
	//----------------------------------- TO get all manifest  list function start ----------------------------------------\\
	
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
	//-------------------------------------------------------------------------------------------------------------------\\
	
	
	//----------------------------------To get all inward manifest list function start--------------------------------\\
	
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
	//-----------------------------------------------------------------------------------------------------------------	//
	
	//-----------------------------To get all inward manifest list function start-------------------------------------
	
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
	//----------------------------------------------------------------------------------------------------------	
	
	
	
	
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
			model.addObject("listManifest", listManifest);
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
			
			 JSONObject obj=new JSONObject(manifest);
			 
			 String frombranch=String.valueOf(obj.get("frombranch"));
			 String tobranch=String.valueOf(obj.get("tobranch"));
					 
			 String fromdate=(String) obj.get("fromdate");
			 String todate=(String) obj.get("todate");
			try 
			{
				loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
				List<ManifestModel> manifestModel = manifestDao.getManifestByCondition(frombranch,tobranch,fromdate,todate);
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

	//-----------------------------------------------------------------------------------------------------------------
	
	//-----------------------------------------Manifest number search function start---------------------------------

		@RequestMapping(value="manifest_search", method=RequestMethod.POST)
		public ResponseEntity<List<ManifestModel>>manifestSearch(@RequestBody String search,HttpServletRequest request)
		{
			JSONObject obj=new JSONObject(search);
			 List<ManifestModel> manifestList=new ArrayList<ManifestModel>();
			 String searchkey=(String) obj.get("manifest_regSearch");
			 String searchby=(String) obj.get("searchBy");
			 String manifest= ConstantValues.MANIFIEST_NUMBER;
			 if(searchby.equals(manifest))
			 {
				 List<ManifestModel> manifestModel=manifestDao.manifestSearch(searchkey);
				 return new ResponseEntity<List<ManifestModel>> (manifestModel,HttpStatus.OK);
			 }
			 else //if(searchkey.length()>3)
			 {
					List<Integer> manifestDetailed=manifestDao.searchShipmentLRnumber(searchkey);
				 	System.out.println("========================================== : "+manifestDetailed.size());
					if(manifestDetailed!=null)
					{
						for(int i=0; i<manifestDetailed.size();i++)
						{
							String manifest_id=manifestDetailed.get(i).toString();
							System.out.println("=====================================================================: "+manifest_id);
							ManifestModel manifestModel=manifestDao.getManifestbyId(Integer.parseInt(manifest_id));
							manifestList.add(i, manifestModel);
						}
						return new ResponseEntity<List<ManifestModel>> (manifestList,HttpStatus.OK);
					}
					
			 }
			 return new ResponseEntity<List<ManifestModel>> (HttpStatus.NO_CONTENT);
		}
	//-----------------------------------------Manifest Register search function start---------------------------------

		@RequestMapping(value="manifest_register_search", method=RequestMethod.POST)
		public ResponseEntity<List<ManifestDetailedModel>>manifest_register_search(@RequestBody String search,HttpServletRequest request)
		{
			List<ManifestDetailedModel> manifestDetailtedList=manifestDao.searchLRnumber(search);
			return new ResponseEntity<List<ManifestDetailedModel>> (manifestDetailtedList,HttpStatus.OK);
		}
		
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
					System.out.print(" Delete id value : "+ id[i]);
					ManifestModel manifestModel=manifestDao.getManifestbyId(id[i]);
					//List<ManifestDetailedModel> manifestDetailed=manifestDao.getAllManifestDetailes(id[i]);
					manifestModel.setUpdated_by(user_id);
					manifestModel.setUpdated_datetime(dateformat.format(date));
					manifestModel.setObsolete("Y");
					manifestDao.saveOrUpdate(manifestModel);
					
					int count=manifestModel.getManifestDetailModel().size();
					System.out.println("===============Manifest detailed countt==================:"+count);
					for(int k=0; k<count;k++)
					{
						int shipment_id=manifestModel.getManifestDetailModel().get(k).shipmentModel.getShipment_id();
						ShipmentModel shipmentModel=shipmentDao.getShipmentModelById(shipment_id);
						shipmentModel.setStatus("Booked");
						shipmentDao.saveOrUpdate(shipmentModel);
					}
				}
				return new ResponseEntity<ManifestModel>(HttpStatus.OK);
			}
			catch(Exception exception) 
			{
				return new ResponseEntity<ManifestModel>(HttpStatus.INTERNAL_SERVER_ERROR);
			}
		}
	//----------------------------------------------------------------------------------------------------------------------
	
		
	//---------------Sorting table function starting--------------------------
		
		@RequestMapping(value="sorting_table/{name}",method=RequestMethod.POST,produces=MediaType.APPLICATION_JSON_VALUE)
		public ResponseEntity<List<ManifestModel>>sortingTable(@RequestBody String status,@PathVariable("name") String name,HttpServletRequest request)
		{
			String sortBy="";
			switch(name.trim())
			{
				case "manifestNumber":
					sortBy="manifest_number";
					break;
				case "manifestOrigin":
					sortBy="manifest_origin";
					break;
				case "manifestDestination":
					sortBy="manifest_destination";
					break;
				case "manifestVehicle":
					sortBy="vehicle_number";
					break;
				case "manifestDriver":
					sortBy="driver_name";
					break;
				case "manifestStatus":
					sortBy="manifest_Status";
					break;
				case "manifestArticles":
					sortBy="manifestArticles";
					break;
			}
			
			List<ManifestModel> manifestModel;
			try
			{
				manifestModel=manifestDao.getManifestbySorting100(sortBy.trim(),status.trim().equals("ASC")?"ASC":"DESC");
				loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
				if(manifestModel.isEmpty())
				{
					return new ResponseEntity<List<ManifestModel>>(HttpStatus.OK);
				}
				return new ResponseEntity<List<ManifestModel>>(manifestModel,HttpStatus.OK);
			}
			catch(Exception e)
			{
				loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS , e);
				e.printStackTrace();
				return new ResponseEntity<List<ManifestModel>>(HttpStatus.INTERNAL_SERVER_ERROR);
			}
		}
		
	//==========================================Manifest Detailed Controller START==============================================================
		
	//------------------------------To get Manifest detailed data--------------------------------------
	
		@RequestMapping(value="manifest_detailed", method=RequestMethod.POST)
		public ResponseEntity<List<ManifestDetailedModel>>fetchAllDetailedManifest(@RequestBody int id,HttpServletRequest request)
		{
			userInformation = new UserInformation(request);
			String username = userInformation.getUserName();
			System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"+id);
			String branch_id = userInformation.getUserBranchId();
			int transitcount=0,receivedcount=0,missingcount=0;
			try
			{
				loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
				List<ManifestDetailedModel> manifestDetailedModel = manifestDao.getAllManifestDetailes(id);
				
				if(manifestDetailedModel.isEmpty()) 
				{
					return new ResponseEntity<List<ManifestDetailedModel>> (HttpStatus.NO_CONTENT);
				}
				else 
				{
					for(int i=0;i<manifestDetailedModel.size();i++){
						if(manifestDetailedModel.get(i).shipmentModel.getStatus().equals(ConstantValues.INTRANSIT)){
							transitcount=transitcount+1;
						}else if(manifestDetailedModel.get(i).shipmentModel.getStatus().equals(ConstantValues.RECEIVED)){
							receivedcount=receivedcount+1;
						}else{
							missingcount=missingcount+1;
						}
							
					}
					ManifestModel manifestModel=manifestDao.getManifestByID(id);
					if(manifestDetailedModel.size()==transitcount){
						manifestModel.setManifest_status(ConstantValues.INTRANSIT);
					}else if(manifestDetailedModel.size()==receivedcount){
						manifestModel.setManifest_status(ConstantValues.COMPLETED);
					}else{
						manifestModel.setManifest_status(ConstantValues.INCOMPLETE);
					}
					manifestDao.saveOrUpdate(manifestModel);
					return new ResponseEntity<List<ManifestDetailedModel>> (manifestDetailedModel, HttpStatus.OK);	
				}			
			} 
			catch (Exception exception) 
			{			
				loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
				return new ResponseEntity<List<ManifestDetailedModel>> (HttpStatus.UNPROCESSABLE_ENTITY);
			}
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
			ManifestModel manifestModel=manifestDao.getManifestbyId(manifest_id);
			ModelAndView model = new ModelAndView();
			try
			{
				loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
				model.addObject("title", "View Manifest");
				model.addObject("m_id",manifest_id);
				model.addObject("manifest_number",manifestModel.getManifest_prefix());
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
	
	//------------------------Make Missing function start------------------------------------
		@RequestMapping(value="make_Missing", method=RequestMethod.POST)
		public ResponseEntity<Void>make_missing(@RequestBody int[] id,HttpServletRequest request){
			userInformation = new UserInformation(request);
			String username = userInformation.getUserName();
			int user_id = Integer.parseInt(userInformation.getUserId());
			
			int active_flag = 0;
			try 
			{
				for(int i=0; i<id.length; i++) 
				{
					ManifestDetailedModel manifestDetailedModel = manifestDao.getAllManifestDetailesByid(id[i]);
					if(manifestDetailedModel == null) 
					{
						loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, null);
						active_flag = 1;
					} 
					else 
					{
						Date date = new Date();
						DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
						
						manifestDetailedModel.shipmentModel.setStatus("Missing");
						manifestDetailedModel.shipmentModel.setUpdated_by(user_id);
						manifestDetailedModel.shipmentModel.setUpdated_datetime(dateFormat.format(date));
										
						shipmentDao.saveOrUpdate(manifestDetailedModel.shipmentModel);
						loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
					}
				}
				
				if( active_flag == 1) {
					return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
				} else {
					return new ResponseEntity<Void> (HttpStatus.OK);
				}
			} catch (Exception exception) {
				loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, exception);
				return new ResponseEntity<Void> (HttpStatus.INTERNAL_SERVER_ERROR);
			}
		}
		/* ------------------------- Make active Branch end ------------------------------------- */
		
		//------------------------Make Missing function start------------------------------------
				@RequestMapping(value="make_Received", method=RequestMethod.POST)
				public ResponseEntity<Void>make_Received(@RequestBody int[] id,HttpServletRequest request){
					userInformation = new UserInformation(request);
					String username = userInformation.getUserName();
					int user_id = Integer.parseInt(userInformation.getUserId());
					
					int active_flag = 0;
					try{
						System.out.println("++++++++++++++++Received function call success ++++++++++++++++"+id.length);
						for(int i=0; i<id.length; i++){
							ManifestDetailedModel manifestDetailedModel = manifestDao.getAllManifestDetailesByid(id[i]);
							if(manifestDetailedModel == null){
								loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, null);
								active_flag = 1;
							}else{
								Date date = new Date();
								DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
								
								manifestDetailedModel.shipmentModel.setStatus("Received");
								manifestDetailedModel.shipmentModel.setUpdated_by(user_id);
								manifestDetailedModel.shipmentModel.setUpdated_datetime(dateFormat.format(date));
												
								shipmentDao.saveOrUpdate(manifestDetailedModel.shipmentModel);
								loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
							}
						}
						
						if( active_flag == 1) {
							return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
						} else {
							return new ResponseEntity<Void> (HttpStatus.OK);
						}
					} catch (Exception exception) {
						loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, exception);
						return new ResponseEntity<Void> (HttpStatus.INTERNAL_SERVER_ERROR);
					}
				}
				/* ------------------------- Make active Branch end ------------------------------------- */


		
	//=====================================================================================================================================
}