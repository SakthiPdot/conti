package com.conti.master.product;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.codehaus.jackson.JsonParser;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONArray;
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

import com.conti.config.SessionListener;
import com.conti.master.employee.EmployeeMaster;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;
import com.conti.settings.company.Company;
import com.conti.settings.company.CompanySettingDAO;
import com.conti.settings.price.PriceSetting;
import com.conti.settings.price.PriceSettingDao;
import com.conti.shipment.add.ShipmentDao;
import com.conti.shipment.add.ShipmentDetailModel;
import com.conti.shipment.add.ShipmentHsnDetailModel;

/**
 * @Project_Name conti
 * @Package_Name com.conti.product  com.conti.product
 * @File_name ProductController.java com.conti.product
 * @author Monu.C
 * @Created_date_time Jul 8, 2017 6:22:38 PM
 */
@RestController
public class ProductController {

	@Autowired
	private ProductDAO productDao;

	@Autowired
	private CompanySettingDAO companySettingDAO;
	@Autowired
	private ShipmentDao shipmentDao;
	@Autowired
	private PriceSettingDao psDao;
	
	Loggerconf loggerconf = new Loggerconf();
	SessionListener sessionListener = new SessionListener();
	UserInformation userInformation;
	
	
	//======================================get Record Count==========================================
	@RequestMapping(value = "/ProductRecordCount/", method = RequestMethod.GET)
	public ResponseEntity<String> priceSettingRecordCount(HttpServletRequest request) {
		try {	
			return new ResponseEntity<String> (String.valueOf(productDao.productCount()), HttpStatus.OK);			
		} catch (Exception exception) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<String> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	//======================================Excel==========================================
	@RequestMapping(value="downloadExcelProduct",method=RequestMethod.GET)
	public ModelAndView downloadExcelProduct(){
		List<Product> productList=productDao.getProduct(); 
		return new ModelAndView("productExcelView","ProductList",productList);
	}
	
	//======================================Pagination begin==========================================
	@RequestMapping(value = "paginationProduct", method=RequestMethod.POST)
	public ResponseEntity<List<Product>> paginationProduct(@RequestBody int page, HttpServletRequest request) {
		userInformation = new UserInformation(request);
		
		//intialize	
		int from_limit = 0, to_limit = 0;
		String order = "DESC";
		if(page == 1) { // First
			from_limit = 0;
			to_limit = page * 100;
		} else if ( page == 0 ) { // Last
			order = "ASC";
			from_limit = page;
			to_limit = 10;
		} else {
			from_limit = (page * 10) + 1;
			to_limit =  (page + 10 ) * 10;
		}
		
		List<Product> productList=productDao.getProductWithLimit(from_limit, to_limit, order); 
		return new ResponseEntity<List<Product>>(productList,HttpStatus.OK);
		
	}
	
	//=================CHECK PRODUCT NAME=====================================
	@RequestMapping(value="checkProductName",method=RequestMethod.POST,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Void> checkProductName(@RequestBody String name,HttpServletRequest request){		 
		String status=productDao.checkProductName(name.trim());
		if(status=="AVAILABLE"){
			return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);			
		}else{
			return	new ResponseEntity<Void>(HttpStatus.OK);
		}			
	}
	//======================================product Inactive==========================================
	@RequestMapping(value="productStaus/{status}",method=RequestMethod.POST,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Void> productInActive(@RequestBody int[] idArray,@PathVariable("status") String status,HttpServletRequest request){	
		
		System.out.println(status+"464644");
		//intialize		
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
		
		try {
			
			
			for(int i=0;i<idArray.length;i++){				
				Product product=productDao.getProduct(idArray[i]);			
				//set variable	
				if(status.trim().equals("InActive") ||status.trim()=="InActive" ){
					product.setActive("N");					
				}else{
					product.setActive("Y");
				}	
				
				product.setUpdated_by(Integer.parseInt(request.getSession().getAttribute("userid").toString()));
				product.setUpdated_datetime(dateFormat.format(date));
				productDao.saveOrUpdate(product);
			}
				return new ResponseEntity<Void>(HttpStatus.OK);
			
		} catch (Exception e) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS,e);
			e.printStackTrace();
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
	}

	//======================================product active==========================================
	@RequestMapping(value="productActive",method=RequestMethod.POST,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Void> productActive(@RequestBody int[] idArray,HttpServletRequest request){
		return null;
	}
	
	//======================================save product==========================================
	@RequestMapping(value="productSave",method=RequestMethod.POST,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Void> saveProduct(@RequestBody Product product,HttpServletRequest request){
	System.out.println("++ inside location save");
		
		//intialize	
		String userid = request.getSession().getAttribute("userid").toString();		
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
		
		//set variable
		product.setCreated_by(Integer.parseInt(userid));
		product.setUpdated_by(Integer.parseInt(userid));
		product.setCreated_datetime(dateFormat.format(date));
		product.setUpdated_datetime(dateFormat.format(date));
		product.setObsolete("N");
		product.setActive("Y");
		
		//save product
		try {
			productDao.saveOrUpdate(product);
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
			return new ResponseEntity<Void>(HttpStatus.CREATED);
		} catch (Exception e) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS,e);
			e.printStackTrace();
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}	
		
	}

	//======================================search product by 4 strings==========================================
	@RequestMapping(value = "searchProuct4String", method=RequestMethod.POST)
	public ResponseEntity<List<Product>> searchProuct4String(@RequestBody String SearchString, HttpServletRequest request) {
		
	
			List<Product> productList = productDao.searchByProduct(SearchString);
		
			/*if(productList.isEmpty()){
				return new ResponseEntity<List<Product>>(HttpStatus.NO_CONTENT);
			}*/
			return new ResponseEntity<List<Product>> (productList, HttpStatus.OK);
	
	}
	//======================================fetch all product==========================================
	@RequestMapping(value="fetchAllProduct",method=RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<Product>> getFetchAllProduct(){
		List<Product> productList=productDao.getProductBy100();
		if(productList.isEmpty()){
			return new ResponseEntity<List<Product>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<Product>>(productList,HttpStatus.OK);
	}
	
	
	//======================================sort by==========================================
	@RequestMapping(value="sortBy/{name}",method=RequestMethod.POST,produces=MediaType.APPLICATION_JSON_VALUE)
	public  ResponseEntity<List<Product>>  sortBy(@RequestBody String status,@PathVariable("name") String name,HttpServletRequest request){
		
		String sortBy="";
		
		switch(name.trim()){
		case "productName":
			 sortBy="product_name";
			break;
		case "productCode":
			 sortBy="product_code";
			break;
		case "productType":
			 sortBy="product_Type";
			break;
		case "maxWeigt":
			 sortBy="max_weight";
			break;
		case "dimenSetUp":
			 sortBy="dimension_flag";
			break;
		case "maxHeigt":
			 sortBy="max_height";
			break;			
		case "maxWidth":
			 sortBy="max_width";
			break;			
		case "maxlength":
			 sortBy="max_length";
			break;			
		case "settingStatus":
			 sortBy="active";
			break;			
		default:
			break;
		}
		
		List<Product> productList=new ArrayList<>();
		
		try {
			productList=productDao.getProductBySorting100(sortBy.trim(),status.trim().equals("ASC")?"ASC":"DESC");
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
			if(productList.isEmpty()){
				return new ResponseEntity<List<Product>>(HttpStatus.NO_CONTENT);
			}
			return new ResponseEntity<List<Product>>(productList,HttpStatus.OK);
		} catch (Exception e) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS,e);
			e.printStackTrace();
			return new ResponseEntity<List<Product>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}	
	}
		
	
	//======================================get the object==========================================
	@RequestMapping(value="ProductModel",method=RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Product> getProduct(){		
		return new ResponseEntity<Product>(new Product(),HttpStatus.OK);
	}

	//======================================update Product==========================================
	@RequestMapping(value="/updateProduct/{id}",method=RequestMethod.PUT)
	public ResponseEntity<Void> updateLocation(@PathVariable("id") long id,
			HttpServletRequest request,@RequestBody Product product){
		
		System.out.println("++ updating Product "+id);
		
		Product productFromDb=productDao.getProduct((int)id);		
		
		//check for null
		if(productFromDb==null){
			return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
		}
		
		//intialize		
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
		
		//set variable		
		product.setUpdated_by(Integer.parseInt(request.getSession().getAttribute("userid").toString()));
		product.setUpdated_datetime(dateFormat.format(date));
		

		try {
			productDao.saveOrUpdate(product);
			return new ResponseEntity<Void>(HttpStatus.OK);	
		} catch (Exception e) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS,e);
			e.printStackTrace();
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}	
		
	}

