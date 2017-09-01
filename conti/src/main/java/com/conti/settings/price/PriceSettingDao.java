package com.conti.settings.price;

import java.util.List;
/**
 * @Project_Name conti
 * @Package_Name com.conti.settings.price  com.conti.settings.price
 * @File_name PriceSettingDao.java com.conti.settings.price
 * @author Monu.C
 * @Created_date_time Jul 20, 2017 10:59:16 AM
 */
public interface  PriceSettingDao {

	public void saveOrUpdate(PriceSetting priceSetting);
	
	public List<PriceSetting> getPriceSetting();
	public List<PriceSetting> getPriceSettingStaff(int branch_id);
	
	public List<PriceSetting> getPriceSettingBy100();
	public List<PriceSetting> getPriceSettingBy100staff(int branch_id);

	public int priceSettingCount();
	public int priceSettingCountstaff(int branch_id);
	
	public List<PriceSetting> gePriceSettingSorting100(String name,String order);
	public List<PriceSetting> gePriceSettingSorting100Staff(String name,String order,int branch_id);
	
	public List<PriceSetting> searchByPriceSetting(String searchString);
	public List<PriceSetting> searchByPriceSettingStaff(String searchString,int branch_id);
	
	public List<PriceSetting> getPriceSettingWithLimit(int from ,int to ,String order);
	public List<PriceSetting> getPriceSettingWithLimitStaff(int from ,int to ,String order,int branch_id);
	
	
	public PriceSetting getPriceSettingById(int priceSettingId);
	public PriceSetting getPriceSettingByBSPID(int branchid,int serviceid,int productid);	
	public void deletePriceSettingById(int priceSettingId);
	
	

	

	
	
	
	//---------------------------------------- FETCH PRICE BY from branch & product & service for add shipment by sankar
	public PriceSetting fetchprice(int from_branch, int product, int service);
	
	//===== Referred Delete Process in Foreign key =========//
	public PriceSetting getServiceById(int serviceid);
	public PriceSetting getBranchId(int branchid);	
	public PriceSetting getProductId(int product_id);
	public PriceSetting getUserId(int created_user,int updated_user);
}
     