package com.ffin.service.community.impl;

import com.ffin.common.Search;
import com.ffin.service.community.CommunityDao;
import com.ffin.service.domain.Comment;
import com.ffin.service.domain.Heart;
import com.ffin.service.domain.Post;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//==> 커뮤니티관리 Dao CRUD 구현
@Repository("communityDaoImpl")
public class CommunityDaoImpl implements CommunityDao {

    ///Filed
    @Autowired
    @Qualifier("sqlSessionTemplate")
    private SqlSession sqlSession;
    public void setSqlSession(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    ///Constructor
    public CommunityDaoImpl() {
        System.out.println(this.getClass());
    }

    ///Method

    // 게시물작성
    @Override
    public void addPost(Post post) throws Exception {
        sqlSession.insert("PostMapper.addPost", post);
    }

    // 게시물조회
    @Override
    public Post getPost(int postNo) throws Exception {
        return sqlSession.selectOne("PostMapper.getPost", postNo);
    }

    // 게시물 목록 조회
    @Override
    public List<Post> getPostList(Search search) throws Exception {
        return sqlSession.selectList("PostMapper.getPostList", search);
    }

    // 게시물 수정
    @Override
    public void updatePost(Post post) throws Exception {
        sqlSession.update("PostMapper.updatePost", post);
    }

    // 댓글 작성
    @Override
    public void addComment(Comment comment) throws Exception {
        sqlSession.insert("CommentMapper.addComment", comment);
    }

    // 댓글 조회
    @Override
    public Comment getComment(int commentNo) throws Exception {
        return sqlSession.selectOne("CommentMapper.getComment", commentNo);
    }

    // 댓글 목록 조회
    @Override
    public List<Comment> getCommentList(Object commentPostNo) throws Exception {
        return sqlSession.selectList("CommentMapper.getCommentList", commentPostNo);
    }

    @Override
    public int count(int commentPostNo) throws Exception {
        return 0;
    }

    // 댓글 수정
    @Override
    public void updateComment(Comment comment) throws Exception {
        sqlSession.update("CommentMapper.updateComment", comment);
    }

    /*// 좋아요 누르기
    @Override
    public void addHeart(Heart heart) throws Exception {
        sqlSession.insert("HeartMapper.addHeart", heart);
    }
    // 좋아요 조회
    @Override
    public Heart getHeart(int heartNo) throws Exception {
        return sqlSession.selectOne("HeartMapper.getHeart", heartNo);
    }
    // 좋아요 목록조회
    @Override
    public List<Heart> getHeartList(Search search) throws Exception {
        return sqlSession.selectList("HeartMapper.getHeartList", search);
    }
    // 좋아요 갱신
    @Override
    public void updateHeart(Heart heart) throws Exception {
        sqlSession.update("HeartMapper.updateHeart", heart);
    }*/


    // 게시글 삭제
    @Override
    public void deletePost(Post post) throws Exception {
        sqlSession.delete("PostMapper.deletePost", post);
    }

    // 댓글 삭제
    @Override
    public void deleteComment(Comment comment) throws Exception {
        sqlSession.delete("CommentMapper.deleteComment", comment);
    }

    // 게시판 Page 처리를 위한 전체Row(totalCount)  return
    @Override
    public int getTotalCountPost(Search search) throws Exception {
        return sqlSession.selectOne("PostMapper.getTotalCount", search);
    }

//    @Override
//    public int getTotalCountPostU(Search search) throws Exception {
//        return sqlSession.selectOne("PostMapper.getTotalCountUser", search);
//    }
//
//    @Override
//    public int getTotalCountPostT(Search search) throws Exception {
//        return sqlSession.selectOne("PostMapper.getTotalCountTruck", search);
//    }


    // HHJ
    @Override
    public Map<String, Object>  getPostList2(Search search, String id, String role) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("search", search);
        map.put("id", id);
        map.put("role", role);
        List<Post> list = sqlSession.selectList("PostMapper.getPostList2", map);

        System.out.println("list::: "+list);


        map.put("list", list);
        return map;
    }





