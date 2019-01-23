package com.don.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.don.domain.User;

@Repository
public class UserDao {
	
	@Autowired
	private SqlSession session;

	public void insertUser(User user) {
		session.insert("user.insertUser",user);
	}

	public User selectOne(String id) {
		return session.selectOne("user.selectOne",id);
	}

	public void setAuthority(String id) {
		session.insert("user.insertAuthority",id);
	}

	public User selectOneByEmail(String email) {
		return session.selectOne("user.selectOneByEmail",email);
	}

	public void updateEmail(User user) {
		System.out.println(user);
		session.update("user.updateEmail",user);
	}
	
	
}
