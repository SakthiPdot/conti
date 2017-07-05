package com.conti.master.branch;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.conti.master.employee.EmployeeMaster;

/**
 * @Project_Name conti
 * @Package_Name com.conti.master.branch
 * @File_name BranchDaoImpl.java
 * @author Sankar
 * @Created_date_time Jul 4, 2017 12:57:05 PM
 * @Updated_date_time Jul 4, 2017 12:57:05 PM
 */
@Repository
public class BranchDaoImpl implements BranchDao {

	/* (non-Javadoc)
	 * @see com.conti.master.branch.BranchDao#getAllBranches()
	 */
	@Autowired
	private SessionFactory sessionFactory;
	
/*	@Override
	@Transactional
	public List<BranchModel> getAllBranches() {
		// TODO Auto-generated method stub
		
		@SuppressWarnings("unchecked")
		List<BranchModel> listBranches = (List<BranchModel>) sessionFactory.getCurrentSession()
				.createQuery("from BranchModel").list();
		
		return listBranches;
	}*/

	@Override
	@Transactional
	public List<BranchModel> getAllBranches() {
		@SuppressWarnings("unchecked")
		List<BranchModel> listEmployee = (List<BranchModel>) sessionFactory.getCurrentSession()
				.createQuery("from BranchModel").list();
		return listEmployee;
	}
}
