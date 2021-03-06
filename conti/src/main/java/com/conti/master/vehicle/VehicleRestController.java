package com.conti.master.vehicle;


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

import org.apache.commons.codec.binary.Base64;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.JsonMappingException;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
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
import org.springframework.web.util.UriComponentsBuilder;

import com.conti.config.SessionListener;
import com.conti.manifest.ManifestDao;
import com.conti.manifest.ManifestModel;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;
import com.conti.settings.company.Company;
import com.conti.settings.company.CompanySettingDAO;
@RestController
public class VehicleRestController {
	

	@Autowired
	private VehicleDao vehicleDao;
	@Autowired
	private CompanySettingDAO companySettingDAO;
	@Autowired
	private ManifestDao mDao;
	
	Loggerconf loggerconf = new Loggerconf();
	ConstantValues constantVal = new ConstantValues();
	SessionListener sessionListener = new SessionListener();
	UserInformation userInformation;
	
	//======================================sort by==========================================
		@RequestMapping(value="sortByVehicle/{name}",method=RequestMethod.POST,produces=MediaType.APPLICATION_JSON_VALUE)
		public  ResponseEntity<List<VehicleMaster>>  sortByLocation(@RequestBody String status,@PathVariable("name") String name,HttpServletRequest request){
			String sortBy="";
			
			switch(name.trim()){
			case "vehicleRegNo":
				 sortBy="vehicle_regno";
				break;
			case "vehicleCode":
				 sortBy="vehicle_code";
				break;
			case "branchName":
				 sortBy="branchModel.branch_name";
				break;
			case "vehicleModelNo":
				 sortBy="vehicle_modelno";
				break;
			case "vehicleType":
				 sortBy="vehicle_type";
				break;
			case "vehicleStatus":
				 sortBy="active";
				break;
			default:
				break;
			}
			List<VehicleMaster> vehicles ;
			try {
				vehicles = vehicleDao.getVehicleSorting100(sortBy.trim(),status.trim().equals("ASC")?"ASC":"DESC");
				loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
				if(vehicles.isEmpty()) {
					return new ResponseEntity<List<VehicleMaster>> (HttpStatus.NO_CONTENT);
				} else {
					return new ResponseEntity<List<VehicleMaster>> (vehicles, HttpStatus.OK);	
				}			
			} catch (Exception exception) {			
				loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
				return new ResponseEntity<List<VehicleMaster>> (HttpStatus.UNPROCESSABLE_ENTITY);
			}
		}
		
	@RequestMapping(value = "checkVehicleRegNo",method=RequestMethod.POST,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Void> checkVehicleRegNo(@RequestBody String regno,HttpServletRequest request) {
		String status = vehicleDao.checkVehicleRegno(regno.trim());
		
		if(status == "AVAILABLE") {
			return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
		} else {
			return new ResponseEntity<Void>(HttpStatus.OK);
		}
		
		
	}
	
	
	@RequestMapping( value = "/vehicles/", method = RequestMethod.GET)
	public ResponseEntity<List<VehicleMaster>> fetchAllVehicles(HttpServletRequest request) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		
		try {
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			List<VehicleMaster> vehicles = vehicleDao.getVehicleBy100();
			if(vehicles.isEmpty()) {
				return new ResponseEntity<List<VehicleMaster>> (HttpStatus.NO_CONTENT);
			} else {
				return new ResponseEntity<List<VehicleMaster>> (vehicles, HttpStatus.OK);	
			}			
		} catch (Exception exception) {			
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<List<VehicleMaster>> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
			/*return new ResponseEntity<List<VehicleMaster>> (vehicles, HttpStatus.OK);*/	
	}

	
	@RequestMapping( value = "/create_vehicle", method = RequestMethod.POST)
	public ResponseEntity<Void> createVehicle(@RequestBody VehicleMaster vehicle, UriComponentsBuilder ucBuilder, HttpServletRequest request) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		int user_id = Integer.parseInt(userInformation.getUserId());
				
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		
		try {
			vehicle.setObsolete("N");
			vehicle.setActive("Y");
			vehicle.setCreated_by(user_id);
			vehicle.setUpdated_by(user_id);	
			vehicle.setCreated_datetime(dateFormat.format(date).toString());
			vehicle.setUpdated_datetime(dateFormat.format(date).toString());
		
			vehicleDao.saveOrUpdate(vehicle);	
			
			HttpHeaders headers = new HttpHeaders();

	        loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
			return new ResponseEntity<Void> (headers, HttpStatus.CREATED);
			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, exception);
			return new ResponseEntity<Void> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}
	
	//================= Update a Vehicle Function Begins ================//
	
