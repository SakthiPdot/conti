/**
 * MC6
 * 
 */
package com.conti.setting.usercontrol;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.bind.DatatypeConverter;

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
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.conti.config.SessionListener;
import com.conti.hsn.Hsn;
import com.conti.hsn.HsnDao;
import com.conti.manifest.ManifestDao;
import com.conti.manifest.ManifestModel;
import com.conti.master.branch.BranchDao;
import com.conti.master.branch.BranchModel;
import com.conti.master.customer.CustomerDao;
import com.conti.master.customer.CustomerModel;
import com.conti.master.employee.EmployeeDao;
import com.conti.master.employee.EmployeeMaster;
import com.conti.master.location.Location;
import com.conti.master.location.LocationDao;
import com.conti.master.product.Product;
import com.conti.master.product.ProductDAO;
import com.conti.master.service.ServiceDao;
import com.conti.master.service.ServiceMaster;
import com.conti.master.vehicle.VehicleDao;
import com.conti.master.vehicle.VehicleMaster;
import com.conti.others.ConstantValues;
import com.conti.others.DateTimeCalculation;
import com.conti.others.Loggerconf;
import com.conti.others.SendMailSMS;
import com.conti.others.UserInformation;
import com.conti.receipt.ReceiptDao;
import com.conti.receipt.ReceiptModel;
import com.conti.settings.company.Company;
import com.conti.settings.company.CompanySettingDAO;
import com.conti.settings.price.PriceSetting;
import com.conti.settings.price.PriceSettingDao;
import com.conti.shipment.add.ShipmentDao;
import com.conti.shipment.add.ShipmentModel;
import com.conti.userlog.UserLogDao;
import com.conti.userlog.UserLogModel;



/**
 * @Project_Name conti
 * @Package_Name com.conti.setting.usercontrol
 * @File_name UserRestController.java
 * @author Sankar
 * @Created_date_time Jun 20, 2017 3:54:17 PM
 * @Updated_date_time Jun 20, 2017 3:54:17 PM
 */

@RestController
public class UserRestController {
	
	@Autowired
	private UsersDao usersDao;
	@Autowired
	private RoleDao roleDao;
	@Autowired
	private EmployeeDao employeeDao;
	@Autowired
	private SendMailSMS sendMailSMS;
	@Autowired
	private UserLogDao userLogDao;
	@Autowired
	private DateTimeCalculation datetimeCalculation;
	@Autowired
	private CompanySettingDAO companySettingDAO;
	@Autowired
	private UserPrivilegeDao userPrivilegeDao;
	@Autowired
	private RolePrivilegeDao rolePrivilegeDao;
	@Autowired
	private PriceSettingDao psDao;
	@Autowired
	private BranchDao branchDao;
	@Autowired
	private CustomerDao customerDao;
	@Autowired
	private LocationDao locationDao;
	@Autowired
	private ProductDAO productDao;
	@Autowired
	private ServiceDao serviceDao;
	@Autowired
	private VehicleDao vehicleDao;
	@Autowired 
	private HsnDao hsnDao;
	@Autowired
	private ManifestDao mDao;
	@Autowired
	private ReceiptDao receiptDao;
	@Autowired
	private ShipmentDao shipmentDao;
	
