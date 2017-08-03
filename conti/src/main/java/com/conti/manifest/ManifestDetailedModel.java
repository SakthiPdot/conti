package com.conti.manifest;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@Entity
@Table(name = "t_manifestdetails")
@JsonIgnoreProperties(ignoreUnknown = true)
public class ManifestDetailedModel 
{
	private int manifestdetailed_id,manifest_id,shipment_id;
	private String lr_number;
	
	
	@Id
	@Column(name="MANIFESTDETAILED_ID")
	public int getManifestdetailed_id() {
		return manifestdetailed_id;
	}
	public void setManifestdetailed_id(int manifestdetailed_id) {
		this.manifestdetailed_id = manifestdetailed_id;
	}
	
	@Column(name="MANIFEST_ID")
	public int getManifest_id() {
		return manifest_id;
	}
	public void setManifest_id(int manifest_id) {
		this.manifest_id = manifest_id;
	}
	
	@Column(name="SHIPMENT_ID")
	public int getShipment_id() {
		return shipment_id;
	}
	public void setShipment_id(int shipment_id) {
		this.shipment_id = shipment_id;
	}
	
	@Column(name="LR_NUMBER")
	public String getLr_number() {
		return lr_number;
	}
	public void setLr_number(String lr_number) {
		this.lr_number = lr_number;
	}
	
	
	
}