	@RequestMapping(value = "update_vehicle/{id}", method = RequestMethod.PUT)
	public ResponseEntity<VehicleMaster> updateVehicle(@PathVariable("id") int id, @RequestBody VehicleMaster vehicleModel, HttpServletRequest request) {
		VehicleMaster vehicleModelDB = vehicleDao.getVehiclebyId(id);
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		int user_id = Integer.parseInt(userInformation.getUserId());
		
		try{
			if(vehicleModelDB == null) {
				loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, null);
				return new ResponseEntity<VehicleMaster> (HttpStatus.NOT_FOUND);
			} else {
				
				Date date = new Date();
				DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
				
				vehicleModel.setUpdated_by(user_id);
				vehicleModel.setUpdated_datetime(dateFormat.format(date));
				
				vehicleDao.saveOrUpdate(vehicleModel);
				loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_SUCCESS,null);
				return new ResponseEntity<VehicleMaster> (vehicleModel,HttpStatus.OK);
			}
		 
		} catch (Exception exception) {
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, exception);
			return new ResponseEntity<VehicleMaster> (HttpStatus.INTERNAL_SERVER_ERROR);
		
		}				
	}
//================= Update a Vehicle Function End ====================//
	

//================= Delete Vehicle Function Begin ======================//
	
	@RequestMapping(value = "delete_vehicle/{id}", method = RequestMethod.DELETE)
	public ResponseEntity<String> deleteVehicle(@PathVariable ("id") int id, HttpServletRequest request) {
		VehicleMaster vehicleModel = vehicleDao.getVehiclebyId(id);
		ManifestModel manifestModel = mDao.getVehicleId(id);
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		int user_id = Integer.parseInt(userInformation.getUserId());
		try {
			  
				 if(vehicleModel == null) {
					 loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.DELETE_NOT_SUCCESS, null);
					 return new ResponseEntity<String> (HttpStatus.NOT_FOUND);
	            } else {
	            	
	            	if(manifestModel == null ) {
	            		Date date = new Date();
		            	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		            	
		            	vehicleModel.setUpdated_by(user_id);
		            	vehicleModel.setUpdated_datetime(dateFormat.format(date));
		            	vehicleModel.setActive("N");
		            	vehicleModel.setObsolete("Y");
		            	
		            	
		                vehicleDao.saveOrUpdate(vehicleModel);
		            	loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.DELETE_SUCCESS, null);
		            	return new ResponseEntity<String> (HttpStatus.OK);
	            	} else {
	            		loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.DELETE_NOT_SUCCESS, null);
	            		 return new ResponseEntity<String> ("already referred manifest",HttpStatus.IM_USED);	
	            	}
	            	
	            	
	            }
		     } catch (Exception exception) {
		    	 loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.DELETE_NOT_SUCCESS, exception);
		    	 return new ResponseEntity<String> (HttpStatus.INTERNAL_SERVER_ERROR);	
		    	
		     }
		}
	
//================= Delete Vehicle Function End ========================//
	
//==================== Active Vehicle Function Begin ================//

	@RequestMapping(value = "makevehicleactive", method = RequestMethod.POST)
	public ResponseEntity<Void> make_vehicleactive(@RequestBody int[] id, HttpServletRequest request) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		int user_id = Integer.parseInt(userInformation.getUserId());
		
		int active_flag = 0 ;
		try {
			for(int i=0; i<id.length; i++) {
				VehicleMaster vehicleModelDB = vehicleDao.getVehiclebyId(id[i]);
				
				if(vehicleModelDB == null) {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, null);
					active_flag = 1;
				} else {
					
					Date date = new Date();
					DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					
					vehicleModelDB.setActive("Y");
					vehicleModelDB.setUpdated_by(user_id);
					vehicleModelDB.setUpdated_datetime(dateFormat.format(date));
					
					vehicleDao.saveOrUpdate(vehicleModelDB);
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
				}
			}
			
			if(active_flag ==1) {
				return new ResponseEntity<Void> (HttpStatus.NOT_FOUND);
			} else {
				return new ResponseEntity<Void> (HttpStatus.OK);
			}
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, exception);
			return new ResponseEntity<Void> (HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
	}
//==================== Active Vehicle Function End ==================//

  //=============== InActive Vehicle Function Begin ==================//
 
		@RequestMapping(value = "make_vehicleinactive", method=RequestMethod.POST)
		public ResponseEntity<Void> make_vehicleinactive(@RequestBody int[] id, HttpServletRequest request) {
			userInformation = new UserInformation(request);
			String username = userInformation.getUserName();
			int user_id = Integer.parseInt(userInformation.getUserId());
			
			int active_flag = 0 ;
			try {
				for(int i=0; i<id.length; i++) {
					VehicleMaster vehicleModelDB = vehicleDao.getVehiclebyId(id[i]);
					
					if(vehicleModelDB == null) {
						loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, null);
						active_flag = 1;
					} else {
						
						Date date = new Date();
						DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						
						vehicleModelDB.setActive("N");
						vehicleModelDB.setUpdated_by(user_id);
						vehicleModelDB.setUpdated_datetime(dateFormat.format(date));
						
						vehicleDao.saveOrUpdate(vehicleModelDB);
						loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
						
					}
				}
				if( active_flag ==1) {
					return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
				} else {
					return new ResponseEntity<Void> (HttpStatus.OK);
				}
			} catch (Exception exception) {
				loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, exception);
				return new ResponseEntity<Void> (HttpStatus.INTERNAL_SERVER_ERROR);
			}
			
		}
