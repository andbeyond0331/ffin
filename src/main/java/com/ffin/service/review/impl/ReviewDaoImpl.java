package com.ffin.service.review.impl;

import com.ffin.common.Search;
import com.ffin.service.domain.Review;
import com.ffin.service.review.ReviewDao;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        Review review = sqlSession.selectOne("ReviewMapper.getReview", reviewNo);
        if(review.getRvTruckCmtContent()!=null){//사장님 댓글이 있다면
            review.setTruckProImg(sqlSession.selectOne("ReviewMapper.getProImgTruck", review.getRvTruckId()));
        }
        review.setUserProImg(sqlSession.selectOne("ReviewMapper.getProImgUser", review.getRvUserId()));
        review.setTruckName(sqlSession.selectOne("ReviewMapper.getTruckName", review.getRvTruckId()));

        return review;
    }

    @Override
    public Map<String, Object> getReviewListTruck(Search search, String truckId) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("search", search);
        map.put("truckId", truckId);
        List<Review> list =sqlSession.selectList("ReviewMapper.getReviewListTruck", map);
        for(int i = 0; i<list.size(); i++){
            if(list.get(i).getRvTruckCmtContent()!=null){
                list.get(i).setTruckProImg(sqlSession.selectOne("ReviewMapper.getProImgTruck", list.get(i).getRvTruckId()));

            }
            list.get(i).setUserProImg(sqlSession.selectOne("ReviewMapper.getProImgUser", list.get(i).getRvUserId()));
            list.get(i).setTruckName(sqlSession.selectOne("ReviewMapper.getTruckName", list.get(i).getRvTruckId()));
        }


        System.out.println("list : " + list);

        int totalCount = sqlSession.selectOne("ReviewMapper.getTotalCount", truckId);

        map.clear();
        map.put("list", list);
        map.put("totalCount", totalCount);

        return map;
    }

    @Override
    public float getReviewAvg(Search search, String truckId) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("search", search);
        map.put("truckId", truckId);
        List<Review> list =sqlSession.selectList("ReviewMapper.getReviewAvg", map);
        System.out.println("list : " + list);

        map.clear();
        map.put("list", list);
        float avg;
        if(list.size()!=0){
            avg=list.get(0).getRvStar();
        }else{
            avg=0;
        }


        return avg;
    }

    @Override
    public int getReviewTotalCount(Search search, String truckId) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("search", search);
        map.put("truckId", truckId);
        List<Review> list =sqlSession.selectList("ReviewMapper.getReviewTotalCount", map);
        System.out.println("list : " + list);

        map.clear();
        map.put("list", list);
//        float avg = list.get(0).getRvStar();
        int total;
        if(list.size()!=0){
            total = list.get(0).getRvNo();
        }else{
            total = 0;
        }

        return total;
    }

    @Override
    public Map<String, Object> getReviewListUser(Search search, String userId) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("search", search);
        map.put("userId", userId);
        List<Review> list =sqlSession.selectList("ReviewMapper.getReviewListUser", map);
        for(int i = 0; i<list.size(); i++){
            if(list.get(i).getRvTruckCmtContent()!=null){
                list.get(i).setTruckProImg(sqlSession.selectOne("ReviewMapper.getProImgTruck", list.get(i).getRvTruckId()));

            }
            list.get(i).setUserProImg(sqlSession.selectOne("ReviewMapper.getProImgUser", list.get(i).getRvUserId()));
            list.get(i).setTruckName(sqlSession.selectOne("ReviewMapper.getTruckName", list.get(i).getRvTruckId()));

        }

        System.out.println("list : " + list);
        Review forTotalCount = sqlSession.selectOne("ReviewMapper.getTotalCountUser", userId);

        int totalCount = forTotalCount.getRvNo();

        map.clear();
        map.put("list", list);
        map.put("totalCount", totalCount);

        return map;
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
