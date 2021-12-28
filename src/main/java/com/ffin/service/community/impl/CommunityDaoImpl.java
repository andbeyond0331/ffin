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

import java.util.List;

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
    public List<Comment> getCommentList(Search search) throws Exception {
        return sqlSession.selectList("CommentMapper.getCommentList", search);
    }

    // 댓글 수정
    @Override
    public void updateComment(Comment comment) throws Exception {
        sqlSession.update("CommentMapper.updateComment", comment);
    }

    // 좋아요 누르기
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
    }

    // 게시판 Page 처리를 위한 전체Row(totalCount)  return
    @Override
    public int getTotalCount(Search search) throws Exception {
        return sqlSession.selectOne("CommunityMapper.getTotalCount", search);
    }
}
