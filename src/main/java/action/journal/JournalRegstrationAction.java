package action.journal;

import action.Action;
import com.google.gson.Gson;
import mybatis.dao.PlaceDAO;
import mybatis.vo.*;
import org.json.JSONObject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

public class JournalRegstrationAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    String user_idx = request.getParameter("user_idx") != null ? request.getParameter("user_idx") : "3";
    String plan_idx = request.getParameter("plan_idx");
    String action = request.getParameter("action");
    String json_response;
    JSONObject json_object = new JSONObject();

    System.out.printf("plan_idx: %s\n", plan_idx);
    System.out.printf("action: %s\n", action);

    if(action == null || action.isEmpty()) {
      return "/jsp/error.jsp";
    }

    switch (action) {
      case "registration":
        return "/jsp/journal/journal_registration.jsp";
      case "get_plan":
        return get_plan_data(request, plan_idx, json_object);
      default:
        return "/jsp/error.jsp";
    }
  }

  private String get_plan_data(HttpServletRequest request, String plan_idx, JSONObject json_object) {
    System.out.printf("plan_idx in get_plan_data: %s\n", plan_idx);
    if(plan_idx == null || plan_idx.isEmpty()) {
      return "/jsp/error.jsp";
    } else {
      // plan_idx를 이용하여 plan, dates, places 를 json 객체로 만들어서 Frontend 로 전달.

      PlanVO plan = PlaceDAO.get_plan(plan_idx);
      List<JournalPlaceVO> journal_places_list = PlaceDAO.get_journal_places_list(plan_idx);


      if(plan == null || journal_places_list == null || journal_places_list.isEmpty()) {
        json_object.put("status", "error");
      } else {
        json_object.put("status", "success");
        // json_object.put("plan", plan);
        json_object.put("plan", new Gson().toJson(plan));
        json_object.put("data", journal_places_list);
      }

      request.setAttribute("json_response", json_object);
      return "/jsp/res_json.jsp";
    }
  }
}
