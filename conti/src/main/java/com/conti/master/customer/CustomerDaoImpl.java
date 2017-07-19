
/**
	 * @Project_Name conti
	 * @Package_Name com.conti.master.customer
	 * @File_name CustomerDao.java
	 * @author Suresh
	 * @Created_date_time July 14, 2017 2:50:56 AM
	 * @Updated_date_time July 14, 2017 2:50:56 AM
	 */
	
	
package com.conti.master.customer;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.conti.master.customer.CustomerModel;
import com.conti.master.employee.EmployeeMaster;
import com.conti.master.customer.CustomerDao;

@Repository
public class CustomerDaoImpl implements CustomerDao
{
	
	@Autowired
	private SessionFactory sessionFactory;

	
	@Override
	@Transactional
	public List<CustomerModel> getCustomer(int branch_id, String empcategory) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		List<CustomerModel> customerlist = (List<CustomerModel>) sessionFactory.getCurrentSession()
				.createQuery("from CustomerModel WHERE obsolete ='N' and branch_id = " + branch_id + " ").list();
		return customerlist;
		
	}
	
	@Override
	@Transactional
	public List<CustomerModel> getAllCustomers(int branch_id) {
		@SuppressWarnings("unchecked")
		List<CustomerModel> listCustomer = (List<CustomerModel>) sessionFactory.getCurrentSession()
				.createQuery("from CustomerModel where obsolete ='N'AND branchModel.branch_id =" + branch_id + " "
						+ "ORDER BY IFNULL(created_datetime, updated_datetime) DESC").setMaxResults(100).list();
		return listCustomer;
	}

	
	@Override
	@Transactional
	public void saveOrUpdate(CustomerModel customerModel) 
	{

		sessionFactory.getCurrentSession().saveOrUpdate(customerModel);
	}
	
	
	/*------------------------------- Find user by mobileno begin ----------------------- */
	@Override
	@Transactional
	@SuppressWarnings("unchecked")
	public CustomerModel findByMobileno(long mobileno)
	{
		String hql = "FROM CustomerModel WHERE obsolete ='N' and customer_mobileno ="+ mobileno + "";
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		
		List<CustomerModel> customerlist = (List<CustomerModel>) query.list();
		if(customerlist != null && !customerlist.isEmpty()) {
			return customerlist.get(0);
		}
		return null;
	}

	
	/*------------------------------- Find user by mobileno end ----------------------- */	
	
	/*------------------------------- Get Customer by id begin -----------------------*/
	
	@Override
	@Transactional
	public CustomerModel getCustomerbyId(int id) {
		String hql = "FROM CustomerModel WHERE obsolete ='N' and customer_id ="+ id + "";
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		
		List<CustomerModel> customerlist = (List<CustomerModel>) query.list();
		if(customerlist != null && !customerlist.isEmpty()) {
			return customerlist.get(0);
		}
		return null;
	}
	
	/*------------------------------- Get Customer by id begin -----------------------*/	
	
	
	
/*------------------------------- Get Customer by id begin -----------------------*/	
	
	@Override
	@Transactional
	public List<CustomerModel> searchbyeyCustomer(String search_key) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		
		List<CustomerModel> listcust = (List<CustomerModel>) sessionFactory.getCurrentSession()
		.createQuery("from CustomerModel WHERE obsolete ='N' and customer_name LIKE '%" + search_key + "%'"
				+ " OR customer_code LIKE '%" + search_key + "%'"
				+ " OR branchModel.branch_name LIKE '%" + search_key + "%' OR emp_address1 LIKE '%" + search_key + "%'"
				+ " OR emp_address2 LIKE '%" + search_key + "%' OR location.location_name LIKE '%" + search_key + "%'"
				+ " OR location.address.city LIKE '%" + search_key + "%' OR location.address.district LIKE '%" + search_key + "%'"
				+ " OR location.address.state LIKE '%" + search_key + "%' OR customer_email LIKE '%" + "%'").list();
		return listcust;
		
	}
	
	/*------------------------------- Get Customer  by id End -----------------------*/
	
	@Override
	@Transactional
	public List<CustomerModel> getCustomerswithLimit(int branch_id, int from_limit, int to_limit, String order) 
	{
		@SuppressWarnings("unchecked")
		List<CustomerModel> listCustomer = (List<CustomerModel>) sessionFactory.getCurrentSession()
				.createQuery("from CustomerModel where obsolete ='N' AND branchModel.branch_id =" + branch_id + " "
						+ "ORDER BY IFNULL(created_datetime, updated_datetime) "+order)
				.setFirstResult(from_limit).setMaxResults(to_limit).list();
		return listCustomer;
	}
}
