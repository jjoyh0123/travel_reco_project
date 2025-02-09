package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.FAQVO;
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

  public static FAQVO[] get_list(int begin, int end) {
    FAQVO[] ar = null;

    HashMap<String, Object> map = new HashMap<>();

    map.put("begin", begin); // String.valueOf(begin);
    map.put("end", end);

    SqlSession ss = FactoryService.get_factory().openSession();

    List<FAQVO> list = ss.selectList("faq.list", map);

    if (list != null && !list.isEmpty()) {
      ar = new FAQVO[list.size()];
      list.toArray(ar);
    }
    ss.close();

    return ar;
  }

  public static FAQVO get_one(String idx) {
    FAQVO ar = null;
    SqlSession ss = FactoryService.get_factory().openSession();
    ar = ss.selectOne("faq.selectOne", idx);
    ss.close();
    return ar;
  }

}
