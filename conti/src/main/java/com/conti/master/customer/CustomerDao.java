package com.conti.master.customer;

import java.util.List;

import com.conti.master.customer.CustomerModel;

/**
 * @Project_Name conti
 * @Package_Name com.conti.master.customer
 * @File_name CustomerDao.java
 * @author Suresh
 * @Created_date_time July 14, 2017 2:50:56 AM
 * @Updated_date_time July 14, 2017 2:50:56 AM
 */

public interface CustomerDao 
{
	public List<CustomerModel> getCustomer(int branch_id, String customercategory);
	public List<CustomerModel> getAllCustomers();
	public void saveOrUpdate(CustomerModel customer);
	public CustomerModel findByMobileno(long mobileno);
	public CustomerModel getCustomerbyId(int id);
}
