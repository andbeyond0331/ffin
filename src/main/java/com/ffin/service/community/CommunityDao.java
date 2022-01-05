package com.ffin.service.community;

import com.ffin.common.Search;
import com.ffin.service.domain.Comment;
import com.ffin.service.domain.Heart;
import com.ffin.service.domain.Post;

import java.util.List;

public interface CommunityDao {

    // INSERT
    public void addPost(Post post) throws Exception;

    public void addComment(Comment comment) throws Exception;

    public void addHeart(Heart heart) throws Exception;

    // SELECT ONE
    public Post getPost(int postNo) throws Exception;

    public Comment getComment(int commentNo) throws Exception;

    public Heart getHeart(int heartNo) throws Exception;

    // SELECT LIST
    public List<Post> getPostList(Search search) throws Exception;

    public List<Comment> getCommentList(Object commentPostNo) throws Exception;

    public int count(int commentPostNo) throws Exception;

    public List<Heart>  getHeartList(Search search) throws Exception;

    // UPDATE
    public void updatePost(Post post) throws Exception;

    public void updateComment(Comment comment) throws Exception;

    public void updateHeart(Heart heart) throws Exception;


    // 게시판 Page 처리를 위한 전체Row(totalCount)  return
    public int getTotalCountPost(Search search) throws Exception ;

//    public int getTotalCountPostU(Search search) throws Exception ;
//
//    public int getTotalCountPostT(Search search) throws Exception ;


}
