package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.JournalBestVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class JournalBestDAO {

  public static JournalBestVO[] get_list() {
    JournalBestVO[] ar = null;

    SqlSession ss = FactoryService.get_factory().openSession();

    List<JournalBestVO> list = ss.selectList("journal_best.list");

    if (list != null && !list.isEmpty()) {
      ar = new JournalBestVO[list.size()];
      list.toArray(ar);
    }
    ss.close();

    return ar;
  }

  public static boolean deact_journal_best(String tier) {
    SqlSession ss = FactoryService.get_factory().openSession();

    int cnt = ss.update("journal_best.deact", tier);
    if (cnt > 0) {
      ss.commit();
    } else {
      ss.rollback();
    }
    ss.close();

    return cnt > 0;
  }

  public static boolean new_journal_best(JournalBestVO vo) {
    SqlSession ss = FactoryService.get_factory().openSession();
    int cnt = ss.insert("journal_best.new", vo);
    if (cnt > 0) {
      ss.commit();
    } else {
      ss.rollback();
    }
    ss.close();
    return cnt > 0;
  }

  public static boolean exists_journal_best(String tier) {
    SqlSession ss = FactoryService.get_factory().openSession();

    int count = ss.selectOne("journal_best.exists", tier);
    if (count > 0) {
      ss.commit();
    } else {
      ss.rollback();
    }
    ss.close();

    return count > 0;  // 0보다 크면 데이터가 존재함
  }
}
