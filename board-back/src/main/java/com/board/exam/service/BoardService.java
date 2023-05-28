package com.board.exam.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.board.exam.domain.Board;
import com.board.exam.domain.Reply;
import com.board.exam.mapper.BoardDao;
import com.board.exam.util.UploadFileUtils;

@Service
public class BoardService {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardService.class);

	@Autowired
	BoardDao boardDao;
	
	@Value("${spring.servlet.multipart.location}")
	String uploadPath;
	
	public List<Board> list(int start, int end) {
		Map<String, Object> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		return boardDao.list(map);
	}
	
	public int count() {
		return boardDao.count();
	}
	
	public Board detail(int num) {
		return boardDao.detail(num);
	}
	
	public List<Reply> listComment(int bnum) {
		return boardDao.listComment(bnum);
	}
	
	@Transactional
	public void insertComment(Reply reply) {
		boardDao.insertComment(reply);
	}
	
	@Transactional
	public void deleteComment(int rnum) {
		boardDao.deleteComment(rnum);
	}
	
	@Transactional
	public void update(Board board) {
		boardDao.update(board);
		if(board.getFiles() != null) {
			MultipartFile[] files=board.getFiles();
			for(MultipartFile file : files) {
				if(file.getSize() > 0) {
					String originalFileName=file.getOriginalFilename();
					String fullname="";
					int bnum=board.getNum();
					try {
						fullname=UploadFileUtils.uploadFile(uploadPath, originalFileName, file.getBytes());
						Map<String, Object> map=new HashMap<>();
						map.put("fullname", fullname);
						map.put("bnum", bnum);
						boardDao.insertAttach(map);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
	
	@Transactional(readOnly = true)
	public String preview(int num) {
		return boardDao.preview(num);
	}
	
	@Transactional
	public void insertReply(Board board) {
		board.setSubstep(board.getSubstep()+1);
		board.setSublevel(board.getSublevel()+1);
		boardDao.plusSubstep(board);
		boardDao.insertReply(board);
		if(board.getFiles() != null) {
			MultipartFile[] files=board.getFiles();
			for(MultipartFile file : files) {
				if(file.getSize() > 0) {
					String originalFileName=file.getOriginalFilename();
					String fullname="";
					int bnum=board.getNum();
					try {
						fullname=UploadFileUtils.uploadFile(uploadPath, originalFileName, file.getBytes());
						Map<String, Object> map=new HashMap<>();
						map.put("fullname", fullname);
						map.put("bnum", bnum);
						boardDao.insertAttach(map);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
	
	@Transactional
	public void insertBoard(Board board) {
		boardDao.insertBoard(board);
		if(board.getFiles() != null) {
			MultipartFile[] files=board.getFiles();
			for(MultipartFile file : files) {
				if(file.getSize() > 0) {
					String originalFileName=file.getOriginalFilename();
					String fullname="";
					int bnum=board.getNum();
					try {
						fullname=UploadFileUtils.uploadFile(uploadPath, originalFileName, file.getBytes());
						Map<String, Object> map=new HashMap<>();
						map.put("fullname", fullname);
						map.put("bnum", bnum);
						boardDao.insertAttach(map);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
	
	public void deleteAttach(String fullname) {
		boardDao.deleteAttach(fullname);
	}
	
	public List<String> listAttach(int bnum) {
		return boardDao.listAttach(bnum);
	}
	
	public void delete(Board dto) {
		if(dto.getCount() > 0) {
			boardDao.deleteReply(dto.getNum());
		}
		List<String> fullnames=boardDao.listAttach(dto.getNum());
		if(fullnames != null) {
			for(String fullname : fullnames) {
				boardDao.deleteAttach(fullname);
				new File(uploadPath+fullname.replace('/', File.separatorChar)).delete();
			}
		}
		boardDao.delete(dto.getNum());
	}
	
}
