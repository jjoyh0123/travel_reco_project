package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.UserVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserDAO {


  public static int get_total_count() {
    SqlSession ss = FactoryService.get_factory().openSession();
    int cnt = ss.selectOne("user.totalCount");
    ss.close();

    return cnt;
  }


  public static int get_search_count(String keyword) {
    SqlSession ss = FactoryService.get_factory().openSession();
    int cnt = ss.selectOne("user.searchCount", keyword);
    ss.close();

    return cnt;
  }


  public static UserVO[] get_list(int begin, int end) {
    UserVO[] ar = null;

    HashMap<String, Object> map = new HashMap<>();

    map.put("begin", begin); // String.valueOf(begin);
    map.put("end", end);

    SqlSession ss = FactoryService.get_factory().openSession();

    List<UserVO> list = ss.selectList("user.list", map);

    if (list != null && !list.isEmpty()) {
      ar = new UserVO[list.size()];
      list.toArray(ar);
    }
    ss.close();

    return ar;
  }


  public static UserVO[] get_search_list(int begin, int end, String keyword) {
    UserVO[] ar = null;

    HashMap<String, Object> map = new HashMap<>();

    map.put("begin", begin); // String.valueOf(begin);
    map.put("end", end);
    map.put("keyword", keyword);

    SqlSession ss = FactoryService.get_factory().openSession();

    List<UserVO> list = ss.selectList("user.searchList", map);

    if (list != null && !list.isEmpty()) {
      ar = new UserVO[list.size()];
      list.toArray(ar);
    }
    ss.close();

    return ar;
  }


  public static boolean update_user(UserVO vo) {
    SqlSession ss = FactoryService.get_factory().openSession();

    int cnt = ss.update("user.edit", vo);
    if (cnt > 0) {
      ss.commit();
    } else {
      ss.rollback();
    }

    ss.close();

    return cnt > 0; // 업데이트 성공 여부 반환
  }


  public static UserVO login_check(String email, String password) {
    SqlSession ss = FactoryService.get_factory().openSession();

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
    try (SqlSession sqlSession = FactoryService.get_factory().openSession()) {
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


  public static String getPassword(int userId) {
    try (SqlSession sqlSession = FactoryService.get_factory().openSession()) {
      return sqlSession.selectOne("user.getPassword", userId);
    }
  }

}