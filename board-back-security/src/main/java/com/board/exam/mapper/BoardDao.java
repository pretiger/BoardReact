package com.board.exam.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.board.exam.domain.Board;
import com.board.exam.domain.Reply;

@Mapper
public interface BoardDao {
	public List<Board> list(Map<String, Object> map);
	public int count();
	public Board detail(int num);
	public List<Reply> listComment(int bnum);
	public void insertComment(Reply reply);
	public void deleteComment(int rnum);
	public void update(Board board);
	public String preview(int num);
	public void plusSubstep(Board board);
	public void insertReply(Board board);
	public void insertBoard(Board board);
	public void delete(int num);
	public void insertAttach(Map<String, Object> map);
	public List<String> listAttach(int bnum);
	public void deleteAttach(String fullname);
	public void deleteReply(int bnum);
}
