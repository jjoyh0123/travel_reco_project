package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.SupportVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;

public class SupportDAO {
  public static int getTotalCount() {
    SqlSession ss = FactoryService.getFactory().openSession();
    int cnt = ss.selectOne("support.totalCount");
    ss.close();

    return cnt;
  }

  public static SupportVO[] getList(int begin, int end) {
    SupportVO[] ar = null;

    HashMap<String, Object> map = new HashMap<>();

    map.put("begin", begin); // String.valueOf(begin);
    map.put("end", end);

    SqlSession ss = FactoryService.getFactory().openSession();

    List<SupportVO> list = ss.selectList("support.list", map);

    if (list != null && !list.isEmpty()) {
      ar = new SupportVO[list.size()];
      list.toArray(ar);
    }
    ss.close();

    return ar;
  }
}
