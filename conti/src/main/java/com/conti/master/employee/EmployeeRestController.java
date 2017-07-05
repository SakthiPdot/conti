package com.conti.master.employee;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.UriComponentsBuilder;

import com.conti.config.SessionListener;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;
import com.conti.setting.usercontrol.RoleDao;
import com.conti.setting.usercontrol.User;
import com.conti.setting.usercontrol.UsersDao;

/**
 * @Project_Name conti
 * @Package_Name com.conti.master.employee
 * @File_name EmployeeRestController.java
 * @author Sankar
 * @Created_date_time Jun 26, 2017 1:50:56 PM
 * @Updated_date_time Jun 26, 2017 1:50:56 PM
 */
@RestController
public class EmployeeRestController {

	@Autowired
	private UsersDao usersDao;
	@Autowired
	private RoleDao roleDao;
	@Autowired
	private EmployeeDao employeeDao;
	
	Loggerconf loggerconf = new Loggerconf();
	ConstantValues constantVal = new ConstantValues();
	SessionListener sessionListener = new SessionListener();
	UserInformation userInformation;
	
	@RequestMapping( value = "/employees/", method = RequestMethod.GET)
	public ResponseEntity<List<EmployeeMaster>> fetchAllEmployees(HttpServletRequest request) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		
		try {
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			List<EmployeeMaster> employees = employeeDao.getAllEmployees();
			if(employees.isEmpty()) {
				return new ResponseEntity<List<EmployeeMaster>> (HttpStatus.NO_CONTENT);
			} else {
				return new ResponseEntity<List<EmployeeMaster>> (employees, HttpStatus.OK);	
			}			
		} catch (Exception exception) {			
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<List<EmployeeMaster>> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}
	@RequestMapping( value = "/employees/category/", method = RequestMethod.GET)
	public ResponseEntity<List<EmployeeMaster>> fetchEmployeesbycat(HttpServletRequest request) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		
		try {
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			List<EmployeeMaster> employees = employeeDao.getAllEmployees();
			if(employees.isEmpty()) {
				return new ResponseEntity<List<EmployeeMaster>> (HttpStatus.NO_CONTENT);
			} else {
				List<EmployeeMaster> empCategory = employees.stream().filter(distinctByKey(emp->emp.getEmpcategory())).collect(Collectors.toList());
				return new ResponseEntity<List<EmployeeMaster>> (empCategory, HttpStatus.OK);	
			}			
		} catch (Exception exception) {			
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<List<EmployeeMaster>> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}	
	/**
	 * @param object
	 * @return
	 */
	 public static <T> Predicate<T> distinctByKey(Function<? super T, Object> keyExtractor) 
	    {
	        Map<Object, Boolean> map = new ConcurrentHashMap<>();
	        return t -> map.putIfAbsent(keyExtractor.apply(t), Boolean.TRUE) == null;
	    }
	/* ------------------------- Create a Employee begin -------------------------------------  */
	@RequestMapping( value = "/create_employee", method = RequestMethod.POST)
	public ResponseEntity<Void> createEmployee(@RequestBody EmployeeMaster employee, UriComponentsBuilder ucBuilder, HttpServletRequest request) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		int user_id = Integer.parseInt(userInformation.getUserId());
				
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		
		try {	
			employee.setCreated_by(user_id);
			employee.setUpdate_by(user_id);	
			employee.setCreated_datetime(dateFormat.format(date).toString());
			employee.setUpdated_datetime(dateFormat.format(date).toString());
			
			employeeDao.saveOrUpdate(employee);		
			
			HttpHeaders headers = new HttpHeaders();
	        headers.setLocation(ucBuilder.path("/employees/{id}").buildAndExpand(employee.getEmp_id()).toUri());
	        loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
			return new ResponseEntity<Void> (headers, HttpStatus.CREATED);
			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, exception);
			return new ResponseEntity<Void> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}
	/* ------------------------- Create a Employee end -------------------------------------  */

}
