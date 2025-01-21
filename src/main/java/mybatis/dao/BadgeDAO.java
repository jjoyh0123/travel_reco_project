package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.BadgeVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;

public class BadgeDAO {
  public static int getTotalCount() {
    SqlSession ss = FactoryService.getFactory().openSession();
    int cnt = ss.selectOne("badge.totalCount");
    ss.close();

    return cnt;
  }

  public static BadgeVO[] getList(int begin, int end) {
    BadgeVO[] ar = null;

    HashMap<String, Object> map = new HashMap<>();

    map.put("begin", begin); // String.valueOf(begin);
    map.put("end", end);

    SqlSession ss = FactoryService.getFactory().openSession();

    List<BadgeVO> list = ss.selectList("badge.list", map);

    if (list != null && !list.isEmpty()) {
      ar = new BadgeVO[list.size()];
      list.toArray(ar);
    }
    ss.close();

    return ar;
  }
}
