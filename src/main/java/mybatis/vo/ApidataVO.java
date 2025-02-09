package mybatis.vo;

public class ApidataVO {
  private String content_id, content_type_id, title, thumnail,thumbnail2, mapx, mapy, addr1, tel;

  public ApidataVO(String content_id, String content_type_id, String title, String thumnail,String thumbnail2, String mapx, String mapy, String addr1, String tel) {
    this.content_id = content_id;
    this.content_type_id = content_type_id;
    this.title = title;
    this.thumnail = thumnail;
    this.thumbnail2 = thumbnail2;
    this.mapx = mapx;
    this.mapy = mapy;
    this.addr1 = addr1;
    this.tel = tel;
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

  public String getThumbnail2() {
    return thumbnail2;
  }

  public void setThumbnail2(String thumbnail2) {
    this.thumbnail2 = thumbnail2;
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

  public String getMapx() {
    return mapx;
  }

  public void setMapx(String mapx) {
    this.mapx = mapx;
  }

  public String getMapy() {
    return mapy;
  }

  public void setMapy(String mapy) {
    this.mapy = mapy;
  }

  public String getAddr1() {
    return addr1;
  }

  public void setAddr1(String addr1) {
    this.addr1 = addr1;
  }

  public String getTel() {
    return tel;
  }

  public void setTel(String tel) {
    this.tel = tel;
  }

}