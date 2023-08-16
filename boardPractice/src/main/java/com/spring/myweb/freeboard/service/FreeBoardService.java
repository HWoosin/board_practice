package com.spring.myweb.freeboard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.myweb.command.FreeBoardVO;
import com.spring.myweb.freeboard.mapper.IFreeBoardMapper;
import com.spring.myweb.util.PageVO;

@Service
public class FreeBoardService implements IFreeBoardService {

	@Autowired
	private IFreeBoardMapper mapper;
	
	@Override
	public void regist(FreeBoardVO vo) {
		mapper.regist(vo);
	}

	@Override
	public List<FreeBoardVO> getList(PageVO vo) {
		return mapper.getList(vo);
	}

	@Override
	public int getTotal(PageVO vo) {
		return mapper.getTotal(vo);
	}
	
	@Override
	public FreeBoardVO getDetail(int bno) {
		return mapper.getDetail(bno);
	}
	
	@Override
	public boolean getContent(int bno, String pw) {
		int result = mapper.getContent(bno, pw);
		return result == 1;

	}

	@Override
	public void update(FreeBoardVO vo) {
		mapper.update(vo);

	}

	@Override
	public void delete(int bno) {
		mapper.delete(bno);
	}

	@Override
	public void replyRegist(FreeBoardVO vo) {
		
		FreeBoardVO rep = vo;
		mapper.updatePos(rep.getOriginBno(),rep.getGroupOrd());//기존글들의 순서를 한층씩 다 밀어내고
		rep.setGroupOrd(rep.getGroupOrd()+1);//새로 작성된 글의 순서를 원글에서 +1하고
		mapper.replyRegist(rep);//자리가 지정된 글을 등록

	}
	
	
	
}
