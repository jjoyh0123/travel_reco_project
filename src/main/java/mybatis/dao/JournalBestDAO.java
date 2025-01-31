package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.JournalBestVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class JournalBestDAO {

  public static JournalBestVO[] getList() {
    JournalBestVO[] ar = null;

    SqlSession ss = FactoryService.getFactory().openSession();

    List<JournalBestVO> list = ss.selectList("journal_best.list");

    if (list != null && !list.isEmpty()) {
      ar = new JournalBestVO[list.size()];
      list.toArray(ar);
    }
    ss.close();

    return ar;
  }
}