	//======================================delete product==========================================
	@RequestMapping(value="/productDelete/{id}",method=RequestMethod.DELETE,
	produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> deleteLocation(@PathVariable("id") long id,
	HttpServletRequest request){
	

		System.out.println("++ deleting Product "+id);
		Product productFromDb=productDao.getProduct((int)id);
		ShipmentDetailModel shipmentDetail = shipmentDao.getProductid((int)id);
		ShipmentHsnDetailModel shipmentHsnDetail = shipmentDao.getProcductID((int)id);
		PriceSetting priceSetting = psDao.getProductId((int)id);
		
		//check for null
		if(productFromDb==null){
			return new ResponseEntity<String>(HttpStatus.NOT_FOUND);
		}
		
		//intialize		
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
		
		//set variable
		productFromDb.setUpdated_by(Integer.parseInt(request.getSession().getAttribute("userid").toString()));
		productFromDb.setUpdated_datetime(dateFormat.format(date));
		productFromDb.setObsolete("Y");
		productFromDb.setActive("N");
		
		
		try {
			if(shipmentDetail == null && shipmentHsnDetail == null && priceSetting == null)  {
				productDao.saveOrUpdate(productFromDb);
				return new ResponseEntity<String>(HttpStatus.OK);
			} else {
				System.out.println("Product else ========================");
				return new ResponseEntity<String>("referred someone table",HttpStatus.IM_USED);
			
			}
			
		} catch (Exception e) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS,e);
			e.printStackTrace();
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	//======================================display page==========================================
	@RequestMapping(value =  "product", method = RequestMethod.GET)
	public ModelAndView adminPage(HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		
		UserInformation userinfo = new UserInformation(request);
		String username = userinfo.getUserName();
		
		String userid = userinfo.getUserId();
		
		session.setAttribute("username", username);
		session.setAttribute("userid", userid);
		
		
		ModelAndView model = new ModelAndView();
			
		
		try
		{ 
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			
			model.addObject("title", "Product Master");
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.setViewName("Masters/product");
			model.addObject("homePage",request.getContextPath());

			System.err.println(request.getContextPath());
			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;

	}
	
	//======================================print product==========================================
	@RequestMapping(value="product_print",method=RequestMethod.POST)
	public ModelAndView productPrint(HttpServletRequest request,
			@RequestParam("SelectedProduct") String selectedProduct) throws IOException{
			
		ObjectMapper mapper=new ObjectMapper();
		
		List<Product> productList=null;
		
		
		try {
			JSONArray jsonProductArray=new JSONArray(selectedProduct);
			
			String[] product_id=new String[jsonProductArray.length()];
			productList = new ArrayList<Product>();
			
			for(int i=0;i<jsonProductArray.length();i++){
				JSONObject productObject=jsonProductArray.getJSONObject(i);
				Product product=productDao.getProduct(productObject.getInt("product_id"));
				productList.add(product);
			}
		} catch (Exception e1) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), "Json parse error", e1);
			e1.printStackTrace();
		}
		
		Company company = companySettingDAO.getById(1);
		String base64DataString = "";
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

		ModelAndView model = new ModelAndView("print/product_print");
		
		model.addObject("title", "Product");
		model.addObject("company", company);
		model.addObject("productList", productList);
		model.addObject("image",base64DataString);
		return model;
	}

	
	
}
