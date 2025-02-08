package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.EventImageVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class EventImageDAO {
  public static EventImageVO[] eventImage(){
     EventImageVO[] image = null;
     SqlSession ss = FactoryService.getFactory().openSession();
     List<EventImageVO> list = ss.selectList("event.get_img");
     if (list != null && list.size() > 0) {
     image = new EventImageVO[list.size()];
     list.toArray(image);
     }
     ss.close();
     return image;
  }
}
