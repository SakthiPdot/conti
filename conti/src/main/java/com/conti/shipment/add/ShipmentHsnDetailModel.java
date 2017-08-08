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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonBackReference;
import org.codehaus.jackson.annotate.JsonManagedReference;

import com.conti.hsn.Hsn;
import com.conti.master.product.Product;

/**
 * @Project_Name conti
 * @Package_Name com.conti.shipment.add
 * @File_name ShipmentHsnDetail.java
 * @author Sankar
 * @Created_date_time Aug 4, 2017 3:12:09 PM
 * @Updated_date_time Aug 4, 2017 3:12:09 PM
 */
@Entity
@Table (name ="t_shipmenthsndetail")
public class ShipmentHsnDetailModel {

	int shipmenthsndetail_id;//, shipmentdetail_id, shipment_id, hsn_id, product_id;

	@Id
	@GeneratedValue
	@Column (name = "shipmenthsndetail_id")
	public int getShipmenthsndetail_id() {
		return shipmenthsndetail_id;
	}

	public void setShipmenthsndetail_id(int shipmenthsndetail_id) {
		this.shipmenthsndetail_id = shipmenthsndetail_id;
	}
	
	//------------shipmentmodel 
	private ShipmentModel shipment;
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "shipment_id", referencedColumnName = "shipment_id")
	@JsonBackReference
	public ShipmentModel getShipment() {
		return shipment;
	}
	public void setShipment(ShipmentModel shipment) {
		this.shipment = shipment;
	}
	
	//-------------shipmentdetailmodel
	
	private ShipmentDetailModel shipmentDetail;
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "shipmentdetail_id", referencedColumnName = "shipmentdetail_id")
	@JsonBackReference
	public ShipmentDetailModel getShipmentDetail() {
		return shipmentDetail;
	}

	public void setShipmentDetail(ShipmentDetailModel shipmentDetail) {
		this.shipmentDetail = shipmentDetail;
	}
	//------ Hsn
			private List<Hsn> hsn = new ArrayList<>();
			
			/*@JoinColumn(name = "hsn_id", referencedColumnName = "hsn_id")*/
			/*@OneToMany(cascade=CascadeType.MERGE)*/
			@OneToMany(mappedBy = "hsn_id", fetch = FetchType.LAZY)
			@JsonManagedReference
			public List<Hsn> getHsn() {
				return hsn;
			}
			public void setHsn(List<Hsn> hsn) {
				this.hsn = hsn;
			}
			
		
		//------------ Product
			private List<Product> product = new ArrayList<>();
			/*@JoinColumn(name = "product_id", referencedColumnName = "product_id")
			@OneToMany(cascade=CascadeType.ALL,orphanRemoval=true)*/
			@OneToMany(mappedBy = "product_id", fetch = FetchType.LAZY)
			@JsonManagedReference
			public List<Product> getProduct() {
				return product;
			}
			public void setProduct(List<Product> product) {
				this.product = product;
			}
}
