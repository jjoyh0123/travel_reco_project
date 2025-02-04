package mybatis.dao;

import mybatis.service.FactoryService;
import mybatis.vo.DateVO;
import mybatis.vo.JournalDTO;
import mybatis.vo.PlaceVO;
import mybatis.vo.PlanVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class PlaceDAO {
  public static PlaceVO[] getPlace(){
    PlaceVO[] ar = null;
    SqlSession ss = null;

    try {
      ss = FactoryService.getFactory().openSession();

      List<PlaceVO> list = ss.selectList("place.getPlace");

      System.out.println(list);

      if(list != null && !list.isEmpty()) {
        ar = new PlaceVO[list.size()];
        list.toArray(ar);
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      if (ss != null) {
        ss.close();
      }
    }
    // System.out.println(ar.length);
    return ar;
  }
  //
  public static DateVO[] getDate(){
    DateVO[] ar = null;

      SqlSession ss = FactoryService.getFactory().openSession();

      List<DateVO> list = ss.selectList("place.getDate");
      if(list != null && !list.isEmpty()){
        ar = new DateVO[list.size()];
        list.toArray(ar);
      }
      ss.close();

      return ar;
  }
  //
  public static PlanVO[] getPlan(){
    PlanVO[] ar = null;

    SqlSession ss = FactoryService.getFactory().openSession();

    List<PlanVO> list = ss.selectList("place.getPlan");
    if(list != null && !list.isEmpty()){
      ar = new PlanVO[list.size()];
      list.toArray(ar);
    }
    ss.close();

    return ar;
  }

  public static List<JournalDTO> getoneIdx(int idx) {
    SqlSession ss = FactoryService.getFactory().openSession();
    List<JournalDTO> list = ss.selectList("place.getoneIdx", idx);
    ss.close();
    return list;
  }
}




