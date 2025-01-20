package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.NoticeVO;
import org.apache.ibatis.session.SqlSession;
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
}
