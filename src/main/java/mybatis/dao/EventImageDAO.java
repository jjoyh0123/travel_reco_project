package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.EventImageVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
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

  public static void update_event_image_path(String idx, String uploaded_file_path) {
    HashMap<String, String> map = new HashMap<>();
    map.put("idx", idx);
    map.put("uploaded_file_path", uploaded_file_path);

    int cnt;
    SqlSession ss;
    ss = FactoryService.getFactory().openSession();
    cnt = ss.update("event_image.update_event_image_path", map);
    if (cnt > 0) ss.commit();
    else ss.rollback();
    ss.close();
  }
}
