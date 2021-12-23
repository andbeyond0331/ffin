package com.ffin.service.review;

import com.ffin.service.domain.Review;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.*;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:config/context-common.xml",
        "classpath:config/context-aspect.xml",
        "classpath:config/context-mybatis.xml",
        "classpath:config/context-transaction.xml" })
public class ReviewServiceTest {

    @Autowired
    @Qualifier("reviewServiceImpl")
    private ReviewService reviewService;

//    @Test
//    public void addReview() throws Exception {
//        Review review = new Review();
//
//        review.setRvNo(6);
//        review.setRvOrderNo(1);
//        review.setRvStar(5);
//        review.setRvContent("reviewContentTest1");
//        review.setRvImg1("rvImgTest1");
//        review.setRvImg2("rvImgTest2");
//        review.setRvImg3("rvImgTest3");
//        review.setRvDelete('0');
//        review.setRvTCDelete('0');
//
//        reviewService.addReview(review);
//
//        Assert.assertEquals(6, review.getRvNo());
//        Assert.assertEquals(1, review.getRvOrderNo());
//        Assert.assertEquals(5.0, review.getRvStar(),0);
//        Assert.assertEquals("reviewContentTest1", review.getRvContent());
//        Assert.assertEquals("rvImgTest1", review.getRvImg1());
//        Assert.assertEquals("rvImgTest2", review.getRvImg2());
//        Assert.assertEquals("rvImgTest3", review.getRvImg3());
//        Assert.assertEquals('0', review.getRvDelete());
//        Assert.assertEquals('0', review.getRvTCDelete());
//
//    }

//    @Test
//    public void getReviewList() {
//    }

    @Test
    public void updateReview() {

    }

//    @Test
//    public void updateRVAddTruckComment() {
//    }
//
//    @Test
//    public void updateRVUpdateTruckComment() {
//    }
}