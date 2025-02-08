package mybatis.dao;

import mybatis.service.FactoryService;
import org.apache.ibatis.session.SqlSession;

public class LikeJournalDAO {

  public static int heartCheck(String journalidx) {
    SqlSession ss = FactoryService.get_factory().openSession();
    int newStatus = 0;  // 기본값 0

    try {
      // 좋아요 상태가 존재하는지 확인
      Integer count = ss.selectOne("like_journal.checkJournalExists", journalidx);
      System.out.println("Journal Exists Count: " + count);

      if (count != null && count > 0) {
        // 기존 좋아요가 존재하면 토글
        int updatedRows = ss.update("like_journal.toggleJournalStatus", journalidx);
        System.out.println("Updated Rows: " + updatedRows);

        if (updatedRows > 0) {
          ss.commit();
        }
      } else {
        // 좋아요가 없으면 새로 추가
        int insertedRows = ss.insert("like_journal.addJournalLike", journalidx);
        System.out.println("Inserted Rows: " + insertedRows);

        if (insertedRows > 0) {
          ss.commit();
        }
      }

      // 상태 변경 후 현재 좋아요 상태를 다시 조회하여 반환
      Integer currentStatus = ss.selectOne("like_journal.getJournalStatus", journalidx);
      if (currentStatus != null) {
        newStatus = currentStatus;
      }

      System.out.println("Final New Status: " + newStatus);  // 디버깅 로그 추가
      return newStatus;

    } finally {
      ss.close();
    }
  }
}
