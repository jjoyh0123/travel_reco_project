package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.JournalVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;

public class JournalDAO {

  public static int get_total_count() {
    SqlSession ss = FactoryService.get_factory().openSession();
    int cnt = ss.selectOne("journal.totalCount");
    ss.close();

    return cnt;
  }

  public static int get_total_count(String keyword) {
    SqlSession ss = FactoryService.get_factory().openSession();
    int cnt = ss.selectOne("journal.searchTotalCount", keyword);
    ss.close();

    return cnt;
  }

  public static int get_area_count(String area_code) {
    SqlSession ss = FactoryService.get_factory().openSession();
    int cnt = ss.selectOne("journal.areaCount", area_code);
    ss.close();

    return cnt;
  }

  public static int get_search_count(String area_code, String keyword) {
    SqlSession ss = FactoryService.get_factory().openSession();

    HashMap<String, Object> map = new HashMap<>();
    map.put("area_code", area_code);
    map.put("keyword", keyword);

    int cnt = ss.selectOne("journal.searchCount", map);
    ss.close();

    return cnt;
  }

  public static int get_range_count(String range) {
    SqlSession ss = FactoryService.get_factory().openSession();
    int cnt = ss.selectOne("journal.rangeCount", range);
    ss.close();

    return cnt;
  }

  public static JournalVO[] get_list(int begin, int end) {
    JournalVO[] ar = null;

    HashMap<String, Object> map = new HashMap<>();

    map.put("begin", begin); // String.valueOf(begin);
    map.put("end", end);

    SqlSession ss = FactoryService.get_factory().openSession();

    List<JournalVO> list = ss.selectList("journal.list", map);

    if (list != null && !list.isEmpty()) {
      ar = new JournalVO[list.size()];
      list.toArray(ar);
    }
    ss.close();

    return ar;
  }

  public static JournalVO[] get_list(int begin, int end, String area_code) {
    JournalVO[] ar = null;

    HashMap<String, Object> map = new HashMap<>();

    map.put("begin", begin); // String.valueOf(begin);
    map.put("end", end);
    map.put("area_code", area_code);

    SqlSession ss = FactoryService.get_factory().openSession();

    List<JournalVO> list = ss.selectList("journal.areaList", map);

    if (list != null && !list.isEmpty()) {
      ar = new JournalVO[list.size()];
      list.toArray(ar);
    }
    ss.close();

    return ar;
  }

  public static JournalVO[] get_range_list(int begin, int end, String range, String sort) {
    JournalVO[] ar = null;
    HashMap<String, Object> map = new HashMap<>();
    map.put("begin", begin);
    map.put("end", end);
    map.put("range", range);
    map.put("sort", sort);

    SqlSession ss = FactoryService.get_factory().openSession();
    List<JournalVO> list = ss.selectList("journal.rangeList", map);
    if (list != null && !list.isEmpty()) {
      ar = new JournalVO[list.size()];
      list.toArray(ar);
    }
    ss.close();
    return ar;
  }

  public static JournalVO[] get_search_list(int begin, int end, String keyword) {
    JournalVO[] ar = null;

    HashMap<String, Object> map = new HashMap<>();

    map.put("begin", begin); // String.valueOf(begin);
    map.put("end", end);
    map.put("keyword", keyword);

    SqlSession ss = FactoryService.get_factory().openSession();

    List<JournalVO> list = ss.selectList("journal.searchList", map);

    if (list != null && !list.isEmpty()) {
      ar = new JournalVO[list.size()];
      list.toArray(ar);
    }
    ss.close();

    return ar;
  }

  public static JournalVO[] get_search_list(int begin, int end, String area_code, String keyword) {
    JournalVO[] ar = null;

    HashMap<String, Object> map = new HashMap<>();

    map.put("begin", begin); // String.valueOf(begin);
    map.put("end", end);
    map.put("area_code", area_code);
    map.put("keyword", keyword);

    SqlSession ss = FactoryService.get_factory().openSession();

    List<JournalVO> list = ss.selectList("journal.searchAreaList", map);

    if (list != null && !list.isEmpty()) {
      ar = new JournalVO[list.size()];
      list.toArray(ar);
    }
    ss.close();

    return ar;
  }
}
