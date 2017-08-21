package com.conti.shipment.add;

import java.util.List;



/**
 * @Project_Name conti
 * @Package_Name com.conti.shipment.add
 * @File_name ShipmentDao.java
 * @author Sankar
 * @Created_date_time Jul 27, 2017 4:52:07 PM
 * @Updated_date_time Jul 27, 2017 4:52:07 PM
 */

public interface ShipmentDao
{

	public int shipmentCount();
	public List<ShipmentModel> fetchShipmentWithLimit(int from,int to,String order);
	public List<ShipmentModel> fetchAllShipment(int branch_id);
	public int fetchMAXlrno(int branch_id);
	public String fetchMAXlrno_prefix(int branch_id);
	public void saveOrUpdate(ShipmentModel shipment);
	public List<ShipmentModel> fetchAllShipment100();
	public List<ShipmentModel> fetchAllShipment100Manifest(int branch_id);
	public List<ShipmentModel> fetchAllShipment();
	public List<ShipmentModel> fetchShipmentByLR(String searchString,int branchid);
	public List<ShipmentModel> filterShipment(String fromBranch, String toBranch, String fromDate,String toDate,String status);
	public ShipmentModel getshipmentby_lrno(int lrno);
//===========================Add Receipt======================================
	public List<ShipmentModel>getShipmentByCondition(int from,int to,String frombranch,String tobranch,String service,String paymode);
	public List<ShipmentModel> fetchAllShipment4receipt(int branch_id);
	public List<ShipmentModel>searchLRnumber(String searchkey);
//============================================================================
	//====== Delete in foreign key check process ==================//
	public ShipmentModel getServiceId(int serviceid);
	public ShipmentModel getCustomerId(int scustomerid,int ccustomerid);
	public ShipmentModel getLocationId(int locationid,int clocationid);
	/**
	 * @param int1
	 * @return
	 */
	public ShipmentModel getShipmentModelById(int shipmentId);
	
	public List<ShipmentModel> fetchshipmentforView(int branch_id); // for Manager / User
	public List<ShipmentModel> fetchshipmentforView(); // for Super Admin
}
