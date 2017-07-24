package com.conti.master.branch;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.conti.master.employee.EmployeeMaster;
import com.conti.master.product.Product;


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
		String hql = "FROM BranchModel WHERE obsolete ='N' and branch_id ="+ id + "";
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		
		List<BranchModel> branchlist = (List<BranchModel>) query.list();
		if(branchlist != null && !branchlist.isEmpty()) {
			return branchlist.get(0);
		}
		return null;
	}
	
	/*------------------------------- Get employee by id begin -----------------------*/
	
	
	
	@Override
	@Transactional
	public List<BranchModel> getBranches() {
		@SuppressWarnings("unchecked")
		List<BranchModel> listBranch = (List<BranchModel>) sessionFactory.getCurrentSession()
				.createQuery("from BranchModel where obsolete ='N' "
						+ "ORDER BY IFNULL(created_datetime, updated_datetime) DESC")
				.list();
		return listBranch;
	}
	
	
	
	@Override
	@Transactional
	public List<BranchModel> searchbyeyBranch(String search_key) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		
		List<BranchModel> listbranch = (List<BranchModel>) sessionFactory.getCurrentSession()
		.createQuery("from BranchModel WHERE obsolete ='N' and branch_name LIKE '%" + search_key + "%'"
				+ " OR branch_code LIKE '%" + search_key + "%'"
				+ " OR branch_addressline1 LIKE '%" + search_key + "%'"
				+ " OR branch_addressline2 LIKE '%" + search_key + "%' OR location.location_name LIKE '%" + search_key + "%'"
				+ " OR location.address.city LIKE '%" + search_key + "%' OR location.address.district LIKE '%" + search_key + "%'"
				+ " OR location.address.state LIKE '%" + search_key + "%' OR branch_contactperson LIKE '%" + search_key + "%' OR branch_mobileno LIKE '%" + search_key + "%' OR branch_email LIKE '%"+ search_key + "%'"
				+ " OR lrno_prefix LIKE '%" + search_key + "%' OR receiptno_prefix LIKE '%" + search_key + "%' ").list();
		return listbranch;
		
	}
	
	@Override
	@Transactional
	public List<BranchModel> getBrancheswithLimit(int branch_id, int from_limit, int to_limit, String order) 
	{
		@SuppressWarnings("unchecked")
		List<BranchModel> listBranch = (List<BranchModel>) sessionFactory.getCurrentSession()
				.createQuery("from BranchModel where obsolete ='N'  "
						+ "ORDER BY IFNULL(created_datetime, updated_datetime) "+order)
				.setFirstResult(from_limit).setMaxResults(to_limit).list();
		return listBranch;
	}
	
	
	@Override
	@Transactional
	public String checkBranchName(String name) {
		@SuppressWarnings("unchecked")
		List<Product> branchList=sessionFactory.getCurrentSession()
				.createQuery("from BranchModel where obsolete ='N' AND branch_name IN ('"+name.toUpperCase()+"','"+name.toLowerCase()+"')").list();
		
		if(!branchList.isEmpty()&& branchList!=null){
			return "AVAILABLE";
		}
		
		return "NOTAVAILABLE";
	}
	
}

