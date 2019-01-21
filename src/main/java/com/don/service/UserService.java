package com.don.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.don.dao.UserDao;
import com.don.domain.User;

@Service
public class UserService implements UserDetailsService{
	
	@Autowired
	private UserDao userDao;

	@Override
	public UserDetails loadUserByUsername(String id) throws UsernameNotFoundException {
		User user = userDao.selectOne(id);
		if(user == null) {
			throw new UsernameNotFoundException("아이디 또는 비밀번호가 올바르지 않습니다");
		}
		return user;
	}
	
	public void insertUser(User user){
		userDao.insertUser(user);
		
	}

	public void setAuthority(String id) {
		userDao.setAuthority(id);
	}

	public User selectOneById(String id) {
		return userDao.selectOne(id);
	}
	
	
	
	
}
