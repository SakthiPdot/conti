package com.conti.master.service;

import java.util.List;

public interface ServiceDao {

	public List<ServiceMaster> getAllServices();
	public void saveOrUpdate(ServiceMaster service);
	public ServiceMaster getServiceId(int id);
}
