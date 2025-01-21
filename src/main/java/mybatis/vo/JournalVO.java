package mybatis.vo;

public class JournalVO extends TempVO {
  private String idx, plan_idx, title, subtitle, hit, status;

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

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }
}
