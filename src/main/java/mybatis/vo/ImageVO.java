package mybatis.vo;

public class ImageVO {
  public String getIdx() {
    return idx;
  }

  public void setIdx(String idx) {
    this.idx = idx;
  }

  public String getPlan_idx() {
    return plan_idx;
  }

  public void setPlan_idx(String plan_idx) {
    this.plan_idx = plan_idx;
  }

  public String getPlace_idx() {
    return place_idx;
  }

  public void setPlace_idx(String place_idx) {
    this.place_idx = place_idx;
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

  private String idx, plan_idx, place_idx, type, upload_date, file_path;
}
