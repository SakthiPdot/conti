package com.conti.setting.usercontrol;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.conti.userlog.UserLogModel;

/**
 * @Project_Name conti
 * @Package_Name com.conti.setting.usercontrol
 * @File_name UsersDaoImpl.java
 * @author Sankar
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 20, 2017 2:21:39 PM
 */

@Repository
class UsersDaoImpl implements UsersDao {
	
	@Autowired
	private SessionFactory sessionFactory;
	
	public UsersDaoImpl() {
		
	}
	
	public UsersDaoImpl(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	//================================save==============================
	@Override
	@Transactional
	public void saveOrUpdate(User user) {
		sessionFactory.getCurrentSession().saveOrUpdate(user);
	}
//	//================================List all Values======================
	@Override
	@Transactional
	public List<User> list() {
		@SuppressWarnings("unchecked")
		List<User> listUser = (List<User>) sessionFactory.getCurrentSession()
				.createQuery("from User where obsolete ='N'").list();
		return listUser;
	}
	//================================Delete By ID============================
	@Override
	@Transactional
	public void delete(int id) {
		User userToDelete = new User();
		userToDelete.setUser_id(id);
		//String Y="Y";
		String hql="update User  set obsolete='Y', active='N' where id=" + id;
		sessionFactory.getCurrentSession().createQuery(hql).executeUpdate();
			
	}
	  //================================List By ID==============================
		@Override 
		@Transactional
		public User get(int id) {
			String hql = "from User where obsolete ='N' id=" + id;
			Query query = sessionFactory.getCurrentSession().createQuery(hql);
			
			@SuppressWarnings("unchecked")
			List<User> listUser = (List<User>) query.list();
			
			if (listUser != null && !listUser.isEmpty()) {
				return listUser.get(0);
			}
			
			return null;
		}
		
		
		
		/*------------------------------- Find user by username begin ----------------------- */				
		@Override
		@Transactional
		@SuppressWarnings("unchecked")
		public User findByUserName(String username)
		{

			List<User> users = new ArrayList<User>();
			users = sessionFactory.getCurrentSession().createQuery("from User where username=? AND obsolete ='N'").setParameter(0, username).list();
			if (users.size() > 0)
			{
				return users.get(0);
			} else
			{
				return null;
			}

		}
		/*------------------------------- Find user by username end ----------------------- */						
		
	
}
	