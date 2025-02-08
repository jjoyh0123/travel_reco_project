package mybatis.vo;

public class LikeJournalVO  extends TempVO{
  private String journal_idx, user_idx, status;

  public String getJournal_idx() {
    return journal_idx;
  }

  public void setJournal_idx(String journal_idx) {
    this.journal_idx = journal_idx;
  }

  public String getUser_idx() {
    return user_idx;
  }

  public void setUser_idx(String user_idx) {
    this.user_idx = user_idx;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }
}
