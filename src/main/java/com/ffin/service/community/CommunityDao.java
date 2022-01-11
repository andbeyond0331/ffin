package com.ffin.service.community;

import com.ffin.common.Search;
import com.ffin.service.domain.Comment;
import com.ffin.service.domain.Heart;
import com.ffin.service.domain.Post;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface CommunityDao {

    // INSERT
    public void addPost(Post post) throws Exception;

    public void addComment(Comment comment) throws Exception;

    /*public void addHeart(Heart heart) throws Exception;*/

    // SELECT ONE
    public Post getPost(int postNo) throws Exception;

    public Comment getComment(int commentNo) throws Exception;

   /* public Heart getHeart(int heartNo) throws Exception;*/

    // SELECT LIST
    public List<Post> getPostList(Search search) throws Exception;

    public List<Comment> getCommentList(Object commentPostNo) throws Exception;

    public int count(int commentPostNo) throws Exception;

   /* public List<Heart>  getHeartList(Search search) throws Exception;*/

    // UPDATE
    public void updatePost(Post post) throws Exception;

    public void updateComment(Comment comment) throws Exception;

    /*public void updateHeart(Heart heart) throws Exception;*/


    // DELETE
    public void deletePost(Post post) throws Exception;

    public void deleteComment(Comment comment) throws Exception;


    // 게시판 Page 처리를 위한 전체Row(totalCount)  return
    public int getTotalCountPost(Search search) throws Exception ;

//    public int getTotalCountPostU(Search search) throws Exception ;
//
//    public int getTotalCountPostT(Search search) throws Exception ;

    //HHJ
    public Map<String, Object> getPostList2(Search search, String id, String role) throws Exception;
    public int addHeart(String role, Heart heart) throws Exception;
    public int removeHeart(String role, Heart heart) throws Exception;
    public Post getCardDetail(String id, String role, int postNo) throws Exception;


    public int writeReply(String role, Comment comment) throws Exception;
    public int writeReReply(String role, Comment comment) throws Exception;
    public ArrayList<Comment> getreplyList(String role, int postNo) throws Exception;
    public int deleteReply(Comment comment) throws Exception;
    public int deleteReReply(Comment comment) throws Exception;
    public int profile_pictureWriteReply(Comment comment) throws Exception;
}
