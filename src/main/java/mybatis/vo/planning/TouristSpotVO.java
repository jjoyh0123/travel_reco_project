package mybatis.vo.planning;

public class TouristSpotVO {
  private String idx, user_idx, content_id, area_code, content_type_id, title, address, thumbnail;
  private double map_x, map_y;

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

  public String getContent_id() {
    return content_id;
  }

  public void setContent_id(String content_id) {
    this.content_id = content_id;
  }

  public String getArea_code() {
    return area_code;
  }

  public void setArea_code(String area_code) {
    this.area_code = area_code;
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

  public double getMap_x() {
    return map_x;
  }

  public void setMap_x(double map_x) {
    this.map_x = map_x;
  }

  public double getMap_y() {
    return map_y;
  }

  public void setMap_y(double map_y) {
    this.map_y = map_y;
  }
}
