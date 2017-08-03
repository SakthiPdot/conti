package com.conti.master.service;

import java.util.List;

public interface ServiceDao {

	public List<ServiceMaster> getAllServices();
	public void saveOrUpdate(ServiceMaster service);
	public ServiceMaster getServiceId(int id);
	public List<ServiceMaster> searchbyService(String search_key);
	public List<ServiceMaster> searchbyServiceName(String search_key);	
	public List<ServiceMaster> getServiceswithLimit(int from_limit, int to_limit, String order);
	
	public String checkServiceName(String SearchString);
	
	public List<ServiceMaster> allSorting(String sorting);
}
