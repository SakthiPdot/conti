package com.conti.receipt;

import java.util.List;

import com.conti.manifest.ManifestModel;



public interface ReceiptDao 
{
	public List<ReceiptModel> getAllReceipt_view();
	public List<ReceiptModel> getReceiptByCondition(int frombranch,int tobranch,String fromdate,String todate);
	public ReceiptModel getReceiptbyId(int id);
	public List<ReceiptModel> searchStaff(String searchkey);
	public List<ReceiptModel> getContactNumberByName(String Name);
	public boolean checkCourierStaffUnique(String Name);
	public int getLastReceiptNoWithBranch(int branchid);
	public void saveOrUpdate(ReceiptModel receiptModel);
	
	
	/*public List<ReceiptModel> searchStaffNoNAdmin(String searchkey,int branchid);*/
	
	
	//===== Referred Delete Process in Foreign key =========//
	public ReceiptModel getUser(int c_user,int u_user);
	
}
