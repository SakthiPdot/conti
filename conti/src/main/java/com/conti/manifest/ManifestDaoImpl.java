package com.conti.manifest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.hibernate.Query;
import org.hibernate.SessionFactory;


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
	public ManifestModel getManifestByID(int manifestId) 
	{
		// TODO Auto-generated method stub
		
		@SuppressWarnings("unchecked")
		List<ManifestModel> listmanifest = (List<ManifestModel>) sessionFactory.getCurrentSession()
				.createQuery("from ManifestModel WHERE obsolete ='N' and manifest_id = " + manifestId ).list();
		
		return listmanifest.get(0);
		
	}
	@Override
	@Transactional
	public int fetchLastManifestNo(){
		int lastManifestNo=0;
		Query query=sessionFactory.getCurrentSession().createQuery("select MAX(manifest_number) from ManifestModel WHERE obsolete = 'N'");
		return (query.uniqueResult()==null)?lastManifestNo:Integer.parseInt(query.uniqueResult().toString());
	}
	
	@Override
	@Transactional
	public int fetchLastManifestNoWithOriginAndDestination(int manifest_origin,int manifest_destination){
		int lastManifestNo=0;
		Query query=sessionFactory.getCurrentSession().createQuery("select MAX(manifest_number) from ManifestModel WHERE obsolete = 'N'"
				+ "and manifest_origin ="+manifest_origin
				+ "and manifest_destination ="+manifest_destination);
		
		return (query.uniqueResult()==null)?lastManifestNo:Integer.parseInt(query.uniqueResult().toString());
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
	
	
	@Override
	@Transactional
	public ManifestModel getLastManifestModel() {
		@SuppressWarnings("unchecked")
		List<ManifestModel> manifestlist = (List<ManifestModel>) sessionFactory.getCurrentSession()
				.createQuery("from ManifestModel where obsolete ='N' "
						+ "ORDER BY IFNULL(created_datetime, created_datetime) DESC")
				.list();
		
		if(manifestlist != null && !manifestlist.isEmpty()) {
			return manifestlist.get(0);
		}
		return null;
	}
	/*------------------------------- Get Manifest by id begin -----------------------*/	
	
	//------------------------Manifest Filter by Filter Condition Start---------------------------
	@Override
	@Transactional
	public List<ManifestModel>getManifestByCondition(int frombranch,int tobranch,String fromdate,String todate)
	{
		@SuppressWarnings("unchecked")
		List<ManifestModel> listmanifest = (List<ManifestModel>) sessionFactory.getCurrentSession()
				.createQuery("FROM ManifestModel WHERE obsolete ='N' and manifest_origin="+frombranch 
				+" AND manifest_destination ="+tobranch
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
	//--------------------------------------------------------------------------------------------------
		
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
		
	//-------------------------------------Manifest Save and Update function---------------------------------------
		
		@Override
		@Transactional
		public void saveOrUpdate(ManifestModel manifestModel)
		{
			sessionFactory.getCurrentSession().saveOrUpdate(manifestModel);
		}
		
		
		
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
		
		
		//===== Referred Delete Process in Foreign key =========//	
		
		@Override
		@Transactional
		public ManifestModel getVehicleId(int vehicleid) {
			@SuppressWarnings("unchecked")
			List<ManifestModel> getvehicleId = sessionFactory.getCurrentSession()
					.createQuery("from ManifestModel where vehicle_number=" +vehicleid).list();
			if(getvehicleId != null && !getvehicleId.isEmpty()){
				return getvehicleId.get(0);
			}
			return null;
		}



		@Override
		@Transactional
		public ManifestModel getEmployeeId(int employeeid) {
			@SuppressWarnings("unchecked")
			List<ManifestModel> getemployeeId = sessionFactory.getCurrentSession()
					.createQuery("from ManifestModel where driver_name="+employeeid).list();
			if(getemployeeId != null && !getemployeeId.isEmpty()){
				return getemployeeId.get(0);
			}
			return null;
		}
		
		
		
}
