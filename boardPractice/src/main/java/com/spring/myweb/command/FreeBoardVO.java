package com.spring.myweb.command;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/*
CREATE TABLE freeboard(
   bno INT PRIMARY KEY AUTO_INCREMENT,
   del INT default 0,
   origin_bno INT(10) DEFAULT NULL,
   parent_bno INT(10) DEFAULT NULL,
   group_ord INT(10) DEFAULT 0,
   group_layer INT(10) DEFAULT 0,
   title VARCHAR(300) NOT NULL,
   writer VARCHAR(50) NOT NULL,
   pw VARCHAR(50) binary NOT NULL,
   content VARCHAR(3000) NOT NULL,
   reg_date DATETIME DEFAULT CURRENT_TIMESTAMP,
   upload_path varchar(100),
   file_loca varchar(100),
   file_name varchar(50),
   file_real_name varchar(50)
   
);
*/

@Getter
@Setter
@ToString
@NoArgsConstructor @AllArgsConstructor
public class FreeBoardVO {

	private int rownum;
	
	private int bno;
	private int del;
	private String title;
	private String writer;
	private String content;
	private String pw;
	private LocalDateTime regDate;
	
	//하나의 게시물이 몇개의 댓글을 포함하는 지 
	private int replyCnt;
	
	//답글을 위한 필드
	private int originBno;//부모글
	private int groupOrd;//원글,답글의 순서...그룹내의 순서
	private int groupLayer;//답글 계층.. 부모글에 대한 답글인지, 답글의 답글인지 표현
	private int parentBno;//바로 윗부모 답글 삭제시 필요 자식의 유무 판단에 사용
	
}
