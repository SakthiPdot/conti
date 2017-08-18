package com.conti.receipt;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.JsonParser.Feature;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONArray;
import org.json.JSONObject;
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
import com.conti.master.branch.BranchDao;
import com.conti.master.branch.BranchModel;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;
import com.conti.setting.usercontrol.UsersDao;
import com.conti.settings.company.CompanySettingDAO;
import com.conti.shipment.add.ShipmentDao;
import com.conti.shipment.add.ShipmentModel;

/**
 * @Project_Name conti
 * @Package_Name com.conti.receipt
 * @File_name ViewReceiptGenerationController.java
 * @author Suresh
 * @Created_date_time Aug 11, 2017 2:21:39 PM
 * @Updated_date_time Aug 11, 2017 2:21:39 PM
 */
@RestController
public class AddReceiptRestController 
{
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
	
//-----------------------------------------Open Generate Receipt page------------------------------------------------
	
	@RequestMapping(value =  "receipt_generate", method = RequestMethod.GET)
	public ModelAndView adminPage(HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		
		UserInformation userinfo = new UserInformation(request);
		String username = userinfo.getUserName();
		String userid = userinfo.getUserId();
		
		session.setAttribute("username", username);
		session.setAttribute("userid", userid);
		BranchModel branchModel=branchDao.getBranchbyId(Integer.parseInt(userinfo.getUserBranchId()));
		String branch_name=branchModel.getBranch_name();
		int branch_id=branchModel.getBranch_id();
		String lr_prefix=branchModel.getLrno_prefix();
		ModelAndView model = new ModelAndView();
		try
		{
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			
			model.addObject("title", "Receipt Generation");
			model.addObject("branch_name",branch_name);
			model.addObject("branch_id", branch_id);
			model.addObject("lr_prefix",lr_prefix);
			model.addObject("branch_id",Integer.parseInt(userinfo.getUserBranchId()));
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.setViewName("Receipt/receipt_generation");

			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;
	}
//-----------------------------------------------------------------------------------------------------------------
	
	//-----------------------------------Get All Receipt  for default loaded in Add Receipt ----------------------------------
		
	@RequestMapping(value="add_receipt_preload", method=RequestMethod.GET)
		public ResponseEntity<List<ShipmentModel>>fetchAllReceipt_add(HttpServletRequest request)
		{
			UserInformation userInformation = new UserInformation(request);
			String username = userInformation.getUserName();
			String branch_id=userInformation.getUserBranchId();
			try
			{
				loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
				List<ShipmentModel> shipmentModel=shipmentDao.fetchAllShipment4receipt(Integer.parseInt(branch_id));
				if(shipmentModel.isEmpty()) 
				{
					return new ResponseEntity<List<ShipmentModel>> (HttpStatus.NO_CONTENT);
				}
				else 
				{
					return new ResponseEntity<List<ShipmentModel>> (shipmentModel, HttpStatus.OK);	
				}	
			}
			catch(Exception exception)
			{
				loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
				return new ResponseEntity<List<ShipmentModel>> (HttpStatus.UNPROCESSABLE_ENTITY);
			}
		}
		
	//-------------------------------------------------------------------------------------------------------------------
	
	//-------------------------------------------Add Receipt filter function start----------------------------------------
	
	@RequestMapping( value = "add_receipt_filter", method = RequestMethod.POST)
	public ResponseEntity<List<ShipmentModel>> addreceiptFilterbycondition(@RequestBody String receipt,HttpServletRequest request) 
			throws JsonProcessingException, IOException 
	{
		HttpSession session = request.getSession();
		UserInformation userinfo = new UserInformation(request);
		String username = userinfo.getUserName();
		JSONObject obj=new JSONObject(receipt);
		
		int frombranchid=obj.getInt("frombranch");
		int tobranchid=obj.getInt("tobranch");
		
		String fromdate=(String) obj.get("fromdate");
		String todate=(String) obj.get("todate");
		
		String servic=(String) obj.get("service");
		String paymod=(String) obj.get("paymode");	
		try 
		{
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			List<ShipmentModel> shipmentModel = shipmentDao.getShipmentByCondition(frombranchid,tobranchid,fromdate,todate,servic,paymod);
			if(shipmentModel.isEmpty()) 
			{
				System.out.println("=====Empty====================================="+shipmentModel);
				return new ResponseEntity<List<ShipmentModel>> (HttpStatus.NO_CONTENT);
			}
			else 
			{
				System.out.println("=====Success====================================="+shipmentModel);
				return new ResponseEntity<List<ShipmentModel>> (shipmentModel, HttpStatus.OK);	
			}		
		} 
		catch (Exception exception) 
		{			
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<List<ShipmentModel>> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	//--------------------------------------------------------------------------------------------------------------------------
	
	//======================LR Number search start==================================
	
	@RequestMapping(value="search_lrnumber", method=RequestMethod.POST)
	public ResponseEntity<List<ShipmentModel>> receipt_search(@RequestBody String searchkey,HttpServletRequest request)
	{
		List<ShipmentModel> shipmentModel=shipmentDao.searchLRnumber(searchkey);
		System.out.println("++++++++++++++++++++++++++++++++============================================================================== "+shipmentModel.toString());
		return new ResponseEntity<List<ShipmentModel>>(shipmentModel,HttpStatus.OK);
	}
}
