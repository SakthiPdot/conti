package com.conti.receipt;

import java.util.List;

import com.conti.manifest.ManifestModel;

public interface ReceiptDao 
{
	public List<ReceiptModel>getAllReceipt_view();
	public List<ReceiptModel>getReceiptByCondition(int frombranch,int tobranch,String fromdate,String todate);
	public ReceiptModel getReceiptbyId(int id);
	
}
