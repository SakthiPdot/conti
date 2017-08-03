package com.conti.manifest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.hibernate.Query;
import org.hibernate.SessionFactory;

import com.conti.manifest.*;
import com.conti.master.customer.CustomerModel;

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
	public List<ManifestModel> getAllManifest(int manifest_origin) 
	{
		// TODO Auto-generated method stub
		
		@SuppressWarnings("unchecked")
		List<ManifestModel> listmanifest = (List<ManifestModel>) sessionFactory.getCurrentSession()
				.createQuery("from ManifestModel WHERE obsolete ='N' and manifest_origin ="+manifest_origin).list();
		return listmanifest;
		
	}
	
	@Override
	@Transactional
	public List<ManifestModel> getAllManifests(int manifest_origin) 
	{
		// TODO Auto-generated method stub
		
		@SuppressWarnings("unchecked")
		List<ManifestModel> listmanifest = (List<ManifestModel>) sessionFactory.getCurrentSession()
				.createQuery("from ManifestModel WHERE obsolete ='N' and branchModel1.branch_id ="+manifest_origin).list();
		return listmanifest;
		
	}
	
/*------------------------------- Get Manifest by id begin -----------------------*/
	
	@Override
	@Transactional
	public ManifestModel getManifestbyId(int id) {
		String hql = "FROM ManifestModel WHERE obsolete ='N' and manifest_id ="+ id + "";
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		
		List<ManifestModel> manifestlist = (List<ManifestModel>) query.list();
		if(manifestlist != null && !manifestlist.isEmpty()) {
			return manifestlist.get(0);
		}
		return null;
	}
	
	/*------------------------------- Get Manifest by id begin -----------------------*/	
	
	//---------------Manifest Filter by Filter Condition Start---------------------------
	
	@Override
	@Transactional
	public List<ManifestModel>getManifestByCondition(int frombranch,int tobranch,String fromdate,String todate)
	{
		@SuppressWarnings("unchecked")
		List<ManifestModel> listmanifest = (List<ManifestModel>) sessionFactory.getCurrentSession()
				.createQuery("FROM ManifestModel WHERE obsolete ='N' and manifest_origin="+frombranch 
				+" AND manifest_origin ="+tobranch
				+" AND created_datetime BETWEEN '"+fromdate+" 00:00:00'"
				+" AND '"+todate+" 23:59:59'").list();
		return listmanifest;
	}
	
	
	//---------------------------------Get inward manifest list Start----------------------------------
	@Override
	@Transactional
	public List<ManifestModel> getInwardManifest(int branch_id) 
	{
		// TODO Auto-generated method stub
		
		@SuppressWarnings("unchecked")
		List<ManifestModel> listmanifest = (List<ManifestModel>) sessionFactory.getCurrentSession()
				.createQuery("from ManifestModel WHERE obsolete ='N' and manifest_destination = " + branch_id ).list();
		return listmanifest;
		
	}
	
	//------------------------------Get inward manifest list End--------------------------------------
	
	
	
	//-----------------------------------Get inward manifest list Start------------------------------------------
		@Override
		@Transactional
		public List<ManifestModel> getOutwardManifest(int branch_id) 
		{
			// TODO Auto-generated method stub
			
			@SuppressWarnings("unchecked")
			List<ManifestModel> listmanifest = (List<ManifestModel>) sessionFactory.getCurrentSession()
					.createQuery("from ManifestModel WHERE obsolete ='N' and manifest_origin = " + branch_id ).list();
			return listmanifest;
			
		}
		
	//-------------------------------Get inward manifest list End-----------------------------------------------
		
	//-------------------------------------Get Manifest Search by Start----------------------------------------------
		
		@Override
		@Transactional
		public List<ManifestModel>manifestSearch(String searchkey)
		{
			@SuppressWarnings("unchecked")
			
			List<ManifestModel> listManifest=(List<ManifestModel>)sessionFactory.getCurrentSession()
			.createQuery("from ManifestModel where obsolete='N' and manifest_number LIKE '%"+searchkey+"%'").list();
			return listManifest;
		}
		
	//-------------------------------------Get Manifest Search by End----------------------------------------------	
		
		
		
		
		
		//+++++++++++++++++++++++++++ MANIFEST DETAILED IMPLEMENTATION START ++++++++++++++++++++++++++++++
		
	//-------------------Get all Manifest detailed list-----------------------------------------
		@Override
		@Transactional
		public List<ManifestDetailedModel> getAllManifestDetailes(int manifest_id) 
		{
			// TODO Auto-generated method stub
			
			@SuppressWarnings("unchecked")
			List<ManifestDetailedModel> listmanifestdetailed = (List<ManifestDetailedModel>) sessionFactory.getCurrentSession()
					.createQuery("from ManifestDetailedModel WHERE manifest_id ="+manifest_id).list();
			return listmanifestdetailed;
			
		}
		
	//------------------------------------------------------------------------------------------
		
		
		
		//+++++++++++++++++++++++++++ MANIFEST DETAILED IMPLEMENTATION END +++++++++++++++++++++++++++++++
		
		
		
		
		
		
		
		
}
