package com.ffin.service.review.impl;

import com.ffin.common.Search;
import com.ffin.service.domain.Review;
import com.ffin.service.review.ReviewDao;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("reviewDaoImpl")
public class ReviewDaoImpl implements ReviewDao {

    //FFF
    @Autowired
    @Qualifier("sqlSessionTemplate")
    private SqlSession sqlSession;

    public void setSqlSession(SqlSession sqlSession){
        this.sqlSession = sqlSession;
    }

    //MMM

    @Override
    public void addReview(Review review) throws Exception {
        sqlSession.insert("ReviewMapper.addReview", review);
    }

    //delete와 update를 위한 get
    @Override
    public Review getReview(int reviewNo) throws Exception {

        return sqlSession.selectOne("ReviewMapper.getReview", reviewNo);
    }

    @Override
    public List<Review> getReviewList(Search search) throws Exception {
        return sqlSession.selectList("ReviewMapper.getReviewList", search);
    }

    @Override
    public void updateReview(Review review) throws Exception {
        sqlSession.update("ReviewMapper.updateReview",review);
    }

    @Override
    public void updateRVAddTruckComment(Review review) throws Exception {
        sqlSession.update("ReviewMapper.updateRVAddTruckComment", review);
    }

    @Override
    public void updateRVUpdateTruckComment(Review review) throws Exception {
        sqlSession.update("ReviewMapper.updateRVUpdateTruckComment", review);
    }

    @Override
    public int getTotalCount(Search search) throws Exception {
        return sqlSession.selectOne("ReviewMapper.getTotalCount", search);
    }


}
