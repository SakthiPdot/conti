package com.conti.master.vehicle;

import java.util.List;

import com.conti.master.location.Location;

public interface VehicleDao {
		
	
	public List<VehicleMaster> getVehicle(int branch_id);
	public List<VehicleMaster> getAllVehicles();
	public void saveOrUpdate(VehicleMaster vehicle);
	public VehicleMaster getVehiclebyId(int id);
	
	public List<VehicleMaster> searchbyVehicle(String search_key);
	public List<VehicleMaster> getVehicleswithLimit(int branch_id, int from_limit, int to_limit, String order);

	public List<VehicleMaster> getVehicleSorting100(String name,String order);
	public List<VehicleMaster> searchbyVehicleType(String search_key);
	public List<VehicleMaster> searchforVehicleType(String search_key);
	public List<VehicleMaster> searchforVehicleRegNo(String search_key);
	
	
	
	public String checkVehicleRegno(String SearchString);
}
