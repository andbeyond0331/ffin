package com.ffin.service.community;

import com.ffin.common.Search;
import com.ffin.service.domain.Comment;
import com.ffin.service.domain.Post;

import java.util.List;

public interface CommunityDao {

    // INSERT
    public void addPost(Post post) throws Exception;

    public void addComment(Comment comment) throws Exception;

    // SELECT ONE
    public Post getPost(int postNo) throws Exception;

    public Comment getComment(int commentNo) throws Exception;

    // SELECT LIST
    public List<Post> getPostList(Search search) throws Exception;

    public List<Comment> getCommentList(Search search) throws Exception;

    // UPDATE
    public void updatePost(Post post) throws Exception;

    public void updatComment(Comment comment) throws Exception;


    // 게시판 Page 처리를 위한 전체Row(totalCount)  return
    public int getTotalCount(Search search) throws Exception ;


}
