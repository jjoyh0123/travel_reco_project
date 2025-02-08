package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.UserVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.Map;
import java.util.List;

public class UserDAO {
  public static int getTotalCount() {
    SqlSession ss = FactoryService.getFactory().openSession();
    int cnt = ss.selectOne("user.totalCount");
    ss.close();

    return cnt;
  }

  public static UserVO[] getList(int begin, int end) {
    UserVO[] ar = null;

    HashMap<String, Object> map = new HashMap<>();

    map.put("begin", begin); // String.valueOf(begin);
    map.put("end", end);

    SqlSession ss = FactoryService.getFactory().openSession();

    List<UserVO> list = ss.selectList("user.list", map);

    if (list != null && !list.isEmpty()) {
      ar = new UserVO[list.size()];
      list.toArray(ar);
    }
    ss.close();

    return ar;
  }

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


  public static boolean deactivateUser(int userId) {
    try (SqlSession sqlSession = FactoryService.getFactory().openSession()) {
      int result = sqlSession.update("user.deactivateUser", userId);
      if (result > 0) {
        sqlSession.commit();
        return true;
      } else {
        return false;
      }
    } catch (Exception e) {
      e.printStackTrace();
      return false;
    }
  }

}