package com.spring.myweb.reply.service;

import java.util.List;

import com.spring.myweb.command.ReplyVO;

public interface IReplyService {

	void replyRegist(ReplyVO vo); //댓글 등록
	List<ReplyVO> getList(int bno); //목록 요청
	int getTotal(int bno); //댓글 개수(페이징, PageCreator는 사용하지 않아.)
	
	int pwCheck(ReplyVO vo); //비밀번호 확인
	void update(ReplyVO vo); //댓글 수정
	void delete(int rno); //댓글 삭제
	
	
}