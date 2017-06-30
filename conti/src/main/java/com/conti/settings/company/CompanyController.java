package com.conti.settings.company;



import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.conti.address.AddressModel;
import com.conti.config.SessionListener;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;
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
		String username =request.getUserPrincipal().getName();				
		ModelAndView model = new ModelAndView();		
		try{
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);			
			model.addObject("title", "Company Settings");
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.setViewName("Settings/company_settings");			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  "Admin/ ", ConstantValues.LOGGER_STATUS_E, exception);
		}		
		return model;
	}
	
	//=================file upload=====================================
	
	@RequestMapping(value = "/fileUpload", method = RequestMethod.POST)
    public ResponseEntity<Void>  handleFileUpload(HttpServletRequest request,
            @RequestParam(value="file", required=true) CommonsMultipartFile[] fileUpload)  {      
		
		
		System.out.println("inside file upload ============================ ");
        if (fileUpload != null && fileUpload.length > 0) {
            for (CommonsMultipartFile aFile : fileUpload){

                System.out.println("Saving file: " + aFile.getOriginalFilename());
                Company company=companyDao.getById(1);
                company.setCompany_logo(aFile.getBytes());
                companyDao.saveOrUpdate(company);
            }
        }
        return new ResponseEntity<Void>(HttpStatus.CREATED);
    }

	//=================Retrieve company details=====================================
	@RequestMapping(value="/company/{id}",method=RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	
	public ResponseEntity<Company> getCompanyDetail(HttpServletRequest request,@PathVariable("id") long id){
		
		 System.out.println("Fetching User with id " + id);
		Company company=companyDao.getById((int) id);
		if(company==null){
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, null);
			return new ResponseEntity<Company>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Company>(company,HttpStatus.OK);
	}
	
	//=================Create company details=====================================
	@RequestMapping(value="/companySave" ,method=RequestMethod.POST,produces=MediaType.APPLICATION_JSON_VALUE)
	
	public ResponseEntity<Void> saveCompanyDetail(@RequestBody Company company,HttpServletRequest request,UriComponentsBuilder ucBuilder){

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
		} catch (Exception e) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS,e);
			e.printStackTrace();
		}
/*		
		HttpHeaders headers=new HttpHeaders();
		
		UriComponents uricomponents=ucBuilder.path("/company/{id}").buildAndExpand(company.getCompany_id());
		
		headers.setLocation(uricomponents.toUri());
		*/
		return new ResponseEntity<Void>(HttpStatus.CREATED);
		
	}
}