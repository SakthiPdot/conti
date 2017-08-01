package com.conti.master.branch;


import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.JsonMappingException;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpHeaders;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriComponentsBuilder;

import com.conti.config.SessionListener;
import com.conti.master.customer.CustomerModel;
import com.conti.master.employee.EmployeeMaster;
import com.conti.master.location.Location;
import com.conti.master.location.LocationDao;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;
import com.conti.setting.usercontrol.RoleDao;
import com.conti.setting.usercontrol.User;
import com.conti.setting.usercontrol.UsersDao;
import com.conti.settings.company.Company;
import com.conti.settings.company.CompanySettingDAO;

/**
 * @Project_Name conti
 * @Package_Name com.conti.master.branch
 * @File_name BranchController.java
 * @author Sakthi
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 20, 2017 2:21:39 PM
 */

@RestController
public class BranchRestController {

	final Logger logger = LoggerFactory.getLogger(BranchRestController.class);

	@Autowired
	private UsersDao usersDao;
	@Autowired
	private BranchDao branchDao;
		
	@Autowired
	private CompanySettingDAO companySettingDAO;
	
	@Autowired
	private LocationDao locationDao;
	
	@Autowired
	@Qualifier("sessionRegistry")
	private SessionRegistry sessionRegistry;
		
	Loggerconf loggerconf = new Loggerconf();
	ConstantValues constantVal = new ConstantValues();
	SessionListener sessionListener = new SessionListener();
	UserInformation userInformation;

	
	
