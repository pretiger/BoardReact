package com.board.exam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.exam.domain.User;
import com.board.exam.mapper.UserDao;

@Service
public class UserService {

	@Autowired
	UserDao userDao;
	
	public User loginchk(User user) {
		return userDao.loginchk(user);
	}
	
	public void insert(User user) {
		userDao.insert(user);
	}
	
	public User login(String username) {
		return userDao.login(username);
	}
	
	public void update(User user) {
		userDao.update(user);
	}
	
}
