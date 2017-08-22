package com.conti.address;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;



@Repository
public class AddressDaoImpl implements AddressDao{

	@Autowired
	private SessionFactory sessionFactory;

	public AddressDaoImpl() {
		
	}
	
	public AddressDaoImpl(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	
	@Override
	@Transactional
	public List<AddressModel> getList() {
		
		@SuppressWarnings("unchecked")
		List<AddressModel> addressModel= (List<AddressModel>)sessionFactory.getCurrentSession()
				.createQuery("from AddressModel where obsolete ='N' and active ='Y'").list();
		
		return addressModel;
		
	}
	
	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public List<AddressModel> searchByAddressName(String searchString) {
		return sessionFactory.getCurrentSession()
				.createQuery("from AddressModel where  obsolete ='N'  and active ='Y' "
						+ "and city LIKE '%"+searchString+"%'"					
						).list();

	}
	
}