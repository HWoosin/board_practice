package com.spring.myweb.freeboard.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import com.spring.myweb.command.FreeBoardVO;
import com.spring.myweb.command.UDFileVO;
import com.spring.myweb.freeboard.mapper.IFreeBoardMapper;
import com.spring.myweb.util.PageVO;

import lombok.extern.slf4j.Slf4j;


@Service
@Slf4j
public class FreeBoardService implements IFreeBoardService {

	@Autowired
	private IFreeBoardMapper mapper;
	
	@Override
	public void regist(FreeBoardVO vo, List<MultipartFile> file) {
		mapper.regist(vo);
		if(file != null) {
			insertfile(file);			
		}
	}
	
	@Override
	public void updateObno() { //bno를 origin_bno와 parent_bno에 똑같이 붙여주기 = 원글 작성시. 
		mapper.updateObno();
	}

	@Override
	public List<FreeBoardVO> getList(PageVO vo) {
		return mapper.getList(vo);
	}
	
	@Override
	public int countDelAll() {
		return mapper.countDelAll();
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
	public void update(FreeBoardVO vo, List<MultipartFile> file, List<String> fileName) {
		
//		mapper.deleteAllFiles(vo.getBno());
		if(file != null) {
			System.out.println(vo.getBno());
			log.info(file.toString());
			updatefile(vo.getBno(), file);	
		}
		if(fileName != null) {
			for(String fn : fileName) {
				deleteFile(fn);
			}
		}
		mapper.update(vo);

	}
	

	@Override
	public void delete(FreeBoardVO vo) {//답글없으면 삭제 , 답글 있으면 삭제되었습니다 처리, 그룹의 댓글이 삭제된 채로 표시되면 완전 모두 삭제
//		System.out.println(vo.getBno());
//		System.out.println(vo.getGroupLayer());
//		System.out.println(mapper.checkChild(vo.getBno()));
//		System.out.println(mapper.checkChild(vo.getBno())>vo.getGroupLayer());
		
		if(mapper.checkChild(vo.getBno())>vo.getGroupLayer()) {
			mapper.delfix(vo.getBno());
			
			if(mapper.countGrp(vo.getOriginBno())== mapper.countDel(vo.getOriginBno())) {
				mapper.deleteAll(vo.getOriginBno());
			}
		}
		else {
			mapper.delete(vo.getBno());
			mapper.deleteReply(vo.getBno());
			
			if(mapper.countGrp(vo.getOriginBno())== mapper.countDel(vo.getOriginBno())) {
				mapper.deleteAll(vo.getOriginBno());
			}
		}
	}
	
//	@Override
//	public void delfix(int bno) {
//		mapper.delfix(bno);
//	}

	@Override
	public void replyRegist(FreeBoardVO vo,List<MultipartFile> file) {
		
		FreeBoardVO rep = vo;
		mapper.updatePos(vo.getOriginBno(),vo.getGroupOrd());//기존글들의 순서를 한층씩 다 밀어내고
		rep.setGroupOrd(rep.getGroupOrd()+1);//새로 작성된 글의 순서를 원글에서 +1하고
		mapper.replyRegist(rep);//자리가 지정된 글을 등록
		if(file != null) {
			insertfile(file);			
		}

	}
	
	public void insertfile(List<MultipartFile> file) {

		//날짜별로 폴더를 생성해서 관리할 예정.
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMdd");
		String fileLoca = now.format(dtf);
		
		//기본 경로 C:/test/upload로 사용.
		String uploadPath = "C:/test/upload/";
		//폴더 없으면 새롭게 생성
		File folder = new File(uploadPath + fileLoca);
		if(!folder.exists()) folder.mkdirs();
		
		//저장될 파일명은 uuid를 이용한 파일명으로 저장
		//uuid가 제공하는 랜덤 문자열에 -을 제거해서 전부 사용.
		
		//리스트로 들어오면 모든 파일 입력
		for(MultipartFile f : file) {
			String fileRealName = f.getOriginalFilename();
			UUID uuid = UUID.randomUUID();
			String uuids = uuid.toString().replaceAll("-", "");
			
			//확장자 추출
			String fileExtension= fileRealName.substring(fileRealName.lastIndexOf("."));
			
			log.info("저장할 폴더 경로: "+ uploadPath);
			log.info("실제 파일명: "+ fileRealName);
			log.info("폴더명: "+ fileLoca);
			log.info("확장자: "+ fileExtension);
			log.info("고유랜덤문자: "+ uuids);
			
			String fileName = uuids + fileExtension;
			log.info("변경해서 저장할 파일명: "+ fileName);
			
			//업로드한 파일을 지정한 로컬 경로로 전송
			File saveFile = new File(uploadPath + fileLoca + "/" + fileName);
			try {
				f.transferTo(saveFile);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
			
			UDFileVO vo = new UDFileVO(); 
			vo.setUploadPath(uploadPath);
			vo.setFileLoca(fileLoca);
			vo.setFileName(fileName);
			vo.setFileRealName(fileRealName);
			
			mapper.insertfile(vo);
		}
		
	}
	
	public void updatefile(int bno, List<MultipartFile> file) {

		//날짜별로 폴더를 생성해서 관리할 예정.
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMdd");
		String fileLoca = now.format(dtf);
		
		//기본 경로 C:/test/upload로 사용.
		String uploadPath = "C:/test/upload/";
		//폴더 없으면 새롭게 생성
		File folder = new File(uploadPath + fileLoca);
		if(!folder.exists()) folder.mkdirs();
		
		//저장될 파일명은 uuid를 이용한 파일명으로 저장
		//uuid가 제공하는 랜덤 문자열에 -을 제거해서 전부 사용.
		
		//리스트로 들어오면 모든 파일 입력
		for(MultipartFile f : file) {
			String fileRealName = f.getOriginalFilename();
			UUID uuid = UUID.randomUUID();
			String uuids = uuid.toString().replaceAll("-", "");
			
			//확장자 추출
			String fileExtension= fileRealName.substring(fileRealName.lastIndexOf("."));
			
			log.info("저장할 폴더 경로: "+ uploadPath);
			log.info("실제 파일명: "+ fileRealName);
			log.info("폴더명: "+ fileLoca);
			log.info("확장자: "+ fileExtension);
			log.info("고유랜덤문자: "+ uuids);
			
			String fileName = uuids + fileExtension;
			log.info("변경해서 저장할 파일명: "+ fileName);
			
			//업로드한 파일을 지정한 로컬 경로로 전송
			File saveFile = new File(uploadPath + fileLoca + "/" + fileName);
			try {
				f.transferTo(saveFile);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
			
			UDFileVO vo = new UDFileVO();
			vo.setBno(bno);
			vo.setUploadPath(uploadPath);
			vo.setFileLoca(fileLoca);
			vo.setFileName(fileName);
			vo.setFileRealName(fileRealName);
			
			mapper.updatefile(vo);
		}
		
	}
	
	public void insertTempfile(int bno, List<MultipartFile> file) {

		//날짜별로 폴더를 생성해서 관리할 예정.
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMdd");
		String fileLoca = now.format(dtf);
		
		//기본 경로 C:/test/upload로 사용.
		String uploadPath = "C:/test/upload/";
		//폴더 없으면 새롭게 생성
		File folder = new File(uploadPath + fileLoca);
		if(!folder.exists()) folder.mkdirs();
		
		//저장될 파일명은 uuid를 이용한 파일명으로 저장
		//uuid가 제공하는 랜덤 문자열에 -을 제거해서 전부 사용.
		
		//리스트로 들어오면 모든 파일 입력
		for(MultipartFile f : file) {
			String fileRealName = f.getOriginalFilename();
			UUID uuid = UUID.randomUUID();
			String uuids = uuid.toString().replaceAll("-", "");
			
			//확장자 추출
			String fileExtension= fileRealName.substring(fileRealName.lastIndexOf("."));
			
			log.info("저장할 폴더 경로: "+ uploadPath);
			log.info("실제 파일명: "+ fileRealName);
			log.info("폴더명: "+ fileLoca);
			log.info("확장자: "+ fileExtension);
			log.info("고유랜덤문자: "+ uuids);
			
			String fileName = uuids + fileExtension;
			log.info("변경해서 저장할 파일명: "+ fileName);
			
			//업로드한 파일을 지정한 로컬 경로로 전송
			File saveFile = new File(uploadPath + fileLoca + "/" + fileName);
			try {
				f.transferTo(saveFile);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
			
			UDFileVO vo = new UDFileVO();
			vo.setBno(bno);
			vo.setUploadPath(uploadPath);
			vo.setFileLoca(fileLoca);
			vo.setFileName(fileName);
			vo.setFileRealName(fileRealName);
			
			mapper.insertTempfile(vo);
		}
		
	}
	
//	@Override
//	public void deleteFile(UDFileVO vo, List<MultipartFile> file) {
//		mapper.deleteFile(vo.getFileName());
//		insertTempfile(vo.getBno(),file);
//	}

	public void deleteFile(String fileName) {
		File file = new File("C:/test/upload/" + fileName);
		log.info(fileName);
		if(file.isFile()) file.delete();
		mapper.deleteFile(fileName);
	}
			
	void deleteTempfile(int bno) {
		mapper.deleteTempfile(bno);
	}
	
	@Override
	public List<UDFileVO> viewfile(int bno) {
		return mapper.viewfile(bno);
	}
	
	
	//엑셀 스타일
	private void setHeaderCS(CellStyle cs, Font font, Cell cell) {
		  cs.setAlignment(CellStyle.ALIGN_CENTER);
		  cs.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		  cs.setBorderTop(CellStyle.BORDER_THIN);
		  cs.setBorderBottom(CellStyle.BORDER_THIN);
		  cs.setBorderLeft(CellStyle.BORDER_THIN);
		  cs.setBorderRight(CellStyle.BORDER_THIN);
		  cs.setFillForegroundColor(HSSFColor.GREY_80_PERCENT.index);
		  cs.setFillPattern(CellStyle.SOLID_FOREGROUND);
		  setHeaderFont(font, cell);
		  cs.setFont(font);
		  cell.setCellStyle(cs);
		}
		 
		private void setHeaderFont(Font font, Cell cell) {
		  font.setBoldweight((short) 700);
		  font.setColor(HSSFColor.WHITE.index);
		}
		 
		private void setCmmnCS2(CellStyle cs, Cell cell) {
		  cs.setAlignment(CellStyle.ALIGN_LEFT);
		  cs.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		  cs.setBorderTop(CellStyle.BORDER_THIN);
		  cs.setBorderBottom(CellStyle.BORDER_THIN);
		  cs.setBorderLeft(CellStyle.BORDER_THIN);
		  cs.setBorderRight(CellStyle.BORDER_THIN);
		  cell.setCellStyle(cs);
		}

	@Override
	public void getExcel(FreeBoardVO vo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<FreeBoardVO> list = mapper.getExcel();
		  
		  SXSSFWorkbook wb = new SXSSFWorkbook();
		  Sheet sheet = wb.createSheet();
		  sheet.setColumnWidth((short) 0, (short) 2000);
		  sheet.setColumnWidth((short) 1, (short) 2000);
		  sheet.setColumnWidth((short) 2, (short) 8000);
		  sheet.setColumnWidth((short) 3, (short) 8000);
		  sheet.setColumnWidth((short) 4, (short) 3000);
		  sheet.setColumnWidth((short) 5, (short) 3000);
		  
		  Row row = sheet.createRow(0);
		  Cell cell = null;
		  CellStyle cs = wb.createCellStyle();
		  Font font = wb.createFont();
		  cell = row.createCell(0);
		  cell.setCellValue("게시글 리스트");
		  setHeaderCS(cs, font, cell);
		  sheet.addMergedRegion(new CellRangeAddress(row.getRowNum(), row.getRowNum(), 0, 5));
		  
		  row = sheet.createRow(1);
		  cell = null;
		  cs = wb.createCellStyle();
		  font = wb.createFont();
		  
		  cell = row.createCell(0);
		  cell.setCellValue("최신순");
		  setHeaderCS(cs, font, cell);
		  
		  cell = row.createCell(1);
		  cell.setCellValue("글번호");
		  setHeaderCS(cs, font, cell);
		 
		  cell = row.createCell(2);
		  cell.setCellValue("제목");
		  setHeaderCS(cs, font, cell);
		  
		  cell = row.createCell(3);
		  cell.setCellValue("내용");
		  setHeaderCS(cs, font, cell);
		  
		  cell = row.createCell(4);
		  cell.setCellValue("작성자");
		  setHeaderCS(cs, font, cell);		  
		  
		  cell = row.createCell(5);
		  cell.setCellValue("작성일");
		  setHeaderCS(cs, font, cell);
		 
		  int i = 2;
		  for (FreeBoardVO fvo : list) {
		      
		DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String createDate = df.format(fvo.getRegDate());
		 
		  row = sheet.createRow(i);
		  cell = null;
		  cs = wb.createCellStyle();
		  font = wb.createFont();
		  
		  cell = row.createCell(0);
		  cell.setCellValue(fvo.getRownum());
		  setCmmnCS2(cs, cell);
		  
		  cell = row.createCell(1);
		  cell.setCellValue(fvo.getBno());
		  setCmmnCS2(cs, cell);
		  
		  cell = row.createCell(2);
		  cell.setCellValue(fvo.getTitle());
		  setCmmnCS2(cs, cell);
		  
		  cell = row.createCell(3);
		  cell.setCellValue(fvo.getContent());
		  setCmmnCS2(cs, cell);
		  
		  cell = row.createCell(4);
		  cell.setCellValue(fvo.getWriter());
		  setCmmnCS2(cs, cell);
		  
		  cell = row.createCell(5);
		  cell.setCellValue(createDate);
		  setCmmnCS2(cs, cell);
		  
		  i++;
		}
		  
		  response.setHeader("Set-Cookie", "fileDownload=true; path=/");
		  response.setHeader("Content-Disposition", String.format("attachment; filename=\"FreeBoardList.xlsx\""));
		  wb.write(response.getOutputStream());
		
	}
	
	
	
}
