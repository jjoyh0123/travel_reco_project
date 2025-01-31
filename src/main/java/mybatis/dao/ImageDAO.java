package mybatis.dao;

import mybatis.service.FactoryService;
import org.apache.ibatis.session.SqlSession;

public class ImageDAO {
  public static boolean check_user_idx() {
    SqlSession ss = null;
    try {
      ss = FactoryService.getFactory().openSession();
      ss.close();
    } catch (Exception e) {
      throw new RuntimeException(e);
    }
    return false;
  }
}
