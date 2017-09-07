package com.conti.settings.company;



import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.conti.config.SessionListener;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.setting.usercontrol.UsersDao;

/**
 * @Project_Name conti
 * @Package_Name com.conti.settings.company
 * @File_name CompanyController.java
 * @author Monu
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 29, 2017 2:21:39 PM
 */

@RestController
public class CompanyController {

	@Autowired
	private CompanySettingDAO companyDao;

	@Autowired
	private UsersDao uDao;

	
	Loggerconf loggerconf = new Loggerconf();
	SessionListener sessionListener = new SessionListener();
	final Logger logger = LoggerFactory.getLogger(CompanyController.class);


	//=================Company setting page=====================================
	@RequestMapping(value =  "company_settings", method = RequestMethod.GET)
	public ModelAndView adminPage(HttpServletRequest request)  {

					
		ModelAndView model = new ModelAndView();		
		try{
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);			
			model.addObject("title", "Company Settings");
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.setViewName("Settings/company_settings");		
			model.addObject("homePage",request.getContextPath());
		} catch (Exception exception) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(),  "Admin/ ", ConstantValues.LOGGER_STATUS_E, exception);
		}		
		return model;
	}
	
	//=================file upload=====================================
	
	@RequestMapping(value = "/companySave", method = RequestMethod.POST)
    public ResponseEntity<Void>  handleFileUpload(HttpServletRequest request,
    		@RequestParam (value="company") String cmp,
            @RequestParam(value="file" , required=false) CommonsMultipartFile[] fileUpload) throws JsonParseException, JsonMappingException, IOException  {      
		

		System.out.println("inside file upload ============================ ");
		
		ObjectMapper mapper=new ObjectMapper();
		Company companyFromJson=mapper.readValue(cmp,Company.class);
		
		
		//intialize	
		String userid = request.getSession().getAttribute("userid").toString();		
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
		
		//always update
		companyFromJson.setUpdated_datetime(dateFormat.format(date));
		companyFromJson.setUpdated_by(Integer.parseInt(userid));		
		
		//check create or update
		if(companyFromJson.getCompany_id()==0){
			companyFromJson.setCompany_id(1);	
			companyFromJson.setCreated_by(Integer.parseInt(userid));
			companyFromJson.setCreated_datetime(dateFormat.format(date));
		}	
		
		
			
		
        if (fileUpload != null && fileUpload.length > 0) {
            for (CommonsMultipartFile aFile : fileUpload){
                System.out.println("Saving file: " + aFile.getOriginalFilename());
                companyFromJson.setCompany_logo(aFile.getBytes());
            }
        }
        
    	//save company
		try {
			companyDao.saveOrUpdate(companyFromJson);
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
			return new ResponseEntity<Void>(HttpStatus.CREATED);
		} catch (Exception e) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS,e);
			e.printStackTrace();
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
    }

	//=================Retrieve company details=====================================
	@RequestMapping(value="/company/{id}",method=RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	
	public ResponseEntity<Company> getCompanyDetail(HttpServletRequest request,@PathVariable("id") long id){

		System.out.println(request.getContextPath()+"============================ ");
		
		 System.out.println("Fetching User with id " + id);
		Company company=companyDao.getById((int) id);
		if(company==null){
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, null);
			return new ResponseEntity<Company>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Company>(company,HttpStatus.OK);
	}
	
	//=================Create company details=====================================
/*	@RequestMapping(value="/companySave" ,method=RequestMethod.POST,
			produces=MediaType.APPLICATION_JSON_VALUE)
	
	public ResponseEntity<Void> saveCompanyDetail(@RequestBody Company company,
			HttpServletRequest request,UriComponentsBuilder ucBuilder){

		System.out.println("++inside company");
		
		//intialize	
		String userid = request.getSession().getAttribute("userid").toString();		
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
			
		
		//check create or update
		if(company.getCompany_id()==0){
			company.setCompany_id(1);	
			company.setCreated_by(Integer.parseInt(userid));
			company.setCreated_datetime(dateFormat.format(date));
			company.setUpdated_by(Integer.parseInt(userid));
		}else{
			company.setUpdated_by(Integer.parseInt(userid));
			company.setUpdated_datetime(dateFormat.format(date));
		}	
		
		
		//save company
		try {
			companyDao.saveOrUpdate(company);
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
			return new ResponseEntity<Void>(HttpStatus.CREATED);
		} catch (Exception e) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS,e);
			e.printStackTrace();
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		HttpHeaders headers=new HttpHeaders();
		
		UriComponents uricomponents=ucBuilder.path("/company/{id}").buildAndExpand(company.getCompany_id());
		
		headers.setLocation(uricomponents.toUri());
		
	
		
	}*/
}