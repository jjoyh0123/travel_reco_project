package mybatis.vo;

import java.util.List;

public class JournalPlaceVO extends TempVO {
  private String plan_idx, plan_area_code, plan_title, plan_start_date, plan_end_date,
    date_idx, date_plan_idx, date,
    place_idx, place_visit_order, content_id, content_type_id, place_title, address, thumbnail, map_x, map_y;
  private List<String> image_list;

  public String getPlan_idx() {
    return plan_idx;
  }

  public void setPlan_idx(String plan_idx) {
    this.plan_idx = plan_idx;
  }

  public String getPlan_area_code() {
    return plan_area_code;
  }

  public void setPlan_area_code(String plan_area_code) {
    this.plan_area_code = plan_area_code;
  }

  public String getPlan_title() {
    return plan_title;
  }

  public void setPlan_title(String plan_title) {
    this.plan_title = plan_title;
  }

  public String getPlan_start_date() {
    return plan_start_date;
  }

  public void setPlan_start_date(String plan_start_date) {
    this.plan_start_date = plan_start_date;
  }

  public String getPlan_end_date() {
    return plan_end_date;
  }

  public void setPlan_end_date(String plan_end_date) {
    this.plan_end_date = plan_end_date;
  }

  public String getDate_idx() {
    return date_idx;
  }

  public void setDate_idx(String date_idx) {
    this.date_idx = date_idx;
  }

  public String getDate_plan_idx() {
    return date_plan_idx;
  }

  public void setDate_plan_idx(String date_plan_idx) {
    this.date_plan_idx = date_plan_idx;
  }

  public String getDate() {
    return date;
  }

  public void setDate(String date) {
    this.date = date;
  }

  public String getPlace_idx() {
    return place_idx;
  }

  public void setPlace_idx(String place_idx) {
    this.place_idx = place_idx;
  }

  public String getPlace_visit_order() {
    return place_visit_order;
  }

  public void setPlace_visit_order(String place_visit_order) {
    this.place_visit_order = place_visit_order;
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

  public String getPlace_title() {
    return place_title;
  }

  public void setPlace_title(String place_title) {
    this.place_title = place_title;
  }

  public String getAddress() {
    return address;
  }

  public void setAddress(String address) {
    this.address = address;
  }

  public String getThumbnail() {
    return thumbnail;
  }

  public void setThumbnail(String thumbnail) {
    this.thumbnail = thumbnail;
  }

  @Override
  public String getMap_x() {
    return map_x;
  }

  @Override
  public void setMap_x(String map_x) {
    this.map_x = map_x;
  }

  @Override
  public String getMap_y() {
    return map_y;
  }

  @Override
  public void setMap_y(String map_y) {
    this.map_y = map_y;
  }

  public List<String> getImage_list() {
    return image_list;
  }

  public void setImage_list(List<String> image_list) {
    this.image_list = image_list;
  }
}
