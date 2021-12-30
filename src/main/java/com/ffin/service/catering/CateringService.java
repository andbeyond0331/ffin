package com.ffin.service.catering;

import com.ffin.common.Search;
import com.ffin.service.domain.Catering;

import java.util.List;
import java.util.Map;

public interface CateringService {

    /*
        21. 12. 22
        getCtList
        search.searchCondition 으로 구분하여 Mapper에서 Where절을 따로 둘 예정
        0: 이용자가 예약한 모든 서비스 (userId={userId})
        1: 이용자가 예약한 서비스/status값으로 구분   (status =n, userId={userId})
        2: 사업자가 등록한 모든 서비스 (truckId={truckId})
        3: status 값으로 구분, 사업자 입장에서. (status=n, truckId={truckID})
        4: 날짜별로 서치 (ctDate={ctDate})

        condition으로 바꾸려고 했는데 너무 정신없을 것 같다는 생각이 드넹
        3개로 나누자.
        1) getCtList(Search search, String id)
                0 : 이용자 아이디만 조회 (이용자의 모든 서비스)
                1 : 사업자 아이디만 조회 (사업자가 등록한 모든 서비스)
                2 : 이용자가 보는 창.. (이용자의 예약완료 서비스 + 모든 등록된 서비스)
        2) getCtStatusList(Search search, String id, String ctStatusCode)
                0 : 이용자의 STATUS 값 조회
                1 : 사업자의 STATUS 값 조회
        3) getCtDateList(Search search, String ctDate) // 4
     */
    public Map<String, Object> getCtList(Search search, String id) throws Exception;
    public Map<String, Object> getCtStatusList(Search search, String id, String ctStatusCode) throws Exception;
    public Map<String, Object> getCtDateList(Search search, String ctDate) throws Exception;

     /*
        21. 12. 22
        getCtTruckMenu(truckId) :  truckId를 기준으로 truck의 정보와 sigMenu의 메뉴 정보를 받아온다.(담는건 Catering)
        getCtDetail(ctNo) : ctNo를 기준으로 등록한 서비스 내역 / 예약 내역을 불러온다.

        addCt(Catering) : 서비스 등록

        updateCtResAdd(Catering) : 예약 등록 - 이용자
        updateCtMenuQty(int, int) : 메뉴 최소, 최대수량 변경 - 사업자
        updateCtRes(Catering) : 예약 상태 수정
        updateCtStatus(int ctNo, String ctStatusCode) : 서비스 상태값 수정
      */
     public Catering getCtTruckMenu(String truckId) throws Exception;
     public Catering getCtDetail(int ctNo) throws Exception;
     public Catering getResDetail(int ctNo) throws Exception;
     public void addCt(Catering catering) throws Exception;

     public void updateCtResAdd(Catering catering) throws Exception;
     public void updateCtMenuQty(int ctNo, int ctMenuMinQty, int ctMenuMaxQty) throws Exception;
     public void updateCtRes(Catering catering) throws Exception;
     public void updateCtResCancel(int ctNo, String ctStatusCode) throws Exception;



}