package com.ffin.service.review;


import com.ffin.common.Search;
import com.ffin.service.domain.Review;

import java.util.List;
import java.util.Map;

public interface ReviewDao {

    //INSERT
    public void addReview(Review review) throws Exception;

    //SELECT ONE
    public Review getReview(int reviewNo) throws Exception;



    //SELECT LIST
    public Map<String, Object> getReviewListTruck(Search search, String truckId) throws Exception;


    public float getReviewAvg(Search search, String truckId) throws Exception;

    //select one
    public int getReviewTotalCount(Search search, String truckId) throws Exception;

    //SELECT LIST
    public Map<String, Object> getReviewListUser(Search search, String userId) throws Exception;

    //UPDATE
    public void updateReview(Review review) throws Exception;

    //UPDATE
    public void updateRVAddTruckComment(Review review) throws Exception;

    //UPDATE
    public void updateRVUpdateTruckComment(Review review) throws Exception;

    // 게시판 page 처리를 위한 전체 Row(totalCount) return
    public int getTotalCount(Search search) throws Exception;


}
