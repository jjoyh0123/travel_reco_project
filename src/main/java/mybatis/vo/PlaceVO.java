package mybatis.vo;

public class PlaceVO {
  private String date_idx, visit_order, content_id, content_type_id, title, thumnail, map_x, map_y, time;
  private String plan_idx;

  public PlaceVO(String date_idx, String visit_order, String content_id, String content_type_id, String title,
                 String thumnail, String map_x, String map_y, String time) {
            super();
            this.date_idx = date_idx;
            this.visit_order = visit_order;
            this.content_id = content_id;
            this.content_type_id = content_type_id;
            this.title = title;
            this.thumnail = thumnail;
            this.map_x = map_x;
            this.map_y = map_y;
            this.time = time;
  }

  public String getDate_idx() {
    return date_idx;
  }

  public void setDate_idx(String date_idx) {
    this.date_idx = date_idx;
  }

  public String getVisit_order() {
    return visit_order;
  }

  public void setVisit_order(String visit_order) {
    this.visit_order = visit_order;
  }

  public String getContent_id() {
    return content_id;
  }

  public void setContent_id(String content_id) {
    this.content_id = content_id;
  }

  public String getContent_type_id() {
    return content_type_id;
  }

  public void setContent_type_id(String content_type_id) {
    this.content_type_id = content_type_id;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public String getThumnail() {
    return thumnail;
  }

  public void setThumnail(String thumnail) {
    this.thumnail = thumnail;
  }

  public String getMap_x() {
    return map_x;
  }

  public void setMap_x(String map_x) {
    this.map_x = map_x;
  }

  public String getMap_y() {
    return map_y;
  }

  public void setMap_y(String map_y) {
    this.map_y = map_y;
  }

  public String getTime() {
    return time;
  }

  public void setTime(String time) {
    this.time = time;
  }

  public String getPlan_idx() {
    return plan_idx;
  }

  public void setPlan_idx(String plan_idx) {
    this.plan_idx = plan_idx;
  }
}
