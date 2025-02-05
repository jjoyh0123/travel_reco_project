package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.FaqVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;

public class FAQDAO {
  public static int getTotalCount() {
    SqlSession ss = FactoryService.getFactory().openSession();
    int cnt = ss.selectOne("faq.totalCount");
    ss.close();

    return cnt;
  }

  public static FaqVO[] getList(int begin, int end) {
    FaqVO[] ar = null;

    HashMap<String, Object> map = new HashMap<>();

    map.put("begin", begin); // String.valueOf(begin);
    map.put("end", end);

    SqlSession ss = FactoryService.getFactory().openSession();

    List<FaqVO> list = ss.selectList("faq.list", map);

    if (list != null && !list.isEmpty()) {
      ar = new FaqVO[list.size()];
      list.toArray(ar);
    }
    ss.close();

    return ar;
  }

  public static FaqVO getOne(String idx) {
    FaqVO ar = null;
    SqlSession ss = FactoryService.getFactory().openSession();
    ar = ss.selectOne("faq.selectOne", idx);
    ss.close();
    return ar;
  }

}
