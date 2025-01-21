package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.NoticeVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;

public class NoticeDAO {
  public static int getTotalCount() {
    SqlSession ss = FactoryService.getFactory().openSession();
    int cnt = ss.selectOne("notice.totalCount");
    ss.close();

    return cnt;
  }

  public static NoticeVO[] getList(int begin, int end) {
    NoticeVO[] ar = null;

    HashMap<String, Object> map = new HashMap<>();

    map.put("begin", begin); // String.valueOf(begin);
    map.put("end", end);

    SqlSession ss = FactoryService.getFactory().openSession();

    List<NoticeVO> list = ss.selectList("notice.list", map);

    if (list != null && !list.isEmpty()) {
      ar = new NoticeVO[list.size()];
      list.toArray(ar);
    }
    ss.close();

    return ar;
  }
}
