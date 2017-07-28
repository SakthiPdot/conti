package com.conti.manifest;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@Entity
@Table(name = "m_manifest")
@JsonIgnoreProperties(ignoreUnknown = true)
public class ManifestModel 
{
	private int manifest_id,shipment_id,updated_by,created_by,manifest_origin,manifest_destination;
	private String manifest_number,vehicle_number,driver_name,manifest_status,obsolate;
	private String created_datetime,updated_datetime;
	
	
	@Id
	@Column(name = "MANIFEST_ID")
	public int getManifest_id() {
		return manifest_id;
	}
	public void setManifest_id(int manifest_id) {
		this.manifest_id = manifest_id;
	}
	
	@Column(name = "MANIFEST_ORIGIN")
	public int getManifest_origin() {
		return manifest_origin;
	}
	public void setManifest_origin(int manifest_origin) {
		this.manifest_origin = manifest_origin;
	}
	
	@Column(name = "MANIFEST_DESTINATION")
	public int getManifest_destination() {
		return manifest_destination;
	}
	public void setManifest_destination(int manifest_destination) {
		this.manifest_destination = manifest_destination;
	}
	@Column(name = "SHIPMENT_ID")
	public int getShipment_id() {
		return shipment_id;
	}
	public void setShipment_id(int shipment_id) {
		this.shipment_id = shipment_id;
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
	
	@Column(name = "VEHICLE_NUMBER")
	public String getVehicle_number() {
		return vehicle_number;
	}
	public void setVehicle_number(String vehicle_number) {
		this.vehicle_number = vehicle_number;
	}
	
	@Column(name = "DRIVER_NAME")
	public String getDriver_name() {
		return driver_name;
	}
	public void setDriver_name(String driver_name) {
		this.driver_name = driver_name;
	}
	
	@Column(name = "MANIFEST_STATUS")
	public String getManifest_status() {
		return manifest_status;
	}
	public void setManifest_status(String manifest_status) {
		this.manifest_status = manifest_status;
	}
	
	@Column(name = "OBSOLATE")
	public String getObsolate() {
		return obsolate;
	}
	public void setObsolate(String obsolate) {
		this.obsolate = obsolate;
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
		
}
