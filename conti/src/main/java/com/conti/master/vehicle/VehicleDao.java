package com.conti.master.vehicle;

import java.util.List;

public interface VehicleDao {
		
	
	public List<VehicleMaster> getVehicle(int branch_id);
	public List<VehicleMaster> getAllVehicles();
	public void saveOrUpdate(VehicleMaster vehicle);
	public VehicleMaster getVehiclebyId(int id);
}
