package com.conti.shipment.add;


import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.conti.master.branch.BranchDao;
import com.conti.master.branch.BranchModel;
import com.conti.master.customer.CustomerDao;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.SendMailSMS;
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
	@Autowired
	private CustomerDao customerDao;
	@Autowired
	private SendMailSMS sendMailSMS;
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
		
		try
		{
			BranchModel branch = brandhDao.getBranchbyId(branch_id);
			int lrno = shipmentDao.fetchMAXlrno(branch_id);
			
			model.addObject("lrno", lrno);
			model.addObject("branch", branch);
			model.addObject("title", "Add Shipment");
			model.setViewName("Shipment/add shipment");
			
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;

	}
	
	//--------------------------------- Create new shipment begin
	
	@RequestMapping(value = "/create_shipment", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Void> createShipment (@RequestBody ShipmentModel shipment,  HttpServletRequest request) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		int user_id = Integer.parseInt(userInformation.getUserId());
		int branch_id = Integer.parseInt(userInformation.getUserBranchId());
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		
		try {
			// LRNO CALCULATION
			int lrno = shipmentDao.fetchMAXlrno(branch_id);
			if( lrno == 0 ) {
				lrno = 10001;
			} else {
				lrno = lrno + 1;
			}
			//NEW CUSTOMER SAVE FOR SNEDER
			if(shipment.getSender_customer().getCustomer_id() == 0){
				shipment.getSender_customer().setActive("Y");
				shipment.getSender_customer().setObsolete("N");
				shipment.getSender_customer().setCreated_by(user_id);
				shipment.getSender_customer().setUpdated_by(user_id);
				shipment.getSender_customer().setCreated_datetime(dateFormat.format(date).toString());
				shipment.getSender_customer().setUpdated_datetime(dateFormat.format(date).toString());
				shipment.getSender_customer().setBranchModel(shipment.getSender_branch());
				shipment.getSender_customer().setCustomer_type(shipment.getPay_mode());
				
				if( shipment.getSender_customer().getGstin_number().length() != 0 ) {
					shipment.getSender_customer().setTaxin_payable("Yes");
				} else {
					shipment.getSender_customer().setTaxin_payable("No");
				}
				
				customerDao.saveOrUpdate(shipment.getSender_customer());
			}
			
			//NEW CUSTOMER SAVE FOR CONSIGNEE
			if(shipment.getConsignee_customer().getCustomer_id() == 0) {
				shipment.getConsignee_customer().setActive("Y");
				shipment.getConsignee_customer().setObsolete("N");
				shipment.getConsignee_customer().setCreated_by(user_id);
				shipment.getConsignee_customer().setUpdated_by(user_id);
				shipment.getConsignee_customer().setCreated_datetime(dateFormat.format(date).toString());
				shipment.getConsignee_customer().setUpdated_datetime(dateFormat.format(date).toString());
				shipment.getConsignee_customer().setBranchModel(shipment.getConsignee_branch());
				shipment.getConsignee_customer().setCustomer_type(shipment.getPay_mode());
				if( shipment.getSender_customer().getGstin_number().length() != 0 ) {
					shipment.getSender_customer().setTaxin_payable("Yes");
				} else {
					shipment.getSender_customer().setTaxin_payable("No");
				}
				
				customerDao.saveOrUpdate(shipment.getConsignee_customer());
			}
			
			shipment.setLr_number(lrno);
			shipment.setObsolete("N");
			shipment.setCreated_by(user_id);
			shipment.setUpdated_by(user_id);
			shipment.setCreated_datetime(dateFormat.format(date).toString());
			shipment.setUpdated_datetime(dateFormat.format(date).toString());
		
			List<ShipmentDetailModel> shipmentDetailList = shipment.getShipmentDetail();
			for(ShipmentDetailModel shipmentDetail : shipmentDetailList) {
				shipmentDetail.setShipment(shipment);
			}
			
			shipmentDao.saveOrUpdate(shipment);  // SAVE SHIPMENT
			
			
			//SMS FOR SENDER 
			/*String message = "Your parcel have been booked successfully at Conti Courier Service."
					+ "LR Number: " + lrno + " "
					+ "From city " + shipment.getSender_customer().location.address.getCity() +" to "
									+ shipment.getConsignee_customer().location.address.getCity() + " " 
					+ "No.of Parcel " + shipment.getNumberof_parcel() + " "
					+ "Delivery Charge " + shipment.getDelivery_charge();
			String mobileno = Long.toString(shipment.getSender_customer().getCustomer_mobileno());
			String sms_respone = sendMailSMS.send_SMS(mobileno, message);*/
			
			
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
			return new ResponseEntity<Void> (HttpStatus.CREATED);
			
		} catch ( Exception exception) {
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, exception);
			return new ResponseEntity<Void> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
		
	}
	
	//--------------------------------- Create new shipment end

	
	//==================================Fetch all shipment(100)============================
	@RequestMapping(value="fetchAllShipment",method=RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ShipmentModel>>  getAllLocation(){
		List<ShipmentModel> shipment=shipmentDao.fetchAllShipment100();
		if(shipment.isEmpty()){
			return new ResponseEntity<List<ShipmentModel>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<ShipmentModel>>(shipment,HttpStatus.OK);
	}
	
	//------------------------------------ 
	
	@RequestMapping(value =  "shipment_bill", method = RequestMethod.GET)
	public ModelAndView shipment_bill(@RequestParam (value = "lrno", required = false) int lrno, HttpServletRequest request) throws Exception {
		
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		String userid = userInformation.getUserId();
		int branch_id = Integer.parseInt(userInformation.getUserBranchId());
		ModelAndView model = new ModelAndView();
		
		try
		{
						
			model.addObject("lrno", lrno);
			model.addObject("title", "Add Shipment");
			model.setViewName("Shipment/shipment_bill");
			
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;

	}

}