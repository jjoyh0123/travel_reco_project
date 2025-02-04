package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.EventImageVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class EventImageDAO {

  public static EventImageVO[] getList() {
    EventImageVO[] ar = null;

    SqlSession ss = FactoryService.getFactory().openSession();

    List<EventImageVO> list = ss.selectList("event_image.list");

    if (list != null && !list.isEmpty()) {
      ar = new EventImageVO[list.size()];
      list.toArray(ar);
    }
    ss.close();

    return ar;
  }

  public static boolean update(EventImageVO vo) {
    int flag;
    SqlSession ss = FactoryService.getFactory().openSession();

    flag = ss.update("event_image.update_image", vo);
    if (flag > 0) {
      ss.commit();
    } else {
      ss.rollback();
    }
    ss.close();

    return flag > 0;
  }
}
