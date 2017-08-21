package com.conti.master.vehicle;

import java.util.List;


public interface VehicleDao {
		
	
	public List<VehicleMaster> getVehicle(int branch_id);
	public List<VehicleMaster> getAllVehicles();
	public void saveOrUpdate(VehicleMaster vehicle);
	public VehicleMaster getVehiclebyId(int id);
	
	public List<VehicleMaster> searchbyVehicle(String search_key);
	public List<VehicleMaster> getVehicleswithLimit( int from_limit, int to_limit, String order);

	public List<VehicleMaster> getVehicleSorting100(String name,String order);
	public List<VehicleMaster> searchbyVehicleType(String search_key);
	public List<VehicleMaster> searchforVehicleType(String search_key);
	public List<VehicleMaster> searchforVehicleRegNo(String search_key);
	
	
	
	public String checkVehicleRegno(String SearchString);
	public int vehicleSettingCount();
	public List<VehicleMaster> getVehicleBy100();
	
	//===== Referred Delete Process in Foreign key =========//
	public VehicleMaster getBranchId(int branch_id);
}
