/**
 * MC6
 * 
 */
package com.conti.setting.usercontrol;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.xml.bind.DatatypeConverter;

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
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.conti.config.SessionListener;
import com.conti.master.employee.EmployeeDao;
import com.conti.master.employee.EmployeeMaster;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.SendMailSMS;
import com.conti.others.UserInformation;
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
	
	Loggerconf loggerconf = new Loggerconf();
	ConstantValues constantVal = new ConstantValues();
	SessionListener sessionListener = new SessionListener();
	UserInformation userInformation;
	
	/* ------------------------- Retrieve all Users begin-------------------------------- */
	@RequestMapping( value = "/users/", method = RequestMethod.GET	)
	public ResponseEntity<List<User>> fetchAllUsers(HttpServletRequest request) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();		
		try {
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			List<User> users = usersDao.list();
			if(users.isEmpty()) {
				return new ResponseEntity<List<User>> (HttpStatus.NO_CONTENT);
			} else {
				return new ResponseEntity<List<User>> (users, HttpStatus.OK);	
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
		try {			
			usersDao.saveOrUpdate(user);			
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
	@RequestMapping(value = "/users/{id}", method = RequestMethod.DELETE)
	public ResponseEntity<User> deleteUser(@PathVariable("id") int id, HttpServletRequest request) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		try {
			User currentUser = usersDao.get(id);
			if(currentUser == null) {
				return new ResponseEntity<User>(HttpStatus.NOT_FOUND);
			} else {
				usersDao.delete(id);
				loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.DELETE_SUCCESS, null);
				return new ResponseEntity<User>(currentUser, HttpStatus.OK);
			}
		} catch (Exception exception) {
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.DELETE_NOT_SUCCESS, exception);
			return new ResponseEntity<User> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}	
	/* ------------------------- Delete a User end ----------------------------------- */
	
	/* --------------------------- Retrieve a User by username begin ------------------------ */
	@RequestMapping(value = "forgotPassword", method = RequestMethod.POST)
	public ResponseEntity<User> getUserbyusername(@RequestBody String username, UriComponentsBuilder ucBuilder, UserLogModel userLogModel) throws NoSuchAlgorithmException, ParseException {
		
			User currentUser = usersDao.findByUserName(username);
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date = new Date();
			
			if(currentUser == null) {
				return new ResponseEntity<User>(HttpStatus.NO_CONTENT);
			} else {
				Role userRole = roleDao.get(currentUser.getUser_id());
				if( userRole == null ) {
					return new ResponseEntity<User>(HttpStatus.NOT_FOUND);
				} else {
					currentUser.setObsolete(userRole.getRole_Name());
					
					if(userRole.getRole_Name().equals(constantVal.ROLE_CUSER)) {	
						List<EmployeeMaster> listemp = employeeDao.getEmployee(currentUser.getBranch_id(), constantVal.ROLE_ADMIN);
						currentUser.setActive(String.valueOf(listemp.get(0).getEmp_phoneno()));
					} 
					if(userRole.getRole_Name().equals(constantVal.ROLE_ADMIN)){
						
						List<UserLogModel> userlog_list = userLogDao.getUserlogListbyId(currentUser.getUser_id());
						int noofDays = 0;
						if(!userlog_list.isEmpty()) {
							UserLogModel lastUserlog = Collections.max(userlog_list, Comparator.comparing(c -> c.getLog_id()));
							String password_req_date = lastUserlog.getPassword_request().substring(0, lastUserlog.getPassword_request().length() - 2);
							Date req_date =  dateFormat.parse(password_req_date);
							String current_date = dateFormat.format(date);
							Date curr_date =  dateFormat.parse(current_date);
							
							// calculate days 					
							long diff = curr_date.getTime() - req_date.getTime();
						    noofDays = (int) TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS);
						}
							if(noofDays < 3 ) {
								return new ResponseEntity<User>(currentUser, HttpStatus.IM_USED);
								
							} else {
								
								MessageDigest md = MessageDigest.getInstance("MD5");
								String hashable = Integer.toString(currentUser.getUser_id()) + " " + dateFormat.format(date);
								md.update(hashable.getBytes());
							    byte[] digest = md.digest();
							    String hashed = DatatypeConverter.printHexBinary(digest).toUpperCase();
							    
							    userLogModel.setLink(hashed);  
								
								UriComponents uri = UriComponentsBuilder
					                    .fromHttpUrl("http://localhost:8080/Conti/resetPassword/"+ currentUser.getUser_id() +"/{hashedPassword}")
					                    .buildAndExpand(hashed);
								String urlString = uri.toUriString();
								String[] mail_id = {currentUser.getEmployeeMaster().getEmp_email()};
								String mail_subject = "Conti - Password Reset";
								
								Calendar c = Calendar.getInstance();
								c.setTime(new Date()); // Now use today date.
								c.add(Calendar.DATE, 3); // Adding 3 days
								String expired_date = dateFormat.format(c.getTime());
								
								String mail_msg = "Hello " + currentUser.getEmployeeMaster().getEmp_name() + ",<br/>"
										+ "We have received new password request for your account " + currentUser.getEmployeeMaster().getEmp_email() + ".<br/>"
										+ "If this request was initiated by you, please click To reset your password click here or copy URL " + urlString +" to your browser and change your password.<br/>"
										+ "This request is valid until " + expired_date + "<br/>"
										+ "Sincerely,<br/> Conti<br/>";
								sendMailSMS.send_Mail(mail_id, mail_subject, mail_msg);
								
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
	@RequestMapping(value = {"forgot_username"}, method = RequestMethod.GET)
	public ModelAndView forgot_username() throws Exception {
		
		ModelAndView model = new ModelAndView();
			
			model.addObject("title", "Conti - Forgot Username");
			model.addObject("message", "Forgot username in Conti");
			model.setViewName("forgot_username");
			
		
		return model;

	}
	/* --------------------------- Forgot Username GET end ----------------------- */		
	
	/*----------------------------- find Username by mobileno begin -------------- */
	@RequestMapping(value = "{forgotUsername}", method = RequestMethod.POST)
	public ResponseEntity<Void> forgotUsername(@RequestBody String mobileno, EmployeeMaster employeeMaster, UserLogModel userLogModel) {
		
		try {
			employeeMaster = employeeDao.findByMobileno(Integer.parseInt(mobileno));
			if(employeeMaster != null) {
				DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date date = new Date();
				dateFormat.format(date);
				
				List<UserLogModel> userlog_list = userLogDao.getUserlogListbyId(employeeMaster.getUser().getUser_id());
				userLogModel = Collections.max(userlog_list, Comparator.comparing(c -> c.getLog_id()));
				userLogModel.setUsername_request(dateFormat.format(date));
				//userLogModel.setUser_id(employeeMaster.getUser().getUser_id());
				userLogModel.setPassword_reset_flag(0);
				userLogDao.saveorupdate(userLogModel);
				System.out.println(employeeMaster.getUser().getUsername());
				loggerconf.saveLogger(Integer.toString(employeeMaster.getEmp_phoneno()), "forgotUsername", ConstantValues.FETCH_SUCCESS, null);
			} else {
				loggerconf.saveLogger(mobileno, "forgotUsername", ConstantValues.FETCH_NOT_SUCCESS, null);				
				return new ResponseEntity<Void> (HttpStatus.UNPROCESSABLE_ENTITY);
			}
			
		} catch (Exception exception) {
			loggerconf.saveLogger(mobileno, "forgotUsername", ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<Void> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
		return new ResponseEntity<Void> (HttpStatus.OK);
	}
	
	/*----------------------------- find Username by mobileno end -------------- */
}


