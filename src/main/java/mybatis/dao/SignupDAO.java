package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.UserVO;
import org.apache.ibatis.session.SqlSession;

public class SignupDAO {

  public static boolean emailCheck(String email) {
    SqlSession ss = FactoryService.getFactory().openSession();

    try {
      Integer count = ss.selectOne("sign_up.checkEmail", email);
      return count != null && count > 0;
    } catch (Exception e) {
      e.printStackTrace();
      return false;
    } finally {
      ss.close();
    }
  }


  public static boolean nickCheck(String nickname) {
    SqlSession ss = FactoryService.getFactory().openSession();

    try {
      Integer count = ss.selectOne("sign_up.checkNick", nickname);
      return count != null && count > 0;
    } finally {
      ss.close(); // 세션 닫기
    }
  }

  public static void signup(String email, String pw, String nick) {
    SqlSession session = FactoryService.getFactory().openSession();
    try {
      UserVO userVO = new UserVO();
      userVO.setEmail(email);
      userVO.setPw(pw);
      userVO.setNick(nick);
      userVO.setStatus(0);

      // 회원 정보를 DB에 저장
      session.insert("sign_up.insertUser", userVO);
      session.commit();  // 트랜잭션 커밋
    } finally {
      session.close();
    }
  }
}
