package com.conti.master.branch;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.conti.master.product.Product;
import com.conti.others.ConstantValues;


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
	
	ConstantValues constantVal = new ConstantValues();
	
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
/*------------------------------- Get branch by id begin -----------------------*/
	
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
	
	/*------------------------------- Get branch by id begin -----------------------*/
	
	
	
	@Override
	@Transactional
	public List<BranchModel> getBranches() {
		@SuppressWarnings("unchecked")
		List<BranchModel> listBranch = (List<BranchModel>) sessionFactory.getCurrentSession()
				.createQuery("from BranchModel where obsolete ='N' "
						+ "ORDER BY IFNULL(created_datetime, created_datetime) DESC")
				.list();
		return listBranch;
	}
	
	@Override
	@Transactional
	public List<BranchModel> getBranchesbyid(int id) {
		@SuppressWarnings("unchecked")
		List<BranchModel> listBranch = (List<BranchModel>) sessionFactory.getCurrentSession()
				.createQuery("from BranchModel where obsolete ='N' and branch_id ="+ id+""
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
	public List<BranchModel> searchbyeyBranchName(String search_key) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		
		List<BranchModel> listbranch = (List<BranchModel>) sessionFactory.getCurrentSession()
		.createQuery("from BranchModel WHERE obsolete ='N' and active ='Y' and branch_name LIKE '%" + search_key + "%'").list();
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
	public List<BranchModel> getBranchSorting100(String name,String order) 
	{
		@SuppressWarnings("unchecked")
		List<BranchModel> listBranch = (List<BranchModel>) sessionFactory.getCurrentSession()
				.createQuery("from BranchModel where obsolete ='N'  "
						+ "order by ("+name+")"+  order )
					.setMaxResults(100)
					.list();
		return listBranch;
	}
	
	
	
	@Override
	@Transactional
	public String checkBranchName(String name) {
		@SuppressWarnings("unchecked")
		List<Product> branchList=sessionFactory.getCurrentSession()
				.createQuery("from BranchModel where obsolete ='N'  and active ='Y' AND branch_name IN ('"+name.toUpperCase()+"','"+name.toLowerCase()+"')").list();
		
		if(!branchList.isEmpty()&& branchList!=null){
			return "AVAILABLE";
		}
		
		return "NOTAVAILABLE";
	}
	
	
	@Override
	@Transactional
	public int find_record_countforSA() {
		int rec_count = ((Long)sessionFactory.getCurrentSession().createQuery("select count(*) from BranchModel WHERE obsolete = 'N'").uniqueResult()).intValue();
		return rec_count;
	}

	@Override
	@Transactional
	public int find_record_count() {
		int rec_count = ((Long)sessionFactory.getCurrentSession().createQuery("select count(*) from BranchModel WHERE obsolete = 'N' AND user.role.role_Name <> '"+ constantVal.ROLE_SADMIN +"'").uniqueResult()).intValue();
		return rec_count;
	}

	@Override
	@Transactional
	public List<BranchModel> getBranchBy100() {
		@SuppressWarnings("unchecked")
		List<BranchModel> listget = (List<BranchModel>) sessionFactory.getCurrentSession()
				.createQuery("from BranchModel where obsolete = 'N' ORDER BY IFNULL(created_datetime,created_datetime) DESC").setMaxResults(100).list();
		return listget;
	}

	//===== Referred Delete Process in Foreign key =========//
	@Override
	@Transactional
	public BranchModel getLocationbyId(int locationid) {
	
		@SuppressWarnings("unchecked")
		List<BranchModel> getlocation = sessionFactory.getCurrentSession()
				.createQuery("FROM BranchModel WHERE obsolete = 'N' and location_id = "+locationid).list();
		if(getlocation != null && !getlocation.isEmpty()){
			return getlocation.get(0);
		}
		return null;
	}

	@Override
	@Transactional
	public BranchModel getUserId(int c_user, int u_user) {
		@SuppressWarnings("unchecked")
		List<BranchModel> getUser = sessionFactory.getCurrentSession()
				.createQuery("from BranchModel where obsolete = 'N' and created_by="+c_user+"OR updated_by='"+u_user+"'").list();
		if(getUser != null && !getUser.isEmpty()){
			return getUser.get(0);
		}
		return null;
	}

	@Override
	@Transactional
	public List<BranchModel> searchBranch4shipment(String search_key, int branch_id) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		
		List<BranchModel> listbranch = (List<BranchModel>) sessionFactory.getCurrentSession()
		.createQuery("from BranchModel WHERE obsolete ='N' and active ='Y' and branch_name LIKE '%" + search_key + "%' and branch_id <> "+branch_id).list();
		return listbranch;
	}

	
	
}

