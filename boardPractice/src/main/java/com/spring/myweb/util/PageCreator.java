package com.spring.myweb.util;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageCreator {

	private PageVO paging;
	private int articleTotalCount, endPage, beginPage, lastPage;
	private boolean prev, next, front, end;
	
	private final int buttonNum = 5;
	
	public PageCreator(PageVO paging, int articleTotalCount) {
		this.paging = paging;
		this.articleTotalCount = articleTotalCount;
		calcDataOfPage();
	}
	
	private void calcDataOfPage() {
		endPage = (int)(Math.ceil(paging.getPageNum()/(double)buttonNum)*buttonNum);
		lastPage = (int) Math.ceil((double) articleTotalCount / paging.getCpp());
		
		beginPage = endPage - buttonNum + 1;
		
		prev = (beginPage == 1) ? false : true;
		
		front = (beginPage == 1) ? false : true;
		
		end = (lastPage - beginPage < buttonNum) ? false : true;
		
		next = articleTotalCount <= (endPage * paging.getCpp()) ? false : true;
		
		
		
		if(!next) {
			endPage = (int) Math.ceil(articleTotalCount/ (double)paging.getCpp());
		}
	}
	
}












