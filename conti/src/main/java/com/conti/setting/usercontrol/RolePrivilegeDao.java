
package com.conti.setting.usercontrol;

import java.util.List;

/**
 * @Project_Name conti
 * @Package_Name com.conti.setting.usercontrol
 * @File_name RolePrivilegeDao.java
 * @author Sankar
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 20, 2017 2:21:39 PM
 */

public interface RolePrivilegeDao {
	public void saveOrUpdate(RolePrivilege u);
	public List<RolePrivilege> list();
	public RolePrivilege get(int id);
	public void delete(int id);
	
	public List<RolePrivilege> getRolePrivilegebyRoleId(int role_id);

}


