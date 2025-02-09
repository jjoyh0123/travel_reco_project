package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.DateVO;
import mybatis.vo.NoticeVO;
import mybatis.vo.PlaceVO;
import mybatis.vo.PlanVO;
import mybatis.vo.planning.TouristSpotVO;
import org.apache.ibatis.session.SqlSession;
import org.json.JSONObject;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MyPageDAO {

  public static List<PlanVO> getPlanByUser(int userId) {
    try (SqlSession ss = FactoryService.get_factory().openSession()) {

      List<PlanVO> list = ss.selectList("myPage.getPlanByUser", userId);

      if (list != null && !list.isEmpty()) {
        return list;
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return null;
  }
}