package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.FaqVO;
import mybatis.vo.NoticeVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class CustomerServiceDAO {
  public static NoticeVO[] getNotice() {
    NoticeVO[] ar = null;
    SqlSession ss = null;

    try {
      ss = FactoryService.get_factory().openSession();

      List<NoticeVO> list = ss.selectList("customer_service.getNotice");

      // System.out.println(list);

      if (list != null && !list.isEmpty()) {
        ar = new NoticeVO[list.size()];
        list.toArray(ar);
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      if (ss != null) {
        ss.close();
      }
    }
    return ar;
  }

  public static FaqVO[] getFaq() {
    FaqVO[] ar = null;

    SqlSession ss = FactoryService.get_factory().openSession();

    List<FaqVO> list = ss.selectList("customer_service.getFaq");
    if (list != null && !list.isEmpty()) {
      ar = new FaqVO[list.size()];
      list.toArray(ar);
    }
    ss.close();

    return ar;
  }
}
