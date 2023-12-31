package com.spring.myweb.freeboard.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

import com.spring.myweb.command.FreeBoardVO;
import com.spring.myweb.command.UDFileVO;
import com.spring.myweb.util.PageVO;

public interface IFreeBoardService {
	
	//글 등록
	void regist(FreeBoardVO vo, List<MultipartFile> file);
	void updateObno();
	
	//글 목록
	List<FreeBoardVO> getList(PageVO vo);
	int countDelAll();
	
	//총 게시물 구하기
	int getTotal(PageVO vo);
	
	//상세보기
	FreeBoardVO getDetail(int bno);
	
	//글쓴이 확인
	boolean getContent(int bno, String pw);
	
	//수정
	void update(FreeBoardVO vo, List<MultipartFile> file, List<String> fileName);
	
			
	//답글없을경우 완전삭제
	void delete(FreeBoardVO vo);
	
	//답글 등록
	void replyRegist(FreeBoardVO vo, List<MultipartFile> file);
	
	//엑셀다운
	void getExcel(PageVO vo, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	
	//파일업로드
//	void insertfile(List<MultipartFile> file);
		
	
	//파일삭제
//	void deleteFile(UDFileVO vo, List<MultipartFile> file);

	//가지고있는 파일 가져오기
	List<UDFileVO> viewfile(int bno);
	
	
}













