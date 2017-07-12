package com.conti.master.product;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

/**
 * @Project_Name conti
 * @Package_Name com.conti.product  com.conti.product
 * @File_name product.java com.conti.product
 * @author Monu.C
 * @Created_date_time Jul 8, 2017 5:38:27 PM
 */

@Entity
@Table(name="m_product")
@JsonIgnoreProperties(ignoreUnknown=true)
public class Product {
	
	private int product_id;
	private String product_name;
	private String product_code;
	private String product_Type;
	private float max_weight;
	private String dimension_flag;
	private float  max_height;
	private float max_width;
	private float max_length;
	private String created_datetime;
	private String updated_datetime;
	private int updated_by;
	private int created_by;
	private String obsolete;
	private String active;
	
	public Product() {
	}

	
	




	@Id
	@GeneratedValue
	@Column(name="product_id")
	public int getProduct_id() {
		return this.product_id;
	}

	@Column(name="product_name")
	public String getProduct_name() {
		return this.product_name;
	}

	@Column(name="product_code")
	public String getProduct_code() {
		return this.product_code;
	}
	
	@Column(name="product_Type")
	public String getProduct_Type() {
		return this.product_Type;
	}
	public void setProduct_Type(String product_Type) {
		this.product_Type = product_Type;
	}

	@Column(name="max_weight")
	public float getMax_weight() {
		return this.max_weight;
	}

	@Column(name="dimension_flag")
	public String getDimension_flag() {
		return this.dimension_flag;
	}

	@Column(name="max_height")
	public float getMax_height() {
		return this.max_height;
	}

	@Column(name="max_width")
	public float getMax_width() {
		return this.max_width;
	}

	@Column(name="max_length")
	public float getMax_length() {
		return this.max_length;
	}

	@Column(name="created_datetime")
	public String getCreated_datetime() {
		return this.created_datetime;
	}

	@Column(name="updated_datetime")
	public String getUpdated_datetime() {
		return this.updated_datetime;
	}

	@Column(name="updated_by")
	public int getUpdated_by() {
		return this.updated_by;
	}

	@Column(name="created_by")
	public int getCreated_by() {
		return this.created_by;
	}

	@Column(name="obsolete")
	public String getObsolete() {
		return this.obsolete;
	}
	
	@Column(name="active")
	public String getActive() {
		return this.active;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}

	public void setMax_weight(float max_weight) {
		this.max_weight = max_weight;
	}

	public void setDimension_flag(String dimension_flag) {
		this.dimension_flag = dimension_flag;
	}

	public void setMax_height(float max_height) {
		this.max_height = max_height;
	}

	public void setMax_width(float max_width) {
		this.max_width = max_width;
	}

	public void setMax_length(float max_length) {
		this.max_length = max_length;
	}

	public void setCreated_datetime(String created_datetime) {
		this.created_datetime = created_datetime;
	}

	public void setUpdated_datetime(String updated_datetime) {
		this.updated_datetime = updated_datetime;
	}

	public void setUpdated_by(int updated_by) {
		this.updated_by = updated_by;
	}

	public void setCreated_by(int created_by) {
		this.created_by = created_by;
	}

	public void setObsolete(String obsolete) {
		this.obsolete = obsolete;
	}

	public void setActive(String active) {
		this.active = active;
	}

}
