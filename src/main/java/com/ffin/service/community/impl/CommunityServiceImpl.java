package com.ffin.service.community.impl;

import com.ffin.common.Search;
import com.ffin.service.community.CommunityDao;
import com.ffin.service.community.CommunityService;
import com.ffin.service.domain.Comment;
import com.ffin.service.domain.Heart;
import com.ffin.service.domain.Post;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

// 게시물관리 서비스 구현
@Service("communityServiceImpl")
public class CommunityServiceImpl implements CommunityService {

    //Field
    @Autowired
    @Qualifier("communityDaoImpl")
    private CommunityDao communityDao;

    public void setCommunityDao(CommunityDao communityDao){
        this.communityDao = communityDao;
    }

    ///Constructor
    public CommunityServiceImpl() {
        System.out.println(this.getClass());
    }

    ///Method

    // 게시물작성
    @Override
    public void addPost(Post post) throws Exception {
        communityDao.addPost(post);
    }

    // 게시물조회
    @Override
    public Post getPost(int postNo) throws Exception {
        return communityDao.getPost(postNo);
    }

    // 게시물 목록 조회
    @Override
    public Map<String, Object> getPostList(Search search) throws Exception {
        List<Post> list = communityDao.getPostList(search);

        int totalCount = communityDao.getTotalCountPost(search);
//        int totalCountU = communityDao.getTotalCountPostU(search);
//        int totalCountT = communityDao.getTotalCountPostT(search);

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("list", list);
        map.put("totalCount", new Integer(totalCount));
//        map.put("totalCountU", new Integer(totalCountU));
//        map.put("totalCountT", new Integer(totalCountT));

        return map;
    }

    // 게시물 수정
    @Override
    public void updatePost(Post post) throws Exception {
        communityDao.updatePost(post);
    }

    // 댓글 작성
    @Override
    public void addComment(Comment comment) throws Exception {
        communityDao.addComment(comment);
    }

    // 댓글 조회
    @Override
    public Comment getComment(int commentNo) throws Exception {
        return communityDao.getComment(commentNo);
    }

    // 댓글 목록 조회
    @Override
    public List<Comment> getCommentList(Object commentPostNo) throws Exception {
        return communityDao.getCommentList(commentPostNo);
    }

    // 댓글 수정
    @Override
    public void updateComment(Comment comment) throws Exception {
        communityDao.updateComment(comment);
    }

    // 댓글 수
    @Override
    public int count(int commentPostNo) throws Exception {
        return 0;
    }

    // 좋아요 누르기
    @Override
    public void addHeart(Heart heart) throws Exception {
        communityDao.addHeart(heart);
    }
    // 좋아요 조회
    @Override
    public Heart getHeart(int heartNo) throws Exception {
        return communityDao.getHeart(heartNo);
    }
    // 좋아요 목록 조회
    @Override
    public Map<String, Object> getHeartList(Search search) throws Exception {

        List<Heart> list = communityDao.getHeartList(search);
        //int totalCount = truckDao.getTatalCount(search);

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("list", list);

        return map;
    }
    // 좋아요 갱신
    @Override
    public void updateHeart(Heart heart) throws Exception {
        communityDao.updateHeart(heart);
    }

    // 게시판 Page 처리를 위한 전체Row(totalCount)
    @Override
    public int getTotalCount(Search search) throws Exception {
        return 0;
    }
}
