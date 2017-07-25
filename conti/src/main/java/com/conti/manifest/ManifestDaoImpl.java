package com.conti.manifest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.hibernate.SessionFactory;

import com.conti.manifest.*;

/**
 * @Project_Name conti
 * @Package_Name com.conti.master.manifest.add
 * @File_name AddManifestDaoImpl.java
 * @author Suresh
 * @Created_date_time July 24, 2017 3:31:53 PM
 * @Updated_date_time July 24, 2017 3:31:53 PM
 */

@Repository
public class ManifestDaoImpl implements ManifestDao
{
	
	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	@Transactional
	public List<ManifestModel> getManifest(int branch_id) 
	{
		// TODO Auto-generated method stub
		
		@SuppressWarnings("unchecked")
		List<ManifestModel> listmanifest = (List<ManifestModel>) sessionFactory.getCurrentSession()
				.createQuery("from ManifestModel WHERE obsolete ='N' and branch_id = " + branch_id ).list();
		return listmanifest;
		
	}
	
	
	
	@Override
	@Transactional
	public List<ManifestModel> getAllManifest(int branch_id) 
	{
		// TODO Auto-generated method stub
		
		@SuppressWarnings("unchecked")
		List<ManifestModel> listmanifest = (List<ManifestModel>) sessionFactory.getCurrentSession()
				.createQuery("from ManifestModel WHERE obsolete ='N' and branch_id = " + branch_id ).list();
		return listmanifest;
		
	}
}
