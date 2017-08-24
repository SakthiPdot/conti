package com.conti.shipment.view;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
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

	// ---------------------------------------------- VIEW SHIPMENT BEGIN
	@RequestMapping(value = "view_shipment", method = RequestMethod.GET)
	public ModelAndView adminPage(HttpServletRequest request) throws Exception {

		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		String userid = userInformation.getUserId();
		int branch_id = Integer.parseInt(userInformation.getUserBranchId());

		ModelAndView model = new ModelAndView();

		try {
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);

			model.addObject("branch_id", branch_id);
			model.addObject("title", "View Shipment");
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.setViewName("Shipment/view shipment");

		} catch (Exception exception) {
			loggerconf.saveLogger(username, "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;

	}
	// ---------------------------------------------- VIEW SHIPMENT END

	// ---------------------------------------------- FETCH SHIPMENT WITH THE
	// STATUS BEGIN
	@RequestMapping(value = "/fetchshipmentforview", method = RequestMethod.GET)
	public ResponseEntity<List<ShipmentModel>> fetchShipmentforView(HttpServletRequest request) {

		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		String userid = userInformation.getUserId();
		int branch_id = Integer.parseInt(userInformation.getUserBranchId());
		try {

			User user = usersDao.get(Integer.parseInt(userid));

			if (user.role.getRole_Name().equals(constantVal.ROLE_SADMIN)) { // block
																			// for
																			// SUPER
																			// ADMIN
				List<ShipmentModel> shipment = shipmentDao.fetchshipmentforView();
				if (shipment.isEmpty()) {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, null);
					return new ResponseEntity<List<ShipmentModel>>(HttpStatus.NOT_FOUND);
				} else {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
					return new ResponseEntity<List<ShipmentModel>>(shipment, HttpStatus.OK);
				}

			} else { // block for MANAGER AND USER
				List<ShipmentModel> shipment = shipmentDao.fetchshipmentforView(branch_id);
				if (shipment.isEmpty()) {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, null);
					return new ResponseEntity<List<ShipmentModel>>(HttpStatus.NOT_FOUND);
				} else {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
					return new ResponseEntity<List<ShipmentModel>>(shipment, HttpStatus.OK);
				}
			}

		} catch (Exception exception) {
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.LOGGER_STATUS_E, exception);
			return new ResponseEntity<List<ShipmentModel>>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

	}
	// ---------------------------------------------- FETCH SHIPMENT WITH THE
	// STATUS END

	// ---------------------------------------------- FILTER SHIPMENT FOR VIEW
	// BEGIN

	@RequestMapping(value = "/filter_shipment", method = RequestMethod.POST)
	public ResponseEntity <List<ShipmentModel>> filterShipemntforView(@RequestBody String viewShipment, HttpServletRequest request) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		String user_id = userInformation.getUserId();
		int branch_id = Integer.parseInt(userInformation.getUserBranchId());
		
		JSONObject viewshipment_json = new JSONObject(viewShipment);
		List<ShipmentModel> filterShipment = shipmentDao.filterViewShipment(
				viewshipment_json.get("from_branch").toString(), viewshipment_json.get("to_branch").toString(), 
				viewshipment_json.get("fromdate").toString(), viewshipment_json.getString("todate").toString(), 
				viewshipment_json.get("status").toString() );	
	
		String product = viewshipment_json.get("product_id").toString();
		List<ShipmentModel> filterShip = new ArrayList<ShipmentModel>();
		if( ! product.isEmpty() ) {
			
			if( ! filterShipment.isEmpty() ) {
				for(ShipmentModel shipment : filterShipment) {
					for(int i = 0; i < shipment.getShipmentDetail().size(); i++ ) {
						if( shipment.getShipmentDetail().get(i).getProduct().getProduct_id() == Integer.parseInt(product) ) {
							filterShip.add(shipment);
						}
					}
				}
			} else {
				filterShip.addAll(filterShipment);
			}
		} else {
			filterShip.addAll(filterShipment);
		}
		
		
		
		return new ResponseEntity<List<ShipmentModel>> (filterShip, HttpStatus.OK);
	}

	// ---------------------------------------------- FILTER SHIPMENT FOR VIEW
	
	//----------------------------------------------- SEARCH BY LRNO FOR VIEW SHIPMENT BEGIN
	
	@RequestMapping( value = "/shipment_searchbylr", method = RequestMethod.POST)
	public ResponseEntity <List<ShipmentModel>> shipment_searchbylr (@RequestBody String lrno, HttpServletRequest request) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		String user_id = userInformation.getUserId();
		int branch_id = Integer.parseInt(userInformation.getUserBranchId());
		
		try {
			List<ShipmentModel> shipmentList = shipmentDao.shipment_searchbyLR4ViewAdmin(lrno);
			
			if( shipmentList.isEmpty() ) {
				return new ResponseEntity<List<ShipmentModel>> (HttpStatus.NOT_FOUND);
			} else {
				return new ResponseEntity<List<ShipmentModel>> (shipmentList,HttpStatus.OK);			
			}	
		} catch (Exception e) {
			return new ResponseEntity<List<ShipmentModel>> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
		
	}
	
	//----------------------------------------------- SEARCH BY LRNO FOR VIEW SHIPMENT END
	
	//----------------------------------------------- SHIPMENT DELETE BEGIN
	
	@RequestMapping(value = "delete_shipment/{id}", method = RequestMethod.DELETE)
	public ResponseEntity <Void> shipment_delete (@PathVariable ("id") int id, HttpServletRequest request) {
		
		userInformation = new UserInformation (request);
		int user_id = Integer.parseInt(userInformation.getUserId()); 
		ShipmentModel shipment = shipmentDao.getShipmentModelById(id);
		
		if (shipment != null) {
			
			Date date = new Date();
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
			
			shipment.setUpdated_by(user_id);
			shipment.setUpdated_datetime(dateFormat.format(date));
			shipment.setObsolete("Y");
			shipment.setStatus("Cancelled");	
			shipmentDao.saveOrUpdate(shipment);
		}
		
		return new ResponseEntity<Void> (HttpStatus.OK);
	}
	
	//----------------------------------------------- SHIPMENT DELETE END
	// END

}