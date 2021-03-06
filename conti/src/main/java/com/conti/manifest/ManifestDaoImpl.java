package com.conti.manifest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.conti.master.product.Product;
import com.conti.others.ConstantValues;
import com.conti.receipt.ReceiptDetail;

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
	String Intransit=ConstantValues.INTRANSIT;
	String Incomplete=ConstantValues.INCOMPLETE;
	String Completed=ConstantValues.COMPLETED;
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
	public ManifestModel getManifestByShipmentID(int shipment_id) 
	{
		// TODO Auto-generated method stub
		
		@SuppressWarnings("unchecked")
		List<ManifestDetailedModel> listmanifest = (List<ManifestDetailedModel>) sessionFactory.getCurrentSession()
				.createQuery("from ManifestDetailedModel WHERE shipmentModel.shipment_id = " + shipment_id).list();
		if(listmanifest != null && !listmanifest.isEmpty()) {
			return listmanifest.get(0).getManifestModel();
		}
		return null;
	}
	
	@Override
	@Transactional
	public ManifestModel getManifestIdByShipmentId(int shipmentId) 
	{
		// TODO Auto-generated method stub
		
		@SuppressWarnings("unchecked")
		List<ManifestDetailedModel> listmanifest = (List<ManifestDetailedModel>) sessionFactory.getCurrentSession()
				.createQuery("from ManifestDetailedModel WHERE shipmentModel.shipment_id= " + shipmentId ).list();
		
		
		if(listmanifest != null && !listmanifest.isEmpty()) {
			return listmanifest.get(0).getManifestModel();
		}
		return null;

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
	
	
	//-----------------------------Get all manifest for View Manifest Preload ---------------
	@Override
	@Transactional
	public List<ManifestModel> getAllManifest(int manifest_destination) 
	{
		// TODO Auto-generated method stub
		
		@SuppressWarnings("unchecked")
		List<ManifestModel> listmanifest = (List<ManifestModel>) sessionFactory.getCurrentSession()
				.createQuery("from ManifestModel WHERE obsolete ='N'"
						+" AND manifest_destination="+manifest_destination
						+" AND manifest_status in ('"+Intransit+"','"+Incomplete+"','"+Completed+"')"
						+" order by IFNULL(updated_datetime,created_datetime)  DESC ").list();
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
		
		@SuppressWarnings("unchecked")
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
	public List<ManifestModel>getManifestByCondition(String frombranch,String tobranch,String fromdate,String todate)
	{
		StringBuilder queryString =new StringBuilder();
		queryString.append("FROM ManifestModel WHERE obsolete ='N' ");
		String frombrnch=String.valueOf(frombranch);
		String tobrnch=String.valueOf(tobranch);
		
		if(frombrnch!=null && !frombrnch.trim().isEmpty())
			queryString.append(" AND manifest_origin='"+frombranch+"' ");
		
		if(tobrnch!=null && !tobrnch.trim().isEmpty())
			queryString.append(" AND manifest_destination='"+tobrnch+"' ");
		
		if(fromdate!=null && !fromdate.trim().isEmpty())			
			queryString.append(" AND created_datetime >= '"+fromdate+" 00:00:00'");
		
		if(todate!=null && !todate.trim().isEmpty())
			queryString.append(" AND created_datetime <= '"+todate+" 23:59:59'"); 
		else{
			queryString.append(" AND manifest_status in ('"+Intransit+"','"+Incomplete+"','"+Completed+"')");
		}
		@SuppressWarnings("unchecked")
		List<ManifestModel> listmanifest = (List<ManifestModel>) sessionFactory.getCurrentSession()
		.createQuery(queryString.toString()).list();
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
			.createQuery("from ManifestModel where obsolete='N' and manifest_prefix LIKE '%"+searchkey+"%'").list();
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
		
	//----------------------------------------------Get all Manifest detailed list---------------------------------------------
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
	//---------------------------------------------------------------------------------------------------------------------------

	//----------------------------------------------Get all Manifest detailed by id---------------------------------------------
			@Override
			@Transactional
			public ManifestDetailedModel getAllManifestDetailesByid(int manifestdetailed_id) 
			{
				Query q= sessionFactory.getCurrentSession()
						.createQuery("from ManifestDetailedModel WHERE manifestdetailed_id ="+manifestdetailed_id);
				List<ManifestDetailedModel> listmanifestdetailed=(List<ManifestDetailedModel>) q.list();
				if(listmanifestdetailed!=null){
					return listmanifestdetailed.get(0);
				}
				return null;
			}
	//----------------------------------------Get Shipment from manifest detailed------------------------------------------
	
		@Override
		@Transactional
		public List<Integer> searchShipmentLRnumber(String lr_number)
		{
		
			String hql = "select distinct manifestModel.manifest_id from ManifestDetailedModel where shipmentModel.lrno_prefix LIKE '%"+lr_number+"%'";
			Query query = sessionFactory.getCurrentSession().createQuery(hql);
			@SuppressWarnings("unchecked")
			List<Integer> manifestDetailed= (List<Integer>) query.list();
			return manifestDetailed;
			
		}
	//-------------------------------------------LR number Search for Admin----------------------------------
		
		@Override
		@Transactional
		public List<ManifestDetailedModel>searchLRnumber(String search_key){
			@SuppressWarnings("unchecked")
			List<ManifestDetailedModel> manifestDetailedList=(List<ManifestDetailedModel>)sessionFactory.getCurrentSession()
			.createQuery("from ManifestDetailedModel WHERE shipmentModel.obsolete='N'"
					+ " AND shipmentModel.lrno_prefix LIKE '%" + search_key + "%'"
					+ " OR shipmentModel.created_datetime LIKE '%" + search_key + "%'"
					+ " OR shipmentModel.sender_branch.branch_name LIKE '%" + search_key + "%'"
					+ " OR shipmentModel.consignee_branch.branch_name LIKE '%" + search_key + "%'"
					+ " OR shipmentModel.sender_customer.customer_name LIKE '%" + search_key + "%'"
					+ " OR shipmentModel.consignee_customer.customer_name LIKE '%" + search_key + "%'"
					+ " OR shipmentModel.status LIKE '%" + search_key + "%'").list();
			return manifestDetailedList;
		}
		
	//-------------------------------------------LR number Search for Staff and Manager----------------------------------
	
		@Override
		@Transactional
		public List<ManifestDetailedModel>searchLRnumber(String search_key,int branch_id){
			@SuppressWarnings("unchecked")
			List<ManifestDetailedModel> manifestDetailedList=(List<ManifestDetailedModel>)sessionFactory.getCurrentSession()
			.createQuery("from ManifestDetailedModel WHERE shipmentModel.obsolete='N' "
					+ "	AND shipmentModel.consignee_branch.branch_id="+branch_id
					+ "	AND shipmentModel.lrno_prefix LIKE '%" + search_key + "%'"
					+ " OR shipmentModel.created_datetime LIKE '%" + search_key + "%'"
					+ " OR shipmentModel.sender_branch.branch_name LIKE '%" + search_key + "%'"
					+ " OR shipmentModel.consignee_branch.branch_name LIKE '%" + search_key + "%'"
					+ " OR shipmentModel.sender_customer.customer_name LIKE '%" + search_key + "%'"
					+ " OR shipmentModel.consignee_customer.customer_name LIKE '%" + search_key + "%'"
					+ " OR shipmentModel.status LIKE '%" + search_key + "%'").list();
			return manifestDetailedList;
		}
	
	//-----------------Get Manifest Sorting table---------------------------------
		@SuppressWarnings("unchecked")
		@Override
		@Transactional
		public List<ManifestModel> getManifestbySorting100(String name,String order) {		
			
			return sessionFactory.getCurrentSession()
					.createQuery("from ManifestModel where  obsolete ='N' "
							+ "order by ("+name+")"+  order ).setMaxResults(100)
					.list();
		}
	//-------------------------------------------------------------
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



		@Override
		@Transactional
		public ManifestModel getBranchId(int branch_id) {
			@SuppressWarnings("unchecked")
			List<ManifestModel> getBranchId = sessionFactory.getCurrentSession()
					.createQuery("from ManifestModel where vehicle_destination =" +branch_id).list();
			if(getBranchId != null && !getBranchId.isEmpty()){
				return getBranchId.get(0);
			}
			return null;
		}



		@Override
		@Transactional
		public ManifestModel getUserId(int c_user, int u_user) {
			@SuppressWarnings("unchecked")
			List<ManifestModel> getuser = sessionFactory.getCurrentSession()
					.createQuery("from ManifestModel where created_by="+c_user+"OR updated_by='"+u_user+"'").list();
					if(getuser != null && !getuser.isEmpty()){
						return getuser.get(0);
					}
			return null;
		}
		
	//--------------------Delete Manifest detailed ----------------
		@Override
		@Transactional
		public void deleteManifestDetailed(int id)
		{
		
			 Query query=sessionFactory.getCurrentSession().createQuery("Delete from ManifestDetailedModel where manifest_id="+id);
			query.executeUpdate();
		}
		
}
