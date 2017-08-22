package com.conti.settings.company;

/**
 * @Project_Name conti
 * @Package_Name com.conti.settings.company  com.conti.settings.company
 * @File_name CompnaySettingDAO.java com.conti.settings.company
 * @author Monu.C
 * @Created_date_time Jun 22, 2017 3:47:25 PM
 */
public interface CompanySettingDAO {
	
	public void saveOrUpdate(Company company);
	public Company getById(int id);	
	
	//===== Referred Delete Process in Foreign key =========//
	public Company getLocationId(int locationid);
	public Company getUserId(int created_user, int updated_user);
	
}
