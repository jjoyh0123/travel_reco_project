package util;

public class Paging {
  int nowPage = 1; // 현재 페이지 == cPage
  int numPerPage = 10; // 한 페이지당 보여질 게시물의 수

  int totalRecord; // 총 게시물의 수

  int pagePerBlock = 10; // 한 블럭당 표현할 페이지 수
  int totalPage; // 전체 페이지 수

  int begin; // 현제 페이지 값에 따라 테이블에서 가져올 게시물의 시작 행 번호
  int end; // 현제 페이지 값에 따라 테이블에서 가져올 게시물의 끝 행 번호

  int startPage; // 한 블럭의 시작 페이지 값
  int endPage; // 한 블럭의 끝 페이지 값

  // 한 페이지당 게시물을 10개식 보여주는 기본 생성자
  public Paging() {}

  public Paging(int numPerPage, int pagePerBlock) {
    this.numPerPage = numPerPage;
    this.pagePerBlock = pagePerBlock;
  }

  public int getNowPage() {
    return nowPage;
  }

  public void setNowPage(int nowPage) { // 현재 페이지 값이 변경될 때
    this.nowPage = nowPage;

    // 현재 페이지 값이 변경 되면 표현할 게시물들이 변경되어야 함
    // 즉 begin 과 end 값이 변경되어야 함 DB로 부터 게시물들을 다시 가져와야 함

    // 현제 페이지 값은 전체 페이지 값을 넘을 수 없음
    if (nowPage > totalPage) {
      nowPage = totalPage;
    } else if (nowPage < 1) {
      nowPage = 1;
    }

    // 각 페이지의 시작 행 번호(begin)와 마지막 행 번호(end)를 구함
    // 예) 현재 페이지:1 begin:1 end:10
    // 예) 현재 페이지:2 begin:11 end:20
    // 예) 현재 페이지:3 begin:2 end:30

    setBegin((nowPage - 1) * numPerPage + 1);
    setEnd(nowPage * numPerPage);
    if (getEnd() > totalRecord) {
      setEnd(totalRecord);
    }

    // 현재 페이지 값에 의해 블럭의 시작 페이지(startPage)를 설정
    setStartPage(((nowPage - 1) / pagePerBlock) * pagePerBlock + 1);
    // 블럭의 마지막 페이지 설정
    setEndPage(startPage + pagePerBlock - 1);

    // 위에서 구한 마지막 페이지 값이 전체 페이지 수보다 크다면 마지막 페이지를 전체 페이지 수로 설정
    if (endPage > totalPage) {
      setEndPage(totalPage);
    }
  }

  public int getNumPerPage() {
    return numPerPage;
  }

  public void setNumPerPage(int numPerPage) {
    this.numPerPage = numPerPage;
  }

  public int getTotalRecord() {
    return totalRecord;
  }

  // 총 게시물 수가 지정(바뀔)때 자동으로 전체 페이지 수를 변경
  public void setTotalRecord(int totalRecord) {
    this.totalRecord = totalRecord;

    // 총 게시물 수가 지정되었으므로 전체 페이지 수를 구함
    /*setTotalPage(totalRecord/numPerPage + 1);*/
    setTotalPage((int) Math.ceil((double) totalRecord / numPerPage));
  }

  public int getPagePerBlock() {
    return pagePerBlock;
  }

  public void setPagePerBlock(int pagePerBlock) {
    this.pagePerBlock = pagePerBlock;
  }

  public int getTotalPage() {
    return totalPage;
  }

  public void setTotalPage(int totalPage) {
    this.totalPage = totalPage;
  }

  public int getBegin() {
    return begin;
  }

  public void setBegin(int begin) {
    this.begin = begin;
  }

  public int getEnd() {
    return end;
  }

  public void setEnd(int end) {
    this.end = end;
  }

  public int getStartPage() {
    return startPage;
  }

  public void setStartPage(int startPage) {
    this.startPage = startPage;
  }

  public int getEndPage() {
    return endPage;
  }

  public void setEndPage(int endPage) {
    this.endPage = endPage;
  }
}