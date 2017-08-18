package com.conti.settings.company;



import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;



/**
 * @Project_Name conti
 * @Package_Name com.conti.settings.company  com.conti.settings.company
 * @File_name CompanySettingDaoImpl.java com.conti.settings.company
 * @author Monu.C
 * @Created_date_time Jun 22, 2017 3:50:55 PM
 */

@Repository
public class CompanySettingDaoImpl implements CompanySettingDAO {

	@Autowired
	private SessionFactory sessionFactory;
	
	
	public CompanySettingDaoImpl() {
	}

	//================================save==============================	
	@Override
	@Transactional
	public void saveOrUpdate(Company company) {
		sessionFactory.getCurrentSession().saveOrUpdate(company);
	}

	//================================List By ID==============================
	@Override
	@Transactional
	public Company getById(int id) {
		String hql="from Company where company_id = "+id;
		Query query=sessionFactory.getCurrentSession().createQuery(hql);
		@SuppressWarnings("unchecked")
		List<Company> companyList = (List<Company>) query.list();
		if (companyList != null && !companyList.isEmpty()) {
			return companyList.get(0);
		}
		return null;
	}
	//===== Referred Delete Process in Foreign key =========//
	@Override
	@Transactional
	public Company getLocationId(int locationid) {
		@SuppressWarnings("unchecked")
		List<Company> getLocationid = sessionFactory.getCurrentSession()
				.createQuery("from Company where location_id="+locationid).list();
		if(getLocationid != null && !getLocationid.isEmpty()){
			return getLocationid.get(0);
		}
		return null;
	}

}
