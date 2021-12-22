package com.ffin.service.truck.impl;

import com.ffin.common.Search;
import com.ffin.service.domain.Truck;
import com.ffin.service.truck.TruckDao;
import com.ffin.service.truck.TruckService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

//==> 푸드트럭관리 서비스 구현
@Service("truckServiceImpl")
public class TruckServiceImpl implements TruckService {

    ///Field
    @Autowired
    @Qualifier("truckDaoImpl")
    private TruckDao truckDao;

    public void setTruckDao(TruckDao truckDao) {
        this.truckDao = truckDao;
    }

    ///Constructor
    public TruckServiceImpl() {
        System.out.println(this.getClass());
    }

    ///Method
    @Override
    public void addTruck(Truck truck) throws Exception {
        truckDao.addTruck(truck);
    }

    @Override
    public Truck getTruck(String truckId) throws Exception {
        return truckDao.getTruck(truckId);
    }


    @Override
    public Map<String, Object> getTruckList(Search search) throws Exception {
        List<Truck> list = truckDao.getTruckList(search);
        //int totalCount = truckDao.getTotalCount(search);

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("list", list);
        //map.put("totalCount", new Integer(totalCount));

        return map;
    }

    @Override
    public void updateTruck(Truck truck) throws Exception {
        truckDao.updateTruck(truck);
    }

    @Override
    public int getTotalCount(Search search) throws Exception {
        return 0;
    }

    @Override
    public void login(Truck truck) throws Exception {

    }

    @Override
    public void logout(Truck truck) throws Exception {

    }

    @Override
    public String findTruckId(String truckName, String truckPhone) throws Exception {
        return truckDao.findTruckId(truckName, truckPhone);
    }


    @Override
    public void updateBusiStatus(Truck truck) throws Exception {
        truckDao.updateBusiStatus(truck);
    }

    @Override
    public void updateNotice(Truck truck) throws Exception {
        truckDao.updateNotice(truck);
    }


    @Override
    public void updateTruckProfile(Truck truck) throws Exception {
        truckDao.updateTruckProfile(truck);
    }


    @Override
    public void updateTruckInfo(Truck truck) throws Exception {
        truckDao.updateTruckInfo(truck);
    }


    @Override
    public void updateTruckPassword(Truck truck) throws Exception {
        truckDao.updateTruckPassword(truck);
    }

    @Override
    public void byeTruck(Truck truck) throws Exception {
        truckDao.byeTruck(truck);
    }

    @Override
    public void uploadFile(Truck truck) throws Exception {
        truckDao.uploadFile(truck);
    }

    @Override
    public void sendEmail(Truck truck) throws Exception {

    }

    @Override
    public void emailAuth(Truck truck) throws Exception {

    }

    @Override
    public void messageAuth(Truck truck) throws Exception {

    }

    @Override
    public void captchaAuth(Truck truck) throws Exception {

    }

    @Override
    public void busiLiceAuth(Truck truck) throws Exception {

    }

    @Override
    public void getNewTruck(Truck truck) throws Exception {

    }

    @Override
    public List<Truck> getNewTruckList(Search search) throws Exception {
        return null;
    }
}
