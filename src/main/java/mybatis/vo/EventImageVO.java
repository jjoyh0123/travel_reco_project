package mybatis.vo;

public class EventImageVO extends TempVO {
  private String idx, upload_date, file_path;

  public String getIdx() {
    return idx;
  }

  public void setIdx(String idx) {
    this.idx = idx;
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
