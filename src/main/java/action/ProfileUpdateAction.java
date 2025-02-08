package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mybatis.service.FactoryService;
import mybatis.vo.UserVO;
import org.apache.ibatis.session.SqlSession;

public class ProfileUpdateAction implements Action {

  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    // 클라이언트로부터 수정된 닉네임과 패스워드 값 가져오기
    String newNick = request.getParameter("nickname");

    if(newNick == null){
      return "jsp/profile_update.jsp";
    }

    System.out.println(newNick);
    String newPw = request.getParameter("password");

    // 세션에서 현재 로그인한 사용자 정보 가져오기
    HttpSession session = request.getSession();
    UserVO currentUser = (UserVO) session.getAttribute("user");
    if (currentUser == null) {

      // 로그인 정보가 없으면 로그인 페이지로 이동
      return "jsp/login.jsp";
    }

    // 유효성 검사 시작

    // 1. 닉네임 한글 검사
    if (!newNick.matches("^[가-힣]+$")) {
      request.setAttribute("msg", "닉네임은 한글만 입력해야 합니다.");
      return "jsp/profile_update.jsp";
    }

    // 2. 패스워드 길이 검사
    if (newPw == null || newPw.length() < 4) {
      request.setAttribute("msg", "패스워드는 4자리 이상 입력해야 합니다.");
      return "jsp/profile_update.jsp";
    }

    // MyBatis SqlSession 생성
    SqlSession sqlSession = FactoryService.get_factory().openSession();
    try {
      // 3. 닉네임 중복 검사
      int nickCheck = sqlSession.selectOne("sign_up.checkNick", newNick);
      if (nickCheck > 0) {
        request.setAttribute("nicknameMessage", "이미 존재하는 닉네임입니다.");
        return "jsp/profile_update.jsp";
      }

      // 업데이트할 정보를 담은 UserVO 객체 생성
      UserVO userToUpdate = new UserVO();
      userToUpdate.setIdx(currentUser.getIdx());
      userToUpdate.setNick(newNick);
      userToUpdate.setPw(newPw);

      // mapper의 updateUserProfile 쿼리 호출
      int result = sqlSession.update("user.updateUserProfile", userToUpdate);
      if (result > 0) {
        sqlSession.commit();

        // 세션 정보 업데이트 (닉네임, 패스워드)
        session.setAttribute("nick", newNick);
        currentUser.setNick(newNick);
        currentUser.setPw(newPw);
        session.setAttribute("user", currentUser);

        // 프로필 업데이트 성공 후 updateProfile 페이지로 리다이렉트 (성공 메시지 포함)
        return "jsp/profile_update.jsp?msg=success";
      } else {
        // 업데이트 실패한 경우, 메시지를 request에 담아서 profileSetting 페이지로 이동
        request.setAttribute("msg", "프로필 업데이트에 실패했습니다.");
        return "jsp/profile_update.jsp";
      }
    } catch (Exception e) {
      sqlSession.rollback();
      e.printStackTrace();
      request.setAttribute("msg", "오류가 발생했습니다.");
      return "jsp/profile_update.jsp";
    } finally {
      sqlSession.close();
    }
  }
}
