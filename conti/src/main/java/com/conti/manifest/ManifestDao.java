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

import com.conti.manifest.*;
import com.conti.master.branch.BranchModel;

import java.util.List;
public interface ManifestDao 
{
	//====================add manifest===================
		public int fetchLastManifestNo();
	
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
		
		public List<ManifestDetailedModel>getAllManifestDetailes(int branch_id);
		
	//====================Manifest Detailed DAO declaration End===================
}
