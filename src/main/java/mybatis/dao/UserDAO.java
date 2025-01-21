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
}
