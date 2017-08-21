package com.conti.shipment.view;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;
import com.conti.setting.usercontrol.User;
import com.conti.setting.usercontrol.UsersDao;
import com.conti.shipment.add.ShipmentDao;
import com.conti.shipment.add.ShipmentModel;

/**
 * @Project_Name conti
 * @Package_Name com.conti.shipment.view
 * @File_name ViewShipmentController.java
 * @author Sakthi
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 20, 2017 2:21:39 PM
 */

@RestController
public class ViewShipmentController {

	final Logger logger = LoggerFactory.getLogger(ViewShipmentController.class);

	@Autowired
	private UsersDao usersDao;
	@Autowired
	private ShipmentDao shipmentDao;
	Loggerconf loggerconf = new Loggerconf();
	UserInformation userInformation;
	ConstantValues constantVal = new ConstantValues();
	
	
//---------------------------------------------- VIEW SHIPMENT BEGIN
	@RequestMapping(value =  "view_shipment", method = RequestMethod.GET)
	public ModelAndView adminPage(HttpServletRequest request) throws Exception {
		
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		String userid = userInformation.getUserId();
		int branch_id = Integer.parseInt(userInformation.getUserBranchId());

		ModelAndView model = new ModelAndView();
		
		
		try
		{
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			
			model.addObject("title", "View Shipment");
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.setViewName("Shipment/view shipment");

			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;

	}
	//---------------------------------------------- VIEW SHIPMENT END
	
	//---------------------------------------------- FETCH SHIPMENT WITH THE STATUS BEGIN
	@RequestMapping( value = "/fetchshipmentforview", method = RequestMethod.GET)
	public ResponseEntity<List<ShipmentModel>> fetchShipmentforView(HttpServletRequest request){
		
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		String userid = userInformation.getUserId();
		int branch_id = Integer.parseInt(userInformation.getUserBranchId());
		try {
			
			User user = usersDao.get(Integer.parseInt(userid));
			if (user.role.getRole_Name() == constantVal.ROLE_SADMIN) { //block for SUPER ADMIN
				List<ShipmentModel> shipment=shipmentDao.fetchshipmentforView();
				if(shipment.isEmpty()) {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, null);	
					return new ResponseEntity <List<ShipmentModel>>(HttpStatus.NOT_FOUND);	
				}else {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
					return new ResponseEntity <List<ShipmentModel>>(shipment, HttpStatus.OK);		
				}
				
			} else { //block for MANAGER AND USER
				List<ShipmentModel> shipment=shipmentDao.fetchshipmentforView();
				if(shipment.isEmpty()) {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, null);	
					return new ResponseEntity <List<ShipmentModel>>(HttpStatus.NOT_FOUND);	
				}else {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
					return new ResponseEntity <List<ShipmentModel>>(shipment, HttpStatus.OK);		
				}
			}
			
		}catch (Exception exception) {
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.LOGGER_STATUS_E, exception);
			return new ResponseEntity<List<ShipmentModel>>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}
	//---------------------------------------------- FETCH SHIPMENT WITH THE STATUS END
 
}