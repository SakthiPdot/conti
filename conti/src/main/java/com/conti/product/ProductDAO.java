package com.conti.product;

import java.util.List;

/**
 * @Project_Name conti
 * @Package_Name com.conti.product  com.conti.product
 * @File_name ProductDAO.java com.conti.product
 * @author Monu.C
 * @Created_date_time Jul 8, 2017 6:22:55 PM
 */
public interface ProductDAO {
	
	public void saveOrUpdate(Product product);
	public List<Product> getProduct();
	public Product getProduct(int productId);
	public void deleteProductById(int productId);
	
}
