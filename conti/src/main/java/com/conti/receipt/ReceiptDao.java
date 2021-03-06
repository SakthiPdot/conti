package com.conti.receipt;

import java.util.List;

import com.conti.manifest.ManifestDetailedModel;
import com.conti.manifest.ManifestModel;



public interface ReceiptDao 
{
	
	public List<ReceiptDetail> getReceiptByCondition(String frombranch,String tobranch,String fromdate,String todate,String status);
	public ReceiptModel getReceiptbyId(int id);
	public List<ReceiptModel> searchStaff(String searchkey);
	public List<ReceiptModel> getContactNumberByName(String Name);
	public boolean checkCourierStaffUnique(String Name);
	public int getLastReceiptNoWithBranch(int branchid);
	public void saveOrUpdate(ReceiptModel receiptModel);
	public void delete(ReceiptDetail receiptDetail);
	
	/*public List<ReceiptModel> searchStaffNoNAdmin(String searchkey,int branchid);*/
	
	
	//===== Referred Delete Process in Foreign key =========//
	public ReceiptModel getUser(int c_user,int u_user);
	public List<ReceiptDetail> getAllReceipt_view();// for Super Admin
	public List<ReceiptDetail> getAllReceipt_view(int branch_id);// for Manager / User
	public List<ReceiptDetail>receiptSearchAdmin(String searchkey);
	public List<ReceiptDetail>receiptSearch(String searchkey,int branch_id);
	public ReceiptDetail getAllReceiptDetailByid(int manifestdetailed_id);
	public ReceiptDetail getReceiptDetailbyId(int id);
	
	public void makePending(int receipt_id);
	public void makeReturn(int receipt_id);
	public void makeDelete(int receipt_id);
	
	public ReceiptDetail getReceiptbyShipment(int shipment_id);
	
	public List<ReceiptModel> getReceiptbyDate(String from_Date, int user_id);
}
