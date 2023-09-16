package hash.com.board.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;


import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("boardMapperDao")
public class boardMapperDao extends EgovAbstractMapper{
	
	private static final Logger logger = LoggerFactory.getLogger(boardMapperDao.class);
		
	
	/**
	 * 게시물 목록정보 가져오기
	 * @param map
	 * @return 게시물 목록정보
	 * @throws Exception
	 */
	public List<Map> selectPostList(Map<String, Object> map) throws Exception {
		return selectList("boardMapperDao.selectPostList", map);
	}
	
	
	/**
	 * 게시판 정보 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map selectPostCatalInfo(Map<String, Object> map) throws Exception {
		return selectOne("boardMapperDao.selectPostCatalInfo", map);
	}
	
	
	/**
	 * 페이지 총 개수
	 * @param map
	 * @return
	 */
	public int selectPageTotalCnt(Map<String, Object> map) throws Exception {
		return selectOne("boardMapperDao.selectPageTotalCnt", map);
	}
	
	
	/**
	 * 게시물 선택
	 * @param map
	 * @return 게시물 정보
	 * @throws Exception
	 */
	public Map selectPostInfo(Map<String, Object> map) throws Exception {
		return selectOne("boardMapperDao.selectPostInfo", map);
	}
	
	
	/**
	 * 게시물 댓글 목록정보 가져오기
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map> selectRepleList(Map<String, Object> map) throws Exception {
		return selectList("boardMapperDao.selectRepleList", map);
	}


	/**
	 * 첨부파일 리스트 조회
	 * @param map
	 * @return
	 */
	public List<Map> selectAttachListList(Map<String, Object> map) throws Exception {
		return selectList("boardMapperDao.selectAttachListList", map);
	}
	
	
	/**
	 * 게시물 저장
	 * @param map
	 * @return Integer
	 * @throws Exception
	 */
	public int insertPostInfo(Map<String, Object> map) throws Exception {
		return insert("boardMapperDao.insertPostInfo", map);
	}


	/**
	 * 게시물 삭제
	 * @param map
	 * @throws Exception
	 */
	public void deletePostInfo(Map<String, Object> map) throws Exception {
		delete("boardMapperDao.deletePostInfo", map);
	}


	/**
	 * 게시물 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int updatePostInfo(Map<String, Object> map) throws Exception {
		return update("boardMapperDao.updatePostInfo", map);
	}


	/**
	 * 첨부파일 저장
	 * @param attchInfo
	 */
	public int insertPostAttach(Map<String, Object> attchInfo) throws Exception {
		return insert("boardMapperDao.insertPostAttach", attchInfo);
	}


	/**
	 * 댓글정보 저장
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int insertRepleInfo(Map<String, Object> map) throws Exception {
		return insert("boardMapperDao.insertRepleInfo", map);
	}
	
}
