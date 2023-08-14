package com.spring.myweb.reply.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.spring.myweb.command.ReplyVO;
import com.spring.myweb.reply.mapper.IReplyMapper;


@Service
public class ReplyService implements IReplyService {

	@Autowired
	private IReplyMapper mapper;
	
	@Override
	public void replyRegist(ReplyVO vo) {
		vo.setReplyPw(vo.getReplyPw());
		mapper.replyRegist(vo);
	}

	@Override
	public List<ReplyVO> getList(int bno) {
		
		Map<String, Object> data = new HashMap<>();
		data.put("bno", bno); //몇 번 글의 댓글을 가져올지에 대한 정보
		return mapper.getList(data);
	}

	@Override
	public int getTotal(int bno) {
		return mapper.getTotal(bno);
	}

	@Override
	public int pwCheck(ReplyVO vo) {
		
		int dbPw = mapper.pwCheck(vo.getRno(), vo.getReplyPw());
		if(dbPw >=1) {
			return 1;
		}
		else {
			return 0;
		}
		
	}

	@Override
	public void update(ReplyVO vo) {
		mapper.update(vo);
	}

	@Override
	public void delete(int rno) {
		mapper.delete(rno);
	}

}