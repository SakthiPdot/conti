package com.conti.address;


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

import com.conti.master.location.Location;

/**
 * @Project_Name conti
 * @Package_Name com.conti.settings.address
 * @File_name AddressController.java
 * @author Monu
 * @Created_date_time Jun 29, 2017 2:21:39 PM
 * @Updated_date_time Jun 29, 2017 2:21:39 PM
 */

@RestController
public class AddressController {
	
	@Autowired
	private AddressDao addressDao;
	//======================get  Address detail========================================
	@RequestMapping(value="/Address",method=RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<AddressModel>> getAddressDetail(){
		List<AddressModel> addresses=addressDao.getList();
		return new ResponseEntity<List<AddressModel>>(addresses,HttpStatus.OK);
	}

	@RequestMapping(value="getCity4Ship/{str}", method = RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Map<String,List<AddressModel>>> getCity4Ship(HttpServletRequest request,
			@PathVariable("str") String searchStr) throws JsonGenerationException, JsonMappingException, JSONException, IOException {
		
		List<AddressModel> city = addressDao.searchByAddressName(searchStr);

		 Map result = new HashMap();
		 result.put("city", city);
		
		return new ResponseEntity<Map<String,List<AddressModel>>> (result,HttpStatus.OK);
	}

}
