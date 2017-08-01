package com.conti.settings.price;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.conti.setting.usercontrol.User;

/**
 * @Project_Name conti
 * @Package_Name com.conti.settings.price  com.conti.settings.price
 * @File_name PriceSettingDaoImpl.java com.conti.settings.price
 * @author Monu.C
 * @Created_date_time Jul 20, 2017 11:16:22 AM
 */
@Repository
public class PriceSettingDaoImpl implements PriceSettingDao {


	@Autowired
	private SessionFactory sessionFactory;
	
	public PriceSettingDaoImpl() {}
	
	
	@Override
	@Transactional
	public int priceSettingCount() {
		int rec_count = ((Long)sessionFactory.getCurrentSession().createQuery("select count(*) from PriceSetting WHERE obsolete = 'N'").uniqueResult()).intValue();
		return rec_count;
	}
	
	@Override
	@Transactional
	public void saveOrUpdate(PriceSetting priceSetting) {
		sessionFactory.getCurrentSession().saveOrUpdate(priceSetting);
	}

	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public List<PriceSetting> getPriceSetting() {
		return sessionFactory.getCurrentSession()
				.createQuery("from PriceSetting where  obsolete ='N' "
						+ "order by IFNULL(updated_datetime,created_datetime)  DESC ")
				.list();
	}


	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public List<PriceSetting> getPriceSettingBy100() {
		return sessionFactory.getCurrentSession()
				.createQuery("from PriceSetting where  obsolete ='N' "
						+ "order by IFNULL(updated_datetime,created_datetime)  DESC ")
				.setMaxResults(100)
				.list();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public PriceSetting getPriceSettingById(int priceSettingId) {
		
		List<PriceSetting> priceSettingList=sessionFactory.getCurrentSession()
				.createQuery("from PriceSetting where obsolete ='N' AND pricesetting_id="+priceSettingId).list();
		
		if(priceSettingList!=null && !priceSettingList.isEmpty()){
			return priceSettingList.get(0);
		}
		return null;
	}

	@Override
	@Transactional
	public void deletePriceSettingById(int priceSettingId) {
		PriceSetting priceSetting=new PriceSetting();
		priceSetting.setPricesetting_id(priceSettingId);
		
		sessionFactory.getCurrentSession().
		createQuery("update PriceSetting  set obsolete='Y', active='N' AND where pricesetting_id="+priceSettingId )
		.executeUpdate();
	}



	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public List<PriceSetting> getPriceSettingWithLimit(int from, int to, String order) {
		return sessionFactory.getCurrentSession()
				.createQuery("from PriceSetting where obsolete ='N'"
						+ "order by IFNULL(updated_datetime,created_datetime) "+order)
					.setFirstResult(from).setMaxResults(to).list();
	}

	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public List<PriceSetting> searchByPriceSetting(String searchString) {
		return sessionFactory.getCurrentSession()
				.createQuery("from PriceSetting where obsolete ='N'"
						+ "and branch.branch_name  LIKE '%"+searchString + "%'"
						+ "OR service.service_name LIKE '%"+searchString+ "%'"
						+ "OR product.product_name LIKE '%"+searchString+ "%'"
						+ "OR product.product_Type LIKE '%"+searchString+ "%'"
						+ "OR default_price LIKE '%"+searchString+ "%'"
						+ "OR defaulthandling_charge LIKE '%"+searchString+ "%'"
						).list();
	}


	//---------------------------------------- FETCH PRICE BY from branch & product & service for add shipment by sankar
	@Override
	@Transactional
	public PriceSetting fetchprice(int from_branch, int product, int service) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		List<PriceSetting> list_pricesetting = (List<PriceSetting>) sessionFactory.getCurrentSession()
				.createQuery("FROM PriceSetting WHERE obsolete = 'N' AND branch.branch_id = " + from_branch
						+ " AND product.product_id =" + product + " AND service.service_id ="+service).list();
		
		if(list_pricesetting != null && !list_pricesetting.isEmpty()) {
			return list_pricesetting.get(0);
		} 
		return null;			
		
	}


	

}
