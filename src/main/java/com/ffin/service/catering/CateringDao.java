package com.ffin.service.catering;


import com.ffin.common.Search;
import com.ffin.service.domain.Catering;

import java.util.Map;

public interface CateringDao {
    public Map<String, Object> getCtList(Search search, String id) throws Exception;
    public Map<String, Object> getCtStatusList(Search search, String id, String ctStatusCode) throws Exception;
    public Map<String, Object> getCtDateList(Search search, String ctDate) throws Exception;
    public Catering getCtTruckMenu(String truckId) throws Exception;
    public Catering getCtDetail(int ctNo) throws Exception;
    public Catering getResDetail(int ctNo) throws Exception;
    public void addCt(Catering catering) throws Exception;
    public void updateCtResAdd(Catering catering) throws Exception;
    public void updateCtMenuQty(int ctNo, int ctMenuMinQty, int ctMenuMaxQty) throws Exception;
    public void updateCtRes(Catering catering) throws Exception;
    public void updateCtResCancel(int cnNo, String ctStatusCode) throws Exception;

}
