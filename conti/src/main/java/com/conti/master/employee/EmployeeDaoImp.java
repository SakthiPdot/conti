package com.conti.master.employee;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.conti.master.branch.BranchModel;
import com.conti.others.ConstantValues;

/**
 * @Project_Name conti
 * @Package_Name com.conti.master.employee
 * @File_name EmployeeDaoImp.java
 * @author Sankar
 * @Created_date_time Jun 22, 2017 4:39:08 PM
 * @Updated_date_time Jun 22, 2017 4:39:08 PM
 */
@Repository
public class EmployeeDaoImp implements EmployeeDao {
	
	@Autowired
	private SessionFactory sessionFactory;

	ConstantValues constantVal = new ConstantValues();
	/* (non-Javadoc)
	 * @see com.conti.master.employee.EmployeeDao#getEmployee()
	 */
	
	@Override
	@Transactional
	public List<EmployeeMaster> getEmployee(int branch_id, String empcategory) {
		// TODO Auto-generated method stub
		
		@SuppressWarnings("unchecked")
		List<EmployeeMaster> listemp = (List<EmployeeMaster>) sessionFactory.getCurrentSession()
				.createQuery("from EmployeeMaster WHERE obsolete ='N' and branch_id = " + branch_id + " AND empcategory = '" + empcategory + "'").list();
		return listemp;
		
	}
	
	@Override
	@Transactional
	public List<EmployeeMaster> getAllEmployees(int branch_id) {
		@SuppressWarnings("unchecked")
		List<EmployeeMaster> listEmployee = (List<EmployeeMaster>) sessionFactory.getCurrentSession()
				.createQuery("from EmployeeMaster where obsolete ='N'AND branchModel.branch_id =" + branch_id + " "
						//+ "user.role.role_Name <>" + constantVal.ROLE_SADMIN + " "
						+ "ORDER BY IFNULL(created_datetime, updated_datetime) DESC")
				.setMaxResults(100).list();
		return listEmployee;
	}
	
	@Override
	@Transactional
	public List<EmployeeMaster> getAllEmployeesforSA() {
		@SuppressWarnings("unchecked")
		List<EmployeeMaster> listEmployee = (List<EmployeeMaster>) sessionFactory.getCurrentSession()
				.createQuery("from EmployeeMaster where obsolete ='N'AND "
						+ "ORDER BY IFNULL(created_datetime, updated_datetime) DESC")
				.setMaxResults(100).list();
		return listEmployee;
	}
	
	@Override
	@Transactional
	public List<EmployeeMaster> getEmployeesbyBranchId(int branch_id) {
		@SuppressWarnings("unchecked")
		List<EmployeeMaster> listEmployee = (List<EmployeeMaster>) sessionFactory.getCurrentSession()
				.createQuery("from EmployeeMaster where obsolete ='N'AND branchModel.branch_id =" + branch_id + " "
						+ "ORDER BY IFNULL(created_datetime, updated_datetime) DESC")
				.list();
		return listEmployee;
	}

	
	@Override
	@Transactional
	public void saveOrUpdate(EmployeeMaster employee) {
		sessionFactory.getCurrentSession().saveOrUpdate(employee);
	}
	
	
	/*------------------------------- Find user by mobileno begin ----------------------- */
	@Override
	@Transactional
	@SuppressWarnings("unchecked")
	public EmployeeMaster findByMobileno(long mobileno)
	{
		String hql = "FROM EmployeeMaster WHERE obsolete ='N' and emp_phoneno ="+ mobileno + "";
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		
		List<EmployeeMaster> emplist = (List<EmployeeMaster>) query.list();
		if(emplist != null && !emplist.isEmpty()) {
			return emplist.get(0);
		}
		return null;
	}

	
	/*------------------------------- Find user by mobileno end ----------------------- */	
	
	/*------------------------------- Get employee by id begin -----------------------*/
	
	@Override
	@Transactional
	public EmployeeMaster getEmployeebyId(int id) {
		String hql = "FROM EmployeeMaster WHERE obsolete ='N' and emp_id ="+ id + "";
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		
		List<EmployeeMaster> emplist = (List<EmployeeMaster>) query.list();
		if(emplist != null && !emplist.isEmpty()) {
			return emplist.get(0);
		}
		return null;
	}
	
	/*------------------------------- Get employee by id begin -----------------------*/	
	
	@Override
	@Transactional
	public List<EmployeeMaster> searchbyeyEmployee(String search_key) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		
		List<EmployeeMaster> listemp = (List<EmployeeMaster>) sessionFactory.getCurrentSession()
		.createQuery("from EmployeeMaster WHERE obsolete ='N' and emp_name LIKE '%" + search_key + "%'"
				+ " OR empcategory LIKE '%" + search_key + "%' OR emp_code LIKE '%" + search_key + "%'"
				+ " OR branchModel.branch_name LIKE '%" + search_key + "%' OR emp_address1 LIKE '%" + search_key + "%'"
				+ " OR emp_address2 LIKE '%" + search_key + "%' OR location.location_name LIKE '%" + search_key + "%'"
				+ " OR location.address.city LIKE '%" + search_key + "%' OR location.address.district LIKE '%" + search_key + "%'"
				+ " OR location.address.state LIKE '%" + search_key + "%' OR emp_phoneno LIKE '%" + search_key + "%' OR emp_email LIKE '%" + search_key + "%' OR dob LIKE '%"+ search_key + "%'"
				+ " OR doj LIKE '%" + search_key + "%'").list();
		return listemp;
		
	}
	
	@Override
	@Transactional
	public List<EmployeeMaster> getEmployeeswithLimit(int branch_id, int from_limit, int to_limit, String order) {
		@SuppressWarnings("unchecked")
		List<EmployeeMaster> listEmployee = (List<EmployeeMaster>) sessionFactory.getCurrentSession()
				.createQuery("from EmployeeMaster where obsolete ='N' AND branchModel.branch_id =" + branch_id + " "
						+ "ORDER BY IFNULL(created_datetime, updated_datetime) "+order)
				.setFirstResult(from_limit).setMaxResults(to_limit).list();
		return listEmployee;
	}
}
