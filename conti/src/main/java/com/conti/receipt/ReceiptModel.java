package com.conti.receipt;


/**
 * @Project_Name conti
 * @Package_Name custom js Receipt
 * @File_name Receipt_controller.js
 * @author Suresh
 * @Updated_user Suresh
  @Created_date_time August 09, 2017 11:31:53 AM
 * @Updated_date_time August 09, 2017 11:31:53 AM
 */
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.conti.shipment.add.ShipmentModel;

@Entity
@Table(name="t_receiptgeneration")
@JsonIgnoreProperties(ignoreUnknown=true)
public class ReceiptModel 
{
	public int receipt_id,updated_by,created_by,receipt_number,manifest_number,lr_number,contact_number;
	public String paymode,courier_staff,obsolete;
	
	@Id
	@GeneratedValue
	@Column(name = "MANIFEST_ID")
	public int getReceipt_id() {	
		return receipt_id;
	}
	public void setReceipt_id(int receipt_id) {
		this.receipt_id = receipt_id;
	}
	
	@Column(name = "CONTACT_NUMBER")
	public int getContact_number() {
		return contact_number;
	}
	public void setContact_number(int contact_number) {
		this.contact_number = contact_number;
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
	
	@Column(name = "PAYMODE")
	public String getPaymode() {
		return paymode;
	}
	public void setPaymode(String paymode) {
		this.paymode = paymode;
	}
	
	@Column(name = "COURIER_STAFF")
	public String getCourier_staff() {
		return courier_staff;
	}
	public void setCourier_staff(String courier_staff) {
		this.courier_staff = courier_staff;
	}
	
	@Column(name = "OBSOLETE")
	public String getObsolete() {
		return obsolete;
	}
	public void setObsolete(String obsolete) {
		this.obsolete = obsolete;
	}
	
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
	
	@Column(name="RECEIPT_NUMBER")
	public int getReceipt_number() {
		return receipt_number;
	}
	public void setReceipt_number(int receipt_number) {
		this.receipt_number = receipt_number;
	}
	
	@Column(name="MANIFEST_NUMBER")
	public int getManifest_number() {
		return manifest_number;
	}
	public void setManifest_number(int manifest_number) {
		this.manifest_number = manifest_number;
	}
	
	@Column(name="LR_NUMBER")
	public int getLr_number() {
		return lr_number;
	}
	public void setLr_number(int lr_number) {
		this.lr_number = lr_number;
	}
	
	
	
}
