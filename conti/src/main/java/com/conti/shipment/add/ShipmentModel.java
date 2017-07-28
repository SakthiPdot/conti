package com.conti.shipment.add;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

/**
 * @Project_Name conti
 * @Package_Name com.conti.shipment.add
 * @File_name ShipmentModel.java
 * @author Sankar
 * @Created_date_time Jul 27, 2017 4:37:13 PM
 * @Updated_date_time Jul 27, 2017 4:37:13 PM
 */
@Entity
@Table(name = "t_shipment")
@JsonIgnoreProperties(ignoreUnknown = true)
public class ShipmentModel {
	
	int shipment_id, lr_number, sendercustomer_id, senderbranch_id, 
		consigneecustomer_id, consigneebranch_id, numberof_parcel,
		shipment_value, chargeable_weight, delivery_charge, handling_charge,
		tax_amount, total_charges, updated_by, created_by;
	String shipment_date, pay_mode, bill_to, status, service, description, 
			created_datetime, updated_datetime, obsolete;
	
	@Id
	@Column(name = "shipment_id")
	public int getShipment_id() {
		return shipment_id;
	}
	public void setShipment_id(int shipment_id) {
		this.shipment_id = shipment_id;
	}
	
	@Column(name = "lr_number")
	public int getLr_number() {
		return lr_number;
	}
	public void setLr_number(int lr_number) {
		this.lr_number = lr_number;
	}
	
	@Column(name = "sendercustomer_id")
	public int getSendercustomer_id() {
		return sendercustomer_id;
	}
	public void setSendercustomer_id(int sendercustomer_id) {
		this.sendercustomer_id = sendercustomer_id;
	}
	
	@Column(name = "senderbranch_id")
	public int getSenderbranch_id() {
		return senderbranch_id;
	}
	public void setSenderbranch_id(int senderbranch_id) {
		this.senderbranch_id = senderbranch_id;
	}
	
	@Column(name = "consigneecustomer_id")
	public int getConsigneecustomer_id() {
		return consigneecustomer_id;
	}
	public void setConsigneecustomer_id(int consigneecustomer_id) {
		this.consigneecustomer_id = consigneecustomer_id;
	}
	
	@Column(name = "consigneebranch_id")
	public int getConsigneebranch_id() {
		return consigneebranch_id;
	}
	public void setConsigneebranch_id(int consigneebranch_id) {
		this.consigneebranch_id = consigneebranch_id;
	}
	
	@Column(name = "numberof_parcel")
	public int getNumberof_parcel() {
		return numberof_parcel;
	}
	public void setNumberof_parcel(int numberof_parcel) {
		this.numberof_parcel = numberof_parcel;
	}
	
	@Column(name = "shipment_value")
	public int getShipment_value() {
		return shipment_value;
	}
	public void setShipment_value(int shipment_value) {
		this.shipment_value = shipment_value;
	}
	
	@Column(name = "chargeable_weight")
	public int getChargeable_weight() {
		return chargeable_weight;
	}
	public void setChargeable_weight(int chargeable_weight) {
		this.chargeable_weight = chargeable_weight;
	}
	
	@Column(name = "delivery_charge")
	public int getDelivery_charge() {
		return delivery_charge;
	}
	public void setDelivery_charge(int delivery_charge) {
		this.delivery_charge = delivery_charge;
	}
	@Column(name = "handling_charge")
	public int getHandling_charge() {
		return handling_charge;
	}
	public void setHandling_charge(int handling_charge) {
		this.handling_charge = handling_charge;
	}
	
	@Column(name = "tax_amount")
	public int getTax_amount() {
		return tax_amount;
	}
	public void setTax_amount(int tax_amount) {
		this.tax_amount = tax_amount;
	}
	
	@Column(name = "total_charges")
	public int getTotal_charges() {
		return total_charges;
	}
	public void setTotal_charges(int total_charges) {
		this.total_charges = total_charges;
	}
	
	@Column(name = "updated_by")
	public int getUpdated_by() {
		return updated_by;
	}
	public void setUpdated_by(int updated_by) {
		this.updated_by = updated_by;
	}
	
	@Column(name = "created_by")
	public int getCreated_by() {
		return created_by;
	}
	public void setCreated_by(int created_by) {
		this.created_by = created_by;
	}
	
	@Column(name = "shipment_date")
	public String getShipment_date() {
		return shipment_date;
	}
	public void setShipment_date(String shipment_date) {
		this.shipment_date = shipment_date;
	}
	
	@Column(name = "pay_mode")
	public String getPay_mode() {
		return pay_mode;
	}
	public void setPay_mode(String pay_mode) {
		this.pay_mode = pay_mode;
	}
	
	@Column(name = "bill_to")
	public String getBill_to() {
		return bill_to;
	}
	public void setBill_to(String bill_to) {
		this.bill_to = bill_to;
	}
	
	@Column(name = "status")
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	@Column(name = "service")
	public String getService() {
		return service;
	}
	public void setService(String service) {
		this.service = service;
	}
	
	@Column(name = "description")
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
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
	
	@Column(name = "obsolete")
	public String getObsolete() {
		return obsolete;
	}
	public void setObsolete(String obsolete) {
		this.obsolete = obsolete;
	}
	
	
	
}
