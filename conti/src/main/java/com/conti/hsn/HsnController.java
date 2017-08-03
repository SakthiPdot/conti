package com.conti.hsn;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.conti.config.SessionListener;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;

/**
 * @Project_Name conti
 * @Package_Name com.conti.hsn
 * @File_name HsnController.java
 * @author Sankar
 * @Created_date_time Aug 2, 2017 4:32:14 PM
 * @Updated_date_time Aug 2, 2017 4:32:14 PM
 */
@RestController
public class HsnController {
	

	Loggerconf loggerconf = new Loggerconf();
	ConstantValues constantVal = new ConstantValues();
	SessionListener sessionListener = new SessionListener();
	UserInformation userInformation;
	
	@Autowired
	private HsnDao hsnDao; 
	
	@RequestMapping(value = "/hsns/", method = RequestMethod.GET)
	public ResponseEntity<List<Hsn>> fetchAllhsns() {
		List<Hsn> list_hsn = hsnDao.getAllHsn();
		
		return new ResponseEntity<List<Hsn>> (list_hsn, HttpStatus.OK);
	}
	
	//===========================fetch hsn code ================================
	
	@RequestMapping(value="getHSNCode4Search/{str}", method = RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Map<String,List<Hsn>>> getHSNCode4Search (HttpServletRequest request,
			@PathVariable("str") String searchStr) throws JsonGenerationException, JsonMappingException, JSONException, IOException {
		
		List<Hsn> hsn = hsnDao.searchbyHsnCode(searchStr);

		 Map result = new HashMap();
		 result.put("hsn_code", hsn);
		 		
		return new ResponseEntity<Map<String,List<Hsn>>> (result,HttpStatus.OK);
	}
	
	//===========================fetch hsn description ================================
	
	@RequestMapping(value="getHSNDesc4Search/{str}", method = RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Map<String,List<Hsn>>> getHSNDesc4Search (HttpServletRequest request,
			@PathVariable("str") String searchStr) throws JsonGenerationException, JsonMappingException, JSONException, IOException {
		
		List<Hsn> hsn = hsnDao.searchbyHsnDescription(searchStr);

		 Map result = new HashMap();
		 result.put("hsn_description", hsn);
		 		
		return new ResponseEntity<Map<String,List<Hsn>>> (result,HttpStatus.OK);
	}

}
