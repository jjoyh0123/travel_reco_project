package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.NoticeVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;

public class NoticeDAO {
  public static NoticeVO[] getNotice() {
    NoticeVO[] ar = null;
    SqlSession ss = null;

    try {
      ss = FactoryService.getFactory().openSession();

      // notice.getnotice 쿼리 실행, 파라미터가 없으면 null 전달
      List<NoticeVO> list = ss.selectList("notice.getnotice");

      System.out.println(list);

      if (list != null && !list.isEmpty()) {
        ar = new NoticeVO[list.size()];
        list.toArray(ar);  // 배열로 변환
      }
    } catch (Exception e) {
      e.printStackTrace();  // 예외 출력
    } finally {
      if (ss != null) {
        ss.close();  // 세션 닫기
      }
    }
    return ar;
  }

  public static int getTotalCount() {
    SqlSession ss = FactoryService.getFactory().openSession();
    int cnt = ss.selectOne("notice.totalCount");
    ss.close();

    return cnt;
  }

  public static NoticeVO[] getList(int begin, int end) {
    NoticeVO[] ar = null;

    HashMap<String, Object> map = new HashMap<>();

    map.put("begin", begin); // String.valueOf(begin);
    map.put("end", end);

    SqlSession ss = FactoryService.getFactory().openSession();

    List<NoticeVO> list = ss.selectList("notice.list", map);

    if (list != null && !list.isEmpty()) {
      ar = new NoticeVO[list.size()];
      list.toArray(ar);
    }
    ss.close();

    return ar;
  }
}
