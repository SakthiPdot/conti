package com.conti.shipment.add;


import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.Base64;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
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
import com.conti.others.NumberToWord;
import com.conti.others.SendMailSMS;
import com.conti.others.UserInformation;
import com.conti.settings.company.Company;
import com.conti.settings.company.CompanySettingDAO;

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
	private CompanySettingDAO companySettingDAO;
	@Autowired
	private BranchDao branchDao;
	@Autowired
	private SendMailSMS sendMailSMS;
	
	@Autowired
	private NumberToWord numberToWord;
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
			model.addObject("userid",userid);
			model.addObject("branch_id", branch_id);
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
	
	//--------------------------------- FETCH MAXIMUM LRNO BEGIN
	
	@RequestMapping(value = "/fetchMAXlrno/{branch_id}", method = RequestMethod.GET, produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> fetchMAXLRno (@PathVariable("branch_id") int branch_id, HttpServletRequest request) {
		
		userInformation = new UserInformation(request);
		String lrno = shipmentDao.fetchMAXlrno_prefix(branch_id);
		String lrwithPrefix = null;
		if(lrno == null) {
			lrwithPrefix = Integer.toString(0);	
		} else {
			BranchModel branch = branchDao.getBranchbyId(branch_id);
			/*lrwithPrefix = branch.getLrno_prefix() + lrno;*/
			lrwithPrefix = lrno;
		}
		
		return new ResponseEntity<String> (lrwithPrefix, HttpStatus.OK);
		
	}
	
	//--------------------------------- FETCH MAXIMUM LRNO END
	
	//--------------------------------- Create new shipment begin
	
	@RequestMapping(value = "/create_shipment", method = RequestMethod.POST)
	public ResponseEntity<String> createShipment (@RequestBody ShipmentModel shipment,  HttpServletRequest request) {
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
				lrno = 1;
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
			BranchModel branch = branchDao.getBranchbyId(branch_id);
			String lrno_prefix = branch.getLrno_prefix() + String.format("%06d", lrno) ;
			shipment.setLr_number(lrno);
			shipment.setLrno_prefix(lrno_prefix);
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
					+ "From city " + shipment.getSender_branch().getBranch_name() +" to "
									+ shipment.getConsignee_branch().getBranch_name() + " " 
					+ "No.of Parcel " + shipment.getNumberof_parcel() + " "
					+ "Delivery Charge " + shipment.getDelivery_charge();
			String mobileno = Long.toString(shipment.getSender_customer().getCustomer_mobileno());
			String sms_respone = sendMailSMS.send_SMS(mobileno, message);*/
			JSONObject lr_details = new JSONObject();
			lr_details.put("lrno", lrno);
			lr_details.put("lrno_prefix", lrno_prefix);
			
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
			return new ResponseEntity<String> (lr_details.toString(),HttpStatus.CREATED);
			
		} catch ( Exception exception) {
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, exception);
			return new ResponseEntity<String> (HttpStatus.UNPROCESSABLE_ENTITY);
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
			Company company = companySettingDAO.getById(1);	
			String base64DataString ="";
			if(company!=null && company.getCompany_logo()!=null){
				byte[] encodeBase64 = Base64.encodeBase64(company.getCompany_logo());
				try {
					 base64DataString = new String(encodeBase64 , "UTF-8");
				} catch (UnsupportedEncodingException e) {
					loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), "Image support error", e);
				}		
			}else{
				base64DataString = ConstantValues.NO_IMAGE;	
			}
			BranchModel branch = brandhDao.getBranchbyId(branch_id);
			model.addObject("branch", branch);
			ShipmentModel shipment = shipmentDao.getshipmentby_lrno(lrno);
			
			String total_charges = Float.toString(shipment.getTotal_charges());
			String[] total_charges_split = total_charges.split("\\.");
			
			String currency_rs = numberToWord.convert(Integer.parseInt(total_charges_split[0]));
			String currency_paise = numberToWord.convert(Integer.parseInt(total_charges_split[1]));
			
			String currency = currency_rs + " rupees " + currency_paise + " paise.";
			
			model.addObject("company",company);
			model.addObject("image",base64DataString);
			model.addObject("shipment", shipment);
			model.addObject("currency", currency);
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