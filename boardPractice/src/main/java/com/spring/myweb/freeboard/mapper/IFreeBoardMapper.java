package com.spring.myweb.freeboard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.myweb.command.FreeBoardVO;
import com.spring.myweb.util.PageVO;

public interface IFreeBoardMapper {

		//글 등록
		void regist(FreeBoardVO vo);
		void updateObno();
		
		//글 목록
		List<FreeBoardVO> getList(PageVO vo);
		int countDelAll();
	
		//총 게시물 수 구하기
		int getTotal(PageVO vo);
		
		//상세보기
		FreeBoardVO getDetail(int bno);
		
		//글쓴이 확인
		int getContent(@Param("bno")int bno,  @Param("pw")String pw);
		
		//수정
		void update(FreeBoardVO vo);
		
		//답글있을경우 논리적삭제
		void delfix(int bno);
		
		//답글없을경우 완전삭제
		void delete(int bno);
		
		//그룹이 모두 삭제된글이라고 뜰경우 del과 그룹의 댓글갯수 비교해서 맞으면 모두 삭제
		int countGrp(int originBno);
		int countDel(int originBno);
		void deleteAll(int originBno);
		
		//답글있는지 확인
		int checkChild(int bno);
		
		//답글 등록
		void replyRegist(FreeBoardVO vo);
		
		//답글 위치 배치
		int replyPos(@Param("originBno")int originBno, @Param("groupOrd")int groupOrd);
		
		//그룹안 답글 위치 수정
		void updatePos(@Param("originBno")int originBno, @Param("groupOrd")int groupOrd);
		
		//엑셀받기
		List<FreeBoardVO> getExcel();

		

}
