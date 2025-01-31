package mybatis.vo;

public class ImageVO {
  private Integer idx, journal_idx, review_idx, type;
  private String upload_date, file_path;

  public Integer getIdx() {
    return idx;
  }

  public void setIdx(Integer idx) {
    this.idx = idx;
  }

  public Integer getJournal_idx() {
    return journal_idx;
  }

  public void setJournal_idx(Integer journal_idx) {
    this.journal_idx = journal_idx;
  }

  public Integer getReview_idx() {
    return review_idx;
  }

  public void setReview_idx(Integer review_idx) {
    this.review_idx = review_idx;
  }

  public Integer getType() {
    return type;
  }

  public void setType(Integer type) {
    this.type = type;
  }

  public String getUpload_date() {
    return upload_date;
  }

  public void setUpload_date(String upload_date) {
    this.upload_date = upload_date;
  }

  public String getFile_path() {
    return file_path;
  }

  public void setFile_path(String file_path) {
    this.file_path = file_path;
  }
}
