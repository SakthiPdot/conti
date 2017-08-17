package com.conti.manifest;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonBackReference;
import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.conti.shipment.add.ShipmentModel;

@Entity
@Table(name = "t_manifestdetailes")
public class ManifestDetailedModel 
{
	private int manifestdetailed_id,manifest_id;
	
	private ManifestModel manifestModel;
	
	@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="manifest_id",referencedColumnName="manifest_id")
	@JsonBackReference
	public ManifestModel getManifestModel() {
		return this.manifestModel;
	}
	public void setManifestModel(ManifestModel manifestModel) {
		this.manifestModel = manifestModel;
	}
	
	
	@Id
	@Column(name="MANIFESTDETAILED_ID")
	@GeneratedValue
	public int getManifestdetailed_id() {
		return manifestdetailed_id;
	}
	public void setManifestdetailed_id(int manifestdetailed_id) {
		this.manifestdetailed_id = manifestdetailed_id;
	}
	
/*	@Column(name="MANIFEST_ID")
	public int getManifest_id() {
		return manifest_id;
	}
	public void setManifest_id(int manifest_id) {
		this.manifest_id = manifest_id;
	}*/
	
	
	public ShipmentModel shipmentModel;
	@JoinColumn(name="SHIPMENT_ID")
	@OneToOne(fetch=FetchType.EAGER, cascade = CascadeType.ALL)	
	public ShipmentModel getShipmentModel() 
	{
		return shipmentModel;
	}
	public void setShipmentModel(ShipmentModel shipmentModel) 
	{
		this.shipmentModel = shipmentModel;
	}
	
	
//	public ShipmentModel shipmentModel_lrnumber;
//	
//	@JoinColumn(name="LR_NUMBER")
//	@OneToOne(fetch=FetchType.EAGER, cascade = CascadeType.ALL)
//	public ShipmentModel getShipmentModel_lrnumber() 
//	{
//		return shipmentModel_lrnumber;
//	}
//	public void setShipmentModel_lrnumber(ShipmentModel shipmentModel_lrnumber) 
//	{
//		this.shipmentModel_lrnumber = shipmentModel_lrnumber;
//	}

	
}
