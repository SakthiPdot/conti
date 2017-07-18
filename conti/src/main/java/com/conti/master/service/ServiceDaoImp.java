package com.conti.master.service;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class ServiceDaoImp implements ServiceDao {

		@Autowired
		private SessionFactory sessionFactory;
		
		
		@Override
		@Transactional
		public List<ServiceMaster> getAllServices() {
			@SuppressWarnings("unchecked")
			List<ServiceMaster> listService = (List<ServiceMaster>) sessionFactory.getCurrentSession()
					.createQuery("from ServiceMaster where obsolete ='N'").list();
			return listService;
			
		}


		@Override
		@Transactional
		public void saveOrUpdate(ServiceMaster service) {
			sessionFactory.getCurrentSession().saveOrUpdate(service);
		}


		@Override
		@Transactional
		public ServiceMaster getServiceId(int id) {
			String hql = "FROM ServiceMaster WHERE obsolete = 'N' and service_id= " +id+ "";
			Query query = sessionFactory.getCurrentSession().createQuery(hql);
			
			@SuppressWarnings("unchecked")
			List<ServiceMaster> servicelist = (List<ServiceMaster>) query.list();
			if(servicelist != null && !servicelist.isEmpty()){
				return servicelist.get(0);
			}
			return null;
		}
}
