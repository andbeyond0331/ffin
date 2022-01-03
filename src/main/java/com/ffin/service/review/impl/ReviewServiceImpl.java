package com.ffin.service.review.impl;

import com.ffin.common.Search;
import com.ffin.service.domain.Review;
import com.ffin.service.review.ReviewDao;
import com.ffin.service.review.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("reviewServiceImpl")
public class ReviewServiceImpl implements ReviewService {

    //FFF
    @Autowired
    @Qualifier("reviewDaoImpl")
    private ReviewDao reviewDao;
    public void setReviewDao(ReviewDao reviewDao){
        this.reviewDao = reviewDao;
    }

    //CCC
    public ReviewServiceImpl(){
        System.out.println(this.getClass());
    }

    //MMM
    @Override
    public void addReview(Review review) throws Exception {
        reviewDao.addReview(review);
    }

    @Override
    public Review getReview(int reviewNo) throws Exception {
        return reviewDao.getReview(reviewNo);
    }

    @Override
    public Map<String, Object> getReviewListTruck(Search search, String truckId) throws Exception {
        return reviewDao.getReviewListTruck(search, truckId);
    }

    @Override
    public float getReviewAvg(Search search, String truckId) throws Exception {
        return reviewDao.getReviewAvg(search, truckId);
    }

    @Override
    public Map<String, Object> getReviewListUser(Search search, String userId) throws Exception {
        return reviewDao.getReviewListTruck(search, userId);
    }

    @Override
    public void updateReview(Review review) throws Exception {
        reviewDao.updateReview(review);
    }

    @Override
    public void updateRVAddTruckComment(Review review) throws Exception {
        reviewDao.updateRVAddTruckComment(review);
    }

    @Override
    public void updateRVUpdateTruckComment(Review review) throws Exception {
        reviewDao.updateRVUpdateTruckComment(review);
    }
}