//================ Inactive Vehicle Function End ====================//
	
//================== Excel Begin ===========================//
		
		@RequestMapping(value = "downloadExcelVehicle",method= RequestMethod.GET)
		public ModelAndView downloadExcelVehicle() {
			
			List<VehicleMaster> vehicleList = vehicleDao.getAllVehicles();
			return new ModelAndView("vehicleExcelView", "vehicleList", vehicleList);
			
		}
		
//================== Excel End =============================//
		
	//================ Print Begin ========================//
		
		@RequestMapping(value = "/vehicle_print", method = RequestMethod.POST)
		public ModelAndView vehiclePrint(@RequestParam("vehicle") String vehicle,HttpServletRequest request) throws JsonProcessingException, IOException {
			
			JSONArray jsonArray = new JSONArray(vehicle);
			String[] vehicleid = new String[jsonArray.length()];
			for(int i=0; i<jsonArray.length();i++){
				JSONObject jsonObject = jsonArray.getJSONObject(i);
				vehicleid[i] = Integer.toString(jsonObject.getInt("vehicle_id"));
				
			}
			
			List<VehicleMaster> listVehicle = new ArrayList<VehicleMaster> ();
			for(int i=0;i<vehicleid.length;i++) {
				VehicleMaster vehicleModel = vehicleDao.getVehiclebyId(Integer.parseInt(vehicleid[i]));
				listVehicle.add(vehicleModel);	
			}
			
			Company company = companySettingDAO.getById(1);
			ModelAndView model = new ModelAndView("print/vehicle_print");
			
			String base64DataString = "";
			if(company!=null && company.getCompany_logo()!= null) {
				byte[] encodeBase64 = Base64.encodeBase64(company.getCompany_logo());
				try {
					base64DataString = new String(encodeBase64 , "UTF-8");
				} catch (UnsupportedEncodingException e) {
					
					loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), "Image support error", e);
				}
			} else {
				base64DataString = ConstantValues.NO_IMAGE;	
			}
			
			model.addObject("title", "Vehicle");
			model.addObject("company", company);
			model.addObject("listVehicle", listVehicle);
			model.addObject("image", base64DataString);
			return model;
			
		}
		
		
	//=============== Print Begin =========================//
		
	//================== Vehicle Register Function Begin ==========//
		
		@RequestMapping(value = "vehicle_registersearch", method=RequestMethod.POST)
		public ResponseEntity<List<VehicleMaster>> vehicle_registersearch(@RequestBody String search_key, HttpServletRequest request) {
			
			List<VehicleMaster> vehicleList =  vehicleDao.searchbyVehicle(search_key);
			return new ResponseEntity<List<VehicleMaster>> (vehicleList, HttpStatus.OK);
		}
		
    //================== Vehicle Register Function Begin ==========//
	
		//=================== Pagination Function Begin ==============//
	
		@RequestMapping(value = "vehicle_pagination", method=RequestMethod.POST)
		public ResponseEntity<List<VehicleMaster>> vehicle_pagination(@RequestBody int page, HttpServletRequest request) {
			
			userInformation = new UserInformation(request);
			
		
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
			
			List<VehicleMaster> vehicList = vehicleDao.getVehicleswithLimit(from_limit, to_limit, order);
			return new ResponseEntity <List<VehicleMaster>> (vehicList, HttpStatus.OK);
		}
		
		//=================== Pagination Function End ================//
		
		@RequestMapping(value = "vehicleType/{str}", method = RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
		public ResponseEntity<Map<String,List<VehicleMaster>>> fetchAllVehicletype(HttpServletRequest request,
				@PathVariable("str") String searchStr) throws JsonGenerationException, JsonMappingException, JSONException, IOException  {
				
					
			   List <VehicleMaster> vehicletype = vehicleDao.searchforVehicleType(searchStr);
			
			    Map result = new HashMap();		
				result.put("VehicleType", vehicletype);
				
				
				System.err.println("@@$$WWWW$"+ searchStr);
				return new ResponseEntity<Map<String,List<VehicleMaster>>> (result,HttpStatus.OK);
				
			
		}
		
		//========================= Get Record Count Begin ==========//
			@RequestMapping(value = "/vehiclerecordcount/", method = RequestMethod.GET)
			public ResponseEntity <String> vehiclerecordcount(HttpServletRequest request) {
				try {
					return new ResponseEntity<String> (String.valueOf(vehicleDao.vehicleSettingCount()),HttpStatus.OK);
					
				} catch (Exception exception) {
					loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
					return new ResponseEntity<String> (HttpStatus.UNPROCESSABLE_ENTITY);
				}
				
				
			}
		
		//========================= Get Record Count End =============//
		
}
