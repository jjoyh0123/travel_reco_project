package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.ImageVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;

public class ImageDAO {
  public static void insert_image_path(ImageVO imageVO) {
    HashMap<String, String> map = new HashMap<>();
    if(imageVO.getJournal_idx() != null) map.put("journal_idx", imageVO.getJournal_idx());
    if(imageVO.getReview_idx() != null) map.put("review_idx", imageVO.getReview_idx());
    map.put("type", imageVO.getType());
    map.put("file_path", imageVO.getFile_path());

    int cnt = 0;
    SqlSession ss = null;
    ss = FactoryService.getFactory().openSession();
    cnt = ss.insert("image.insert_image_path", map);
    if (cnt > 0) ss.commit();
    else ss.rollback();
    ss.close();
  }

  public static void update_event_image_path(String idx, String uploaded_file_path) {
    HashMap<String, String> map = new HashMap<>();
    map.put("idx", idx);
    map.put("uploaded_file_path", uploaded_file_path);

    int cnt = 0;
    SqlSession ss = null;
    ss = FactoryService.getFactory().openSession();
    cnt = ss.update("image.update_event_image_path", map);
    if(cnt > 0) ss.commit();
    else ss.rollback();
    ss.close();
  }
}
