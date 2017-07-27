package com.conti.settings.price;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 * @Project_Name conti
 * @Package_Name com.conti.settings.price  com.conti.settings.price
 * @File_name PriceSettingDetailDaoImpl.java com.conti.settings.price
 * @author Monu.C
 * @Created_date_time Jul 26, 2017 12:28:32 PM
 */

@Repository
public class PriceSettingDetailDaoImpl implements PriceSettingDetailDao {
	
	@Autowired
	private SessionFactory sessionFactory;

	public PriceSettingDetailDaoImpl() {
	}

	@Override
	@Transactional
	public List<PriceSettingDetail> getPriceSettingDetailBypsId(int priceSettingId) {
		

		return sessionFactory.getCurrentSession()
				.createQuery("from PriceSettingDetail where pricesetting_id="+priceSettingId).list();
		
	}
	
	
	
}
