package com.conti.master.location;

import java.util.List;


/**
 * @Project_Name conti
 * @Package_Name com.conti.master.location  com.conti.master.location
 * @File_name LocationDao.java com.conti.master.location
 * @author Monu.C
 * @Created_date_time Jun 30, 2017 11:45:59 AM
 */

public interface LocationDao {
	
	public void saveOrUpdate(Location location);
	public List<Location> getLocation();
	public List<Location> fetchAllLocation();
	public Location getLocationById(int locationId);
	public void deleteLocationById(int locationId);
	public String checkLocationName(String name);
	public List<Location> searchbyeyLocation(String search_key);
	public List<Location> searchbyeyLocationName(String search_key);	
	public List<Location> getLocationWithLimit(int from,int to,String order);
	public List<Location> getLocationSorting100(String name,String order);
	public List<Location> searchByLocation(String SearchString);
	public int locationSettingCount();
	//======= Delete by Foreign Key ==========//
	public Location getUser(int c_user,int u_user);
}
 