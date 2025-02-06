package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.EventImageVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class EventImageDAO {

  public static EventImageVO[] get_list() {
    EventImageVO[] ar = null;

    SqlSession ss = FactoryService.get_factory().openSession();

    List<EventImageVO> list = ss.selectList("event_image.list");

    if (list != null && !list.isEmpty()) {
      ar = new EventImageVO[list.size()];
      list.toArray(ar);
    }
    ss.close();

    return ar;
  }

}
