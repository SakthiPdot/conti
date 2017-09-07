
/**
 * @Project_Name conti
 * @Package_Name custom js Receipt
 * @File_name Receipt_controller.js
 * @author Suresh
 * @Updated_user Suresh
  @Created_date_time August 09, 2017 11:31:53 AM
 * @Updated_date_time August 09, 2017 11:31:53 AM
 */
package com.conti.receipt;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.conti.manifest.ManifestDetailedModel;
import com.conti.manifest.ManifestModel;
import com.conti.master.employee.EmployeeMaster;
import com.conti.others.ConstantValues;


@Repository
public class ReceiptDaoImpl implements ReceiptDao
{
	@Autowired
	private SessionFactory sessionFactory;
	
//	String Delivered=ConstantValues.DELIVERED;
//	String Pending=ConstantValues.PENDING;
//	String Received=ConstantValues.RECEIVED;
	
	@Override
	@Transactional
	public void saveOrUpdate(ReceiptModel receiptModel)
	{
		sessionFactory.getCurrentSession().saveOrUpdate(receiptModel);
	}
	
	
	//======================================VIEW RECEIPT===============================================
	@Override
	@Transactional
	public List<ReceiptDetail> getAllReceipt_view() // View shipment for SuperAdmin
	{
		// TODO Auto-generated method stub
		
		@SuppressWarnings("unchecked")
		List<ReceiptDetail> listReceiptDetail = (List<ReceiptDetail>) sessionFactory.getCurrentSession()
				.createQuery("from ReceiptDetail where shipmentModel.obsolete='N'"
						+ " and shipmentModel.status in('"+ConstantValues.DELIVERED+"','"+ConstantValues.PENDING+"')"
						+" ORDER BY shipmentModel.consignee_branch.branch_name,shipmentModel.created_datetime DESC").setMaxResults(100).list();
		return listReceiptDetail;
		
	}
	
	@Override
	@Transactional
	public List<ReceiptDetail> getAllReceipt_view(int branch_id) // View Shipment for Manager and Staff
	{
		// TODO Auto-generated method stub
		
		@SuppressWarnings("unchecked")
		List<ReceiptDetail> listReceiptDetail = (List<ReceiptDetail>) sessionFactory.getCurrentSession()
				.createQuery("from ReceiptDetail WHERE shipmentModel.consignee_branch.branch_id=" + branch_id+ 
						" and shipmentModel.status in('"+ConstantValues.DELIVERED+"','"+ConstantValues.PENDING+"') ").setMaxResults(100).list();
		return listReceiptDetail;
		
	}
	
	@Override
	@Transactional
	public List<ReceiptModel> searchStaff(String search_key) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		
		List<ReceiptModel> receiptList = (List<ReceiptModel>) sessionFactory.getCurrentSession()
		.createQuery("from ReceiptModel WHERE obsolete ='N'"
				+ "and courier_staff  LIKE '%"+search_key+"%'").list();
		
		return receiptList;
		
	}
	