	@RequestMapping( value = "/branches", method = RequestMethod.GET)
	public ResponseEntity<List<BranchModel>> fetchAllBranches(HttpServletRequest request) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		String branch_id = userInformation.getUserBranchId();
		try {
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			//List<BranchModel> branches = branchDao.getBranchesbyid(Integer.parseInt(branch_id));
			List<BranchModel> branches = branchDao.getBranches();
			if(branches.isEmpty()) {
				return new ResponseEntity<List<BranchModel>> (HttpStatus.NO_CONTENT);
			} else {
				return new ResponseEntity<List<BranchModel>> (branches, HttpStatus.OK);	
			}			
		} catch (Exception exception) {			
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<List<BranchModel>> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}
	
	
	//=================CHECK PRODUCT NAME=====================================
		@RequestMapping(value="checkBranchName",method=RequestMethod.POST,produces=MediaType.APPLICATION_JSON_VALUE)
		public ResponseEntity<Void> checkBranchName(@RequestBody String name,HttpServletRequest request){		 
			String status=branchDao.checkBranchName(name.trim());
			if(status=="AVAILABLE"){
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);			
			}else{
				return	new ResponseEntity<Void>(HttpStatus.OK);
			}			
		}
	
	@RequestMapping(value =  "branch", method = RequestMethod.GET)
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
			
			model.addObject("title", "Branch Master");
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.setViewName("Masters/branch");

			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;

	}
	
	
	
	@RequestMapping( value = "/branches/branch/{id}", method = RequestMethod.GET)
	public ResponseEntity<List<BranchModel>> fetchBranches(@PathVariable ("id") int id,  HttpServletRequest request) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();

		try {
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			List<BranchModel> branches = branchDao.getBranches();
			if(branches.isEmpty()) {
				return new ResponseEntity<List<BranchModel>> (HttpStatus.NO_CONTENT);
			} else {
				return new ResponseEntity<List<BranchModel>> (branches, HttpStatus.OK);	
			}			
		}
		catch (Exception exception) 
		{			
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<List<BranchModel>> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}	
	
	
	

	//-------Create Branch begin---------------------
	 
	@RequestMapping(value="/create_branch", method=RequestMethod.POST)
	public ResponseEntity<Void> createBranch(@RequestBody BranchModel branchModel,UriComponentsBuilder ucBuilder, HttpServletRequest request)
	{
		userInformation=new UserInformation(request);
		String username=userInformation.getUserName();
		int user_id=Integer.parseInt(userInformation.getUserId());
		String lr_prefix,receipt_prefix;
		DateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date=new Date();
		try
		{
			lr_prefix="L"+branchModel.getLrno_prefix();
			receipt_prefix="R"+branchModel.getReceiptno_prefix();
			branchModel.setLrno_prefix(lr_prefix);
			branchModel.setReceiptno_prefix(receipt_prefix);
			branchModel.setObsolete("N");
			branchModel.setActive("Y");
			branchModel.setCreated_by(user_id);
			branchModel.setUpdated_by(user_id);
			branchModel.setCreated_datetime(dateFormat.format(date).toString());
			branchModel.setUpdated_datetime(dateFormat.format(date).toString());
			branchDao.saveOrUpdate(branchModel);
			HttpHeaders headers=new HttpHeaders();
			System.out.println("********************************************************");
			headers.setLocation(ucBuilder.path("/branches/{id}").buildAndExpand(branchModel.getBranch_id()).toUri());
			System.out.println("********************************************************");
			loggerconf.saveLogger(username,request.getServletPath(), ConstantValues.SAVE_SUCCESS,null);
			
			System.out.println("********************************************************");
			return new ResponseEntity<Void>(HttpStatus.CREATED);
		}
		catch(Exception exception)
		{
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, exception);
			return new ResponseEntity<Void>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	/* ------------------------- Update Branch begin ------------------------------------- */
//	@RequestMapping( value = "/update_branch/{id}", method = RequestMethod.PUT)
//	public ResponseEntity<BranchModel> updateBranch(@PathVariable ("id") int id, @RequestBody BranchModel branchModel,  HttpServletRequest request) 
//	{
//		BranchModel branchModeldb=branchDao.getBranchbyId(id);
//		userInformation = new UserInformation(request);
//		String username = userInformation.getUserName();
//		int user_id = Integer.parseInt(userInformation.getUserId());
//		try
//		{
//			if(branchModeldb==null)
//			{
//				loggerconf.saveLogger(username,request.getServletPath(),ConstantValues.SAVE_NOT_SUCCESS,null);
//				return new ResponseEntity<BranchModel>(HttpStatus.NOT_FOUND);
//			}
//			else
//			{
//				DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//				Date date = new Date();
//				branchModeldb.setUpdated_by(user_id);
//				branchModeldb.setUpdated_datetime(dateFormat.format(date).toString());
//				
//				branchDao.saveOrUpdate(branchModel);		
//				loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
//				return new ResponseEntity<BranchModel> (branchModel, HttpStatus.CREATED);
//			}
//		}
//		catch (Exception exception)
//		{
//			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, exception);
//			return new ResponseEntity<BranchModel> (HttpStatus.UNPROCESSABLE_ENTITY);
//		}
//		
//	}
	/* ------------------------- Update Branches end ------------------------------------- */
	
	
	/* ------------------------- Update Branch begin ------------------------------------- */
	@RequestMapping( value = "/update_branch", method = RequestMethod.POST)
	public ResponseEntity<BranchModel> updateBranch(@RequestBody BranchModel branchModel,  HttpServletRequest request) 
	{
		
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		int user_id = Integer.parseInt(userInformation.getUserId());
		try
		{
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date = new Date();
			String lr_prefix,receipt_prefix;
			branchModel.setUpdated_by(user_id);
			branchModel.setUpdated_datetime(dateFormat.format(date).toString());
			lr_prefix="L"+branchModel.getLrno_prefix();
			receipt_prefix="R"+branchModel.getReceiptno_prefix();
			branchModel.setLrno_prefix(lr_prefix);
			branchModel.setReceiptno_prefix(receipt_prefix);
			branchDao.saveOrUpdate(branchModel);		
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
			return new ResponseEntity<BranchModel> (branchModel, HttpStatus.CREATED);
			
		}
		catch (Exception exception)
		{
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, exception);
			return new ResponseEntity<BranchModel> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}
	/* ------------------------- Update Branches end ------------------------------------- */
	
	
	/* ------------------------- Delete Branch begin ------------------------------------- */
	@RequestMapping(value = "delete_branch/{id}", method = RequestMethod.DELETE)
	public ResponseEntity<BranchModel> deleteBranch(@PathVariable ("id") int id, HttpServletRequest request) {
		BranchModel branchModel = branchDao.getBranchbyId(id);
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		int user_id = Integer.parseInt(userInformation.getUserId());
		try {
			
			if(branchModel == null) {
				loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.DELETE_NOT_SUCCESS, null);
				return new ResponseEntity<BranchModel>(HttpStatus.NOT_FOUND);
			} else {
				
				Date date = new Date();
				DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
				
				branchModel.setUpdated_by(user_id);
				branchModel.setUpdated_datetime(dateFormat.format(date));
				branchModel.setActive("N");
				branchModel.setObsolete("Y");
				
				branchDao.saveOrUpdate(branchModel);
				loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.DELETE_SUCCESS, null);
				return new ResponseEntity<BranchModel> (branchModel,HttpStatus.OK);
			}
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.DELETE_NOT_SUCCESS, exception);
			return new ResponseEntity<BranchModel> (HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	/* ------------------------- Delete Branch end ------------------------------------- */

	
	/* ------------------------- Make active in Branch begin ------------------------------------- */
	
	@RequestMapping(value = "/make_active_branch", method = RequestMethod.POST)
	public ResponseEntity<Void> make_active_branch(@RequestBody int[] id, HttpServletRequest request) 
	{
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		int user_id = Integer.parseInt(userInformation.getUserId());
		
		int active_flag = 0;
		try 
		{
			for(int i=0; i<id.length; i++) 
			{
				BranchModel branchModelDB = branchDao.getBranchbyId(id[i]);
				
				if(branchModelDB == null) 
				{
					loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, null);
					active_flag = 1;
				} 
				else 
				{
					Date date = new Date();
					DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
					
					branchModelDB.setActive("Y");
					branchModelDB.setUpdated_by(user_id);
					branchModelDB.setUpdated_datetime(dateFormat.format(date));
									
					branchDao.saveOrUpdate(branchModelDB);
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

	
	
	/* ------------------------- Make inactive in Branch begin ------------------------------------- */
	@RequestMapping(value = "make_inactive_branch", method = RequestMethod.POST)
	public ResponseEntity<Void> make_inactive_branch(@RequestBody int[] id, HttpServletRequest request) 
	{
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		int user_id = Integer.parseInt(userInformation.getUserId());
		
		int active_flag = 0;
		try {
			for(int i=0; i<id.length; i++) {
				BranchModel branchModelDB = branchDao.getBranchbyId(id[i]);
				
				if(branchModelDB == null) {
					loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, null);
					active_flag = 1;
					
				} else {
					
					Date date = new Date();
					DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
					
					branchModelDB.setActive("N");
					branchModelDB.setUpdated_by(user_id);
					branchModelDB.setUpdated_datetime(dateFormat.format(date));
									
					branchDao.saveOrUpdate(branchModelDB);
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

	
	/* ------------------------- Print in Branch begin ------------------------------------- */	
	@RequestMapping(value = "/branch_print", method = RequestMethod.POST)
	public ModelAndView farmPrint_branch(@RequestParam("branch") String branch, HttpServletRequest request) throws JsonProcessingException, IOException{

		JSONArray jsonArray = new JSONArray(branch);
		String[] branchid = new String[jsonArray.length()];
		for(int i=0; i <jsonArray.length();i++) {
			JSONObject jsonObject = jsonArray.getJSONObject(i);
			branchid[i] = Integer.toString(jsonObject.getInt("branch_id"));			
		}
		
		List<BranchModel> listBranch = new ArrayList<BranchModel> ();
		for(int i=0; i<branchid.length;i++)
		{
			BranchModel branchModel = branchDao.getBranchbyId(Integer.parseInt(branchid[i]));
			listBranch.add(branchModel);
		}
		Company company = companySettingDAO.getById(1);
		ModelAndView model = new ModelAndView("print/branch_print");

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
		
		model.addObject("title", "Branch");
		model.addObject("company", company);
		model.addObject("listBranch", listBranch);
		model.addObject("image",base64DataString);
			
		return model;
	}
	/* ------------------------- Print in Employee end ------------------------------------- */	
	

	//======================================Excel begin==========================================
		@RequestMapping(value="downloadExcelBranch",method=RequestMethod.GET)
		public ModelAndView downloadExcelBranch()
		{
		
			List<BranchModel> branchList=branchDao.getAllBranches();
			return new ModelAndView("branchExcelView","branchList",branchList);
		}	
		
		@RequestMapping(value = "register_search_branch", method=RequestMethod.POST)
		public ResponseEntity<List<BranchModel>> register_search_branch(@RequestBody String searchkey, HttpServletRequest request) {
			
			List<BranchModel> branchList = branchDao.searchbyeyBranch(searchkey);
			return new ResponseEntity<List<BranchModel>> (branchList, HttpStatus.OK);
		}
	//======================================Excel end==========================================
		
	//======================================Pagination begin==========================================
		
		@RequestMapping(value = "pagination_branch", method=RequestMethod.POST)
		public ResponseEntity<List<BranchModel>> pagination_branch(@RequestBody int page, HttpServletRequest request) {
			
			userInformation = new UserInformation(request);
			String branch_id = userInformation.getUserBranchId();
		
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
				to_limit =  (page + 1 ) * 100;
			}
			
			List<BranchModel> branchList = branchDao.getBrancheswithLimit(Integer.parseInt(branch_id), from_limit, to_limit, order);
			return new ResponseEntity<List<BranchModel>> (branchList, HttpStatus.OK);
		}
		
		
		
		
		
		/* ------------------------- Find record count begin ------------------------------------- */
		
		@RequestMapping(value = "/branch_record_count/", method = RequestMethod.GET)
		public ResponseEntity<String> branchrecordCount(HttpServletRequest request) 
		{
			String username = userInformation.getUserName();
			
			try {
				int userid = Integer.parseInt(userInformation.getUserId());	
				User user = usersDao.get(userid);
				List<User> userList = new ArrayList<User>();
				if( user.getRole().getRole_Name().equals(constantVal.ROLE_SADMIN) ) {
					String rec_count = Integer.toString(branchDao.find_record_countforSA());
					return new ResponseEntity<String> (rec_count, HttpStatus.OK);	
				} else {
					String rec_count = Integer.toString(branchDao.find_record_count());
					return new ResponseEntity<String> (rec_count, HttpStatus.OK);	
				}
				
			} catch (Exception exception) {
				loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
				return new ResponseEntity<String> (HttpStatus.UNPROCESSABLE_ENTITY);
			}
			
		}
		
		/* ------------------------- Find record count end ------------------------------------- */
		
		
	//======================================Pagination end==========================================
		
		
//		@RequestMapping(value="getLocations4Branch/{str}", method = RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
//		public ResponseEntity<Map<String,List<Location>>> fetchAllLocations4Branch(HttpServletRequest request,
//				@PathVariable("str") String searchStr) throws JsonGenerationException, JsonMappingException, JSONException, IOException {
//			
//			List<Location> locations = locationDao.searchbyeyLocationName(searchStr);
//
//			 Map result = new HashMap();
//			 result.put("Location", locations);
//			
//			System.err.println(searchStr+"464644");
//			return new ResponseEntity<Map<String,List<Location>>> (result,HttpStatus.OK);
//		}
		
}