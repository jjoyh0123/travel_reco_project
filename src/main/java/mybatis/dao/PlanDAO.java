package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.PlanVO;
import org.apache.ibatis.session.SqlSession;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

public class PlanDAO {

  // Insert into plan_table
  public static int insertPlan(PlanVO plan) {

    // Before inserting the plan, validate user_idx and area_code
    if (plan.getUser_idx() == null) {
      return -1; // User does not exist
    }
    if (plan.getArea_code() == null) {
      return -1; // Area does not exist
    }

    try (SqlSession ss = FactoryService.get_factory().openSession()) {
      int cnt = ss.insert("plan.insertPlan", plan);

      System.out.println("Inserting plan with user_idx: " + plan.getUser_idx() + " and area_code: " + plan.getArea_code());

      if (cnt > 0) {
        ss.commit();
        return Integer.parseInt(plan.getIdx()); // Get auto-generated plan_idx
      } else {
        ss.rollback();
        return -1;
      }
    }
  }



  // Insert into date_table
  public static int insertDate(int planIdx, String date) {
    try (SqlSession ss = FactoryService.get_factory().openSession()) {
      Map<String, Object> param = new HashMap<>();
      param.put("plan_idx", planIdx);
      param.put("date", date);

      String date_idx = null;
      int cnt = ss.insert("plan.insertDate", param);
      if (cnt > 0) {
        ss.commit();
        System.out.printf("Inserted date with param: %s, idx: %s", param, param.get("idx"));
        date_idx = param.get("idx").toString();
      } else {
        ss.rollback();
      }

      if (date_idx == null || date_idx.isEmpty()) {
        return -1;
      } else {
        return Integer.parseInt(date_idx);
      }
    }
  }

  // Insert into place_table
  public static int insertPlace(int planIdx, int dateIdx, int order, JSONObject place) {
    try (SqlSession ss = FactoryService.get_factory().openSession()) {
      Map<String, Object> param = new HashMap<>();
      param.put("plan_idx", planIdx);
      param.put("date_idx", dateIdx);
      param.put("visit_order", order);
      param.put("content_id", place.getString("content_id"));
      param.put("content_type_id", place.getInt("content_type_id"));
      param.put("title", place.getString("title"));
      param.put("thumbnail", place.getString("thumbnail"));
      param.put("map_x", place.getDouble("map_x"));
      param.put("map_y", place.getDouble("map_y"));
      param.put("time", place.getString("time"));

      int cnt = ss.insert("plan.insertPlace", param);
      if (cnt > 0) {
        ss.commit();
      } else {
        ss.rollback();
      }
      return cnt;
    }
  }
  // public static boolean insertPlace(int planIdx, int dateIdx, int order, JSONObject place) {
  //   try (SqlSession ss = FactoryService.get_factory().openSession()) {
  //     Map<String, Object> param = new HashMap<>();
  //     param.put("plan_idx", planIdx);
  //     param.put("date_idx", dateIdx);
  //     param.put("visit_order", order);
  //     param.put("content_id", place.getString("content_id"));
  //     param.put("content_type_id", place.getInt("content_type_id"));
  //     param.put("title", place.getString("title"));
  //     param.put("thumbnail", place.getString("thumbnail"));
  //     param.put("map_x", place.getDouble("map_x"));
  //     param.put("map_y", place.getDouble("map_y"));
  //     param.put("time", place.getString("time"));
  //
  //     int cnt = ss.insert("plan.insertPlace", param);
  //     if (cnt > 0) {
  //       ss.commit();
  //       return true;
  //     } else {
  //       ss.rollback();
  //       return false;
  //     }
  //   }
  // }
}
