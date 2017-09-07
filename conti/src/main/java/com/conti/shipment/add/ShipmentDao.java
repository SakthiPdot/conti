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

	
	
	public List<ShipmentModel> getShipmentBySorting100ManifestAdmin (String name,String Order);
	public List<ShipmentModel> getShipmentBySorting100Manifest(String name,String Order,int branchId);
	
	public List<ShipmentModel> getShipmentBySorting100ReceiptAdmin (String name,String Order);
	public List<ShipmentModel> getShipmentBySorting100Receipt(String name,String Order,int branchId);
	
	public List<ShipmentModel> fetchAllShipment100Admin();
	public List<ShipmentModel> fetchAllShipment100Manifest(int branch_id);
	public List<ShipmentModel> filterShipment(String fromBranch, String toBranch, String fromDate,String toDate,String status);
	public ShipmentModel getshipmentby_lrno(int lrno);
	
	public int shipmentCount();
	public int shipmentCountStaff(int branch_id);
	
	public int shipmentCountReceipt();
	public int shipmentCountStaffReceipt(int branch_id);
	
	public List<ShipmentModel> fetchShipmentWithLimit(int from,int to,String order);
	public List<ShipmentModel> fetchShipmentWithLimitStaff(int from,int to,String order,int branch_id);
	
	public List<ShipmentModel> fetchShipmentWithLimitReceipt(int from,int to,String order);
	public List<ShipmentModel> fetchShipmentWithLimitStaffReceipt(int from,int to,String order,int branch_id);
	
	public List<ShipmentModel> fetchAllShipment(int branch_id);
	public int fetchMAXlrno(int branch_id);
	public String fetchMAXlrno_prefix(int branch_id);
	public void saveOrUpdate(ShipmentModel shipment);
	public List<ShipmentModel> fetchAllShipment100();
	
	public List<ShipmentModel> fetchAllShipmentForReceipt();
	public List<ShipmentModel> fetchAllShipmentForStaffForReceipt(int branchid);
	
	public List<ShipmentModel> fetchAllShipment();
	public List<ShipmentModel> fetchAllShipmentForStaff(int branchid);
	
	public List<ShipmentModel> fetchShipmentByLR(String searchString,int branchid);
	public List<ShipmentModel> fetchShipmentByLRAdmin(String searchString);
	
	public List<ShipmentModel> fetchShipmentByLRReceipt(String searchString,int branchid);
	public List<ShipmentModel> fetchShipmentByLRAdminReceipt(String searchString);
	
//===========================Add Receipt======================================
	public List<ShipmentModel>getShipmentByCondition(String from,String to,String frombranch,String tobranch,String service,String paymode);
	
	public List<ShipmentModel>searchLRnumber(String searchkey);
	
	public List<ShipmentModel> fetchAllShipment4receipt(int branch_id);
	public List<ShipmentModel> fetchAllShipment4receiptAdmin();
	
//============================================================================
	//====== Delete in foreign key check process ==================//
	public ShipmentModel getServiceId(int serviceid);
	public ShipmentModel getCustomerId(int scustomerid,int ccustomerid);
	public ShipmentModel getLocationId(int locationid,int clocationid);
	public ShipmentModel getBranchId(int sbranch_id,int cbranch_id);
	public ShipmentModel getUserId(int c_user,int u_user);
	
	public ShipmentDetailModel getProductid(int product_id);
	public ShipmentHsnDetailModel getProcductID(int productid);
	/**
	 * @param int1
	 * @return
	 */
	public ShipmentModel getShipmentModelById(int shipmentId);
	
	public List<ShipmentModel> fetchshipmentforView(int branch_id); // for Manager / User
	public List<ShipmentModel> fetchshipmentforView(); // for Super Admin
	
	public List<ShipmentModel> filterViewShipment(String fromBranch, String toBranch, String fromDate,String toDate,String status);
	public List<ShipmentDetailModel> filterViewShipmentbyproduct(String product);
	
	public List<ShipmentModel> shipment_searchbyLR4ViewAdmin(String lrno);
	
	public List<ShipmentModel> fetchAllLRNo();

	public List<ShipmentModel> getShipemntSorting1004SA(String name, String order);
	public List<ShipmentModel> getShipemntSorting1004MS(String name, String order, int branch_id);
	
}

