package com.conti.setting.usercontrol;

import java.util.List;


/**
 * @Project_Name conti
 * @Package_Name com.conti.setting.usercontrol
 * @File_name UsersDao.java
 * @author Sankar
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 20, 2017 2:21:39 PM
 */
public interface UsersDao {
	public void saveOrUpdate(User u);
	public List<User> list();
	public User get(int id);
	public void delete(int id);
	public User findByUserName(String username);
	
	public List<User> getUsersbyBranchId(int branch_id);

	public List<User> getUsersbyBranchIdwihoutSA(int branch_id);
	
	public User getUserbyEmp(int emp_id);
	
	public List<User> getUserbyEmpid(int emp_id);
	public List<User> getAllUsers();
	public List<User> getUserwithLimitbySA(int from_limit, int to_limit, String order);
	public List<User> getUserwithLimit(int branch_id, int from_limit, int to_limit, String order);
	public List<User> getLocationSorting100(String name,String order);
	public List<User> searchbySAUser(String search_key);
	
	public List<User> searchbyUser(String search_key);
	
	public int find_record_countforSA();
	public int find_record_count();
	
	public List<User> getUser100();
	
	//===== Referred Delete Process in Foreign key =========//
	public User getEmployeeId(int emp_id);
	public User getBranchId(int branch_id);

}




