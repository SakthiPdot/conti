package com.conti.master.vehicle;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.conti.others.ConstantValues;
@Repository
public class VehicleDaoImp implements VehicleDao  {
	
	@Autowired
	private SessionFactory sessionFactory;
	
	ConstantValues constantVal = new ConstantValues();

	@Transactional
	@Override
	public List<VehicleMaster> getVehicle(int branch_id) {
		
		@SuppressWarnings("unchecked")
		List<VehicleMaster> listvehic = (List<VehicleMaster>) sessionFactory.getCurrentSession()
				.createQuery("from VehicleMaster WHERE obsolete = 'N' and active ='Y' and branch_id = '" + branch_id +"'" ).list();
		return listvehic;
	}

	@Override
	@Transactional
	public List<VehicleMaster> getAllVehicles() {
		@SuppressWarnings({ "unchecked"})
		List<VehicleMaster> listVehicle = (List<VehicleMaster>) sessionFactory.getCurrentSession()
				.createQuery("from VehicleMaster where obsolete = 'N' ORDER BY  created_datetime DESC ").list();
				return listVehicle;
	}

	@Override
	@Transactional
	public List<VehicleMaster> getVehicleSorting100(String name,String order) {
		@SuppressWarnings({ "unchecked"})
		List<VehicleMaster> listVehicle = (List<VehicleMaster>) sessionFactory.getCurrentSession()
				.createQuery("from VehicleMaster where obsolete = 'N' "
						 + "order by ("+name+")"+  order )
				.setMaxResults(100)
				.list();
				return listVehicle;
	}

	
	@Override
	@Transactional
	public void saveOrUpdate(VehicleMaster vehicle) {
		sessionFactory.getCurrentSession().saveOrUpdate(vehicle);
	}

	@Override
	@Transactional
	public VehicleMaster getVehiclebyId(int id) {
		String hql = "FROM VehicleMaster WHERE obsolete = 'N' and vehicle_id =" + id+"";
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		
		@SuppressWarnings("unchecked")
		List<VehicleMaster> vehiclelist = (List<VehicleMaster>) query.list();
		if(vehiclelist !=null && !vehiclelist.isEmpty()) {
			return vehiclelist.get(0);
		}
		return null;
	}

	@Override
	@Transactional
	public List<VehicleMaster> searchbyVehicle(String search_key) {
		
		@SuppressWarnings("unchecked")
		List<VehicleMaster> listservice = (List<VehicleMaster>) sessionFactory.getCurrentSession()
				.createQuery("from VehicleMaster WHERE obsolete = 'N' and vehicle_regno LIKE '%" + search_key + "%'" 
						+ "OR vehicle_code LIKE '%" + search_key + "%'" 
						+ "OR branchModel.branch_name LIKE '%" + search_key + "%'"
						+ "OR vehicle_modelno LIKE '%" + search_key + "%'" 
						+ "OR vehicle_type LIKE '%" + search_key + "%'").list();
		return listservice;
	}

	@Override
	@Transactional
	public List<VehicleMaster> getVehicleswithLimit(int from_limit, int to_limit, String order) {
		@SuppressWarnings("unchecked")
		
		List<VehicleMaster> listVehicle = (List<VehicleMaster>) sessionFactory.getCurrentSession()
				.createQuery("from VehicleMaster where obsolete = 'N' ORDER BY IFNULL (created_datetime, updated_datetime)" +order)
				.setFirstResult(from_limit).setMaxResults(to_limit).list();

		return listVehicle;
		
	
	}

	
	@Override
	@Transactional
	public List<VehicleMaster> searchbyVehicleType(String search_key) {
		
		@SuppressWarnings("unchecked")
		List<VehicleMaster> listtype = (List<VehicleMaster>) sessionFactory.getCurrentSession()
				.createQuery("from VehicleMaster WHERE obsolete = 'N' "
						+ " AND vehicle_type LIKE '%" + search_key+ "%' GROUP BY vehicle_type").list();
		return listtype;
	}

	
	@Override
	@Transactional
	public List<VehicleMaster> searchforVehicleRegNo(String search_key) {
		
		@SuppressWarnings("unchecked")
		List<VehicleMaster> listtype = (List<VehicleMaster>) sessionFactory.getCurrentSession()
				.createQuery("from VehicleMaster WHERE obsolete = 'N' "
						+ " AND vehicle_regno LIKE '%" + search_key+ "%'").list();
		return listtype;
	}
	@Override
	@Transactional
	public List<VehicleMaster> searchforVehicleType(String search_key) {
		@SuppressWarnings("unchecked" )
		List<VehicleMaster> listtype = (List<VehicleMaster>) sessionFactory.getCurrentSession()
				.createQuery("from VehicleMaster WHERE obsolete = 'N' "
						+ "AND vehicle_type LIKE '%" + search_key + "%' GROUP BY vehicle_type").list();
		return listtype;
	}

	@Override
	@Transactional
	public String checkVehicleRegno(String regno) {
		@SuppressWarnings("unchecked")
		List<VehicleMaster> VehicleList = sessionFactory.getCurrentSession()
				.createQuery("from VehicleMaster where obsolete = 'N' AND vehicle_regno IN('" + regno.toUpperCase()+ "','" + regno.toLowerCase()+ "')").list();
		if(!VehicleList.isEmpty()&& VehicleList!=null) {
			return "AVAILABLE";
		}
		
		return "NOTAVAILABLE";
	}

	@Override
	@Transactional
	public int vehicleSettingCount() {
		int record_count = ((Long) sessionFactory.getCurrentSession()
				.createQuery("select count(*) from VehicleMaster WHERE obsolete = 'N'").uniqueResult()).intValue();
		
		return record_count;
	}

	@Override
	@Transactional
	public List<VehicleMaster> getVehicleBy100() {
		@SuppressWarnings("unchecked")
		List<VehicleMaster> getlist = (List<VehicleMaster>) sessionFactory.getCurrentSession()
				.createQuery("from VehicleMaster where obsolete = 'N' ORDER BY created_datetime DESC ").setMaxResults(100).list();
		
		return getlist;
	}
	//===== Referred Delete Process in Foreign key =========//
	@Override
	@Transactional
	public VehicleMaster getBranchId(int branch_id) {
		@SuppressWarnings("unchecked")
		List<VehicleMaster> getbranchId = sessionFactory.getCurrentSession()
				.createQuery("from VehicleMaster where obsolete = 'N' and branch_id=" +branch_id).list();
		if(getbranchId != null && !getbranchId.isEmpty()){
			return getbranchId.get(0);
		}
		return null;
	}
	
	

}
