package com.conti.master.location;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.conti.master.branch.BranchModel;

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
	public int locationSettingCount() {
		int rec_count = ((Long)sessionFactory.getCurrentSession().createQuery("select count(*) from Location WHERE obsolete = 'N'").uniqueResult()).intValue();
		return rec_count;
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
	
	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public List<Location> getLocationSorting100(String name,String order) {
		
		return sessionFactory.getCurrentSession()
				.createQuery("from Location where  obsolete ='N' "
						    + "order by ("+name+")"+  order )
				.setMaxResults(100)
				.list();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public List<Location> fetchAllLocation() {
		
		return sessionFactory.getCurrentSession()
				.createQuery("from Location where  obsolete ='N' "
						+ "order by IFNULL(updated_datetime,created_datetime)  DESC ")
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

	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public List<Location> getLocationWithLimit(int from, int to, String order) {
		return sessionFactory.getCurrentSession()
				.createQuery("from Location where obsolete ='N'"
						+ "order by IFNULL(updated_datetime,created_datetime) "+order)
					.setFirstResult(from).setMaxResults(to).list();
	}

	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public List<Location> searchByLocation(String searchString) {
		
		return sessionFactory.getCurrentSession()
				.createQuery("from Location where obsolete ='N' "
						+ "and location_name  LIKE '%"+searchString + "%' "
						+ "OR location_code LIKE '%"+searchString+ "%' "
						+ "OR pincode LIKE '%"+searchString+ "%' "
						+ "OR abbreviation LIKE '%"+searchString+ "%' "
						+ "OR obsolete LIKE '%"+searchString+ "%' "
						+ "OR address.city LIKE '%"+searchString+ "%' "
						+ "OR address.state LIKE '%"+searchString+ "%' "
						+ "OR address.country LIKE '%"+searchString+ "%' "
						+ "OR pincode LIKE '%"+searchString+ "%' "
						).list();
		
	}
	
	
	@Override
	@Transactional
	public List<Location> searchbyeyLocation(String search_key) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		
		List<Location> listlocation = (List<Location>) sessionFactory.getCurrentSession()
		.createQuery("from Location WHERE obsolete ='N' and location_name LIKE '%" + search_key + "%'"
				+ " OR location_code LIKE '%" + search_key + "%'"
				+ " OR branch_addressline1 LIKE '%" + search_key + "%'"
				+ " OR branch_addressline2 LIKE '%" + search_key + "%' OR location.location_name LIKE '%" + search_key + "%'"
				+ " OR location.address.city LIKE '%" + search_key + "%' OR location.address.district LIKE '%" + search_key + "%'"
				+ " OR location.address.state LIKE '%"+ search_key + "%'OR location.address.pincode LIKE '%" + search_key + "%'").list();
		return listlocation;
		
	}
	
	@Override
	@Transactional
	public List<Location> searchbyeyLocationName(String search_key) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		
		List<Location> locationlist = (List<Location>) sessionFactory.getCurrentSession()
		.createQuery("from Location WHERE obsolete ='N'and active='Y' and location_name LIKE '%" + search_key + "%'"+"OR pincode LIKE '%"+search_key + "%'").list();
		return locationlist;
		
	}
	

}
