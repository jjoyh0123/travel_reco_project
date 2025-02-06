package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.BadgeVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;

public class BadgeDAO {
  public static int get_total_count() {
    SqlSession ss = FactoryService.get_factory().openSession();
    int cnt = ss.selectOne("badge.totalCount");
    ss.close();

    return cnt;
  }

  public static int get_search_count(String keyword) {
    SqlSession ss = FactoryService.get_factory().openSession();
    int cnt = ss.selectOne("badge.searchCount", keyword);
    ss.close();

    return cnt;
  }

  public static BadgeVO[] get_list(int begin, int end) {
    BadgeVO[] ar = null;

    HashMap<String, Object> map = new HashMap<>();

    map.put("begin", begin); // String.valueOf(begin);
    map.put("end", end);

    SqlSession ss = FactoryService.get_factory().openSession();

    List<BadgeVO> list = ss.selectList("badge.list", map);

    if (list != null && !list.isEmpty()) {
      ar = new BadgeVO[list.size()];
      list.toArray(ar);
    }
    ss.close();

    return ar;
  }

  public static BadgeVO[] get_search_list(int begin, int end, String keyword) {
    BadgeVO[] ar = null;

    HashMap<String, Object> map = new HashMap<>();

    map.put("begin", begin); // String.valueOf(begin);
    map.put("end", end);
    map.put("keyword", keyword);

    SqlSession ss = FactoryService.get_factory().openSession();

    List<BadgeVO> list = ss.selectList("badge.searchList", map);

    if (list != null && !list.isEmpty()) {
      ar = new BadgeVO[list.size()];
      list.toArray(ar);
    }
    ss.close();

    return ar;
  }
}
