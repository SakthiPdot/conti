package com.conti.userlog;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;


/**
 * @Project_Name conti
 * @Package_Name com.conti.userlog
 * @File_name UserLogDaoImpl.java
 * @author Sankar
 * @Created_date_time Jun 27, 2017 3:44:52 PM
 * @Updated_date_time Jun 27, 2017 3:44:52 PM
 */
@Repository
public class UserLogDaoImpl implements UserLogDao {

	@Autowired
	private SessionFactory sessionFactory;
	
	public UserLogDaoImpl() {
		
	}
	public UserLogDaoImpl(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	/* (non-Javadoc)
	 * @see com.conti.userlog.UserLogDao#saveorupdate(com.conti.userlog.UserLogModel)
	 */
	@Override
	@Transactional
	public void saveorupdate(UserLogModel userLogModel) {
		// TODO Auto-generated method stub
		sessionFactory.getCurrentSession().saveOrUpdate(userLogModel);
	}
	@Override
	@Transactional
	public UserLogModel passwordResetConf(int user_id, String link) {
		String hql = "FROM UserLogModel WHERE user_id ="+ user_id + " AND link ='"+ link +"'";
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		
		@SuppressWarnings("unchecked")
		List<UserLogModel> userloglist = (List<UserLogModel>) query.list();
		if(userloglist != null && !userloglist.isEmpty()) {
			return userloglist.get(0);
		}
		return null;
			
	}
	
	@Override
	@Transactional
	public List<UserLogModel> getUserlogListbyId(int user_id) {
		String hql = "FROM UserLogModel WHERE user_id ="+ user_id + "";
		@SuppressWarnings("unchecked")
		List<UserLogModel> listUser = (List<UserLogModel>) sessionFactory.getCurrentSession()
				.createQuery(hql).list();
		return listUser;
	}
}
