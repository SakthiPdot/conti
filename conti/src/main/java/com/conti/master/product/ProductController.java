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
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;
import com.conti.settings.company.Company;
import com.conti.settings.company.CompanySettingDAO;

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
	
	Loggerconf loggerconf = new Loggerconf();
	SessionListener sessionListener = new SessionListener();

	//======================================Excel==========================================
	@RequestMapping(value="downloadExcelProduct",method=RequestMethod.GET)
	public ModelAndView downloadExcelProduct(){
		List<Product> productList=productDao.getProduct(); 
		return new ModelAndView("productExcelView","ProductList",productList);
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
	//======================================fetch all product==========================================
	@RequestMapping(value="fetchAllProduct",method=RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<Product>> getFetchAllProduct(){
		List<Product> productList=productDao.getProduct();
		if(productList.isEmpty()){
			return new ResponseEntity<List<Product>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<Product>>(productList,HttpStatus.OK);
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
	public ResponseEntity<Void> deleteLocation(@PathVariable("id") long id,
	HttpServletRequest request){
	

		System.out.println("++ deleting Product "+id);
		Product productFromDb=productDao.getProduct((int)id);
		
		//check for null
		if(productFromDb==null){
			return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
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
			productDao.saveOrUpdate(productFromDb);
			return new ResponseEntity<Void>(HttpStatus.OK);
		} catch (Exception e) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS,e);
			e.printStackTrace();
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
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

			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;

	}
	
	
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
