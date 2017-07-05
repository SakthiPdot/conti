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
	public Location getLocationById(int locationId);
	public void deleteLocationById(int locationId);
	
}
 