
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

import com.conti.manifest.ManifestModel;
import com.conti.master.employee.EmployeeMaster;


@Repository
public class ReceiptDaoImpl implements ReceiptDao
{
	@Autowired
	private SessionFactory sessionFactory;
	
	
	@Override
	@Transactional
	public void saveOrUpdate(ReceiptModel receiptModel)
	{
		sessionFactory.getCurrentSession().saveOrUpdate(receiptModel);
	}
	
	
	//======================================VIEW RECEIPT===============================================
	@Override
	@Transactional
	public List<ReceiptModel> getAllReceipt_view() 
	{
		// TODO Auto-generated method stub
		
		@SuppressWarnings("unchecked")
		List<ReceiptModel> listReceipt = (List<ReceiptModel>) sessionFactory.getCurrentSession()
				.createQuery("from ReceiptModel WHERE obsolete ='N'  ").list();
		return listReceipt;
		
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
	public List<ReceiptModel>getReceiptByCondition(int frombranch,int tobranch,String fromdate,String todate)
	{
		@SuppressWarnings("unchecked")
		List<ReceiptModel> listreceipt = (List<ReceiptModel>) sessionFactory.getCurrentSession()
				.createQuery("FROM ReceiptModel WHERE obsolete ='N' and shipmentModel.manifest_origin="+frombranch 
				+" AND manifest_origin ="+tobranch
				+" AND created_datetime BETWEEN '"+fromdate+" 00:00:00'"
				+" AND '"+todate+" 23:59:59'").list();
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
	
	//===================================================================================================
}
