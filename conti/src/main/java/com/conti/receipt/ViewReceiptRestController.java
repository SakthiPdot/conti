package com.conti.receipt;


import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.JsonParser.Feature;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.session.SessionAuthenticationException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.conti.config.SessionListener;
import com.conti.manifest.ManifestModel;
import com.conti.master.branch.BranchDao;
import com.conti.master.branch.BranchModel;
import com.conti.receipt.ReceiptModel;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;
import com.conti.setting.usercontrol.RoleDao;
import com.conti.setting.usercontrol.User;
import com.conti.setting.usercontrol.UsersDao;
import com.conti.settings.company.Company;
import com.conti.settings.company.CompanySettingDAO;
import com.conti.shipment.add.ShipmentDao;
import com.conti.shipment.add.ShipmentModel;



/**
 * @Project_Name conti
 * @Package_Name com.conti.receipt
 * @File_name ViewReceiptGenerationController.java
 * @author Suresh
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 20, 2017 2:21:39 PM
 */

@RestController
public class ViewReceiptRestController {

	final Logger logger = LoggerFactory.getLogger(ViewReceiptRestController.class);

	@Autowired
	private UsersDao usersDao;
	
	@Autowired
	private ReceiptDao receiptDao;
	
	@Autowired
	private BranchDao branchDao;
	
	@Autowired
	private ShipmentDao shipmentDao;
		
	@Autowired
	private CompanySettingDAO companySettingDAO;
	
	@Autowired
	@Qualifier("sessionRegistry")
	private SessionRegistry sessionRegistry;
		
	Loggerconf loggerconf = new Loggerconf();
	SessionListener sessionListener = new SessionListener();
	
	private UserInformation userInformation;

	
	//--------------------------------Open view receipt page----------------------------------------
	
	@RequestMapping(value =  "view_receipt", method = RequestMethod.GET)
	public ModelAndView viewadminPage(HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		
		UserInformation userinfo = new UserInformation(request);
		String username = userinfo.getUserName();
		
		String userid = userinfo.getUserId();
		String branch_id=userinfo.getUserBranchId();
		session.setAttribute("username", username);
		session.setAttribute("userid", userid);
		
		
		ModelAndView model = new ModelAndView();
		
		
		try
		{
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			
			model.addObject("title", "View Receipt");
			model.addObject("branch_id",branch_id);
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.setViewName("Receipt/view_receipt");
			
			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;

	}
//-------------------------------------------------------------------------------------------------------
	
//-----------------------------------Get Receipt details------------------------------------------------
	@RequestMapping(value="view_receipt_preload", method=RequestMethod.GET)
	public ResponseEntity<List<ReceiptDetail>>fetchAllReceipt_view(HttpServletRequest request)
	{
		UserInformation userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		String userid = userInformation.getUserId();
		int branch_id = Integer.parseInt(userInformation.getUserBranchId());
		try
		{
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			
			User user = usersDao.get(Integer.parseInt(userid));

			if (user.role.getRole_Name().equals(ConstantValues.ROLE_SADMIN)) {
				List<ReceiptDetail> receiptModel=receiptDao.getAllReceipt_view();
				if(receiptModel.isEmpty()) 
				{
					System.out.println("==========================Null============ "+receiptModel);
					return new ResponseEntity<List<ReceiptDetail>> (HttpStatus.NO_CONTENT);
				}
				else 
				{
					System.out.println("=========================Not Null============ ");
					return new ResponseEntity<List<ReceiptDetail>> (receiptModel, HttpStatus.OK);	
				}
			}else{
				List<ReceiptDetail> receiptModel=receiptDao.getAllReceipt_view(branch_id);
					if(receiptModel.isEmpty()) 
					{
						System.out.println("==========================Null============ "+receiptModel);
						return new ResponseEntity<List<ReceiptDetail>> (HttpStatus.NO_CONTENT);
					}
					else 
					{
						System.out.println("=========================Not Null============ ");
						return new ResponseEntity<List<ReceiptDetail>> (receiptModel, HttpStatus.OK);	
					}
			}
		}
		catch(Exception exception)
		{
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<List<ReceiptDetail>> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	//-------------------------------------------------------------------------------------------------------------------
	
	//-------------------------------Filter Receipt function start-----------------------------------------------------------
	
	
	@RequestMapping( value = "view_receipt_filter", method = RequestMethod.POST)
	public ResponseEntity<List<ReceiptDetail>> receiptFilterbycondition(@RequestBody String receipt,HttpServletRequest request) throws JsonProcessingException, IOException 
	{
		HttpSession session = request.getSession();
		UserInformation userinfo = new UserInformation(request);
		String username = userinfo.getUserName();
		String userid = userinfo.getUserId();
		
		 JSONObject obj=new JSONObject(receipt);
		 String frombranchid=String.valueOf(obj.get("frombranch"));
		 String tobranchid=String.valueOf(obj.get("tobranch")); 
		 String fromdate=(String) obj.get("fromdate");
		 String todate=(String) obj.get("todate");
		 String status=(String)obj.get("status");
		try 
		{
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			List<ReceiptDetail> receiptDetail = receiptDao.getReceiptByCondition(frombranchid,tobranchid,fromdate,todate,status);
			if(receiptDetail.isEmpty()) 
			{
				return new ResponseEntity<List<ReceiptDetail>> (HttpStatus.NO_CONTENT);
			}
			else 
			{
				return new ResponseEntity<List<ReceiptDetail>> (receiptDetail, HttpStatus.OK);	
			}		
		} 
		catch (Exception exception) 
		{			
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<List<ReceiptDetail>> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	//-------------------------------Receipt Excel Export function start----------------------------
	@RequestMapping(value="downloadExcelReceipt",method=RequestMethod.GET)
	public ModelAndView downloadExcelReceipt()
	{
		
		List<ReceiptDetail> receiptList=receiptDao.getAllReceipt_view();
		return new ModelAndView("receiptExcelView","receiptList",receiptList);
	}
	
	//-----------------------------Receipt print function start------------------------------------
	
	@RequestMapping(value="/receipt_print",method=RequestMethod.POST)
	public ModelAndView receiptPrint(@RequestParam("receipt") String receipt,HttpServletRequest request)throws JsonProcessingException, IOException
	{
		JSONArray jsonArray = new JSONArray(receipt);
		String[] receiptid = new String[jsonArray.length()];
		for(int i=0; i <jsonArray.length();i++) {
			JSONObject jsonObject = jsonArray.getJSONObject(i);
			receiptid[i] = Integer.toString(jsonObject.getInt("receipt_id"));			
		}
		
		List<ReceiptModel> listReceipt = new ArrayList<ReceiptModel> ();
		for(int i=0; i<receiptid.length;i++) {
			ReceiptModel receiptModel = receiptDao.getReceiptbyId(Integer.parseInt(receiptid[i]));
			listReceipt.add(receiptModel);
		}
		Company company = companySettingDAO.getById(1);
		ModelAndView model = new ModelAndView("print/receipt_print");

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
		
		model.addObject("title", "Receipt");
		model.addObject("company", company);
		model.addObject("listCust", listReceipt);
		model.addObject("image",base64DataString);
			
		return model;
	}
	//===============================================================================================
	
	
	
	
	

}