package com.conti.master.product;

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
	
	public List<Product> getProductBy100();
	public List<Product> getProductBySorting100(String name,String order);	
	public List<Product> getProductWithLimit(int from,int to,String order);
	
	public List<Product> searchByProduct(String SearchString);
	public List<Product> searchByProductName(String SearchString);
	public List<Product> searchByProductTypeUnique(String SearchString);
	public String checkProductName(String SearchString);
	public int productCount();
}
