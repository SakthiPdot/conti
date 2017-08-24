package com.conti.receipt;

import java.util.List;



public interface ReceiptDao 
{
	public List<ReceiptModel>getAllReceipt_view();
	public List<ReceiptModel>getReceiptByCondition(int frombranch,int tobranch,String fromdate,String todate);
	public ReceiptModel getReceiptbyId(int id);
	
	//===== Referred Delete Process in Foreign key =========//
	public ReceiptModel getUser(int c_user,int u_user);
	
}
