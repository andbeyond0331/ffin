package com.ffin.service.community;

import com.ffin.common.Search;
import com.ffin.service.domain.Post;

import java.util.Map;

public interface CommunityService {

    //
    public Map<String, Object> getPostList(Search search) throws Exception ;

    public Post getPost(String postNo) throws Exception;

    public void addPost(Post post) throws Exception;

    public void updatePost(Post post) throws Exception;


}
