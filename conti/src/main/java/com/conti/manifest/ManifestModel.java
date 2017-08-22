package com.conti.manifest;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonManagedReference;
import org.codehaus.jackson.annotate.JsonProperty;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import com.conti.master.branch.BranchModel;
import com.conti.master.employee.EmployeeMaster;
import com.conti.master.vehicle.VehicleMaster;

@Entity
@Table(name = "t_manifest")
public class ManifestModel 
{
	private int manifest_id,updated_by,created_by,manifest_origin,manifest_destination;
	private String manifest_number,vehicle_number,driver_name,manifest_status,obsolete;
	private String created_datetime,updated_datetime,manifest_prefix;
	
	
	
	


	private List<ManifestDetailedModel> manifestDetailModel=new ArrayList<>();
	
	
	@LazyCollection(LazyCollectionOption.FALSE)
	@JoinColumn(name="manifest_id",referencedColumnName="manifest_id")
	@OneToMany(cascade=CascadeType.ALL,orphanRemoval=true)
	@JsonManagedReference
	public List<ManifestDetailedModel> getManifestDetailModel() {
		return this.manifestDetailModel;
	}
	public void setManifestDetailModel(List<ManifestDetailedModel> manifestDetailModel) {
		this.manifestDetailModel = manifestDetailModel;
	}
	
	
	@Id
	@GeneratedValue
	@Column(name = "MANIFEST_ID")
	public int getManifest_id() {
		return manifest_id;
	}
	public void setManifest_id(int manifest_id) {
		this.manifest_id = manifest_id;
	}
	
	@Column(name = "OBSOLETE")
	public String getObsolete() {
		return obsolete;
	}
	public void setObsolete(String obsolete) {
		this.obsolete = obsolete;
	}
	
	public BranchModel branchModel1,branchModel2;
	
	
	@JoinColumn(name = "MANIFEST_ORIGIN")
	@OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
	public BranchModel getBranchModel1() {
		return branchModel1;
	}
	public void setBranchModel1(BranchModel branchModel1) {
		this.branchModel1 = branchModel1;
	}
	
	@JoinColumn(name = "MANIFEST_DESTINATION")
	@OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
	public BranchModel getBranchModel2() {
		return branchModel2;
	}
	public void setBranchModel2(BranchModel branchModel2) {
		this.branchModel2 = branchModel2;
	}
	
	public BranchModel 	vehicle_destination;	
	
	@JoinColumn(name="vehicle_destination")
	@OneToOne(fetch=FetchType.EAGER,cascade=CascadeType.MERGE)
	public BranchModel getVehicle_destination() {
		return this.vehicle_destination;
	}
	public void setVehicle_destination(BranchModel vehicle_destination) {
		this.vehicle_destination = vehicle_destination;
	}
	@Column(name = "UPDATED_BY")
	public int getUpdated_by() {
		return updated_by;
	}
	public void setUpdated_by(int updated_by) {
		this.updated_by = updated_by;
	}
	
	@Column(name = "CREATED_BY")
	public int getCreated_by() {
		return created_by;
	}
	public void setCreated_by(int created_by) {
		this.created_by = created_by;
	}
	
	
	
	
	@Column(name = "MANIFEST_NUMBER")
	public String getManifest_number() {
		return manifest_number;
	}
	public void setManifest_number(String manifest_number) {
		this.manifest_number = manifest_number;
	}
	
	private VehicleMaster vehicleMaster;
	
	
	@JsonProperty("vehicle_number")
	@JoinColumn(name="VEHICLE_NUMBER",referencedColumnName="vehicle_id")
	@OneToOne(fetch=FetchType.EAGER,cascade=CascadeType.MERGE)
	public VehicleMaster getVehicleMaster() {
		return this.vehicleMaster;
	}
	public void setVehicleMaster(VehicleMaster vehicleMaster) {
		this.vehicleMaster = vehicleMaster;
	}
/*	@Column(name = "VEHICLE_NUMBER")
	public String getVehicle_number() {
		return vehicle_number;
	}
	public void setVehicle_number(String vehicle_number) {
		this.vehicle_number = vehicle_number;
	}*/
	
	
	private EmployeeMaster employeeDriver;
	
	@JsonProperty("driver_name")
	@JoinColumn(name="DRIVER_NAME",referencedColumnName="emp_id")
	@OneToOne(fetch=FetchType.EAGER,cascade=CascadeType.MERGE)
	public EmployeeMaster getEmployeeDriver() {
		return this.employeeDriver;
	}
	public void setEmployeeDriver(EmployeeMaster employeeDriver) {
		this.employeeDriver = employeeDriver;
	}
/*	@Column(name = "DRIVER_NAME")
	public String getDriver_name() {
		return driver_name;
	}
	public void setDriver_name(String driver_name) {
		this.driver_name = driver_name;
	}
	*/
	@Column(name = "MANIFEST_STATUS")
	public String getManifest_status() {
		return manifest_status;
	}
	public void setManifest_status(String manifest_status) {
		this.manifest_status = manifest_status;
	}
	
	
	@Column(name = "CREATED_DATETIME")
	public String getCreated_datetime() {
		return created_datetime;
	}
	public void setCreated_datetime(String created_datetime) {
		this.created_datetime = created_datetime;
	}
	
	@Column(name = "UPDATED_DATETIME")
	public String getUpdated_datetime() {
		return updated_datetime;
	}
	public void setUpdated_datetime(String updated_datetime) {
		this.updated_datetime = updated_datetime;
	}
	
	@Column(name = "manifest_prefix")
	public String getManifest_prefix() {
		return this.manifest_prefix;
	}
	public void setManifest_prefix(String manifest_prefix) {
		this.manifest_prefix = manifest_prefix;
	}
		
}
