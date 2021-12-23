package com.ffin.service.review;


import com.ffin.common.Search;
import com.ffin.service.domain.Review;

import java.util.List;

public interface ReviewDao {

    //INSERT
    public void addReview(Review review) throws Exception;

    //SELECT ONE
    public Review getReview(int reviewNo) throws Exception;
    //SELECT LIST
    public List<Review> getReviewList(Search search) throws Exception;

    //UPDATE
    public void updateReview(Review review) throws Exception;

    //UPDATE
    public void updateRVAddTruckComment(Review review) throws Exception;

    //UPDATE
    public void updateRVUpdateTruckComment(Review review) throws Exception;

    // 게시판 page 처리를 위한 전체 Row(totalCount) return
    public int getTotalCount(Search search) throws Exception;

}
