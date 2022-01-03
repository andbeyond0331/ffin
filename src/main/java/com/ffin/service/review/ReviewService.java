package com.ffin.service.review;

import com.ffin.common.Search;
import com.ffin.service.domain.Review;

import java.util.Map;

public interface ReviewService {


    //리뷰 등록
    public void addReview(Review review) throws Exception;

    //리뷰 조회
    public Review getReview(int reviewNo) throws Exception;

    //리뷰 목록 조회 - 트럭
    public Map<String, Object> getReviewListTruck(Search search, String truckId) throws Exception;

    //리뷰 평균 별점 조회
   public float getReviewAvg(Search search, String truckId) throws Exception;

    //리뷰 목록 조회 - 유저
    public Map<String, Object> getReviewListUser(Search search, String userId) throws Exception;

    //리뷰 수정
    public void updateReview(Review review) throws Exception;

    //사장님 댓글 등록을 위한 리뷰 수정
    public void updateRVAddTruckComment(Review review) throws Exception;

    //사장님 댓글 수정을 위한 리뷰 수정
    public void updateRVUpdateTruckComment(Review review) throws Exception;

}
