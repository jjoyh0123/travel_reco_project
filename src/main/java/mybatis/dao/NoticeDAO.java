package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.NoticeVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;

public class NoticeDAO {

  public static int get_total_count() {
    SqlSession ss = FactoryService.get_factory().openSession();
    int cnt = ss.selectOne("notice.totalCount");
    ss.close();

    return cnt;
  }

  public static NoticeVO[] get_list(int begin, int end, String sort) {
    NoticeVO[] ar = null;

    HashMap<String, Object> map = new HashMap<>();

    map.put("begin", begin); // String.valueOf(begin);
    map.put("end", end);
    map.put("sort", sort);

    SqlSession ss = FactoryService.get_factory().openSession();

    List<NoticeVO> list = ss.selectList("notice.list", map);

    if (list != null && !list.isEmpty()) {
      ar = new NoticeVO[list.size()];
      list.toArray(ar);
    }
    ss.close();

    return ar;
  }

  public static NoticeVO get_one(String idx) {
    NoticeVO ar = null;
    SqlSession ss = FactoryService.get_factory().openSession();
    ar = ss.selectOne("notice.selectOne", idx);
    ss.close();
    return ar;
  }

  public static int updateNotice(NoticeVO vo) {
    SqlSession ss = FactoryService.get_factory().openSession();
    int cnt = ss.update("notice.updateNotice", vo);
    if (cnt > 0) {
      ss.commit();
    } else {
      ss.rollback();
    }
    ss.close();

    return cnt;
  }

  public static int insertNotice(NoticeVO vo) {
    SqlSession ss = FactoryService.get_factory().openSession();
    int cnt = ss.insert("notice.insertNotice", vo);
    if (cnt > 0) {
      ss.commit();
    } else {
      ss.rollback();
    }
    ss.close();
    return cnt;
  }

  public static boolean deleteNotice(String idx) {
    SqlSession ss = FactoryService.get_factory().openSession();
    int cnt = ss.delete("notice.deleteNotice", idx);
    if (cnt > 0) {
      ss.commit();
    } else {
      ss.rollback();
    }
    ss.close();
    return cnt > 0;
  }

  public static boolean restoreNotice(String idx) {
    SqlSession ss = FactoryService.get_factory().openSession();
    int cnt = ss.delete("notice.restoreNotice", idx);
    if (cnt > 0) {
      ss.commit();
    } else {
      ss.rollback();
    }
    ss.close();
    return cnt > 0;
  }
}