    public int addHeart(String role, Heart heart) {

        // 해당 게시물의 heart를 +1
        sqlSession.update("HeartMapper.addHeartPostCount", heart.getHeartTargetP());
        int result ;
        // heart 테이블에 추가
        if (role == "user") {
            result = sqlSession.insert("HeartMapper.addHeartPostUser", heart);
        }else{
            result = sqlSession.insert("HeartMapper.addHeartPostTruck", heart);
        }
        int heartCount =0; // 0으로 초기 세팅을 해도 되나.. 실패했을 때에도 걍 0으로 뜰껀데. 고민.
        if (result == 1) {	// heart 테이블에 새로운 좋아요 추가가 성공한다면..
            // 갱신된 하트 갯수를 가져옴
            heartCount = sqlSession.selectOne("HeartMapper.heartCountCheck", heart.getHeartTargetP());
        }
        return heartCount;
    }
    public int removeHeart(String role, Heart heart) {

        // 해당 게시물의 heart를 -1 한다.
        sqlSession.update("HeartMapper.minusHeartPostCount", heart.getHeartTargetP());
        int result ;
        // heart 테이블에서 삭제
        if (role == "user") {
            result = sqlSession.delete("HeartMapper.removeHeartUser", heart);
        }else{
            result = sqlSession.delete("HeartMapper.removeHeartTruck", heart);
        }



        int heartCount =0;
        if (result == 1) {	// p_heart 테이블에 좋아요 삭제가 성공한다면..
            // 갱신된 하트 갯수를 가져옴
            heartCount = sqlSession.selectOne("HeartMapper.heartCountCheck", heart.getHeartTargetP());
        }
        return heartCount;
    }


    public Post getCardDetail(String id, String role, int postNo) throws Exception{
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("id", id);
        map.put("role", role);
        map.put("postNo", postNo);

        return sqlSession.selectOne("PostMapper.getCardDetail", map);
    }


public void updatePostHitUp (int postNo) throws Exception{
    sqlSession.update("PostMapper.post_hit_up", postNo);
}



