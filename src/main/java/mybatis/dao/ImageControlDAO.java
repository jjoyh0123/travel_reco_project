package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.ImageVO;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

public class ImageControlDAO {
  SqlSessionFactory sqlSessionFactory = FactoryService.get_factory();

  public ImageVO getImage(int planIdx, int imageIndex) {
    SqlSession session = sqlSessionFactory.openSession();
    try {
      return session.selectOne("ImageMapper.getImage", new ImageVO());
    } finally {
      session.close();
    }
  }
}
