package com.spring.myweb.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.myweb.command.FreeBoardVO;
import com.spring.myweb.command.UDFileVO;
import com.spring.myweb.freeboard.service.IFreeBoardService;
import com.spring.myweb.util.PageCreator;
import com.spring.myweb.util.PageVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/freeboard")
@Slf4j
public class FreeBoardController {

	@Autowired
	private IFreeBoardService service;
	
	//목록 화면
	@GetMapping("/freeList")
	public void freeList(PageVO vo, Model model) {
		
		PageCreator pc = new PageCreator(vo, service.getTotal(vo));
		
//		System.out.println(pc.toString());
		log.info(pc.toString());
		model.addAttribute("del", service.countDelAll());
		model.addAttribute("boardList", service.getList(vo));
		model.addAttribute("pc", pc);
	}
	
	//글쓰기 페이지 열어주는 메서드
	@GetMapping("/regist")
	public String regist() {
		return "freeboard/freeRegist";
	}
	
	//글 등록 처리
	@PostMapping("/regist")
	public String regist(FreeBoardVO vo, List<MultipartFile> file) {
		service.regist(vo, file);
		service.updateObno();//부모글, 그룹번호 업데이트
		return "redirect:/freeboard/freeList";
	}
	
	//글 상세 보기 처리
		/*
		 * PathVariable은 URL 경로에 변수를 포함시켜주는 방식
		 * null이나 공백이 들어갈 수 있는 파라미터라면 적용하지 않는 것을 추천
		 * 파라미터 값에 .이 포함되어 있다면 .뒤의 값은 잘린다는 것
		 * {}안에 변수명을 지어주고, @PathVariable 괄호 안에 영역을 지목해서 값 받아오기
		 */
	@GetMapping("/content/{bno}")
	public String getDetail(@PathVariable int bno, @ModelAttribute("p") PageVO vo, Model model) {		
		model.addAttribute("article", service.getDetail(bno));
		model.addAttribute("fileInfo", service.viewfile(bno));
		return "freeboard/freeDetail";
	}
	
	//글쓴이 확인
	@PostMapping("/check")
	@ResponseBody
	public int getContent(@RequestBody FreeBoardVO vo) {
		int bno = vo.getBno();
		String pw = vo.getPw();
		
		boolean checkPw = service.getContent(bno, pw);
		System.out.println(checkPw);
		System.out.println(bno);
		log.info(pw);
		return checkPw ? 1:0;
	}
	
	//글 수정 페이지 이동 처리
	@PostMapping("/modify")
	public String modify(@ModelAttribute("article") FreeBoardVO vo, Model model) {
		model.addAttribute("article", service.getDetail(vo.getBno()));
		return "freeboard/freeModify";
	}
	
	//글 수정 처리
	@PostMapping("/update")
	public String update(FreeBoardVO vo) {
		service.update(vo);
		return "redirect:/freeboard/content/" + vo.getBno();
	}
	
	//글 논리적삭제 처리
//	@PostMapping("/delfix")
//	public String delfix(int bno) {
//		service.delfix(bno);
//		return "redirect:/freeboard/freeList";
//	}
	
	//글 완전삭제 처리ㄴ
	@PostMapping("/delete")
	public String delete(FreeBoardVO vo) {
		service.delete(vo);
		return "redirect:/freeboard/freeList";
	}
	
	//답글작성 페이지 열어주는 메서드
	@GetMapping("/replyBoard")
	public String replyBoard(FreeBoardVO vo , Model model) {
		model.addAttribute("repBD",vo);
		return "freeboard/replyRegist";
	}
	//답글 등록 처리
	@PostMapping("/replyBoard")
	public String replyBoard(FreeBoardVO vo) {
		service.replyRegist(vo);
		return "redirect:/freeboard/freeList";
	}
	
	//엑셀다운
	@GetMapping("/downloadExcel")
	public void Excel(FreeBoardVO vo, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    service.getExcel(vo, request, response);
	 
	}
	
	
	//파일업로드
//	@PostMapping("/upload")
//	public String upload(List<MultipartFile> file, UDFileVO vo) {
//		service.insertfile(vo, file);
//		return "success";
//		
//	}
	
	//파일다운로드
	@GetMapping("/download/{fileLoca}/{fileName}")
	public ResponseEntity<byte[]> download(@PathVariable String fileLoca, @PathVariable String fileName){
		File file = new File("C:/test/upload/"+fileLoca+"/"+fileName);
		ResponseEntity<byte[]> result = null;
		
		HttpHeaders header = new HttpHeaders();
		
		//응답하는 본문을 브라우저가 어떻게 표시해야 할 지 알려주는 헤더 정보를 추가
		//inline인 경우 웹 페이지 화면에 표시되고, attachment인 경우 다운로드를 제공
		//request객체의 getHeader("User-Agent") -> 단어를 뽑아서 확인
        //ie: Mozilla/5.0 (Windows NT 6.3; WOW64; Trident/7.0; rv:11.0) like Gecko  
        //chrome: Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.101 Safari/537.36

        //파일명한글처리(Chrome browser) 크롬
        //header.add("Content-Disposition", "attachment; filename=" + new String(fileName.getBytes("UTF-8"), "ISO-8859-1") );
        //파일명한글처리(Edge) 엣지 
        //header.add("Content-Disposition", "attachment; filename=" + URLEncoder.encode(fileName, "UTF-8"));
        //파일명한글처리(Trident) IE
        //Header.add("Content-Disposition", "attachment; filename=" + URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", " "));
		
		header.add("Content-Disposition", "attachment; filename=" + fileName);
		
		try {
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
			result = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return result;
	}
}













