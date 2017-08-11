
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

@Repository
public class ReceiptDaoImpl implements ReceiptDao
{
	@Autowired
	private SessionFactory sessionFactory;
	
	
	//======================================VIEW RECEIPT===============================================
	@Override
	@Transactional
	public List<ReceiptModel> getAllReceipt() 
	{
		// TODO Auto-generated method stub
		
		@SuppressWarnings("unchecked")
		List<ReceiptModel> listReceipt = (List<ReceiptModel>) sessionFactory.getCurrentSession()
				.createQuery("from ReceiptModel WHERE obsolete ='N'  ").list();
		return listReceipt;
		
	}
	
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
	
	//------------------------------Get Receipt by id------------------------------------------
	
	@Override
	@Transactional
	public ReceiptModel getReceiptbyId(int id) {
		String hql = "FROM ReceiptModel WHERE obsolete ='N' and receipt_id ="+ id + "";
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		
		List<ReceiptModel> receiptlist = (List<ReceiptModel>) query.list();
		if(receiptlist != null && !receiptlist.isEmpty()) {
			return receiptlist.get(0);
		}
		return null;
	}
	//---------------------------------------------------------------------------------
	//===================================================================================================
}
