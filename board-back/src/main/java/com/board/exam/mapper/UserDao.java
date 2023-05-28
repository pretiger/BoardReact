package com.board.exam.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.board.exam.domain.User;

@Mapper
public interface UserDao {
	public User loginchk(User user);
	public void insert(User user);
	public User login(String user);
	public void update(User user);
}
