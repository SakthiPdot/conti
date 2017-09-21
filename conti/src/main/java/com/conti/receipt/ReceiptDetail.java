package com.conti.receipt;


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
import javax.persistence.Transient;

import org.codehaus.jackson.annotate.JsonBackReference;

import com.conti.manifest.ManifestModel;
import com.conti.shipment.add.ShipmentModel;

/**
 * @Project_Name conti
 * @Package_Name com.conti.receipt  com.conti.receipt
 * @File_name ReceiptDetail.java com.conti.receipt
 * @author Monu.C
 * @Created_date_time Aug 23, 2017 11:23:55 AM
 */

@Entity
@Table(name="t_receiptdetail")
public class ReceiptDetail {

	public int receiptdetailid,manifest_id;
	public float handling_charge,net_freight_charges;
	
	private int receipt_id;
	private String temp_date,temp_receiptno,temp_manifestno;

	@Id
	@GeneratedValue
	@Column(name="receiptdetailid")
	public int getReceiptdetailid() {
		return this.receiptdetailid;
	}
		
	


	@Transient
	public String getTemp_manifestno() {
		return temp_manifestno;
	}
	public void setTemp_manifestno(String temp_manifestno) {
		this.temp_manifestno = temp_manifestno;
	}


	@Transient
	public String getTemp_date() {
		return temp_date;
	}

	public void setTemp_date(String temp_date) {
		this.temp_date = temp_date;
	}


	@Transient
	public String getTemp_receiptno() {
		return temp_receiptno;
	}


	@Transient
	public int getReceipt_id() {
		return receipt_id;
	}


	public void setReceipt_id(int receipt_id) {
		this.receipt_id = receipt_id;
	}


	public void setTemp_receiptno(String temp_receiptno) {
		this.temp_receiptno = temp_receiptno;
	}

	public void setReceiptdetailid(int receiptdetailid) {
		this.receiptdetailid = receiptdetailid;
	}

	public ReceiptModel receiptModel;

	
	
	@JoinColumn(name="receipt_id")
	@ManyToOne(cascade=CascadeType.MERGE)  
	@JsonBackReference
	public ReceiptModel getReceiptModel() {
		return this.receiptModel;
	}


	public void setReceiptModel(ReceiptModel receiptModel) {
		this.receiptModel = receiptModel;
	}
	
	
	
	public ShipmentModel shipmentModel;

	
	@JoinColumn(name="shipment_id",referencedColumnName="shipment_id")
	@OneToOne(fetch=FetchType.EAGER,cascade=CascadeType.MERGE)
	public ShipmentModel getShipmentModel() {
		return this.shipmentModel;
	}


	public void setShipmentModel(ShipmentModel shipmentModel) {
		this.shipmentModel = shipmentModel;
	}
	
//	public ManifestModel  manifestModel;
//	
//	
//	@JoinColumn(name="manifest_id",referencedColumnName="manifest_id")
//	@OneToOne(fetch=FetchType.EAGER,cascade=CascadeType.ALL)
//	public ManifestModel getManifestModel() {
//		return this.manifestModel;
//	}
//	public void setManifestModel(ManifestModel manifestModel) {
//		this.manifestModel = manifestModel;
//	}
	
	
	@Column(name="handling_charge")
	public float getHandling_charge() {
		return this.handling_charge;
	}
	public void setHandling_charge(float handling_charge) {
		this.handling_charge = handling_charge;
	}

	
	@Column(name="net_freight_charges")
	public float getNet_freight_charges() {
		return this.net_freight_charges;
	}
	public void setNet_freight_charges(float net_freight_charges) {
		this.net_freight_charges = net_freight_charges;
	}


	@Column(name="manifest_id")
	public int getManifest_id() {
		return this.manifest_id;
	}
	public void setManifest_id(int manifest_id) {
		this.manifest_id = manifest_id;
	}

	
	
}
