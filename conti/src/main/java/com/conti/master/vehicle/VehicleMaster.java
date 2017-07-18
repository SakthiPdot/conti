package com.conti.master.vehicle;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.conti.master.branch.BranchModel;

@Entity
@Table(name = "m_vehicle")
@JsonIgnoreProperties(ignoreUnknown = true)
public class VehicleMaster {
	
	private int vehicle_id;
	private String vehicle_regno;
	private String vehicle_code;
	private String vehicle_modelno;
	private String vehicle_type;
	private String created_datetime;
	private String updated_datetime;
	private int created_by;
	private int updated_by;
	private String obsolete;
	private String active;
	
	public VehicleMaster() {
		
	}
	
	public BranchModel branchModel;
	@JoinColumn(name = "branch_id")
	@OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	public BranchModel getBranchModel() {
		return branchModel;
	}
	public void setBranchModel(BranchModel branchModel) {
		this.branchModel = branchModel;
	}
	
	
	@Id
	@Column(name ="vehicle_id")
	public int getVehicle_id() {
		return vehicle_id;
	}
	public void setVehicle_id(int vehicle_id) {
		this.vehicle_id = vehicle_id;
	}
	
	@Column( name = "vehicle_regno")
	public String getVehicle_regno() {
		return vehicle_regno;
	}
	public void setVehicle_regno(String vehicle_regno) {
		this.vehicle_regno = vehicle_regno;
	}
	
	@Column(name = "vehicle_code")
	public String getVehicle_code() {
		return vehicle_code;
	}
	public void setVehicle_code(String vehicle_code) {
		this.vehicle_code = vehicle_code;
	}
	
	
	@Column(name = "vehicle_modelno")
	public String getVehicle_modelno() {
		return vehicle_modelno;
	}
	public void setVehicle_modelno(String vehicle_modelno) {
		this.vehicle_modelno = vehicle_modelno;
	}
	
	@Column( name = "vehicle_type")
	public String getVehicle_type() {
		return vehicle_type;
	}
	public void setVehicle_type(String vehicle_type) {
		this.vehicle_type = vehicle_type;
	}
	
	
	@Column(name = "created_datetime")
	public String getCreated_datetime() {
		return created_datetime;
	}
	public void setCreated_datetime(String created_datetime) {
		this.created_datetime = created_datetime;
	}
	
	
	@Column(name = "updated_datetime")
	public String getUpdated_datetime() {
		return updated_datetime;
	}
	public void setUpdated_datetime(String updated_datetime) {
		this.updated_datetime = updated_datetime;
	}
	
	@Column( name = "created_by")
	public int getCreated_by() {
		return created_by;
	}
	public void setCreated_by(int created_by) {
		this.created_by = created_by;
	}
	
	@Column ( name = "updated_by")
	public int getUpdated_by() {
		return updated_by;
	}
	public void setUpdated_by(int updated_by) {
		this.updated_by = updated_by;
	}
	
	
	@Column( name ="obsolete")
	public String getObsolete() {
		return obsolete;
	}
	public void setObsolete(String obsolete) {
		this.obsolete = obsolete;
	}
	
	@Column(name = "active")
	public String getActive() {
		return active;
	}
	public void setActive(String active) {
		this.active = active;
	}
	
	
	
}
