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
					.createQuery("from ServiceMaster where obsolete ='N' ORDER BY  created_datetime DESC ").list();
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


		@Override
		@Transactional
		public List<ServiceMaster> searchbyService(String search_key) {
			
			@SuppressWarnings("unchecked")
			List<ServiceMaster> listservice = (List<ServiceMaster>) sessionFactory.getCurrentSession()
					.createQuery("from ServiceMaster WHERE obsolete = 'N' and service_name LIKE '%" + search_key + "%'"
							+ " OR service_code LIKE '%" + search_key + "%'").list();
			return listservice;
		}


		@Override
		@Transactional
		public List<ServiceMaster> searchbyServiceName(String search_key) {
			
			@SuppressWarnings("unchecked")
			List<ServiceMaster> listservice = (List<ServiceMaster>) sessionFactory.getCurrentSession()
					.createQuery("from ServiceMaster WHERE obsolete = 'N' and service_name LIKE '%" + search_key + "%'").list();
			return listservice;
		}


		@Override
		@Transactional
		public List<ServiceMaster> getServiceswithLimit(int from_limit, int to_limit, String order) {
			
			@SuppressWarnings("unchecked")
			List<ServiceMaster> listServ = (List<ServiceMaster>) sessionFactory.getCurrentSession()
					.createQuery("from ServiceMaster where obsolete = 'N' " + "ORDER BY IFNULL(created_datetime,updated_datetime)" + order)
					.setFirstResult(from_limit).setMaxResults(to_limit).list();
			return listServ;
		}
		@Override
		@Transactional
		public List<ServiceMaster> getServiceSorting100(String name,String order) {
			
			@SuppressWarnings("unchecked")
			List<ServiceMaster> listServ = (List<ServiceMaster>) sessionFactory.getCurrentSession()
					.createQuery("from ServiceMaster where obsolete = 'N' " 
							 + "order by ("+name+")"+  order )
							.setMaxResults(100).list();
			return listServ;
		}

		@Override
		@Transactional
		public String checkServiceName(String name) {
			@SuppressWarnings("unchecked")
			List<ServiceMaster> ServiceList = sessionFactory.getCurrentSession()
					.createQuery("from ServiceMaster where obsolete = 'N' AND service_name IN ('" + name.toUpperCase()+ "', '" + name.toLowerCase()+"')").list();
			
			
			if(!ServiceList.isEmpty()&& ServiceList!=null) {
				return "AVAILABLE";
			}
			return "NOTAVAILABLE";
		}


		@Override
		@Transactional
		public List<ServiceMaster> allSorting( String sorting) {
			
			
			@SuppressWarnings("unchecked")
			List<ServiceMaster> SortList = (List<ServiceMaster>) sessionFactory.getCurrentSession()
					.createQuery("from ServiceMaster where obsolete = 'N' ORDER BY "+ sorting +" ASC").list();
			
			return SortList;
		
		}


		@Override
		@Transactional
		public int serviceSettingCount() {
			int record_count = ((Long) sessionFactory.getCurrentSession().createQuery("select count(*) from ServiceMaster WHERE obsolete = 'N'").uniqueResult()).intValue();		
			return record_count;
		}
}
