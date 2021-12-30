package com.ffin.service.catering.impl;


import com.ffin.common.Search;
import com.ffin.service.catering.CateringDao;
import com.ffin.service.catering.CateringService;
import com.ffin.service.domain.Catering;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;


import java.util.Map;

@Service("cateringServiceImpl")
public class CateringServiceImpl implements CateringService {

    @Autowired
    @Qualifier("cateringDaoImpl")
    private CateringDao cateringDao;

    public CateringServiceImpl() {
        System.out.println(this.getClass());
    }

    @Override
    public Map<String, Object> getCtList(Search search, String id) throws Exception {
        return cateringDao.getCtList(search, id);
    }

    @Override
    public Map<String, Object> getCtStatusList(Search search, String id, String ctStatusCode) throws Exception {
        return cateringDao.getCtStatusList(search, id, ctStatusCode);
    }

    @Override
    public Map<String, Object> getCtDateList(Search search, String ctDate) throws Exception {
        return cateringDao.getCtDateList(search, ctDate);
    }

    @Override
    public Catering getCtTruckMenu(String truckId) throws Exception {
        return cateringDao.getCtTruckMenu(truckId);
    }

    @Override
    public Catering getCtDetail(int ctNo) throws Exception {
        return cateringDao.getCtDetail(ctNo);
    }

    @Override
    public Catering getResDetail(int ctNo) throws Exception {
        return cateringDao.getResDetail(ctNo);
    }

    @Override
    public void addCt(Catering catering) throws Exception {
        cateringDao.addCt(catering);
    }

    @Override
    public void updateCtResAdd(Catering catering) throws Exception {
        cateringDao.updateCtResAdd(catering);
    }

    @Override
    public void updateCtMenuQty(int ctNo, int ctMenuMinQty, int ctMenuMaxQty) throws Exception {
        cateringDao.updateCtMenuQty(ctNo, ctMenuMinQty, ctMenuMaxQty);
    }

    @Override
    public void updateCtRes(Catering catering) throws Exception {
        cateringDao.updateCtRes(catering);
    }

    @Override
    public void updateCtResCancel(int cnNo, String ctStatusCode) throws Exception {
        cateringDao.updateCtResCancel(cnNo, ctStatusCode);
    }
}
