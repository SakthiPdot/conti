package com.conti.master.location;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 * @Project_Name conti
 * @Package_Name com.conti.master.location  com.conti.master.location
 * @File_name LocationDaoImpl.java com.conti.master.location
 * @author Monu.C
 * @Created_date_time Jun 30, 2017 11:57:58 AM
 */

@Repository
public class LocationDaoImpl implements LocationDao {


	@Autowired
	private SessionFactory sessionFactory;
	
	public LocationDaoImpl() {}
	
	public LocationDaoImpl(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	@Override
	@Transactional
	public void saveOrUpdate(Location location) {
		sessionFactory.getCurrentSession().saveOrUpdate(location);		
	}

	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public List<Location> getLocation() {
		
		return sessionFactory.getCurrentSession()
				.createQuery("from Location where  obsolete ='N' "
						+ "order by IFNULL(updated_datetime,created_datetime)  DESC ")
				.setMaxResults(100)
				.list();
	}

	
	@Override
	@Transactional
	public Location getLocationById(int locationId) {
		@SuppressWarnings("unchecked")
		List<Location> locationList=sessionFactory.getCurrentSession()
				.createQuery("from Location where id="+locationId).list();
		
		if(locationList!=null && !locationList.isEmpty()){
			return locationList.get(0);
		}
		return null;
	}


	@Override
	@Transactional
	public void deleteLocationById(int locationId) {
		Location location=new Location();
		location.setLocation_id(locationId);
		
		sessionFactory.getCurrentSession().
		createQuery("update Location  set obsolete='Y', active='N' where id="+locationId )
		.executeUpdate();
		
	}

	
	@Override
	@Transactional
	public String checkLocationName(String name) {
		@SuppressWarnings("unchecked")
		List<Location> locationList=sessionFactory.getCurrentSession()
				.createQuery("from Location where obsolete ='N' AND location_name IN ('"+name.toUpperCase()+"','"+name.toLowerCase()+"')").list();
		
		if(locationList!=null && !locationList.isEmpty()){
			return "AVAILABLE";
		}
		return "NOTAVAILABLE";
	}

}
