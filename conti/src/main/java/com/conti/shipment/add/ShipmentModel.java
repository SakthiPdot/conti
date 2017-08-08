package com.conti.shipment.add;

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

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.codehaus.jackson.annotate.JsonManagedReference;

import com.conti.master.branch.BranchModel;
import com.conti.master.customer.CustomerModel;
import com.conti.master.service.ServiceMaster;

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
	
	int shipment_id, lr_number, numberof_parcel,
		updated_by, created_by, reference_invoice_no;
	String shipment_date, pay_mode, bill_to, status, description, 
			created_datetime, updated_datetime, obsolete;
	
	float shipment_value, chargeable_weight, delivery_charge, handling_charge,
	tax_amount, total_charges, cgst, igst, sgst, discount_amount, discount_percentage, tax;
	
	
	public ShipmentModel() {
		
	}
	
	//------------------Sender customer
	private CustomerModel sender_customer;
	@JoinColumn(name = "sendercustomer_id", referencedColumnName = "customer_id")
	@OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.PERSIST)
	public CustomerModel getSender_customer() {
		return sender_customer;
	}
	public void setSender_customer(CustomerModel sender_customer) {
		this.sender_customer = sender_customer;
	}
	
	//------------------Consignee customer	
	private CustomerModel consignee_customer;
	@JoinColumn(name = "consigneecustomer_id", referencedColumnName = "customer_id")
	@OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.PERSIST)
	public CustomerModel getConsignee_customer() {
		return consignee_customer;
	}
	public void setConsignee_customer(CustomerModel consignee_customer) {
		this.consignee_customer = consignee_customer;
	}
	
	//------------------ Sender branch
	private BranchModel sender_branch;
	@JoinColumn(name = "senderbranch_id", referencedColumnName = "branch_id")
	@OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
	public BranchModel getSender_branch() {
		return sender_branch;
	}
	public void setSender_branch(BranchModel sender_branch) {
		this.sender_branch = sender_branch;
	}
	
	//------------------ Consignee Branch
	private BranchModel consignee_branch;
	@JoinColumn(name = "consigneebranch_id", referencedColumnName = "branch_id")
	@OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
	public BranchModel getConsignee_branch() {
		return consignee_branch;
	}
	public void setConsignee_branch(BranchModel consignee_branch) {
		this.consignee_branch = consignee_branch;
	}
	
	//----------------- Service
	private ServiceMaster service;
	@JoinColumn(name = "service_id", referencedColumnName = "service_id")
	@OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
	public ServiceMaster getService() {
		return service;
	}
	public void setService(ServiceMaster service) {
		this.service = service;
	}
	
	//-------------- Shipment Detailed
	private List<ShipmentDetailModel> shipmentDetail = new ArrayList<>();
	
	@JoinColumn(name = "shipment_id", referencedColumnName = "shipment_id")
	@OneToMany(cascade = CascadeType.ALL, orphanRemoval= true, fetch = FetchType.EAGER)
	@JsonManagedReference
	public List<ShipmentDetailModel> getShipmentDetail() {
		return shipmentDetail;
	}
	public void setShipmentDetail(List<ShipmentDetailModel> shipmentDetail) {
		this.shipmentDetail = shipmentDetail;
	}

	
	
	
	
	@Id
	@GeneratedValue
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
	
	@Column(name = "numberof_parcel")
	public int getNumberof_parcel() {
		return numberof_parcel;
	}
	public void setNumberof_parcel(int numberof_parcel) {
		this.numberof_parcel = numberof_parcel;
	}
	
	@Column(name = "shipment_value")
	public float getShipment_value() {
		return shipment_value;
	}
	public void setShipment_value(float shipment_value) {
		this.shipment_value = shipment_value;
	}
	
	@Column(name ="chargeable_weight")
	public float getChargeable_weight() {
		return chargeable_weight;
	}
	public void setChargeable_weight(float chargeable_weight) {
		this.chargeable_weight = chargeable_weight;
	}
	@Column(name ="delivery_charge")
	public float getDelivery_charge() {
		return delivery_charge;
	}
	public void setDelivery_charge(float delivery_charge) {
		this.delivery_charge = delivery_charge;
	}
	@Column(name ="handling_charge")
	public float getHandling_charge() {
		return handling_charge;
	}
	public void setHandling_charge(float handling_charge) {
		this.handling_charge = handling_charge;
	}
	@Column(name ="tax_amount")
	public float getTax_amount() {
		return tax_amount;
	}
	public void setTax_amount(float tax_amount) {
		this.tax_amount = tax_amount;
	}
	@Column(name ="total_charges")
	public float getTotal_charges() {
		return total_charges;
	}
	public void setTotal_charges(float total_charges) {
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
	
	@Column(name = "reference_invoice_no")
	public int getReference_invoice_no() {
		return reference_invoice_no;
	}
	public void setReference_invoice_no(int reference_invoice_no) {
		this.reference_invoice_no = reference_invoice_no;
	}
	
	@Column(name = "cgst")
	public float getCgst() {
		return cgst;
	}
	public void setCgst(float cgst) {
		this.cgst = cgst;
	}
	@Column(name = "igst")
	public float getIgst() {
		return igst;
	}
	public void setIgst(float igst) {
		this.igst = igst;
	}
	@Column(name = "sgst")
	public float getSgst() {
		return sgst;
	}
	public void setSgst(float sgst) {
		this.sgst = sgst;
	}
	@Column(name = "discount_amount")
	public float getDiscount_amount() {
		return discount_amount;
	}
	public void setDiscount_amount(float discount_amount) {
		this.discount_amount = discount_amount;
	}
	@Column(name = "discount_percentage")
	public float getDiscount_percentage() {
		return discount_percentage;
	}
	public void setDiscount_percentage(float discount_percentage) {
		this.discount_percentage = discount_percentage;
	}
	@Column(name = "tax")
	public float getTax() {
		return tax;
	}
	public void setTax(float tax) {
		this.tax = tax;
	}
	
	
	
	
	
}
