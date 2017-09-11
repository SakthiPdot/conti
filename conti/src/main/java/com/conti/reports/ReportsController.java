package com.conti.reports;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.conti.config.SessionListener;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;
import com.conti.setting.usercontrol.UsersDao;
import com.conti.shipment.add.ShipmentDao;
import com.conti.shipment.add.ShipmentModel;

/**
 * @Project_Name conti
 * @Package_Name com.conti.reports
 * @File_name ReportsController.java
 * @author Sakthi
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 20, 2017 2:21:39 PM
 */

@RestController
public class ReportsController {

	final Logger logger = LoggerFactory.getLogger(ReportsController.class);

	@Autowired
	private UsersDao usersDao;
		
	@Autowired
	@Qualifier("sessionRegistry")
	private SessionRegistry sessionRegistry;
	@Autowired
	private ShipmentDao shipmentDao;
	UserInformation userInformation;
	ConstantValues constantVal = new ConstantValues();	
	Loggerconf loggerconf = new Loggerconf();
	SessionListener sessionListener = new SessionListener();

	@RequestMapping(value =  "report", method = RequestMethod.GET)
	public ModelAndView adminPage(HttpServletRequest request) throws Exception {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		String userid = userInformation.getUserId();
		ModelAndView model = new ModelAndView();
		try
		{
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			model.addObject("title", "Reports");
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.setViewName("Reports/reports");
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;

	}

	@RequestMapping(value="/fetch4all", method=RequestMethod.POST)
	public ResponseEntity<List<ShipmentModel>> fetch4all(@RequestBody String shipment, HttpServletRequest request){
		userInformation = new UserInformation(request);
		/*try{*/

		JSONObject json = new JSONObject(shipment);
			List<ShipmentModel> filterShip = new ArrayList<ShipmentModel>();
			List<ShipmentModel> shipmentList = shipmentDao.getShipment4Report(json.get("fromtoday").toString(), json.get("todate").toString(), 
					json.get("datecondition").toString(), json.get("frombranch").toString(), json.get("tobranch").toString(), json.get("branchcondition").toString(), 
					json.get("from_lrno").toString(), json.get("to_lrno").toString(), json.get("lrcondition").toString(), json.get("product_id").toString(), 
					json.get("paymentmode").toString(), json.get("status").toString());
			
			if(!json.get("product_id").toString().isEmpty()){
				if(!shipmentList.isEmpty()){
					for(ShipmentModel shipmentM : shipmentList){
						for(int i=0; i<shipmentM.getShipmentDetail().size();i++){
							if(shipmentM.getShipmentDetail().get(i).getProduct().getProduct_id() == Integer.parseInt(json.get("product_id").toString())){
								filterShip.add(shipmentM);
							}
						}
					}
				}else{
					filterShip.addAll(shipmentList);
				}
				
			} else {
				filterShip.addAll(shipmentList);
			}
			return new ResponseEntity<List<ShipmentModel>> (shipmentList, HttpStatus.OK);

		/*}catch(Exception e){
			return new ResponseEntity<List<ShipmentModel>> (HttpStatus.UNPROCESSABLE_ENTITY);
		}*/
	}

}