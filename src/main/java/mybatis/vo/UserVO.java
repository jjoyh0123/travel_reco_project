package mybatis.vo;

public class UserVO extends TempVO {
  private String idx, email, nick, pw, status;

  public String getIdx() {
    return idx;
  }

  public void setIdx(String idx) {
    this.idx = idx;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getNick() {
    return nick;
  }

  public void setNick(String nick) {
    this.nick = nick;
  }

  public String getPw() {
    return pw;
  }

  public void setPw(String pw) {
    this.pw = pw;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }
}
