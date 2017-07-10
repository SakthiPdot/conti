package com.conti.product;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.conti.master.location.Location;

/**
 * @Project_Name conti
 * @Package_Name com.conti.product  com.conti.product
 * @File_name ProductDaoImpl.java com.conti.product
 * @author Monu.C
 * @Created_date_time Jul 8, 2017 6:23:19 PM
 */

@Repository
public class ProductDaoImpl implements ProductDAO {


	@Autowired
	private SessionFactory sessionFactory;
	
	
	
	public ProductDaoImpl() {
	}

	public ProductDaoImpl(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@Override
	@Transactional
	public void saveOrUpdate(Product product) {
		sessionFactory.getCurrentSession().saveOrUpdate(product);
	}

	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public List<Product> getProduct() {
		return sessionFactory.getCurrentSession()
				.createQuery("from Product where  obsolete ='N' and active ='Y'  ")
				.list();
	}

	
	@Override
	@Transactional
	public Product getProduct(int productId) {

		@SuppressWarnings("unchecked")
		List<Product> ProductList=sessionFactory.getCurrentSession()
				.createQuery("from Product where id="+productId).list();
		
		if(!ProductList.isEmpty()&& ProductList!=null){
			return ProductList.get(0);
		}
		
		return null;
	}
	
	@Override
	@Transactional
	public void deleteProductById(int productId) {
		
		Product product =new Product();
		product.setProduct_id(productId);
		
		sessionFactory.getCurrentSession().
		createQuery("update Product  set obsolete='Y', active='N' where id="+productId )
		.executeUpdate();
	}

}
