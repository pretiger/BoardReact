package com.board.exam.util;

public class Pager {
	private static final int PAGE_SCALE=5;
	private static final int BLOCK_SCALE=5;
	private int curPage;
	private int prePage;
	private int nextPage;
	private int totalPage;
	private int curBlock;
	private int preBlock;
	private int nextBlock;
	private int totalBlock;
	private int pageStart;
	private int pageEnd;
	private int blockStart;
	private int blockEnd;
	
	public Pager(int count, int curPage) {
		this.curPage=curPage;
		setTotalPage(count);
		setPageRange();
		setTotalBlock();
		setBlockRange();
	}
	public void setTotalPage(int count) {
		totalPage = (int)Math.ceil(count*1.0/PAGE_SCALE);
	}
	public void setPageRange() {
		pageStart=(curPage - 1) * PAGE_SCALE + 1;
		pageEnd=pageStart + (PAGE_SCALE - 1);
	}
	public void setTotalBlock() {
		totalBlock = (int)Math.ceil(totalPage*1.0/BLOCK_SCALE);
	}
	public void setBlockRange() {
		curBlock=(int)((curPage - 1) / BLOCK_SCALE) + 1;
		blockStart=(curBlock - 1) * BLOCK_SCALE + 1;
		blockEnd=blockStart + (BLOCK_SCALE - 1);
		if(blockEnd > totalPage) {
			blockEnd = totalPage;
		}
		prePage = curBlock==1 ? 1 : (curBlock - 1) * BLOCK_SCALE;
		nextPage = curBlock > totalBlock ? (curBlock * BLOCK_SCALE) : (curBlock * BLOCK_SCALE) + 1;
		if(nextPage >= totalPage) {
			nextPage = totalPage;
		}
	}
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public int getPrePage() {
		return prePage;
	}
	public void setPrePage(int prePage) {
		this.prePage = prePage;
	}
	public int getNextPage() {
		return nextPage;
	}
	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
	}
	public int getTotalPage() {
		return totalPage;
	}

	public int getCurBlock() {
		return curBlock;
	}
	public void setCurBlock(int curBlock) {
		this.curBlock = curBlock;
	}
	public int getPreBlock() {
		return preBlock;
	}
	public void setPreBlock(int preBlock) {
		this.preBlock = preBlock;
	}
	public int getNextBlock() {
		return nextBlock;
	}
	public void setNextBlock(int nextBlock) {
		this.nextBlock = nextBlock;
	}
	public int getTotalBlock() {
		return totalBlock;
	}

	public int getPageStart() {
		return pageStart;
	}
	public void setPageStart(int pageStart) {
		this.pageStart = pageStart;
	}
	public int getPageEnd() {
		return pageEnd;
	}
	public void setPageEnd(int pageEnd) {
		this.pageEnd = pageEnd;
	}
	public int getBlockStart() {
		return blockStart;
	}
	public void setBlockStart(int blockStart) {
		this.blockStart = blockStart;
	}
	public int getBlockEnd() {
		return blockEnd;
	}
	public void setBlockEnd(int blockEnd) {
		this.blockEnd = blockEnd;
	}
	public static int getPageScale() {
		return PAGE_SCALE;
	}
	public static int getBlockScale() {
		return BLOCK_SCALE;
	}
}