/*	@Override
	@Transactional
	public List<ReceiptModel> searchStaffNoNAdmin(String searchkey,int branchid) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		
		List<ReceiptModel> receiptList = (List<ReceiptModel>) sessionFactory.getCurrentSession()
		.createQuery("from ReceiptModel WHERE obsolete ='N'"
				+" AND manifest_origin ="+branchid
				+ "and courier_staff  LIKE '%"+searchkey+"%'").list();
		
		return receiptList;
		
	}*/

	
	//-------------------------Get Receipts by filter condition----------------------------------------------
	@Override
	@Transactional
	public List<ReceiptDetail>getReceiptByCondition(String frombranch,String tobranch,String fromdate,String todate,String status)
	{
		StringBuilder queryString=new StringBuilder();
		queryString.append("FROM ReceiptDetail Where shipmentModel.obsolete='N'");
		String frombrnch=String.valueOf(frombranch);
		String tobrnch=String.valueOf(tobranch);
		String stats=String.valueOf(status);
		if(frombrnch!=null &&!frombrnch.trim().isEmpty())
			queryString.append(" AND shipmentModel.sender_branch.id='"+frombranch+"' ");
		
		if(tobrnch!=null &&!tobrnch.trim().isEmpty())
			queryString.append(" AND shipmentModel.consignee_branch.id='"+tobranch+"' ");
		
		if(fromdate!=null && !fromdate.trim().isEmpty())			
			queryString.append(" AND created_datetime >= '"+fromdate+" 00:00:00'");
		
		if(todate!=null && !todate.trim().isEmpty())
			queryString.append(" AND created_datetime <= '"+todate+" 23:59:59'");
		
		if(stats!=null && !stats.trim().isEmpty())
			queryString.append(" AND shipmentModel.status='"+status+"'");
		else{
			queryString.append(" AND  shipmentModel.status in ('"+ConstantValues.DELIVERED+"','"+ConstantValues.PENDING+"') ");
		}
	@SuppressWarnings("unchecked")
//		List<ReceiptModel> listreceipt = (List<ReceiptModel>) sessionFactory.getCurrentSession()
//				.createQuery("FROM ReceiptModel WHERE obsolete ='N' and shipmentModel.manifest_origin="+frombranch 
//				+" AND manifest_origin ="+tobranch
//				+" AND created_datetime BETWEEN '"+fromdate+" 00:00:00'"
//				+" AND '"+todate+" 23:59:59'").list();
		
		List<ReceiptDetail> listreceipt=(List<ReceiptDetail>)sessionFactory.getCurrentSession()
				.createQuery(queryString.toString()).list();
		return listreceipt;
	}
	//------------------------------------------------------------------------------------------------------
	
	//-------------------------Get Receipts by filter condition----------------------------------------------
	@Override
	@Transactional
	public List<ReceiptModel> getContactNumberByName(String Name)
	{
		@SuppressWarnings("unchecked")
		List<ReceiptModel> listreceipt = (List<ReceiptModel>) sessionFactory.getCurrentSession()
				.createQuery("FROM ReceiptModel WHERE obsolete ='N' "
				+" AND courier_staff ='"+Name.trim()+"'")
				.list();
		return listreceipt;
	}

	//-------------------------check if Courier Staff Unique----------------------------------------------
	@Override
	@Transactional
	public boolean checkCourierStaffUnique(String Name)
	{
		@SuppressWarnings("unchecked")
		List<ReceiptModel> listreceipt = (List<ReceiptModel>) sessionFactory.getCurrentSession()
				.createQuery("FROM ReceiptModel WHERE obsolete ='N' "
				+" AND courier_staff ='"+Name.trim()+"'")
				.list();
		
		if(listreceipt != null && !listreceipt.isEmpty()) {
			return true;
		}
		return false;
	}

	
	//------------------------------Get Receipt by id------------------------------------------
	
	@Override
	@Transactional
	public ReceiptModel getReceiptbyId(int id) {
		String hql = "FROM ReceiptModel WHERE obsolete ='N' and receipt_id ="+ id + "";
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		
		@SuppressWarnings("unchecked")
		List<ReceiptModel> receiptlist = (List<ReceiptModel>) query.list();
		if(receiptlist != null && !receiptlist.isEmpty()) {
			return receiptlist.get(0);
		}
		return null;
	}
	
	@Override
	@Transactional
	public ReceiptDetail getReceiptDetailbyId(int id) {
		String hql = "FROM ReceiptDetail WHERE receipt_id ="+ id;
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		
		@SuppressWarnings("unchecked")
		List<ReceiptDetail> receiptlist = (List<ReceiptDetail>) query.list();
		if(receiptlist != null && !receiptlist.isEmpty()) {
			return receiptlist.get(0);
		}
		return null;
	}
	
	
	
	@Override
	@Transactional
	public int getLastReceiptNoWithBranch(int branchid) {
		
		int lastReceipttNo=0;
		
		String hql = "select MAX(receipt_number)  FROM ReceiptModel WHERE obsolete ='N' and branchModel.branch_id ="+branchid+ "";
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		
		return (query.uniqueResult()==null)?lastReceipttNo:Integer.parseInt(query.uniqueResult().toString());
	}
	
	
	//---------------------------------------------------------------------------------

	@Override
	@Transactional
	public ReceiptModel getUser(int c_user, int u_user) {
		@SuppressWarnings("unchecked")
		List<ReceiptModel> getuserid = sessionFactory.getCurrentSession()
				.createQuery("from ReceiptModel where  obsolete ='N' and created_by= " +c_user+ " OR updated_by='" +u_user+ "'").list();
		if (getuserid != null && !getuserid.isEmpty()){
			return getuserid.get(0);
		}
		return null;
	}
		
	
	//-------------------------------------Get Receipt Search by Start----------------------------------------------
	
		@Override
		@Transactional
		public List<ReceiptDetail>receiptSearchAdmin(String searchkey)
		{
			@SuppressWarnings("unchecked")
			
			List<ReceiptDetail> listReceipt=(List<ReceiptDetail>)sessionFactory.getCurrentSession()
			.createQuery("from ReceiptDetail where shipmentModel.obsolete='N'"
					+ " AND shipmentModel.lrno_prefix LIKE '%"+searchkey+"%'"
					//+ " OR select manifestModel.manifest_prefix from manifestModel where manifest_prefix LIKE '%"+searchkey+"%' and shipmentModel.shipment_id=manifestModel.manifestDetailModel.shipment_id"
					+ " OR receiptModel.receipt_prefix LIKE '%"+searchkey+"%'"
					+ " AND shipmentModel.status in ('"+ConstantValues.DELIVERED+"','"+ConstantValues.PENDING+"')"
					
					).list();
			return listReceipt;
		}
		
		
	//-------------------------------------Get Receipt Search by Start----------------------------------------------
		
		@Override
		@Transactional
		public List<ReceiptDetail>receiptSearch(String searchkey,int branchid)
		{
			@SuppressWarnings("unchecked")
			
			List<ReceiptDetail> listReceipt=(List<ReceiptDetail>)sessionFactory.getCurrentSession()
			.createQuery("from ReceiptDetail where shipmentModel.obsolete='N'"
					+ " AND shipmentModel.lrno_prefix LIKE '%"+searchkey+"%'"
//					+ " OR  manifest_prefix from ManifestModel LIKE '%"+searchkey+"%'"
//					+ " OR ReceiptModel.receipt_prefix LIKE '%"+searchkey+"%'"
					+ " AND shipmentModel.consignee_branch.branch_id="+branchid
					+ " AND shipmentModel.status in ('"+ConstantValues.DELIVERED+"','"+ConstantValues.PENDING+"')"
					).list();
			return listReceipt;
		}
			
	//----------------------------------------------Get Receipt detailed by id---------------------------------------------
		@Override
		@Transactional
		public ReceiptDetail getAllReceiptDetailByid(int receiptdetailed_id) 
		{
			Query q= sessionFactory.getCurrentSession()
					.createQuery("from ReceiptDetail WHERE receiptdetailid ="+receiptdetailed_id);
			List<ReceiptDetail> receiptDetail=(List<ReceiptDetail>) q.list();
			if(receiptDetail!=null){
				return receiptDetail.get(0);
			}
			return null;
		}


		@Override
		@Transactional
		public void makePending(int receipt_id) {
			// TODO Auto-generated method stub
			
			String hql = "UPDATE ReceiptDetail SET shipmentModel.status = 'Pending' WHERE obsolete ='N' and receiptModel.receipt_id = " + receipt_id;
			Query query = sessionFactory.getCurrentSession().createQuery(hql);
			
		}
		@Override
		@Transactional
		public void makeReturn(int receipt_id) {
			// TODO Auto-generated method stub
			
			String hql = "UPDATE ReceiptDetail SET shipmentModel.status = 'Return' WHERE obsolete ='N' and receiptModel.receipt_id = " + receipt_id;
			Query query = sessionFactory.getCurrentSession().createQuery(hql);
			
		}
		@Override
		@Transactional
		public void makeDelete(int receipt_id) {
			// TODO Auto-generated method stub
			
			String hql = "UPDATE ReceiptDetail SET shipmentModel.status = 'Received' WHERE obsolete ='N' and receiptModel.receipt_id = " + receipt_id;
			Query query = sessionFactory.getCurrentSession().createQuery(hql);
			
		}
		
		
		@Override
		@Transactional
		public ReceiptDetail getReceiptbyShipment(int shipment_id) 
		{
			@SuppressWarnings("unchecked")
			List<ReceiptDetail> receiptDetail = sessionFactory.getCurrentSession()
					.createQuery("from ReceiptDetail where shipmentModel.shipment_id =" +shipment_id).list();
			if(receiptDetail!=null && !receiptDetail.isEmpty()){
				return receiptDetail.get(0);
			}
			return null;
		}
			
	//===================================================================================================
}
