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
import com.conti.master.customer.CustomerModel;

import java.util.List;
public interface ManifestDao 
{
	public List<ManifestModel>getManifest(int branch_id);
	public List<ManifestModel>getAllManifest(int branch_id);
	public List<ManifestModel>getAllManifests(int branch_id);
	public ManifestModel getManifestbyId(int id);
}
