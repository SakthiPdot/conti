package com.conti.master.branch;

import java.util.List;

import com.conti.master.employee.EmployeeMaster;
import com.conti.master.location.Location;

/**
 * @Project_Name conti
 * @Package_Name com.conti.master.branch
 * @File_name BranchDao.java
 * @author Sankar
 * @Created_date_time Jul 4, 2017 12:55:45 PM
 * @Updated_date_time Jul 4, 2017 12:55:45 PM
 */
public interface BranchDao 
{
	public List<BranchModel> getAllBranches();
	public List<BranchModel> getBranches();
	public void saveOrUpdate(BranchModel branchModel);
	public BranchModel getBranchbyId(int id);
	public List<BranchModel> searchbyeyBranch(String search_key);
	public List<BranchModel> searchbyeyBranchName(String search_key);
	public List<BranchModel> getBrancheswithLimit(int branch_id, int from_limit, int to_limit, String order);
	public List<BranchModel> getBranchSorting100(String name,String order);
	public String checkBranchName(String SearchString);
	public int find_record_countforSA();
	public int find_record_count();
	public List<BranchModel> getBranchesbyid(int id);
}
