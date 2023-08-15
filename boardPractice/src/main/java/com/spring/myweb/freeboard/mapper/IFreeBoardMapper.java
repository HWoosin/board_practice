package com.spring.myweb.freeboard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.myweb.command.FreeBoardVO;
import com.spring.myweb.util.PageVO;

public interface IFreeBoardMapper {

		//글 등록
		void regist(FreeBoardVO vo);
		
		//글 목록
		List<FreeBoardVO> getList(PageVO vo);
	
		//총 게시물 수 구하기
		int getTotal(PageVO vo);
		
		//상세보기
		FreeBoardVO getDetail(int bno);
		
		//글쓴이 확인
		int getContent(@Param("bno")int bno,  @Param("pw")String pw);
		
		//수정
		void update(FreeBoardVO vo);
		
		//삭제
		void delete(int bno);
		
		//답글 등록
		void replyRegist(FreeBoardVO vo);
		
		//답글 위치 배치
		int replyPos(@Param("originBno")int originBno, @Param("groupOrd")int groupOrd);

		

}
