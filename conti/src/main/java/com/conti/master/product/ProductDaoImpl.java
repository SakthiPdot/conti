package com.conti.master.product;

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
	public int productCount() {
		int rec_count = ((Long)sessionFactory.getCurrentSession()
				.createQuery("select count(*) from Product WHERE obsolete = 'N'").uniqueResult()).intValue();
		return rec_count;
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
				.createQuery("from Product where  obsolete ='N' "
						+ "order by IFNULL(updated_datetime,created_datetime)  DESC ")
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

	
	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public List<Product> getProductBy100() {		
		
		return sessionFactory.getCurrentSession()
				.createQuery("from Product where  obsolete ='N' "
						+ "order by IFNULL(updated_datetime,created_datetime)  DESC ").setMaxResults(100)
				.list();
	}

	
	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public List<Product> getProductBySorting100(String name,String order) {		
		
		return sessionFactory.getCurrentSession()
				.createQuery("from Product where  obsolete ='N' "
						+ "order by ("+name+")"+  order ).setMaxResults(100)
				.list();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public List<Product> getProductWithLimit(int from, int to, String order) {
		
		return sessionFactory.getCurrentSession()
				.createQuery("from Product where  obsolete ='N' "
						+ "order by IFNULL(updated_datetime,created_datetime) "+order)
				.setFirstResult(from).setMaxResults(to).list();
	}


	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public List<Product> searchByProduct(String searchString) {
		return sessionFactory.getCurrentSession()
				.createQuery("from Product where  obsolete ='N' "
						+ "and product_name LIKE '%" +searchString + "%'"
						+ "OR product_Type LIKE '%"+searchString+ "%'"
						+ "OR product_code LIKE '%"+searchString+ "%'"
						+ "OR max_weight LIKE '%"+searchString+ "%'"
						+ "OR dimension_flag LIKE '%"+searchString+ "%'"
						+ "OR max_height LIKE '%"+searchString+ "%'"
						+ "OR max_width LIKE '%"+searchString+ "%'"
						+ "OR max_length LIKE '%"+searchString+ "%'"
						+ "OR active LIKE '%"+searchString+ "%'"					
						).list();
	}


	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public List<Product> searchByProductName(String searchString) {
		return sessionFactory.getCurrentSession()
				.createQuery("from Product where  obsolete ='N'  and active ='Y' "
						+ "and product_name LIKE '%"+searchString+"%'"					
						).list();

	}
	
	
	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public List<Product> searchByProductTypeUnique(String searchString) {
		return sessionFactory.getCurrentSession()
				.createQuery("from Product  where product_Type is not null"
						+ " and product_Type LIKE '%"+searchString+"%'"
						+ " group by product_Type"											
						).list();

	}
	
	
	@Override
	@Transactional
	public String checkProductName(String name) {
		@SuppressWarnings("unchecked")
		List<Product> ProductList=sessionFactory.getCurrentSession()
				.createQuery("from Product where obsolete ='N' AND product_name IN ('"+name.toUpperCase()+"','"+name.toLowerCase()+"')").list();
		
		if(!ProductList.isEmpty()&& ProductList!=null){
			return "AVAILABLE";
		}
		
		return "NOTAVAILABLE";
	}

}
