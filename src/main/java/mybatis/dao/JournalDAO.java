package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.JournalVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;

public class JournalDAO {

  public static int getTotalCount() {
    SqlSession ss = FactoryService.getFactory().openSession();
    int cnt = ss.selectOne("journal.totalCount");
    ss.close();

    return cnt;
  }

  public static int getAreaCount(String area_code) {
    SqlSession ss = FactoryService.getFactory().openSession();
    int cnt = ss.selectOne("journal.areaCount", area_code);
    ss.close();

    return cnt;
  }

  public static int getRangeCount(String range) {
    SqlSession ss = FactoryService.getFactory().openSession();
    int cnt = ss.selectOne("journal.rangeCount", range);
    ss.close();

    return cnt;
  }

  public static JournalVO[] getList(int begin, int end) {
    JournalVO[] ar = null;

    HashMap<String, Object> map = new HashMap<>();

    map.put("begin", begin); // String.valueOf(begin);
    map.put("end", end);

    SqlSession ss = FactoryService.getFactory().openSession();

    List<JournalVO> list = ss.selectList("journal.list", map);

    if (list != null && !list.isEmpty()) {
      ar = new JournalVO[list.size()];
      list.toArray(ar);
    }
    ss.close();

    return ar;
  }

  public static JournalVO[] getList(int begin, int end, String area_code) {
    JournalVO[] ar = null;

    HashMap<String, Object> map = new HashMap<>();

    map.put("begin", begin); // String.valueOf(begin);
    map.put("end", end);
    map.put("area_code", area_code);

    SqlSession ss = FactoryService.getFactory().openSession();

    List<JournalVO> list = ss.selectList("journal.areaList", map);

    if (list != null && !list.isEmpty()) {
      ar = new JournalVO[list.size()];
      list.toArray(ar);
    }
    ss.close();

    return ar;
  }

  public static JournalVO[] getRangeList(int begin, int end, String range) {
    JournalVO[] ar = null;
    HashMap<String, Object> map = new HashMap<>();
    map.put("begin", begin);
    map.put("end", end);
    map.put("range", range);

    SqlSession ss = FactoryService.getFactory().openSession();
    List<JournalVO> list = ss.selectList("journal.rangeList", map);
    if (list != null && !list.isEmpty()) {
      ar = new JournalVO[list.size()];
      list.toArray(ar);
    }
    ss.close();
    return ar;
  }
}
