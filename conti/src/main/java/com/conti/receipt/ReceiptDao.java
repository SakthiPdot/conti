package com.conti.receipt;

import java.util.List;

import com.conti.manifest.ManifestModel;

public interface ReceiptDao 
{
	public List<ReceiptModel>getAllReceipt();
	public List<ReceiptModel>getReceiptByCondition(int frombranch,int tobranch,String fromdate,String todate);
}
