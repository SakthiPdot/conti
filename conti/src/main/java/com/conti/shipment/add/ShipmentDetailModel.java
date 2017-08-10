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
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonBackReference;
import org.codehaus.jackson.annotate.JsonManagedReference;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import com.conti.master.product.Product;

/**
 * @Project_Name conti
 * @Package_Name com.conti.shipment.add
 * @File_name ShipmentDetailModel.java
 * @author Sankar
 * @Created_date_time Aug 4, 2017 2:49:24 PM
 * @Updated_date_time Aug 4, 2017 2:49:24 PM
 */

@Entity
@Table (name = "t_shipmentdetail")

public class ShipmentDetailModel {

	public ShipmentDetailModel (){}
	int shipmentdetail_id, quantity;
	float length, width, height, weight, unit_price, total_price;
		
	//------------shipmentmodel 
		private ShipmentModel shipment;
		@ManyToOne(fetch = FetchType.EAGER,cascade = CascadeType.ALL)
		@JoinColumn(name = "shipment_id", referencedColumnName = "shipment_id")
		@JsonBackReference
		public ShipmentModel getShipment() {
			return shipment;
		}
		public void setShipment(ShipmentModel shipment) {
			this.shipment = shipment;
		}
		
	//----------------shipmenthsn detail
	private List<ShipmentHsnDetailModel> shipmentHsnDetail = new ArrayList<>() ;
	@LazyCollection(LazyCollectionOption.FALSE)
	@JoinColumn(name = "shipmentdetail_id", referencedColumnName = "shipmentdetail_id")
	@OneToMany(cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
	@JsonManagedReference
	public List<ShipmentHsnDetailModel> getShipmentHsnDetail() {
		return shipmentHsnDetail;
	}
	public void setShipmentHsnDetail(List<ShipmentHsnDetailModel> shipmentHsnDetail) {
		this.shipmentHsnDetail = shipmentHsnDetail;
	}
	
	
		
		
	//------------ Product
	private Product product;	
	
	@JoinColumn(name="product_id", referencedColumnName = "product_id")
	@OneToOne(fetch = FetchType.EAGER,cascade = CascadeType.MERGE)
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	
	

	
	@Id
	@GeneratedValue
	@Column(name = "shipmentdetail_id")
	public int getShipmentdetail_id() {
		return shipmentdetail_id;
	}
	public void setShipmentdetail_id(int shipmentdetail_id) {
		this.shipmentdetail_id = shipmentdetail_id;
	}
	
	@Column(name = "quantity")
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	@Column(name = "length")
	public float getLength() {
		return length;
	}
	public void setLength(float length) {
		this.length = length;
	}
	
	@Column(name = "width")
	public float getWidth() {
		return width;
	}
	public void setWidth(float width) {
		this.width = width;
	}
	
	@Column(name = "height")
	public float getHeight() {
		return height;
	}
	public void setHeight(float height) {
		this.height = height;
	}
	
	@Column(name = "weight")
	public float getWeight() {
		return weight;
	}
	public void setWeight(float weight) {
		this.weight = weight;
	}
	
	@Column(name = "unit_price")
	public float getUnit_price() {
		return unit_price;
	}
	public void setUnit_price(float unit_price) {
		this.unit_price = unit_price;
	}
	
	@Column(name = "total_price")
	public float getTotal_price() {
		return total_price;
	}
	public void setTotal_price(float total_price) {
		this.total_price = total_price;
	}
	
	
}
