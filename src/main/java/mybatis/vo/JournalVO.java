package mybatis.vo;

import java.util.List;

public class JournalVO extends TempVO {
  private String title, subtitle, hit, nick,file_path;


  public String getFile_path() {
    return file_path;
  }

  public void setFile_path(String file_path) {
    this.file_path = file_path;
  }

  public String getNick() {
    return nick;
  }

  public void setNick(String nick) {
    this.nick = nick;
  }
  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public String getSubtitle() {
    return subtitle;
  }

  public void setSubtitle(String subtitle) {
    this.subtitle = subtitle;
  }

  public String getHit() {
    return hit;
  }

  public void setHit(String hit) {
    this.hit = hit;
  }

}
