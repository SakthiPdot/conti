package com.conti.shipment.add;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.conti.master.branch.BranchDao;
import com.conti.master.branch.BranchModel;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;

/**
 * @Project_Name conti
 * @Package_Name com.conti.shipment.add
 * @File_name AddShipmentController.java
 * @author Sakthi
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 20, 2017 2:21:39 PM
 */

@RestController
public class AddShipmentController {

	@Autowired
	private BranchDao brandhDao;
	@Autowired
	private ShipmentDao shipmentDao;
	Loggerconf loggerconf = new Loggerconf();	
	UserInformation userInformation;
	ConstantValues constantVal = new ConstantValues();

	
	@RequestMapping(value =  "add_shipment", method = RequestMethod.GET)
	public ModelAndView adminPage(HttpServletRequest request) throws Exception {
		
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		String userid = userInformation.getUserId();
		int branch_id = Integer.parseInt(userInformation.getUserBranchId());
		ModelAndView model = new ModelAndView();
		
		/*try
		{*/
			BranchModel branch = brandhDao.getBranchbyId(branch_id);
			int lrno = shipmentDao.fetchMAXlrno(branch_id);
			
			model.addObject("lrno", lrno);
			model.addObject("branch", branch);
			model.addObject("title", "Add Shipment");
			model.setViewName("Shipment/add shipment");
			
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
		/*} catch (Exception exception) {
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.LOGGER_STATUS_E, exception);
		}*/
		return model;

	}

	

}