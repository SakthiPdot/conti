package com.conti.shipment.add;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.conti.manifest.ManifestModel;
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
	public List<ShipmentModel> fetchShipmentByLR(String searchString) {
		@SuppressWarnings("unchecked")
		List<ShipmentModel> listShipment = sessionFactory.getCurrentSession()
				.createQuery("from ShipmentModel WHERE obsolete = 'N'"
						+ "and  lr_number LIKE '%"+searchString+ "%' ")
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
		if(status!=null && !status.trim().isEmpty())
			queryString.append(" AND status = '"+status+"' ");
		
		@SuppressWarnings("unchecked")
		List<ShipmentModel> listShipment = (List<ShipmentModel>) sessionFactory.getCurrentSession()
				.createQuery(queryString.toString()).list();
		
		return listShipment;
		
	}
	
	
	
	@Override
	@Transactional
	public int fetchMAXlrno(int branch_id) {
		// TODO Auto-generated method stub
		int lrno = 0;
		Query query = sessionFactory.getCurrentSession()
				.createQuery("Select MAX(lr_number) from ShipmentModel WHERE senderbranch_id = " + branch_id);
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
	
	

}
