package com.board.exam.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Reply {
	private int rnum;
	private int bnum;
	private String replytext;
	private String replyer;
	private Date regdate;
}
