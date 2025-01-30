package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.UserVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.Map;

public class UserDAO {


  public static UserVO loginCheck(String email, String password) {
    SqlSession ss = FactoryService.getFactory().openSession();

    // 파라미터를 담을 맵 생성
    Map<String, String> params = new HashMap<>();
    params.put("email", email);
    params.put("pw", password);

    // MyBatis Mapper 호출
    UserVO userVO = ss.selectOne("user.loginCheck", params);
    ss.close();

    return userVO;
  }
}
