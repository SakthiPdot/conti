package com.conti.hsn;

import java.util.List;

/**
 * @Project_Name conti
 * @Package_Name com.conti.hsn
 * @File_name HsnDao.java
 * @author Sankar
 * @Created_date_time Aug 2, 2017 12:39:37 PM
 * @Updated_date_time Aug 2, 2017 12:39:37 PM
 */
public interface HsnDao {
	public List<Hsn> searchbyHsnCode(String search_key);
	public List<Hsn> searchbyHsnDescription(String search_key);
	public List<Hsn> getAllHsn();
	
	//=====Delete by Foreign Key ======//
	public Hsn getUserId(int c_user,int u_user);
}
