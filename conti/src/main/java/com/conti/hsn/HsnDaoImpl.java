package com.conti.hsn;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 * @Project_Name conti
 * @Package_Name com.conti.hsn
 * @File_name HsnDaoImpl.java
 * @author Sankar
 * @Created_date_time Aug 2, 2017 12:45:01 PM
 * @Updated_date_time Aug 2, 2017 12:45:01 PM
 */

@Repository
public class HsnDaoImpl implements HsnDao {

	
	@Autowired
	private SessionFactory sessionFactory;
	
	/* (non-Javadoc)
	 * @see com.conti.hsn.HsnDao#searchbyHsnCode(java.lang.String)
	 */
	
	
	
	@Override
	@Transactional
	public List<Hsn> searchbyHsnCode(String search_key) {
		// TODO Auto-generated method stub
		
		@SuppressWarnings("unchecked")
		List<Hsn> listHSN = sessionFactory.getCurrentSession()
				.createQuery("from Hsn WHERE obsolete = 'N' and hsn_code LIKE '%"+ search_key +"%'").list();
		return listHSN;
	}
	
	

	@Override
	@Transactional
	public List<Hsn> searchbyHsnDescription(String search_key) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		List<Hsn> listHSN = sessionFactory.getCurrentSession()
				.createQuery("from Hsn WHERE obsolete = 'N' and hsn_description LIKE '%"+ search_key +"%'").list();
		return listHSN;
	}



	@Override
	@Transactional
	public List<Hsn> getAllHsn() {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		List<Hsn> listHSN = sessionFactory.getCurrentSession()
				.createQuery("from Hsn WHERE obsolete = 'N'").list();
		return listHSN;
	}

}
