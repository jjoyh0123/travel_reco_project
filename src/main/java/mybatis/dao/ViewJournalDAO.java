package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.*;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class ViewJournalDAO {
  public static JournalVO getJournal(String plan_idx) {
    SqlSession ss = FactoryService.get_factory().openSession();

    JournalVO vo = ss.selectOne("view_journal.getJournal", plan_idx);
    ss.close();

    return vo;
  }

  public static List<ImageVO> get_Images(String plan_idx) {
    SqlSession ss = FactoryService.get_factory().openSession();
    List<ImageVO> list = ss.selectList("view_journal.getImages", plan_idx);
    ss.close();
    return list;
  }

  public static DateVO[] getDate(String plan_idx) {
    DateVO[] ar = null;

    SqlSession ss = FactoryService.get_factory().openSession();
    List<DateVO> list = ss.selectList("view_journal.getDate", plan_idx);
    if (list != null && !list.isEmpty()) {
      ar = new DateVO[list.size()];
      list.toArray(ar);

    }
    ss.close();

    return ar;
  }

  public static List<ViewJournalDTO> getPlace(String plan_idx) {
    SqlSession ss = FactoryService.get_factory().openSession();
    List<ViewJournalDTO> list = ss.selectList("view_journal.getPlace", plan_idx);
    ss.close();
    return list;
  }

  public static PlanVO getPlan(String plan_idx) {
    SqlSession ss = FactoryService.get_factory().openSession();
    PlanVO vo = ss.selectOne("view_journal.getPlan", plan_idx);
    ss.close();
    return vo;
  }

  public static List<ReviewVO> getReview() {
    SqlSession ss = FactoryService.get_factory().openSession();
    List<ReviewVO> list = ss.selectList("view_journal.getReview");

    ss.close();

    return list;
  }
}

