package com.conti.master.branch;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;


/**
 * @Project_Name conti
 * @Package_Name com.conti.master.branch
 * @File_name BranchDaoImpl.java
 * @author Sankar
 * @Created_date_time Jul 4, 2017 12:57:05 PM
 * @Updated_date_time Jul 4, 2017 12:57:05 PM
 */
@Repository
public class BranchDaoImpl implements BranchDao 
{

	
	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	@Transactional
	public List<BranchModel> getAllBranches() 
	{
		@SuppressWarnings("unchecked")
		List<BranchModel> listBranch = (List<BranchModel>) sessionFactory.getCurrentSession()
				.createQuery("from BranchModel").list();
		return listBranch;
	}
	
	@Override
	@Transactional
	public void saveOrUpdate(BranchModel branchModel)
	{
		sessionFactory.getCurrentSession().saveOrUpdate(branchModel);
	}
/*------------------------------- Get employee by id begin -----------------------*/
	
	@Override
	@Transactional
	public BranchModel getBranchbyId(int id) {
		String hql = "FROM BranchModel WHERE obsolete ='N' and active ='Y' and branch_id ="+ id + "";
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		
		List<BranchModel> branchlist = (List<BranchModel>) query.list();
		if(branchlist != null && !branchlist.isEmpty()) {
			return branchlist.get(0);
		}
		return null;
	}
	
	/*------------------------------- Get employee by id begin -----------------------*/	
}

