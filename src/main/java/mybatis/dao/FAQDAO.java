package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.FaqVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;

public class FAQDAO {
  public static int get_total_count() {
    SqlSession ss = FactoryService.get_factory().openSession();
    int cnt = ss.selectOne("faq.totalCount");
    ss.close();

    return cnt;
  }

  public static FaqVO[] get_list(int begin, int end) {
    FaqVO[] ar = null;

    HashMap<String, Object> map = new HashMap<>();

    map.put("begin", begin); // String.valueOf(begin);
    map.put("end", end);

    SqlSession ss = FactoryService.get_factory().openSession();

    List<FaqVO> list = ss.selectList("faq.list", map);

    if (list != null && !list.isEmpty()) {
      ar = new FaqVO[list.size()];
      list.toArray(ar);
    }
    ss.close();

    return ar;
  }

  public static FaqVO get_one(String idx) {
    FaqVO ar = null;
    SqlSession ss = FactoryService.get_factory().openSession();
    ar = ss.selectOne("faq.selectOne", idx);
    ss.close();
    return ar;
  }

}
