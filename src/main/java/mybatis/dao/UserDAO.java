package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.UserVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;

public class UserDAO {
  public static int getTotalCount() {
    SqlSession ss = FactoryService.getFactory().openSession();
    int cnt = ss.selectOne("user.totalCount");
    ss.close();

    return cnt;
  }

  public static int getSearchCount(String keyword) {
    SqlSession ss = FactoryService.getFactory().openSession();
    int cnt = ss.selectOne("user.searchCount", keyword);
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

  public static UserVO[] getSearchList(int begin, int end, String keyword) {
    UserVO[] ar = null;

    HashMap<String, Object> map = new HashMap<>();

    map.put("begin", begin); // String.valueOf(begin);
    map.put("end", end);
    map.put("keyword", keyword);

    SqlSession ss = FactoryService.getFactory().openSession();

    List<UserVO> list = ss.selectList("user.searchList", map);

    if (list != null && !list.isEmpty()) {
      ar = new UserVO[list.size()];
      list.toArray(ar);
    }
    ss.close();

    return ar;
  }

  public static boolean updateUser(UserVO vo) {
    SqlSession ss = FactoryService.getFactory().openSession();

    int cnt = ss.update("user.edit", vo);
    if (cnt > 0) {
      ss.commit();
    } else {
      ss.rollback();
    }

    ss.close();

    return cnt > 0; // 업데이트 성공 여부 반환
  }
}
