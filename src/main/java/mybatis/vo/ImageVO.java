package mybatis.vo;

public class ImageVO {
  private String idx, journal_idx, review_idx, type, upload_date, file_path;

  public String getIdx() {
    return idx;
  }

  public void setIdx(String idx) {
    this.idx = idx;
  }

  public String getJournal_idx() {
    return journal_idx;
  }

  public void setJournal_idx(String journal_idx) {
    this.journal_idx = journal_idx;
  }

  public String getReview_idx() {
    return review_idx;
  }

  public void setReview_idx(String review_idx) {
    this.review_idx = review_idx;
  }

  public String getType() {
    return type;
  }

  public void setType(String type) {
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
