package com.conti.manifest;
/**
 * @Project_Name conti
 * @Package_Name com.conti.master.Manifest.add
 * @File_name AddManifest
 * Dao.java
 * @author Suresh
 * @Created_date_time Jun 22, 2017 4:31:53 PM
 * @Updated_date_time Jun 22, 2017 4:31:53 PM
 */



import java.util.List;
public interface ManifestDao 
{
	
	//====================add manifest===================
			public int fetchLastManifestNo();
			public int fetchLastManifestNoWithOriginAndDestination(int manifest_origin,int manifest_destination);
			public ManifestModel getLastManifestModel();			
			public ManifestModel getManifestByID(int manifestId);
	//====================Manifest  DAO declaration Start===================
	
		public List<ManifestModel>getManifest(int branch_id);
		public List<ManifestModel>getAllManifest(int branch_id);
		public List<ManifestModel>getAllManifests(int branch_id);
		public ManifestModel getManifestbyId(int id);
		public List<ManifestModel>getManifestByCondition(int frombranch,int tobranch,String fromdate,String todate);
		public List<ManifestModel>getInwardManifest(int id);
		public List<ManifestModel>getOutwardManifest(int id);
		public List<ManifestModel>manifestSearch(String searchkey);
		public void saveOrUpdate(ManifestModel manifestModel);//Save and update function
	
	//====================Manifest  DAO declaration End===================
	
	
	//====================Manifest Detailed DAO declaration Start===================
		
		public List<ManifestDetailedModel>getAllManifestDetailes(int manifest_id);
		//public List<ManifestDetailedModel>getManifestDetailed(int manifest_id);
		
	//====================Manifest Detailed DAO declaration End===================
		
		//===== Referred Delete Process in Foreign key =========//
		public ManifestModel getVehicleId(int vehicleid);
		public ManifestModel getEmployeeId(int employeeid);
}
