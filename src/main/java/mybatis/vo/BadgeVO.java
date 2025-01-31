package mybatis.vo;

public class BadgeVO extends TempVO {
  private String idx, user_idx, type, grade, date;

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

  public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
  }

  public String getGrade() {
    return grade;
  }

  public void setGrade(String grade) {
    this.grade = grade;
  }

  public String getDate() {
    return date;
  }

  public void setDate(String date) {
    this.date = date;
  }
}
