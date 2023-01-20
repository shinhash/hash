package hash.com.board.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;


@SuppressWarnings("rawtypes")
@Repository("boardMapperDao")
public class boardMapperDao {
	
	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;
	
	/**
	 * 게시물 목록정보 가져오기
	 * @param map
	 * @return 게시물 목록정보
	 * @throws Exception
	 */
	public List<Map> selectPostList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("boardMapperDao.selectPostList", map);
	}
	
	
	/**
	 * 게시물 선택
	 * @param map
	 * @return 게시물 정보
	 * @throws Exception
	 */
	public Map selectPost(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("boardMapperDao.selectPost", map);
	}
	
	
	/**
	 * 게시물 댓글 목록정보 가져오기
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map> selectRepleList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("boardMapperDao.selectRepleList", map);
	}
	
	
	/**
	 * 게시물 저장
	 * @param map
	 * @throws Exception
	 */
	public void insertPostInfo(Map<String, Object> map) throws Exception {
		sqlSession.insert("boardMapperDao.insertPostInfo", map);
	}
	
	
	/**
	 * 게시물 수정
	 * @param map
	 * @throws Exception
	 */
	public void updatePostInfo(Map<String, Object> map) throws Exception {
		sqlSession.update("boardMapperDao.updatePostInfo", map);
	}

	
	/**
	 * 게시물 삭제
	 * @param map
	 * @throws Exception
	 */
	public void deletePostInfo(Map<String, Object> map) throws Exception {
		sqlSession.delete("boardMapperDao.deletePostInfo", map);
	}
	
}
