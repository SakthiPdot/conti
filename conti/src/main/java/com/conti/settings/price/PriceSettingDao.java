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
	public List<PriceSetting> getPriceSettingBy100();
	public PriceSetting getPriceSettingById(int priceSettingId);
	public void deletePriceSettingById(int priceSettingId);
	public List<PriceSetting> getPriceSettingWithLimit(int from ,int to ,String order);
	public List<PriceSetting> searchByPriceSetting(String searchString);
	public int priceSettingCount();
	
	//---------------------------------------- FETCH PRICE BY from branch & product & service for add shipment by sankar
	public PriceSetting fetchprice(int from_branch, int product, int service);
	
}
     