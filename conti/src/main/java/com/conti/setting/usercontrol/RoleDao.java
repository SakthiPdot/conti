
package com.conti.setting.usercontrol;


import java.util.List;

/**
 * @Project_Name conti
 * @Package_Name com.conti.setting.usercontrol
 * @File_name RoleDao.java
 * @author Sankar
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 20, 2017 2:21:39 PM
 */

public interface RoleDao {
	public void saveOrUpdate(Role u);
	public List<Role> list();
	public Role get(int id);
	public void delete(int id);
	
	public List<Role> geta(int id);


}