	Loggerconf loggerconf = new Loggerconf();
	ConstantValues constantVal = new ConstantValues();
	SessionListener sessionListener = new SessionListener();
	UserInformation userInformation;
	

	
	//======================================sort by==========================================
	@RequestMapping(value="sortByUser/{name}",method=RequestMethod.POST,produces=MediaType.APPLICATION_JSON_VALUE)
	public  ResponseEntity<List<User>>  sortByLocation(@RequestBody String status,@PathVariable("name") String name,HttpServletRequest request){
		int branch_id = Integer.parseInt(userInformation.getUserBranchId());
		int user_id = Integer.parseInt(userInformation.getUserId());
		String sortBy="";
		
		switch(name.trim()){
		case "empName":
			 sortBy="employeeMaster.emp_name";
			break;
		case "usrName":
			 sortBy="username";
			break;
		case "usrRole":
			 sortBy="role.role_Name";
			break;
		case "branchName":
			 sortBy="branchModel.branch_name";
			break;
		case "usrStatus":
			 sortBy="active";
			break;
		default:
			break;
		}
		
		List<User> userList=new ArrayList<>();
		try {
			User user = usersDao.get(user_id);
			if( user.getRole().getRole_Name().equals(constantVal.ROLE_SADMIN) ) {
				userList = usersDao.getLocationSorting1004SA(sortBy.trim(),status.trim().equals("ASC")?"ASC":"DESC");	
			} else {
				userList = usersDao.getLocationSorting100(sortBy.trim(),status.trim().equals("ASC")?"ASC":"DESC", branch_id);
			}
			
			if(userList.isEmpty()) {
				loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
				return new ResponseEntity<List<User>> (HttpStatus.NO_CONTENT);
			} else {
				loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
				return new ResponseEntity<List<User>> (userList, HttpStatus.OK);	
			}
		} catch (Exception e) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS,e);
			e.printStackTrace();
			return new ResponseEntity<List<User>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}	
		
	}
	
	
	/* ------------------------- User page begin-------------------------------- */
	@RequestMapping(value =  "user", method = RequestMethod.GET)
	public ModelAndView userPage(HttpServletRequest request) throws Exception {
		
		UserInformation userinfo = new UserInformation(request);
		String username = userinfo.getUserName();		
		String userid = userinfo.getUserId();
		String branch_id = userinfo.getUserBranchId();
		ModelAndView model = new ModelAndView();
		
		try
		{
			
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			
			model.addObject("title", "User Master");
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.setViewName("Settings/user_master");
			model.addObject("homePage",request.getContextPath());

			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;

	}
	/* ------------------------- User page end-------------------------------- */
	
	/* ------------------------- Retrieve all Users begin-------------------------------- */
	@RequestMapping( value = "/users/", method = RequestMethod.GET	)
	public ResponseEntity<List<User>> fetchAllUsers(HttpServletRequest request) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();		
		int userid = Integer.parseInt(userInformation.getUserId());
		int branch_id = Integer.parseInt(userInformation.getUserBranchId());
		
		try {
			
			
			User user = usersDao.get(userid);
			List<User> userList = new ArrayList<User>();
			if( user.getRole().getRole_Name().equals(constantVal.ROLE_SADMIN) ) {
				
				userList = usersDao.getUser100();
				if(userList.isEmpty()) {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
					return new ResponseEntity<List<User>> (HttpStatus.NO_CONTENT);
				} else {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
					return new ResponseEntity<List<User>> (userList, HttpStatus.OK);	
				}	
				
			} else {
				
				userList = usersDao.getUsersbyBranchIdwihoutSA(branch_id);
				if(userList.isEmpty()) {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
					return new ResponseEntity<List<User>> (HttpStatus.NO_CONTENT);
				} else {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
					return new ResponseEntity<List<User>> (userList, HttpStatus.OK);	
				}
			}
			
					
		} catch (Exception exception) {			
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<List<User>> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
				
	}
	/* ------------------------- Retrieve all Users end-------------------------------- */
	
	/* ------------------------- Retrieve single Users begin-------------------------------- */
	@RequestMapping( value = "/users/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<User> getUser(@PathVariable("id") int id, HttpServletRequest request) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		try {
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			User user = usersDao.get(id);
			if(user == null) {
				return new ResponseEntity<User> (HttpStatus.NO_CONTENT);
			} else {
				return new ResponseEntity<User> (user, HttpStatus.OK);
			}			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<User> (HttpStatus.UNPROCESSABLE_ENTITY);
		}		
	}
	/* ------------------------- Retrieve single Users end-------------------------------- */
	
	/* ------------------------- Create a User begin -------------------------------------  */
	@RequestMapping( value = "/create_user", method = RequestMethod.POST)
	public ResponseEntity<Void> createUser(@RequestBody User user, UriComponentsBuilder ucBuilder, HttpServletRequest request) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		int user_id = Integer.parseInt(userInformation.getUserId());
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		
		try {			
		
			BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
			String hashedPassword = passwordEncoder.encode(user.getUserpassword());
			user.setUserpassword(hashedPassword);
			user.setCompany_id(1);
			user.setCreated_datetime(dateFormat.format(date).toString());
			user.setUpdated_datetime(dateFormat.format(date).toString());
			user.setCreated_by(user_id);
			user.setUpdated_by(user_id);
			user.setObsolete("N");
			user.setActive("Y");
			usersDao.saveOrUpdate(user);	
			
			User userfor_privilege = usersDao.findByUserName(user.getUsername());
			
			List<RolePrivilege> rolePrivilegeList = rolePrivilegeDao.getRolePrivilegebyRoleId(user.role.getRole_Id());
			UserPrivilege userPrivilege = new UserPrivilege();
			
			
			for( RolePrivilege rolePrivileges : rolePrivilegeList ) {
				
				userPrivilege.setBranch(userfor_privilege.branchModel);
				userPrivilege.setUser(userfor_privilege);
				userPrivilege.setRole(userfor_privilege.role);
				userPrivilege.setActive("Y");
				userPrivilege.setObsolete("N");
				
				userPrivilege.setRole_menuname(rolePrivileges.getRole_menuname());
				userPrivilege.setRole_screenname(rolePrivileges.getRole_screenname());
				userPrivilege.setUserprivilege_add(rolePrivileges.getRole_add());
				userPrivilege.setUserprivilege_modify(rolePrivileges.getRole_modify());
				userPrivilege.setUserprivilege_delete(rolePrivileges.getRole_delete());
				userPrivilege.setUserprivilege_print(rolePrivileges.getRole_print());
				userPrivilege.setUserprivilege_view(rolePrivileges.getRole_view());
				userPrivilege.setCreated_datetime(dateFormat.format(date).toString());
				userPrivilege.setUpdated_datetime(dateFormat.format(date).toString());
				
				userPrivilegeDao.saveOrUpdate(userPrivilege);
				
			}
			
			
			HttpHeaders headers = new HttpHeaders();
	        headers.setLocation(ucBuilder.path("/users/{id}").buildAndExpand(user.getUser_id()).toUri());
	        
	       
	        loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
			return new ResponseEntity<Void> (headers, HttpStatus.CREATED);
			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, exception);
			return new ResponseEntity<Void> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}
	/* ------------------------- Create a User end -------------------------------------  */
	
	/* ------------------------- Update a User begin -------------------------------------  */
	@RequestMapping( value = "/update_user", method = RequestMethod.POST)
	public ResponseEntity<User> updateUser(@RequestBody User user, HttpServletRequest request) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		int user_id = Integer.parseInt(userInformation.getUserId());
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		
		try {			
		
			User user_pwdexists = usersDao.get(user.getUser_id());
			BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
						
			if( !(user.getUserpassword().equals(user_pwdexists.getUserpassword())) ) {
				String hashedPassword = passwordEncoder.encode(user.getUserpassword());
				user.setUserpassword(hashedPassword);			
			} else {
				user.setUserpassword(user_pwdexists.getUserpassword());
			}
			
			user.setUpdated_datetime(dateFormat.format(date).toString());
			user.setUpdated_by(user_id);
			usersDao.saveOrUpdate(user);			
			 
	        loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
			return new ResponseEntity<User> (user, HttpStatus.CREATED);
			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, exception);
			return new ResponseEntity<User> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}
	/* ------------------------- Update a User end -------------------------------------  */
	
	/* ------------------------- Update a User begin -------------------------------------  */
	@RequestMapping( value = "/users/{id}", method = RequestMethod.PUT)
	public ResponseEntity<User> updateUser(@PathVariable("id") int id, @RequestBody User user, HttpServletRequest request) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		try {
			User currentUser = usersDao.get(id);
			if(currentUser == null) {
				return new ResponseEntity<User>(HttpStatus.NOT_FOUND);
			} else {
				usersDao.saveOrUpdate(currentUser);
				loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
				return new ResponseEntity<User>(currentUser, HttpStatus.OK);
			}
		} catch(Exception exception) {
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, exception);
			return new ResponseEntity<User> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
		
	}
	/* ------------------------- Update a User end -------------------------------------  */
	
	/* ------------------------- Delete a User begin ----------------------------------- */
	@RequestMapping(value = "/delete_user/{id}", method = RequestMethod.DELETE)
	public ResponseEntity<String> deleteUser(@PathVariable("id") int id, HttpServletRequest request) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		Company company = companySettingDAO.getUserId(id, id);
		PriceSetting priceSetting = psDao.getUserId(id, id);
		BranchModel branchModel = branchDao.getUserId(id, id);
		CustomerModel customerModel = customerDao.getUserId(id, id);
		EmployeeMaster employeeMaster = employeeDao.getUserId(id, id);
		Location location = locationDao.getUser(id, id);
		Product product = productDao.getUserId(id, id);
		ServiceMaster serviceMaster = serviceDao.getUserid(id, id);
		VehicleMaster vehicleMaster = vehicleDao.getUserId(id, id);
		Hsn hsn = hsnDao.getUserId(id, id);
		ManifestModel manifest = mDao.getUserId(id, id);
		ReceiptModel receipt = receiptDao.getUser(id, id);
		ShipmentModel shipment = shipmentDao.getUserId(id, id);
				
		
		try {
			User currentUser = usersDao.get(id);
			if(currentUser == null) {
				return new ResponseEntity<String>(HttpStatus.NOT_FOUND);
			} else {
				if(company == null && priceSetting == null && branchModel == null && customerModel == null && employeeMaster == null
						&& location == null && product == null && serviceMaster == null && vehicleMaster == null && hsn == null
						&& manifest == null && receipt == null && shipment == null) {
					usersDao.delete(id);
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.DELETE_SUCCESS, null);
					return new ResponseEntity<String>( HttpStatus.OK);
			
				} else {
					return new ResponseEntity<String>("referdata", HttpStatus.IM_USED);
				}
					}
		} catch (Exception exception) {
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.DELETE_NOT_SUCCESS, exception);
			return new ResponseEntity<String> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}	
	/* ------------------------- Delete a User end ----------------------------------- */
	
	/* --------------------------- Retrieve a User by username begin ------------------------ */
	@RequestMapping(value = "forgotPassword", method = RequestMethod.POST)
	public ResponseEntity<User> getUserbyusername(@RequestBody String username, UserLogModel userLogModel)  {
		
			User currentUser = usersDao.findByUserName(username);
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date = new Date();

			/*try {*/
				
			
			if(currentUser == null) {
				return new ResponseEntity<User>(HttpStatus.NO_CONTENT);
			} else {
				Role userRole = roleDao.get(currentUser.getRole().getRole_Id());
				if( userRole == null ) {
					return new ResponseEntity<User>(HttpStatus.NOT_FOUND);
				} else {
					currentUser.setObsolete(userRole.getRole_Name());
				
					if(currentUser.role.getRole_Name().equals(constantVal.ROLE_CUSER)) {	
						List<User> userlist = usersDao.getUserbyRole(currentUser.getBranchModel().getBranch_id(), constantVal.ROLE_ADMIN);
						/*List<EmployeeMaster> listemp = employeeDao.getEmployee(currentUser.getBranchModel().getBranch_id(), constantVal.ROLE_ADMIN);*/
						if(! userlist.isEmpty()) {
							EmployeeMaster employee = employeeDao.getEmployeebyId(userlist.get(0).getUser_id());
							currentUser.setActive(String.valueOf(employee.getEmp_phoneno()));
						} else {
							
						}
						
						
					} 
					if(currentUser.role.getRole_Name().equals(constantVal.ROLE_ADMIN)){
						
						List<UserLogModel> userlog_list = userLogDao.getUserlogListbyId(currentUser.getUser_id());
						int noofDays = 0;
						if(!userlog_list.isEmpty()) {
							UserLogModel lastUserlog = Collections.max(userlog_list, Comparator.comparing(c -> c.getLog_id()));
							
							if( lastUserlog.getPassword_request() != null ) {
								
								/*String password_req_date = lastUserlog.getPassword_request().substring(0, lastUserlog.getPassword_request().length() - 2);
								Date req_date =  dateFormat.parse(password_req_date);
								String current_date = dateFormat.format(date);
								Date curr_date =  dateFormat.parse(current_date);
								
								// calculate days 					
								long diff = curr_date.getTime() - req_date.getTime();
							    noofDays = (int) TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS);*/
							} else {
								noofDays = 3;
							}
							
							
						}
							if(noofDays < 3 ) {
								return new ResponseEntity<User>(currentUser, HttpStatus.IM_USED);
								
							} else {
								
								/*MessageDigest md = MessageDigest.getInstance("MD5");
								String hashable = Integer.toString(currentUser.getUser_id()) + " " + dateFormat.format(date);
								md.update(hashable.getBytes());
							    byte[] digest = md.digest();
							    String hashed = DatatypeConverter.printHexBinary(digest).toUpperCase();
							    
							    userLogModel.setLink(hashed);  
								
								UriComponents uri = UriComponentsBuilder
					                    .fromHttpUrl("http://localhost:8080/Conti/resetPassword/"+ currentUser.getUser_id() +"/{hashedPassword}")
					                    .buildAndExpand(hashed);
								String urlString = uri.toUriString();*/
								String[] mail_id = {currentUser.getEmployeeMaster().getEmp_email()};
								String mail_subject = "Conti - Password Reset";
								
								Calendar c = Calendar.getInstance();
								c.setTime(new Date()); // Now use today date.
								c.add(Calendar.DATE, 3); // Adding 3 days
								String expired_date = dateFormat.format(c.getTime());
								
								/*String mail_msg = "Hello " + currentUser.getEmployeeMaster().getEmp_name() + ",<br/>"
										+ "We have received new password request for your account " + currentUser.getEmployeeMaster().getEmp_email() + ".<br/>"
										+ "If this request was initiated by you, please click To reset your password click here or copy URL " + urlString +" to your browser and change your password.<br/>"
										+ "This request is valid until " + expired_date + "<br/>"
										+ "Sincerely,<br/> Conti<br/>";
								sendMailSMS.send_Mail(mail_id, mail_subject, mail_msg);*/
								
								userLogModel.setUser_id(currentUser.getUser_id());
								//userLogModel.setLoggedin_date(dateFormat.format(date));
								userLogModel.setLast_loginhours(0);
								//userLogModel.setUsername_request(dateFormat.format(date));
								userLogModel.setPassword_reset_flag(0);
								userLogModel.setPassword_request(dateFormat.format(date));
								
								userLogDao.saveorupdate(userLogModel);
								
								return new ResponseEntity<User>(currentUser, HttpStatus.OK);
							}
						   
					}
					return new ResponseEntity<User>(currentUser, HttpStatus.OK);
				}			
			}
		/*}	catch(Exception exception) {
			return new ResponseEntity<User>(HttpStatus.UNPROCESSABLE_ENTITY);
		}*/
	}
	
	/* --------------------------- Retrieve a User by username end ------------------------ */
	
	/* --------------------------- Password reset for admin begin ------------------------ */
	@RequestMapping(value = "resetPassword/{id}/{hascode}", method = RequestMethod.GET)
	public ModelAndView resetPassword(@PathVariable("id") int id, @PathVariable("hascode") String hascode) {
		
		ModelAndView model = new ModelAndView();
		try {
			
				UserLogModel userLogModel = userLogDao.passwordResetConf(id, hascode); 
				if(userLogModel != null) {
					// get current date
					DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date date = new Date();
					String current_date = dateFormat.format(date);
					Date curr_date =  dateFormat.parse(current_date);
					// get password requested date
					String password_req_date =  userLogModel.getPassword_request().substring(0, userLogModel.getPassword_request().length() - 2);
					Date req_date = dateFormat.parse(password_req_date);
					// calculate days 					
					long diff = curr_date.getTime() - req_date.getTime();
				    TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS);
					// Checks the days 				    
				    if(TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS) >= 3) {
						model.addObject("link_expired","true");
				    } else {
				    	model.addObject("link_expired","false");
				    }
				    
				    model.addObject("user_id", id);
					model.addObject("link", hascode);
					model.addObject("valid","true");
				    
					if (userLogModel.getPassword_reset_flag() == 0) {
						model.addObject("link_used","false");
					} else {
						model.addObject("link_used","true");
					}
					
				} else {
					model.addObject("valid","false");
				}	
		
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.setViewName("reset_password");
		model.addObject("title", "Conti - Admin Reset Password");
		return model;
	}
	/* --------------------------- Password reset for admin end ------------------------ */	
	
	/* --------------------------- Change Password for Admin begin ----------------------- */
	@RequestMapping(value = "changePassword", method = RequestMethod.POST)
	public ResponseEntity<Void> change_Password(@RequestBody User user) {
		
		try {
			
			UserLogModel userLogModel = userLogDao.passwordResetConf(user.getUser_id(), user.getObsolete());
			if(userLogModel == null) {
				loggerconf.saveLogger(user.getUsername(), "ChangePassword", ConstantValues.FETCH_NOT_SUCCESS, null);
				return new ResponseEntity<Void>(HttpStatus.NOT_ACCEPTABLE);
				
			} else {
				loggerconf.saveLogger(user.getUsername(), "ChangePassword", ConstantValues.FETCH_SUCCESS, null);
				
				DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date date = new Date();
				
				BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
				String hashedPassword = passwordEncoder.encode(user.getUserpassword());
							
				User userInfo = usersDao.get(user.getUser_id());
				userInfo.setUserpassword(hashedPassword);
				userInfo.setUpdated_datetime(dateFormat.format(date));
				usersDao.saveOrUpdate(userInfo);
				userLogModel.setPassword_reset_flag(1);
				userLogDao.saveorupdate(userLogModel);
				loggerconf.saveLogger(user.getUsername(), "ChangePassword", ConstantValues.SAVE_SUCCESS, null);
				return new ResponseEntity<Void>(HttpStatus.OK);
			}
		} catch (Exception exception) {
			loggerconf.saveLogger(user.getUsername(), "ChangePassword", ConstantValues.SAVE_NOT_SUCCESS, exception);
			return new ResponseEntity<Void> (HttpStatus.UNPROCESSABLE_ENTITY);
			
		}
		
		
		
	}
	
	/* --------------------------- Change Password for Admin end ----------------------- */
	
	/* --------------------------- Forgot Username GET begin ----------------------- */	
	@RequestMapping(value = "forgot_username", method = RequestMethod.GET)
	public ModelAndView forgot_username() throws Exception {
		
		ModelAndView model = new ModelAndView();
			
			model.addObject("title", "Conti - Forgot Username");
			model.addObject("message", "Forgot username in Conti");
			model.setViewName("forgot_username");
			
		
		return model;

	}
	/* --------------------------- Forgot Username GET end ----------------------- */		
	
	/* --------------------------- Forgot Username GET begin ----------------------- */	
	@RequestMapping(value = "forgot_password", method = RequestMethod.GET)
	public ModelAndView forgot_password() throws Exception {
		
		ModelAndView model = new ModelAndView();
			
			model.addObject("title", "Conti - Forgot Password");
			model.addObject("message", "Forgot password in Conti");
			model.setViewName("forgot_password");
			
		
		return model;

	}
	/* --------------------------- Forgot Username GET end ----------------------- */	
	
	/*----------------------------- find Username by mobileno begin -------------- */
	@RequestMapping(value = "forgotUsername", method = RequestMethod.POST)
	public ResponseEntity<Void> forgotUsername(@RequestBody String mobileno, EmployeeMaster employeeMaster, UserLogModel userLogModel) {
		
		try {
			employeeMaster = employeeDao.findByMobileno(Long.parseLong(mobileno));

			if(employeeMaster != null) {
				
				// get current date
				DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date date = new Date();
				// get password requested date			
				
				User user = usersDao.getUserbyEmp(employeeMaster.getEmp_id());
				System.out.println();
				List<UserLogModel> userlog_list = userLogDao.getUserlogListbyId(user.getUser_id());
				userLogModel = Collections.max(userlog_list, Comparator.comparing(c -> c.getLog_id()));
				
				
				
				int minute = 0;
				if( userLogModel.getUsername_request() != null ) {
					
					String username_req_date =  userLogModel.getUsername_request().substring(0, userLogModel.getUsername_request().length() - 2);
					// calculate days 					
					String[] datetime_diff = datetimeCalculation.calculateDateDiff(username_req_date);
					
					minute = Integer.parseInt(datetime_diff[2]);
										
				}
				
				
				if ( minute > constantVal.SMS_MAXHOUR_FORGOT_USERNAME ) {
					userLogModel.setForgotusernme_count( 0 );
				}	
					
					if ( (minute <= constantVal.SMS_MAXHOUR_FORGOT_USERNAME) && (userLogModel.getForgotusernme_count() >= constantVal.SMS_MAXCOUNT_FORGOT_USERNAME) ) {
						 
							loggerconf.saveLogger(Long.toString(employeeMaster.getEmp_phoneno()), "forgotUsername", ConstantValues.FETCH_NOT_SUCCESS, null);
							return new ResponseEntity<Void> (HttpStatus.ALREADY_REPORTED);
						
						
					} else {
						
						
						loggerconf.saveLogger(Long.toString(employeeMaster.getEmp_phoneno()), "forgotUsername", ConstantValues.FETCH_SUCCESS, null);

						userLogModel.setUsername_request(dateFormat.format(date));
						//userLogModel.setUser_id(employeeMaster.getUser().getUser_id());
						userLogModel.setPassword_reset_flag(0);
						userLogModel.setForgotusernme_count( userLogModel.getForgotusernme_count() + 1 );
						userLogDao.saveorupdate(userLogModel);
						loggerconf.saveLogger(Long.toString(employeeMaster.getEmp_phoneno()), "forgotUsername", ConstantValues.SAVE_SUCCESS, null);
						
						String message= "Dear CONTI user, Your Conti Cargo courier portal username: " + user.getUsername();
						String sms_respone = sendMailSMS.send_SMS(mobileno, message); // call send_sms method
						
						// check sms send success or not
						if( !(sms_respone.contains("0x2")) ) {
							//success block
							loggerconf.saveLogger(Long.toString(employeeMaster.getEmp_phoneno()), "forgotUsername", ConstantValues.SEND_SUCCESS, null);
							return new ResponseEntity<Void> (HttpStatus.OK);
						} else {
							//not success block
							loggerconf.saveLogger(Long.toString(employeeMaster.getEmp_phoneno()), "forgotUsername", ConstantValues.SEND_NOT_SUCCESS, null);
							return new ResponseEntity<Void> (HttpStatus.SERVICE_UNAVAILABLE);
						}
						
												
					}
					
				
				
				//System.out.println(employeeMaster.getUser().getUsername());
				
			} else {
				loggerconf.saveLogger(mobileno, "forgotUsername", ConstantValues.FETCH_NOT_SUCCESS, null);				
				return new ResponseEntity<Void> (HttpStatus.UNPROCESSABLE_ENTITY);
			}
			
		} catch (Exception exception) {
			loggerconf.saveLogger(mobileno, "forgotUsername", ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<Void> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
		
	}
	
	/*----------------------------- find Username by mobileno end -------------- */
	
	
	@RequestMapping(value =  "password_change", method = RequestMethod.GET)
	public ModelAndView changePassword(HttpServletRequest request) throws Exception {
		
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
			
			model.addObject("title", " Accounts Settings");
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.setViewName("User Profile/change_password");

			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;

	}
	
	/* ------------------------- Retrieve all Roles begin-------------------------------- */
	@RequestMapping( value = "/roles/", method = RequestMethod.GET	)
	public ResponseEntity<List<Role>> fetchAllRoles(HttpServletRequest request) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();		
		try {
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			
			List<Role> roles = roleDao.list();
			if(roles.isEmpty()) {
				return new ResponseEntity<List<Role>> (HttpStatus.NO_CONTENT);
			} else {
				
				if( request.isUserInRole(constantVal.ROLE_ADMIN) ) {
					for ( Role role : roles ) {
						
						if( role.getRole_Name().equals(constantVal.ROLE_SADMIN) ) {
							roles.remove(role);
							break;
						}	
					}
				}
				return new ResponseEntity<List<Role>> (roles, HttpStatus.OK);	
			}			
		} catch (Exception exception) {			
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<List<Role>> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
				
	}
	/* ------------------------- Retrieve all Roles end-------------------------------- */
	
	/* ------------------------------ Check username begin ----------------------------------------- */
	@RequestMapping(value = "check_username", method = RequestMethod.POST)
	public ResponseEntity<Void> checkUsername(HttpServletRequest request, @RequestBody String check_username) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		try {
			User user = usersDao.findByUserName(check_username);
			if( user == null ) {
				loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
				return new ResponseEntity<Void> (HttpStatus.NO_CONTENT);
			} else {
				loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
				return new ResponseEntity<Void> (HttpStatus.OK);	
			}
			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<Void> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}
	/* ------------------------------ Check username end ----------------------------------------- */
	

	
	//======================================Excel begin==========================================
	@RequestMapping(value="downloadExcelUser",method=RequestMethod.GET)
	public ModelAndView downloadExcelUser(){
		String user_id = userInformation.getUserId();
		String branch_id = userInformation.getUserBranchId();
		
		User user = usersDao.get(Integer.parseInt(user_id));
		
		List<User> userList = new ArrayList<User>();
		
		if ( user.getRole().getRole_Name().equals(constantVal.ROLE_SADMIN) ) {
			userList = usersDao.getAllUsers();
		} else {
			userList = usersDao.getUsersbyBranchId(Integer.parseInt(branch_id));
		}
		
		
		return new ModelAndView("userExcelView","userList",userList);
	}

	//======================================Excel end==========================================
	
	/* ------------------------- Make active in User begin ------------------------------------- */
	@RequestMapping(value = "make_Useractive", method = RequestMethod.POST)
	public ResponseEntity<Void> make_active(@RequestBody int[] id, HttpServletRequest request) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		int user_id = Integer.parseInt(userInformation.getUserId());
		
		int active_flag = 0;
		try {
			for(int i=0; i<id.length; i++) {
				User usersDB = usersDao.get(id[i]);
				
				if(usersDB == null) {
					loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, null);
					active_flag = 1;
					
				} else {
					
					Date date = new Date();
					DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
					
					usersDB.setActive("Y");
					usersDB.setUpdated_by(user_id);
					usersDB.setUpdated_datetime(dateFormat.format(date));
									
					usersDao.saveOrUpdate(usersDB);
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
	/* ------------------------- Make active User end ------------------------------------- */
	
	
	/* ------------------------- Make inactive in User begin ------------------------------------- */
	@RequestMapping(value = "make_Userinactive", method = RequestMethod.POST)
	public ResponseEntity<Void> make_Userinactive(@RequestBody int[] id, HttpServletRequest request) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		int user_id = Integer.parseInt(userInformation.getUserId());
		
		int active_flag = 0;
		try {
			for(int i=0; i<id.length; i++) {
				User usersDB = usersDao.get(id[i]);
				
				if(usersDB == null) {
					loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, null);
					active_flag = 1;
					
				} else {
					
					Date date = new Date();
					DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
					
					usersDB.setActive("N");
					usersDB.setUpdated_by(user_id);
					usersDB.setUpdated_datetime(dateFormat.format(date));
									
					usersDao.saveOrUpdate(usersDB);
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
	/* ------------------------- Make inactive User end ------------------------------------- */
	
	
	/* ------------------------- Print in User begin ------------------------------------- */	
	@RequestMapping(value = "/user_print", method = RequestMethod.POST)
	public ModelAndView farmPrint(@RequestParam("user") String user, HttpServletRequest request) throws JsonProcessingException, IOException{

		JSONArray jsonArray = new JSONArray(user);
		String[] userid = new String[jsonArray.length()];
		for(int i=0; i <jsonArray.length();i++) {
			JSONObject jsonObject = jsonArray.getJSONObject(i);
			userid[i] = Integer.toString(jsonObject.getInt("user_id"));			
		}
		List<User> listuser = new ArrayList<User> ();
		for(int i=0; i<userid.length;i++) {
			User userDB = usersDao.get(Integer.parseInt(userid[i]));
			listuser.add(userDB);
		}
		

		
		Company company = companySettingDAO.getById(1);
		ModelAndView model = new ModelAndView("print/user_print");

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
		
		model.addObject("title", "User");
		model.addObject("company", company);
		model.addObject("listuser", listuser);
		model.addObject("image",base64DataString);
			
		return model;
	}
	/* ------------------------- Print in User end ------------------------------------- */	
	
	//======================================Pagination begin==========================================
	
	@RequestMapping(value = "pagination_user", method=RequestMethod.POST)
	public ResponseEntity<List<User>> pagination(@RequestBody int page, HttpServletRequest request) {
		
		String username = userInformation.getUserName();
		int userid = Integer.parseInt(userInformation.getUserId());
		int branch_id = Integer.parseInt(userInformation.getUserBranchId());
	
		try {
			
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
			
			User user = usersDao.get(userid);
			List<User> userList = new ArrayList<User>();
			if( user.getRole().getRole_Name().equals(constantVal.ROLE_SADMIN) ) {
				
				userList = usersDao.getUserwithLimitbySA(from_limit, to_limit, order);
				
				
				if(userList.isEmpty()) {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
					return new ResponseEntity<List<User>> (HttpStatus.NO_CONTENT);
				} else {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
					return new ResponseEntity<List<User>> (userList, HttpStatus.OK);	
				}	
				
			} else {
				
				userList = usersDao.getUserwithLimit(branch_id, from_limit, to_limit, order);
				
				if(userList.isEmpty()) {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
					return new ResponseEntity<List<User>> (HttpStatus.NO_CONTENT);
				} else {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
					return new ResponseEntity<List<User>> (userList, HttpStatus.OK);	
				}
			}
		
			
		} catch (Exception exception) {
			
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<List<User>> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}
	
	//======================================Pagination end==========================================
	
	/* ------------------------- Register user search begin ------------------------------------- */	
	@RequestMapping(value = "register_Usersearch", method=RequestMethod.POST)
	public ResponseEntity<List<User>> register_search(@RequestBody String searchkey, HttpServletRequest request) {
		
		String username = userInformation.getUserName();
		int userid = Integer.parseInt(userInformation.getUserId());
		int branch_id = Integer.parseInt(userInformation.getUserBranchId());
		
		try {
			
			User user = usersDao.get(userid);
			List<User> userList = new ArrayList<User>();
			if( user.getRole().getRole_Name().equals(constantVal.ROLE_SADMIN) ) {
				
				userList = usersDao.searchbySAUser(searchkey);
				
				
				if(userList.isEmpty()) {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
					return new ResponseEntity<List<User>> (HttpStatus.NO_CONTENT);
				} else {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
					return new ResponseEntity<List<User>> (userList, HttpStatus.OK);	
				}	
				
			} else {
				
				userList = usersDao.searchbyUser(searchkey, branch_id);
				
				if(userList.isEmpty()) {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
					return new ResponseEntity<List<User>> (HttpStatus.NO_CONTENT);
				} else {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
					return new ResponseEntity<List<User>> (userList, HttpStatus.OK);	
				}
			}
			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<List<User>> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	
	}
	/* ------------------------- Register user search end ------------------------------------- */
	
	/* ------------------------- Find record count begin ------------------------------------- */
	
	@RequestMapping(value = "/record_count/", method = RequestMethod.GET)
	public ResponseEntity<String> recordCount(HttpServletRequest request) {
		String username = userInformation.getUserName();
		
		try {
			int userid = Integer.parseInt(userInformation.getUserId());	
			User user = usersDao.get(userid);
			List<User> userList = new ArrayList<User>();
			if( user.getRole().getRole_Name().equals(constantVal.ROLE_SADMIN) ) {
				String rec_count = Integer.toString(usersDao.find_record_countforSA());
				return new ResponseEntity<String> (rec_count, HttpStatus.OK);	
			} else {
				String rec_count = Integer.toString(usersDao.find_record_count());
				return new ResponseEntity<String> (rec_count, HttpStatus.OK);	
			}
			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<String> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}
	
	/* ------------------------- Find record count end ------------------------------------- */
	
	//===========================To get all Employee name for Searching================================
	
	@RequestMapping(value="getEmployee4Search/{str}", method = RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Map<String,List<EmployeeMaster>>> getEmployee4Search(HttpServletRequest request,
			@PathVariable("str") String searchStr) throws JsonGenerationException, JsonMappingException, JSONException, IOException 
	{
		List<EmployeeMaster> employees = employeeDao.searchbyEmployee4SA(searchStr);
		Map result = new HashMap();	
		result.put("Employees",employees);
		return new ResponseEntity<Map<String,List<EmployeeMaster>>> (result,HttpStatus.OK);
	}
	
}