    // 댓글 작성
    public int writeReply(String role, Comment comment) {
        // p_board 테이블에 해당 게시물의 reply수를 +1 하기위한 to세팅

        int postNo = comment.getCommentPostNo();
        // 해당 게시물의 reply를 +1 한다.
        sqlSession.update("ReplyMapper.reply_up", postNo);

        // 현재 p_reply 테이블의 가장 큰 no값을 가져온다.
        int grp = sqlSession.selectOne("ReplyMapper.reply_max_no");
        System.out.println(">>>>>>>><><><><><><><><><><><><><><><>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
        System.out.println("grp = " + grp);
        // grp 세팅
        comment.setGrp(grp+1);
        int result=0;
        if (role == "user") {
            result = sqlSession.insert("ReplyMapper.reply_write_user", comment);
        }else if(role=="truck"){
            result = sqlSession.insert("ReplyMapper.reply_write_truck", comment);
        }


        //int check = sqlSession.selectOne("ReplyMapper.reply_max_no");
        // grp를 현재 가장 큰 no 즉 방금 넣은 데이터의 no값로 세팅함
        //comment.setGrp(check);
        // no 와 grp가 다르면 grp를 no로 없데이트
        //int check_update = sqlSession.update("ReplyMapper.reply_check", check);
        int replyCount=0;
        if (result == 1) {	// p_reply 테이블에 새로운 댓글 추가가 성공한다면..
            // 갱신된 댓글 갯수를 가져옴
            replyCount = sqlSession.selectOne("ReplyMapper.reply_count", postNo);
        }
        return replyCount;
    }

    // 답글 작성
    public int writeReReply(String role, Comment comment) {
        // p_board 테이블에 해당 게시물의 reply수를 +1 하기위한 to세팅

        System.out.println("와따와따와따와따와따와따와따와따와따와따");
        int postNo = comment.getCommentPostNo();
        System.out.println("postNo = " + postNo);
        // 해당 게시물의 reply를 +1 한다.
        sqlSession.update("ReplyMapper.reply_up", postNo);

        int result=0;
        if (role == "user") {
            result = sqlSession.insert("ReplyMapper.rereply_write_user", comment);
        }else if(role=="truck"){
            result = sqlSession.insert("ReplyMapper.rereply_write_truck", comment);
        }



        // p_reply 테이블에 추가 (댓글 작성과 동일)


        int replyCount=0;
        if (result == 1) {	// p_reply 테이블에 새로운 댓글 추가가 성공한다면..
            // 갱신된 댓글 갯수를 가져옴
            replyCount = sqlSession.selectOne("ReplyMapper.reply_count", postNo);
        }
        return replyCount;



    }

    // 댓글 리스트
    public ArrayList<Comment> getreplyList(String role, int postNo){

        ArrayList<Comment> replyList = (ArrayList) sqlSession.selectList("ReplyMapper.getreplyList", postNo);

        for (int i=0; i<replyList.size(); i++){

            if (replyList.get(i).getCommentUserId() == null){
                replyList.get(i).setTruckProImg(sqlSession.selectOne("ReplyMapper.get_pro_img_truck", replyList.get(i).getCommentTruckId()));

            }else {
                replyList.get(i).setUserProImg(sqlSession.selectOne("ReplyMapper.get_pro_img_user", replyList.get(i).getCommentUserId()));
            }


        }
      /*  if (role == "user") {
            replyList = (ArrayList) sqlSession.selectList("ReplyMapper.replyListUser", postNo);
        }else if(role=="truck"){
            replyList = (ArrayList) sqlSession.selectList("ReplyMapper.replyListTruck", postNo);
        }*/
        return replyList;
    }

    // 모댓글 삭제
    public int deleteReply(Comment comment) {
        // p_board 테이블에 해당 게시물의 reply수를 -1 하기위한 to세팅
        int postNo = comment.getCommentPostNo();

        // grp가 reply의 no와 일치하는 댓글이 몇갠지 카운트한다. 모댓글에 딸린 답글이 몇갠지 카운트하기 위함
        int count_rereply = sqlSession.selectOne("ReplyMapper.count_rereply", comment);

        int result = 0;

        // 해당 게시물의 reply를 -1 한다.
        sqlSession.update("ReplyMapper.reply_down", postNo);

        if(count_rereply==0) {	// 답글이 없을 때 - 그냥 삭제
            // p_reply 테이블에서 삭제
            result = sqlSession.delete("ReplyMapper.reply_delete", comment.getCommentNo());
        }else {					// 답글이 있을 때 - content에 공백을 넣음 ("삭제된 게시물입니다" 라고 표기하기 위함)
            // p_reply 테이블에서 삭제하지 않고 content에 공백을 넣음
            result = sqlSession.update("ReplyMapper.reply_not_delete", comment.getCommentNo());
        }
        int replyCount=0;
        if (result == 1) {	// p_reply 테이블에서 댓글삭제가 성공한다면..
            // 갱신된 댓글 갯수를 가져옴
            replyCount = sqlSession.selectOne("ReplyMapper.reply_count", postNo);
        }
        return replyCount;
    }

    // 답글 삭제
    public int deleteReReply(Comment comment) {
        // p_board 테이블에 해당 게시물의 reply수를 -1 하기위한 to세팅
        int postNo = comment.getCommentPostNo();

        // 해당 게시물의 reply를 -1 한다.
        sqlSession.update("ReplyMapper.reply_down", postNo);

        // p_reply 테이블에서 삭제
        int result = sqlSession.delete("ReplyMapper.reply_delete", comment.getCommentNo());

        // grp가  일치하는 답글이 몇갠지 카운트 한다. 없고 모댓글의 content가 ""이면 모댓글을 삭제하기 위함.
        int count_rereply = sqlSession.selectOne("ReplyMapper.count_rereply_fromrereply", comment);


        System.out.println("count_rereply = " + count_rereply);
        if(count_rereply == 0) {
            sqlSession.delete("ReplyMapper.reply_delete_after_rereply_delete", comment.getGrp());
        }
        int replyCount=0;
        if (result == 1) {	// p_reply 테이블에서 댓글삭제가 성공한다면..
            // 갱신된 댓글 갯수를 가져옴
            replyCount = sqlSession.selectOne("ReplyMapper.reply_count", postNo);
        }
        return replyCount;
    }


    // 댓글 작성
    public int profile_pictureWriteReply(Comment comment) {
        // p_board 테이블에 해당 게시물의 reply수를 +1 하기위한 to세팅
        int postNo = comment.getCommentPostNo();

        // 해당 게시물의 reply를 +1 한다.
        sqlSession.update("ReplyMapper.reply_up", postNo);

        // 현재 p_reply 테이블의 가장 큰 no값을 가져온다.
        int grp = sqlSession.selectOne("ReplyMapper.reply_max_no");

        // grp 세팅
        comment.setGrp(grp+1);


        int result = sqlSession.insert("ReplyMapper.reply_write", comment);

        int check = sqlSession.selectOne("ReplyMapper.reply_max_no");
        // grp를 현재 가장 큰 no 즉 방금 넣은 데이터의 no값로 세팅함
        comment.setGrp(check);

        // no 와 grp가 다르면 grp를 no로 없데이트
        //int check_update = sqlSession.update("picture_reply_check", to);
        int replyCount=0;
        if (result == 1) {	// p_reply 테이블에 새로운 댓글 추가가 성공한다면..
            // 갱신된 댓글 갯수를 가져옴
           // pto = sqlSession.selectOne("picture_reply_count", pto);
            replyCount = sqlSession.selectOne("ReplyMapper.reply_count", postNo);
        }
        return replyCount;
    }







}
