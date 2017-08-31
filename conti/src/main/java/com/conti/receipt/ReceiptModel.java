package com.conti.receipt;


import java.util.ArrayList;
import java.util.List;
import java.util.Set;

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
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonManagedReference;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import com.conti.master.branch.BranchModel;

@Entity
@Table(name="t_receiptgeneration")
public class ReceiptModel 
{
	public int receipt_id,updated_by,created_by,receipt_number;
	public String paymode,courier_staff,obsolete,receipt_prefix;
	private String created_datetime,updated_datetime;
	private float local_transport,receipt_total;
	public long contact_number;
		
	
	

	
	public List<ReceiptDetail> receiptDetailList;
	
	
	@LazyCollection(LazyCollectionOption.FALSE)
	@JoinColumn(name="receipt_id",referencedColumnName="receipt_id")
	@OneToMany(cascade=CascadeType.ALL,orphanRemoval=true)
	@JsonManagedReference
	public List<ReceiptDetail> getReceiptDetailList() {
		return this.receiptDetailList;
	}
	public void setReceiptDetailList(List<ReceiptDetail> receiptDetailList) {
		this.receiptDetailList = receiptDetailList;
	}
	
	
	private BranchModel branchModel;
	

	@JoinColumn(name = "branch_id", referencedColumnName = "branch_id")
	@OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
	public BranchModel getBranchModel() {
		return this.branchModel;
	}
	public void setBranchModel(BranchModel branchModel) {
		this.branchModel = branchModel;
	}
	
	
	@Id
	@GeneratedValue
	@Column(name = "RECEIPT_ID")
	public int getReceipt_id() {	
		return receipt_id;
	}
	public void setReceipt_id(int receipt_id) {
		this.receipt_id = receipt_id;
	}
	
	

	@Column(name="RECEIPT_NUMBER")
	public int getReceipt_number() {
		return receipt_number;
	}
	public void setReceipt_number(int receipt_number) {
		this.receipt_number = receipt_number;
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
	

	@Column(name = "CREATED_DATETIME")
	public String getCreated_datetime() {
		return created_datetime;
	}
	public void setCreated_datetime(String created_datetime) {
		this.created_datetime = created_datetime;
	}
	
	@Column(name = "UPDATED_DATETIME")
	public String getUpdated_datetime(){
		return updated_datetime;
	}
	public void setUpdated_datetime(String updated_datetime) {
		this.updated_datetime = updated_datetime;
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
	
	@Column(name="local_transport")
	public float getLocal_transport() {
		return this.local_transport;
	}
	public void setLocal_transport(float local_transport) {
		this.local_transport = local_transport;
	}
	
	@Column(name="receipt_total")
	public float getReceipt_total() {
		return this.receipt_total;
	}
	public void setReceipt_total(float receipt_total) {
		this.receipt_total = receipt_total;
	}
	
	@Column(name = "receipt_prefix")
	public String getReceipt_prefix() {
		return this.receipt_prefix;
	}
	public void setReceipt_prefix(String receipt_prefix) {
		this.receipt_prefix = receipt_prefix;
	}
	@Column(name = "CONTACT_NUMBER")
	public long getContact_number() {
		return this.contact_number;
	}
	public void setContact_number(long contact_number) {
		this.contact_number = contact_number;
	}
}
