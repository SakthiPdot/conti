package com.conti.master.employee;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

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
	public List<EmployeeMaster> getAllEmployees() {
		@SuppressWarnings("unchecked")
		List<EmployeeMaster> listEmployee = (List<EmployeeMaster>) sessionFactory.getCurrentSession()
				.createQuery("from EmployeeMaster where obsolete ='N'").list();
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
				.createQuery("from EmployeeMaster WHERE obsolete ='N' and emp_name LIKE '%" + search_key + "%'").list();
		return listemp;
		
	}
}
