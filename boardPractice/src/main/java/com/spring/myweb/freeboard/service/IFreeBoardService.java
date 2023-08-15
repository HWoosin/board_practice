package com.spring.myweb.freeboard.service;

import java.util.List;

import com.spring.myweb.command.FreeBoardVO;
import com.spring.myweb.util.PageVO;

public interface IFreeBoardService {
	
	//글 등록
	void regist(FreeBoardVO vo);
	
	//글 목록
	List<FreeBoardVO> getList(PageVO vo);
	
	//총 게시물 구하기
	int getTotal(PageVO vo);
	
	//상세보기
	FreeBoardVO getDetail(int bno);
	
	//글쓴이 확인
	boolean getContent(int bno, String pw);
	
	//수정
	void update(FreeBoardVO vo);
	
	//삭제
	void delete(int bno);	
	
	//답글 등록
	void replyRegist(FreeBoardVO vo);
	
}













