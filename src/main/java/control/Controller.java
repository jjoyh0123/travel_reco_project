package control;

import action.Action;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

@WebServlet(
    urlPatterns = {"/Controller"},
    initParams = {
        @WebInitParam(name = "myParam", value = "/WEB-INF/action.properties")
    })
public class Controller extends HttpServlet {

  private final Map<String, Action> actionMap;

  public Controller() {
    super();
    actionMap = new HashMap<>();
  }

  public void init() {
    String props_path = this.getInitParameter("myParam");

    ServletContext application = this.getServletContext();

    String publicIP = "http://43.201.37.240";
    application.setAttribute("publicIP", publicIP);

    String realPath = application.getRealPath(props_path);

    Properties props = new Properties();

    FileInputStream fis = null;
    try {
      fis = new FileInputStream(realPath);

      props.load(fis);

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      try {
        if (fis != null)
          fis.close();
      } catch (Exception e) {
        e.printStackTrace();
      }
    }
    Iterator<Object> it = props.keySet().iterator();

    while (it.hasNext()) {
      String key = (String) it.next();
      String value = props.getProperty(key);
      try {
        Object obj = Class.forName(value).newInstance();
        Action action = (Action) obj;
        actionMap.put(key, action);
      } catch (Exception e) {
        e.printStackTrace();
      }
    }
  }

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // if(request.getSession().getAttribute("user_idx") == null) {
    //   response.sendRedirect("Controller?type=index");
    // }
    // 먼저 로그인을 무조건 해야되는 페이지와 안해도 되는 페이지를 구분할 것.

    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    String type = request.getParameter("type");
    if (type == null || type.isEmpty()) {
      type = "index";
    }

    Action action = actionMap.get(type);
    String view_path = action.execute(request, response);

    if (type.equals("error")) {
      response.sendRedirect("Controller?type=index");
    } else {
      RequestDispatcher dis = request.getRequestDispatcher(view_path);
      dis.forward(request, response);
    }
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    doGet(request, response);
  }
}
