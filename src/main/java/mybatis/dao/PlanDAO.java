package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.PlanVO;
import org.apache.ibatis.session.SqlSession;

import static mybatis.service.FactoryService.getFactory;

public class PlanDAO {

  public static int insertPlan(PlanVO plan) {
    System.out.println(plan.getUser_idx());
    // SqlSession ss = FactoryService.getFactory().openSession();
    int cnt;
    try (SqlSession ss = FactoryService.getFactory().openSession()) {
      cnt = ss.insert("plan.insertPlan", plan);
      if (cnt > 0) {
        ss.commit();  // Commit the transaction
      } else {
        ss.rollback();
      }
    }
    System.out.println(cnt);
    return cnt;
  }
}
