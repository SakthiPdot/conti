package com.conti.shipment.add;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.conti.master.location.Location;

/**
 * @Project_Name conti
 * @Package_Name com.conti.shipment.add
 * @File_name ShipmentDaoImpl.java
 * @author Sankar
 * @Created_date_time Jul 27, 2017 5:05:06 PM
 * @Updated_date_time Jul 27, 2017 5:05:06 PM
 */
@Repository
public class ShipmentDaoImpl implements ShipmentDao {

	/* (non-Javadoc)
	 * @see com.conti.shipment.add.ShipmentDao#fetchAllShipment()
	 */
	@Autowired
	private SessionFactory sessionFactory;
	@Override
	@Transactional
	public List<ShipmentModel> fetchAllShipment(int branch_id) {
		// TODO Auto-generated method stub
		
		@SuppressWarnings("unchecked")
		List<ShipmentModel> listShipment = sessionFactory.getCurrentSession()
				.createQuery("from ShipmentModel WHERE obsolete = 'N' and senderbranch_id = " + branch_id).list();
		return listShipment;
	}
	
	@Override
	@Transactional
	public int shipmentCount(){
		int recCount=((Long)sessionFactory.getCurrentSession().
				createQuery("select count(*) from ShipmentModel WHERE obsolete='N'").
				uniqueResult()).intValue();
		return recCount;
	}
	
	
	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public List<ShipmentModel> fetchShipmentWithLimit(int from, int to, String order) {
		return sessionFactory.getCurrentSession()
				.createQuery("from ShipmentModel where obsolete ='N'"
						+ "order by IFNULL(updated_datetime,created_datetime) "+order)
					.setFirstResult(from).setMaxResults(to).list();
	}

	
	
	
	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public List<ShipmentModel> fetchAllShipment100() {
		@SuppressWarnings("unchecked")
		List<ShipmentModel> listShipment = sessionFactory.getCurrentSession()
				.createQuery("from ShipmentModel WHERE obsolete = 'N'"
						+ "and  status in ('Booked','Missing')" )
				.setMaxResults(100).list();
		
		return listShipment;
	}
	
	
	
	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public List<ShipmentModel> fetchAllShipment100Manifest(int branch_id) {
		@SuppressWarnings("unchecked")
		List<ShipmentModel> listShipment = sessionFactory.getCurrentSession()
				.createQuery("from ShipmentModel WHERE obsolete = 'N'"
						+ "and sender_branch.branch_id='"+branch_id+"' "
						+ "and  status in ('Booked','Missing')" )
				.setMaxResults(100).list();
		
		return listShipment;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public List<ShipmentModel> fetchAllShipment() {
		@SuppressWarnings("unchecked")
		List<ShipmentModel> listShipment = sessionFactory.getCurrentSession()
				.createQuery("from ShipmentModel WHERE obsolete = 'N'"
						+ "and  status in ('Booked','Missing')" ).list();
		
		return listShipment;
	}
	
	
	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public List<ShipmentModel> fetchShipmentByLR(String searchString,int branch_id) {
		@SuppressWarnings("unchecked")
		List<ShipmentModel> listShipment = sessionFactory.getCurrentSession()
				.createQuery("from ShipmentModel WHERE obsolete = 'N'"
						+ "and  lr_number LIKE '%"+searchString+ "%'"
								+ "and sender_branch.branch_id='"+branch_id+"' "
								+ "and  status in ('Booked','Missing') ")
				
				.setMaxResults(100).list();
		
		return listShipment;
	}
	
	
	
	@Override
	@Transactional
	public List<ShipmentModel> filterShipment(String fromBranch, String toBranch, String fromDate,String toDate,String status)
	{
		StringBuilder queryString =new StringBuilder();
		queryString.append("FROM ShipmentModel WHERE obsolete ='N' ");
		
		if(fromBranch!=null && !fromBranch.trim().isEmpty())
			queryString.append(" AND sender_branch.branch_id='"+fromBranch+"' ");
		if(toBranch!=null && !toBranch.trim().isEmpty())
			queryString.append(" AND consignee_branch.branch_id='"+toBranch+"' ");
		if(fromDate!=null && !fromDate.trim().isEmpty())			
			queryString.append(" AND shipment_date >= '"+fromDate+" 00:00:00'");
		if(toDate!=null && !toDate.trim().isEmpty())
			queryString.append(" AND shipment_date <= '"+toDate+" 00:00:00'");
		
		if(status!=null && !status.trim().isEmpty()){
			queryString.append(" AND status = '"+status+"' ");
		}else{
			queryString.append("AND  status in ('Booked','Missing') ");
		}
		
		@SuppressWarnings("unchecked")
		List<ShipmentModel> listShipment = (List<ShipmentModel>) sessionFactory.getCurrentSession()
				.createQuery(queryString.toString()).list();
		
		return listShipment;
		
	}
	
	
	
	@Override
	@Transactional
	public String fetchMAXlrno_prefix(int branch_id) {
		// TODO Auto-generated method stub
		String lrno = null;
		Query query = sessionFactory.getCurrentSession()
				.createQuery("Select lrno_prefix from ShipmentModel WHERE " 
						+ " lr_number = (SELECT MAX(lr_number) FROM ShipmentModel WHERE sender_branch.branch_id= "+ branch_id + ")");
		if(query.uniqueResult() == null) {
			return lrno;
		} else {
			lrno = query.uniqueResult().toString();
			return lrno;
		}
	}
	
	@Override
	@Transactional
	public int fetchMAXlrno(int branch_id) {
		// TODO Auto-generated method stub
		int lrno = 0;
		Query query = sessionFactory.getCurrentSession()
				.createQuery("Select MAX(lr_number) from ShipmentModel WHERE sender_branch.branch_id= " + branch_id);
		if(query.uniqueResult() == null) {
			return lrno;
		} else {
			lrno = Integer.parseInt(query.uniqueResult().toString());
			return lrno;
		}
	}
	
	@Override
	@Transactional
	public void saveOrUpdate(ShipmentModel shipment) {
		// TODO Auto-generated method stub
		
		sessionFactory.getCurrentSession().saveOrUpdate(shipment);
		
	}
	
	
	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public ShipmentModel getshipmentby_lrno(int lrno) {
		// TODO Auto-generated method stub
		
		String hql = "FROM ShipmentModel WHERE obsolete = 'N' and lr_number = " + lrno;
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		
		List<ShipmentModel> shipmentList = (List<ShipmentModel>)query.list();
		if ( shipmentList != null && !shipmentList.isEmpty()) {
			return shipmentList.get(0);
		}
		return null;
	}
	
	
	
	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public ShipmentModel getShipmentModelById(int shipmentId) {
		
		String hql = "FROM ShipmentModel WHERE obsolete = 'N' and shipment_id = " + shipmentId;
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		
		List<ShipmentModel> shipmentList = (List<ShipmentModel>)query.list();
		if ( shipmentList != null && !shipmentList.isEmpty()) {
			return shipmentList.get(0);
		}
		return null;
	}

	
	//========================================4 RECEIPT===========================================
	
	//----------------------------------------------Receipt Filter condition start-------------------------------------------------------
	@Override
	@Transactional
	public List<ShipmentModel>getShipmentByCondition(int frombranch,int tobranch,String fromdate,String todate,String service,String paymode)
	{
		@SuppressWarnings("unchecked")
		List<ShipmentModel> listShipment=(List<ShipmentModel>)sessionFactory.getCurrentSession()
			.createQuery("from ShipmentModel where obsolete='N'"
		+" and sender_branch.branch_id="+frombranch
		//+" and consignee_branch.branch_id="+tobranch
		+" and created_datetime BETWEEN '"+fromdate+" 00:00:00'"
		+" and '"+todate+" 23:59:59'"
		+" and pay_mode='"+paymode+"'"
					).list(); 	 	
		return listShipment;
	}
	//------------------------------------------------------------------------------------------------------------------------------------
	
	//--------------------------Fetch all shipment details--------------------------------------
	@Override
	@Transactional
	public List<ShipmentModel> fetchAllShipment4receipt(int branch_id) {
		// TODO Auto-generated method stub
		
		@SuppressWarnings("unchecked")
		List<ShipmentModel> listShipment = sessionFactory.getCurrentSession()
				.createQuery("from ShipmentModel WHERE obsolete = 'N' and status ='Received'"
						+ " and senderbranch_id = " + branch_id).list();
		return listShipment;
	}
 //----------------------------------------------------------------------------
	@Override
	@Transactional
	public List<ShipmentModel>searchLRnumber(String searchkey)
	{
		@SuppressWarnings("unchecked")
		List<ShipmentModel> listShipment=(List<ShipmentModel>)sessionFactory.getCurrentSession()
		.createQuery("from ShipmentModel where obsolete='N' and lr_number like '%"+searchkey+"%'").list();
		return listShipment;
	}




	
//==============================================================================================
	
	//====== Delete in foreign key check process ==================//
	@Override
	@Transactional
	public ShipmentModel getServiceId(int serviceid) {
		@SuppressWarnings("unchecked")
		List<ShipmentModel> getServiceList = sessionFactory.getCurrentSession()
				.createQuery("from ShipmentModel where obsolete = 'N' and service_id = "+serviceid).list();
		if(getServiceList!= null && !getServiceList.isEmpty()){			
			return getServiceList.get(0);
		}
		return null;
	}




	@Override
	@Transactional
	public ShipmentModel getCustomerId(int customerid,int ccustomerid) {
		@SuppressWarnings("unchecked")
		List<ShipmentModel> getCustomerList = sessionFactory.getCurrentSession()
				.createQuery("from ShipmentModel where obsolete = 'N' and sendercustomer_id = "+customerid+" OR consigneecustomer_id='"+ccustomerid+"'").list();
		if(getCustomerList!= null && !getCustomerList.isEmpty()){
			return getCustomerList.get(0);
		}
		return null;
	}




	@Override
	@Transactional
	public ShipmentModel getLocationId(int slocationid,int clocationid) {
		@SuppressWarnings("unchecked")
		List<ShipmentModel> getLocationid = sessionFactory.getCurrentSession()
				.createQuery("from ShipmentModel where obsolete = 'N' and sendercustomer_location_id = "+slocationid+" OR consigneecustomer_location_id = '"+clocationid+"'").list();
		if(getLocationid!= null && !getLocationid.isEmpty()){
			return getLocationid.get(0);
		}
		return null;
	}


	@Override
	@Transactional
	public List<ShipmentModel> fetchshipmentforView(int branch_id) { // View Shipment for Manager and Staff
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		List<ShipmentModel> listShipment = sessionFactory.getCurrentSession()
				.createQuery("from ShipmentModel WHERE obsolete = 'N'"
						+ "and sender_branch.branch_id=" + branch_id
						+ "and  status in ('Booked','Intransit','Pending','Return')" )
				.setMaxResults(100).list();
		
		return listShipment;		
	}




	@Override
	@Transactional
	public List<ShipmentModel> fetchshipmentforView() { // View shipment for SuperAdmin
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		List<ShipmentModel> listShipment = sessionFactory.getCurrentSession()
				.createQuery("from ShipmentModel WHERE obsolete = 'N'"
						+ "and  status in ('Booked','Intransit','Pending','Return')" )
				.setMaxResults(100).list();
		
		return listShipment;
	}

	@Override
	@Transactional
	public ShipmentModel getBranchId(int sbranch_id, int cbranch_id) {
		@SuppressWarnings("unchecked")
		List<ShipmentModel> getbranchId = sessionFactory.getCurrentSession()
				.createQuery("from ShipmentModel WHERE obsolete = 'N' and senderbranch_id=" +sbranch_id+" OR consigneebranch_id='" +cbranch_id+"'").list();
		if(getbranchId != null && !getbranchId.isEmpty()){
			return getbranchId.get(0);
		}
		return null;
	}

	@Override
	@Transactional
	public ShipmentDetailModel getProductid(int product_id) {
		@SuppressWarnings("unchecked")
		List<ShipmentDetailModel> getproductid = sessionFactory.getCurrentSession()
				.createQuery("from ShipmentDetailModel where product_id= "+product_id).list();
		if(getproductid != null && !getproductid.isEmpty()){
			return getproductid.get(0);
		}
		return null;
	}

	@Override
	@Transactional
	public ShipmentHsnDetailModel getProcductID(int productid) {
		@SuppressWarnings("unchecked")
		List<ShipmentHsnDetailModel> getidProduct = sessionFactory.getCurrentSession()
				.createQuery("from ShipmentHsnDetailModel where product_id ="+productid ).list();
		if(getidProduct != null && !getidProduct.isEmpty()){
			return getidProduct.get(0);
		}
		return null;
	}

	
}
