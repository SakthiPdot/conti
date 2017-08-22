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

	
	//---------------------------------------- FETCH PRICE BY  to pricesetting & branch & productweight for add shipment by sankar
	
	@Transactional
	@Override
	public PriceSettingDetail fetchprice(int priceSettingId, int to_branch, int product_weight) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		List<PriceSettingDetail> list_pricesettingdet = (List<PriceSettingDetail>) sessionFactory.getCurrentSession()
				.createQuery("FROM PriceSettingDetail WHERE priceSetting.pricesetting_id = " + priceSettingId
						+ " AND branch.branch_id =" + to_branch + " AND ps_weightfrom <= "
						+ product_weight + " AND ps_weightto >=" + product_weight).list();
		
		if(list_pricesettingdet != null && !list_pricesettingdet.isEmpty()) {
			return list_pricesettingdet.get(0);
		} 
		return null;
	}
	//===== Referred Delete Process in Foreign key =========//
	@Override
	@Transactional
	public PriceSettingDetail getBranchid(int branch_id) {
		@SuppressWarnings("unchecked")
		List<PriceSettingDetail> getbranch = sessionFactory.getCurrentSession()
				.createQuery("from PriceSettingDetail where tobranch_id="+branch_id).list();
		if(getbranch != null && !getbranch.isEmpty()){
			return getbranch.get(0);
		}
		return null;
	}
	
	
	
	
}
