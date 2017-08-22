package com.conti.address;


import java.util.List;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

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


}
