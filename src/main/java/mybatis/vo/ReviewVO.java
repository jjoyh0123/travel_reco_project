package mybatis.vo;

public class ReviewVO {
  private String idx;
  private String user_idx;
  private String place_idx;
  private String content_id;
  private String rate;
  private String review;
  private String reg_date;
  private String status;
  private String plan_idx;

  public String getPlan_idx() {
    return plan_idx;
  }

  public void setPlan_idx(String plan_idx) {
    this.plan_idx = plan_idx;
  }

  public String getIdx() {
    return idx;
  }

  public void setIdx(String idx) {
    this.idx = idx;
  }

  public String getUser_idx() {
    return user_idx;
  }

  public void setUser_idx(String user_idx) {
    this.user_idx = user_idx;
  }

  public String getPlace_idx() {
    return place_idx;
  }

  public void setPlace_idx(String place_idx) {
    this.place_idx = place_idx;
  }

  public String getContent_id() {
    return content_id;
  }

  public void setContent_id(String content_id) {
    this.content_id = content_id;
  }

  public String getRate() {
    return rate;
  }

  public void setRate(String rate) {
    this.rate = rate;
  }

  public String getReview() {
    return review;
  }

  public void setReview(String review) {
    this.review = review;
  }

  public String getReg_date() {
    return reg_date;
  }

  public void setReg_date(String reg_date) {
    this.reg_date = reg_date;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }
}
