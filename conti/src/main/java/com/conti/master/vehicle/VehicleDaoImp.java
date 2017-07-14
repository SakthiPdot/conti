package com.conti.master.vehicle;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
@Repository
public class VehicleDaoImp implements VehicleDao  {
	
	@Autowired
	private SessionFactory sessionFactory;

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
		@SuppressWarnings("unchecked")
		List<VehicleMaster> listVehicle = (List<VehicleMaster>) sessionFactory.getCurrentSession()
				.createQuery("from VehicleMaster where obsolete = 'N' ").list();
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
		String hql = "FROM VehicleMaster WHERE obsolete = 'N' and active = 'Y' and vehicle_id =" + id+"";
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		
		@SuppressWarnings("unchecked")
		List<VehicleMaster> vehiclelist = (List<VehicleMaster>) query.list();
		if(vehiclelist !=null && !vehiclelist.isEmpty()) {
			return vehiclelist.get(0);
		}
		return null;
	}
	
	

}
