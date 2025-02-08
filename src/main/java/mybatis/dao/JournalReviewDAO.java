package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.JournalVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class JournalReviewDAO {
  public static JournalVO[] getReview(){
    JournalVO[] journal = null;
    SqlSession ss = FactoryService.getFactory().openSession();
    List<JournalVO> list = ss.selectList("journalReview.review");
    if (list != null && !list.isEmpty()) {
      journal = new JournalVO[list.size()];
      list.toArray(journal);
    }
    ss.close();
    return journal;
  }
}
