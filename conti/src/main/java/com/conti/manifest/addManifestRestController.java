package com.conti.manifest;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.conti.master.employee.EmployeeDao;
import com.conti.master.employee.EmployeeMaster;
import com.conti.master.vehicle.VehicleDao;
import com.conti.master.vehicle.VehicleMaster;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;
import com.conti.shipment.add.ShipmentDao;
import com.conti.shipment.add.ShipmentModel;

/**
 * @Project_Name conti
 * @Package_Name com.conti.manifest  com.conti.manifest
 * @File_name addManifestRestController.java com.conti.manifest
 * @author Monu.C
 * @Created_date_time Aug 8, 2017 3:19:48 PM
 */


@RestController
public class addManifestRestController {

	@Autowired
	private ManifestDao mDao;

	@Autowired
	private VehicleDao vehicleDao;
	
	@Autowired
	private ShipmentDao sDao;

	@Autowired
	private EmployeeDao employeeDao;

	
	Loggerconf loggerconf = new Loggerconf();
	
	
	
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
	
	//======================================search shipment  by lr==========================================
	@RequestMapping(value = "searchLRShipment", method=RequestMethod.POST)
	public ResponseEntity<List<ShipmentModel>> searchLRShipment(@RequestBody String searchString, HttpServletRequest request) {				
			List<ShipmentModel> shipmentList=sDao.fetchShipmentByLR(searchString);		
			return new ResponseEntity<List<ShipmentModel>> (shipmentList, HttpStatus.OK);		
	}
	
	//===========================To get all Employee name for Searching================================
	
	@RequestMapping(value="getEmployeeDriver4Search/{str}", method = RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Map<String,List<EmployeeMaster>>> getEmployeeDriver4Search(HttpServletRequest request,
			@PathVariable("str") String searchStr) throws JsonGenerationException, JsonMappingException, JSONException, IOException 
	{
		List<EmployeeMaster> employees = employeeDao.searchDriver(searchStr);
		Map result = new HashMap();	
		result.put("Employees",employees);
		return new ResponseEntity<Map<String,List<EmployeeMaster>>> (result,HttpStatus.OK);
	}
			
	//========================== fetch last manifest no==========================
	@RequestMapping(value="/fetchLastManifestNo/",method=RequestMethod.GET)
	public ResponseEntity<String> fetchLastManifestNo(HttpServletRequest request){		
		try {
			return new ResponseEntity<String>(String.valueOf(mDao.fetchLastManifestNo()),HttpStatus.OK);
		} catch (Exception e) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, e);
			return new ResponseEntity<String> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	
	//=================test==========================
	@RequestMapping(value ="fetchManifest",method=RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<ManifestModel> fetchManifest(){
	/*	ManifestModel manifest =new ManifestModel();
		manifest.setManifest_id(1);
		
		
		List<ManifestDetailedModel> detailedList=new ArrayList<ManifestDetailedModel>();
		ManifestDetailedModel det1=new ManifestDetailedModel();
		det1.setShipmentModel(new  ShipmentModel());
		det1.setManifestModel(new ManifestModel());
		detailedList.add(det1);
		
		
		manifest.setManifestDetailModel(detailedList);*/
		
		return new ResponseEntity<>(mDao.getManifestByID(1),HttpStatus.OK);
		
	}
	//=================== Pagination Function End ================//
	
	@RequestMapping(value = "vehicleRegNo/{str}", method = RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Map<String,List<VehicleMaster>>> vehicleRegNo(HttpServletRequest request,
			@PathVariable("str") String searchStr) throws JsonGenerationException, JsonMappingException, JSONException, IOException  {
			
				
		   List <VehicleMaster> vehicletype = vehicleDao.searchforVehicleRegNo(searchStr);
		
		    Map result = new HashMap();		
			result.put("VehicleType", vehicletype);
			
			
			System.err.println("@@$$WWWW$"+ searchStr);
			return new ResponseEntity<Map<String,List<VehicleMaster>>> (result,HttpStatus.OK);
			
		
	}

	//========================== save Manifest==========================
	@RequestMapping(value="manifestSave",method=RequestMethod.POST,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Void> manifestSave(HttpServletRequest request,@RequestBody ManifestModel manifest){

		System.out.println("++ inside manifest save");
		
		//intialize	
		String userid = request.getSession().getAttribute("userid").toString();		
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
		
		
		//set variable
		manifest.setCreated_by(Integer.parseInt(userid));
		manifest.setUpdated_by(Integer.parseInt(userid));
		manifest.setCreated_datetime(dateFormat.format(date));
		manifest.setUpdated_datetime(dateFormat.format(date));
		manifest.setObsolete("N");
		

		//set shipment and manifest status (Intransit) and set manifest id manually
		manifest.setManifest_status("Intransit");
		for(ManifestDetailedModel manifestDetailModel:manifest.getManifestDetailModel()){
			manifestDetailModel.setManifestModel(manifest);
			manifestDetailModel.getShipmentModel().setStatus("Intransit");
		}
		
		
		
		//generate manifest number
		
		try {
			mDao.saveOrUpdate(manifest);
			loggerconf.saveLogger(request.getUserPrincipal().getName(),request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
			return new ResponseEntity<Void>(HttpStatus.CREATED);
		} catch (Exception e) {
			e.printStackTrace();
			loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, e);
			return new ResponseEntity<Void> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}
	//========================== filter Shipment==========================
	@RequestMapping(value="/filterShipment/",method=RequestMethod.POST,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ShipmentModel>>  filterShipment(@RequestBody String filterValues,HttpServletRequest request){
		
		JSONObject filterValueObject=new JSONObject(filterValues);
		
		try
		{
			loggerconf.saveLogger(request.getUserPrincipal().getName(),request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			
			List<ShipmentModel> shipmentList=sDao.filterShipment(filterValueObject.get("fromBranch").toString(), filterValueObject.get("toBranch").toString(),
					filterValueObject.get("fromDate").toString(), filterValueObject.get("toDate").toString(), filterValueObject.get("status").toString());			
			
			return (shipmentList.isEmpty()) ? new ResponseEntity<List<ShipmentModel>> (HttpStatus.NO_CONTENT) :new ResponseEntity<List<ShipmentModel>> (shipmentList, HttpStatus.OK);
		
		}
		catch(Exception exception)
		{
			exception.printStackTrace();
			loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<List<ShipmentModel>> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}
}