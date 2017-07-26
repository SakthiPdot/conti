package com.conti.settings.price;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.conti.master.location.Location;

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
				.createQuery("from PriceSetting where pricesetting_id="+priceSettingId).list();
		
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
		createQuery("update PriceSetting  set obsolete='Y', active='N' where pricesetting_id="+priceSettingId )
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
	public List<PriceSetting> searchByLocation(String searchString) {
		return sessionFactory.getCurrentSession()
				.createQuery("from PriceSetting where obsolete ='N'").list();
	}



}
