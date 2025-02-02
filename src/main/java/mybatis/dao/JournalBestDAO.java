package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.JournalBestVO;
import mybatis.vo.JournalVO;
import mybatis.vo.UserVO;
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
  public static JournalVO[] getTop3list() {
    JournalVO[] journal = null;
    SqlSession ss = FactoryService.getFactory().openSession();
    List<JournalVO> list = ss.selectList("journal_best.top3");

    if (list != null && !list.isEmpty()) {
      journal = new JournalVO[list.size()];
      list.toArray(journal);

    }
    ss.close();
    return journal;
  }

}
