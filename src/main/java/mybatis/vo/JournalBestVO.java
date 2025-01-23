package mybatis.vo;

public class JournalBestVO extends TempVO {
  private String idx, journal_idx, tier, act_date, deact_date, status;

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

  public String getTier() {
    return tier;
  }

  public void setTier(String tier) {
    this.tier = tier;
  }

  public String getAct_date() {
    return act_date;
  }

  public void setAct_date(String act_date) {
    this.act_date = act_date;
  }

  public String getDeact_date() {
    return deact_date;
  }

  public void setDeact_date(String deact_date) {
    this.deact_date = deact_date;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }
}
