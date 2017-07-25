
package com.conti.setting.usercontrol;

import java.util.List;

/**
 * @Project_Name conti
 * @Package_Name com.conti.setting.usercontrol
 * @File_name UserPrivilegeDao.java
 * @author Sankar
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 20, 2017 2:21:39 PM
 */

public interface UserPrivilegeDao {
	public void saveOrUpdate(UserPrivilege u);
	public List<UserPrivilege> list();
	public UserPrivilege get(int id);
	public void delete(int id);
	public void deleteall(int id);
	public List<UserPrivilege> getprivilegebyUserId(int id);

}


