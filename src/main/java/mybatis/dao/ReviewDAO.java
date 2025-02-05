package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.ReviewVO;
import org.apache.ibatis.session.SqlSession;

public class ReviewDAO {
  public static void insertReview(ReviewVO review) {
    SqlSession ss = FactoryService.getFactory().openSession();
    try {
      ss.insert("place.insertReview", review);
      ss.commit();
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      ss.close();
    }
  }
}
