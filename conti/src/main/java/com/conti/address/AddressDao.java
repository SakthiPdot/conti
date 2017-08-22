package com.conti.address;

import java.util.List;



/**
 * Servlet implementation class AddressDao
 */
public interface AddressDao {
	
		public List<AddressModel> getList();

		public List<AddressModel> searchByAddressName(String SearchString);
}
