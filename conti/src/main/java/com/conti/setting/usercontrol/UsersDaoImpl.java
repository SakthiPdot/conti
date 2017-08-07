package com.conti.setting.usercontrol;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.conti.master.employee.EmployeeMaster;
import com.conti.others.ConstantValues;


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
	
	ConstantValues constantVal = new ConstantValues();
	
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
			String hql = "from User where obsolete ='N' and id=" + id;
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

		
		@Override
		@Transactional
		public List<User> getUsersbyBranchId(int branch_id) {
			@SuppressWarnings("unchecked")
			List<User> listuser = (List<User>) sessionFactory.getCurrentSession()
					.createQuery("from User WHERE obsolete = 'N' and branchModel.branch_id = '"+ branch_id+"'").list();
			
			return listuser;
		}


		@Override
		@Transactional
		public List<User> getUserbyEmpid(int emp_id) {
			@SuppressWarnings("unchecked")
			List<User> listuser = (List<User>) sessionFactory.getCurrentSession()
					.createQuery("from User WHERE obsolete = 'N' and emp_id = '"+ emp_id+"'").list();
			
			return listuser;
		}

		@Override
		@Transactional
		public List<User> getAllUsers() {
			@SuppressWarnings("unchecked")
			List<User> listUser = (List<User>) sessionFactory.getCurrentSession()
					.createQuery("from User where obsolete = 'N' "
					+ "ORDER BY IFNULL(created_datetime, updated_datetime) DESC")
					.list();
			return listUser;
		}						

		@Override
		@Transactional
		public User getUserbyEmp(int emp_id) {
			String hql = "FROM User WHERE obsolete = 'N' and emp_id = " + emp_id+ "";
			Query query = sessionFactory.getCurrentSession().createQuery(hql);
			
			@SuppressWarnings("unchecked")
			List<User> userlist = (List<User>) query.list();
			if(userlist !=null && !userlist.isEmpty()){
				return userlist.get(0);
			}
			return null;
		}
		
		
		@Override
		@Transactional
		public List<User> getLocationSorting100(String name,String order) {
			@SuppressWarnings("unchecked")
			List<User> listUser = (List<User>) sessionFactory.getCurrentSession()
					.createQuery("from User where obsolete ='N' "
							+ "order by ("+name+")"+  order )
					.setMaxResults(100)
					.list();
			
			return listUser;
		}
		
		@Override
		@Transactional
		public List<User> getUserwithLimitbySA(int branch_id, int from_limit, int to_limit, String order) {
			@SuppressWarnings("unchecked")
			List<User> listUser = (List<User>) sessionFactory.getCurrentSession()
					.createQuery("from User where obsolete ='N' AND branchModel.branch_id =" + branch_id + " "
							+ "ORDER BY IFNULL(created_datetime, updated_datetime) "+order)
					.setFirstResult(from_limit).setMaxResults(to_limit).list();
			return listUser;
		}
		
		
		@Override
		@Transactional
		public List<User> getUserwithLimit(int branch_id, int from_limit, int to_limit, String order) {
			@SuppressWarnings("unchecked")
			List<User> listUser = (List<User>) sessionFactory.getCurrentSession()
					.createQuery("from User where obsolete ='N' AND branchModel.branch_id =" + branch_id + " "
							+ "AND role.role_Name <>"+ constantVal.ROLE_SADMIN +" "
							+ "ORDER BY IFNULL(created_datetime, updated_datetime) "+order)
					.setFirstResult(from_limit).setMaxResults(to_limit).list();
			return listUser;
		}
		
		
		@Override
		@Transactional
		public List<User> searchbySAUser(String search_key) {
			// TODO Auto-generated method stub
			@SuppressWarnings("unchecked")
			
			List<User> listemp = (List<User>) sessionFactory.getCurrentSession()
			.createQuery("from User WHERE obsolete ='N' and employeeMaster.emp_name LIKE '%" + search_key + "%'"
					+ " OR employeeMaster.emp_code LIKE '%" + search_key + "%'"
					+ " OR branchModel.branch_name LIKE '%" + search_key + "%'"
					+ " OR username LIKE '%" + search_key + "%' OR role.role_Name LIKE '%" + search_key + "%'").list();
			return listemp;
			
		}
		
		@Override
		@Transactional
		public List<User> searchbyUser(String search_key) {
			// TODO Auto-generated method stub
			@SuppressWarnings("unchecked")
			
			List<User> listemp = (List<User>) sessionFactory.getCurrentSession()
			.createQuery("from User WHERE obsolete ='N' and employeeMaster.emp_name LIKE '%" + search_key + "%'"
					+ " OR employeeMaster.emp_code LIKE '%" + search_key + "%'"
					+ " OR branchModel.branch_name LIKE '%" + search_key + "%'"
					+ " OR username LIKE '%" + search_key + "%' OR role.role_Name LIKE '%" + search_key + "%' AND role.role_Name <> '"+ constantVal.ROLE_SADMIN +"'").list();
			return listemp;
			
		}
		
		@Override
		@Transactional
		public List<User> getUsersbyBranchIdwihoutSA(int branch_id) {
			@SuppressWarnings("unchecked")
			List<User> listuser = (List<User>) sessionFactory.getCurrentSession()
					.createQuery("from User WHERE obsolete = 'N' and branchModel.branch_id = '"+ branch_id+"' and role.role_Name <> '" + constantVal.ROLE_SADMIN + "'").list();
			
			return listuser;
		}
		
		@Override
		@Transactional
		public int find_record_countforSA() {
			int rec_count = ((Long)sessionFactory.getCurrentSession().createQuery("select count(*) from User WHERE obsolete = 'N'").uniqueResult()).intValue();
			return rec_count;
		}
	
		@Override
		@Transactional
		public int find_record_count() {
			int rec_count = ((Long)sessionFactory.getCurrentSession().createQuery("select count(*) from User WHERE obsolete = 'N' AND role.role_Name <> '"+ constantVal.ROLE_SADMIN +"'").uniqueResult()).intValue();
			return rec_count;
		}
}
	