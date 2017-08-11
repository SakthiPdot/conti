package com.conti.master.employee;

import java.util.List;

import com.conti.master.location.Location;
import com.conti.setting.usercontrol.User;



/**
 * @Project_Name conti
 * @Package_Name com.conti.master.employee
 * @File_name EmployeeDao.java
 * @author Sankar
 * @Created_date_time Jun 22, 2017 4:31:53 PM
 * @Updated_date_time Jun 22, 2017 4:31:53 PM
 */
public interface EmployeeDao {
	
	public List<EmployeeMaster> getEmployee(int branch_id, String empcategory);
	public List<EmployeeMaster> getAllEmployees(int branch_id);
	public List<EmployeeMaster> getAllEmployeesExcel(int branch_id);
	public List<EmployeeMaster> getAllEmployeesforSA();
	public List<EmployeeMaster> getEmployeesbyBranchId(int branch_id);
	public void saveOrUpdate(EmployeeMaster employee);
	public EmployeeMaster findByMobileno(long mobileno);
	public EmployeeMaster getEmployeebyId(int id);
	public List<EmployeeMaster> searchbyeyEmployee(String searchkey);
	public List<EmployeeMaster> searchbyeyEmployeeforSA(String searchkey);
	public List<EmployeeMaster> getEmployeeswithLimit(int branch_id, int from_limit, int to_limit, String order);
	public List<EmployeeMaster> getEmployeeswithLimitforSA(int branch_id, int from_limit, int to_limit, String order);

	public List<EmployeeMaster> getEmployeeSorting100(String name,String order);
	public List<EmployeeMaster> searchbyeyEmpCategory(String searchkey);
	public List<EmployeeMaster> searchbyeyEmpCategoryforSA(String searchkey);
	public List<EmployeeMaster> searchDriver(String searchkey);
	
	public int find_record_countforSA();
	public int find_record_count();
	public List<EmployeeMaster> searchbyEmployee(String searchkey);
	
}
