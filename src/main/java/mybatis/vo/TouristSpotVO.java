package mybatis.vo;

public class TouristSpotVO {
  private String title;
  private String address;
  private String image;
  private double mapx;
  private double mapy;
  private String category;

  public String getTitle() { return title; }
  public void setTitle(String title) { this.title = title; }

  public String getAddress() { return address; }
  public void setAddress(String address) { this.address = address; }

  public String getImage() { return image; }
  public void setImage(String image) { this.image = image; }

  public double getMapx() { return mapx; }
  public void setMapx(double mapx) { this.mapx = mapx; }

  public double getMapy() { return mapy; }
  public void setMapy(double mapy) { this.mapy = mapy; }

  public String getCategory() { return category; }
  public void setCategory(String category) { this.category = category; }
}
