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
	
	
	//======== User Master Functions Begin ============//
	
	public User getBranchId(int id);
	public List<User> getUser(int emp_id);
	public List<User> getAllUsers();
	
	//======== User Master Functions End ==============//

	
	/*public void deletearchive(int id);*/
	
	/*public  int maxid();*/

	/*public void resetPassword(String username, String password);
	
	
	public List<User> listbyclientid(int compay_id);
	
	public List<User> getlistOrderbydatedesc(int clientid);
	
	public boolean getlisybyusername(String username,int clientid);
	public  boolean getisuname(String username);*/
}




