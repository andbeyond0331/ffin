package com.ffin.service.community;

import com.ffin.common.Search;
import com.ffin.service.domain.*;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.Map;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:config/context-auth.xml",
        "classpath:config/context-common.xml",
        "classpath:config/context-aspect.xml",
        "classpath:config/context-mybatis.xml",
        "classpath:config/context-transaction.xml"})

public class CommunityServiceTest {

    /**
     *
     */
    //==>@RunWith,@ContextConfiguration 이용 Wiring, Test 할 instance DI
    @Autowired
    @Qualifier("communityServiceImpl")
    private CommunityService communityService;

    //@Test
    public void testAddPost() throws Exception {
        Truck truck = new Truck();
        truck.setTruckId("truck04");

        Post post = new Post();
        post.setPostTruck(truck);
        post.setPostTitle("할수있따");
        post.setPostContent("힘내자");
        post.setPostFile1("힘나는사진.jpg");

        communityService.addPost(post);
    }

    //@Test
    public void testAddComment() throws Exception {

        Comment comment = new Comment();
        comment.setCommentPostNo(1);
        comment.setCommentContent("후회없도록");
        comment.setCommentUserId("use04");

        communityService.addComment(comment);
    }

    //@Test
    public void testAddHeart() throws Exception {

        Heart heart = new Heart();
        heart.setHeartTargetP(4);
        heart.setHeartType(1);
        heart.setHeartFlag(0);
        //heart.setHeartUserId("use04");

        communityService.addHeart(heart);
    }

    //@Test
    public void testGetPost() throws Exception {

        Post post = new Post();

        post = communityService.getPost(1);

        Assert.assertEquals("날씨가", post.getPostTitle());
        Assert.assertEquals("춥습니다", post.getPostContent());
    }

    //@Test
    public void testGetComment() throws Exception {

        Comment comment = new Comment();

        comment = communityService.getComment(1);

        Assert.assertEquals("그러네요", comment.getCommentContent());
    }

    //@Test
    public void testGetHeart() throws Exception {

        Heart heart = new Heart();

        heart = communityService.getHeart(1);

        Assert.assertEquals(1, heart.getHeartType());
    }

    //@Test
    public void testUpdatePost() throws Exception {

        Post post = communityService.getPost(1);


        post.setPostTitle("힘들면");
        post.setPostContent("잠시쉬었다해");

        communityService.updatePost(post);

        //communityService.getPost(1);
    }

    //@Test
    public void testUpdateComment() throws Exception {

        Comment comment = communityService.getComment(1);

        comment.setCommentContent("퓨퓨ㅠㅠ");

        communityService.updateComment(comment);

    }

    //@Test
    public void testUpdateHeart() throws Exception {

        Heart heart = communityService.getHeart(1);

        heart.setHeartFlag(0);

        communityService.updateHeart(heart);

    }

    //@Test
    public void testGetPostListAll() throws Exception {
        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(3);
        Map<String, Object> map = communityService.getPostList(search);
        //Assert.assertEquals(3, list.size());

        //==> console 확인
        //System.out.println(list);

        //Integer totalCount = (Integer)map.get("totalCount");
        //System.out.println(totalCount);

        List<Object> list = (List<Object>) map.get("list");

        System.out.println("============================================");

        search.setCurrentPage(1);
        search.setPageSize(3);
        search.setSearchCondition("0");
        search.setSearchKeyword("");
        map = communityService.getPostList(search);

        list = (List<Object>) map.get("list");
        //Assert.assertEquals(3, list.size());

        //==> console 확인
        //System.out.println(list);

        //totalCount = (Integer)map.get("totalCount");
        //System.out.println(totalCount);
    }


    //@Test
    public void testGetCommentList() throws Exception {
        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(3);

        Map<String, Object> map = communityService.getCommentList(search);
        //Assert.assertEquals(3, list.size());

        //==> console 확인
        //System.out.println(list);

        //Integer totalCount = (Integer)map.get("totalCount");
        //System.out.println(totalCount);

        List<Object> list = (List<Object>) map.get("list");

        System.out.println("============================================");

        search.setCurrentPage(1);
        search.setPageSize(3);
        search.setSearchCondition("0");
        search.setSearchKeyword("");
        //map = communityService.getCommentList(search);

        list = (List<Object>) map.get("list");
        //Assert.assertEquals(3, list.size());

        //==> console 확인
        //System.out.println(list);

        //totalCount = (Integer)map.get("totalCount");
        //System.out.println(totalCount);
    }

    //@Test
    public void testGetHeartList() throws Exception {
        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(3);

        Map<String, Object> map = communityService.getHeartList(search);
        //Assert.assertEquals(3, list.size());

        //==> console 확인
        //System.out.println(list);

        //Integer totalCount = (Integer)map.get("totalCount");
        //System.out.println(totalCount);

        List<Object> list = (List<Object>) map.get("list");

        System.out.println("============================================");

        search.setCurrentPage(1);
        search.setPageSize(3);
        search.setSearchCondition("0");
        search.setSearchKeyword("");
        //map = communityService.getCommentList(search);

        list = (List<Object>) map.get("list");
        //Assert.assertEquals(3, list.size());

        //==> console 확인
        //System.out.println(list);

        //totalCount = (Integer)map.get("totalCount");
        //System.out.println(totalCount);
    }
}
