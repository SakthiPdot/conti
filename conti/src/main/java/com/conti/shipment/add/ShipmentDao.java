package com.conti.shipment.add;

import java.util.List;

import com.conti.master.location.Location;

/**
 * @Project_Name conti
 * @Package_Name com.conti.shipment.add
 * @File_name ShipmentDao.java
 * @author Sankar
 * @Created_date_time Jul 27, 2017 4:52:07 PM
 * @Updated_date_time Jul 27, 2017 4:52:07 PM
 */
public interface ShipmentDao {
	public List<ShipmentModel> fetchAllShipment(int branch_id);
	public int fetchMAXlrno(int branch_id);
	public void saveOrUpdate(ShipmentModel shipment);
	public List<ShipmentModel> fetchAllShipment100();
	public List<ShipmentModel> fetchShipmentByLR(String searchString);
	public List<ShipmentModel> filterShipment(String fromBranch, String toBranch, String fromDate,String toDate,String status);
}
