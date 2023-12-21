package hash.com.board.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("boardMapperDao")
public class boardMapperDao extends EgovAbstractMapper{
	
	
	/**
	 * 게시글 목록정보 가져오기
	 * @param map
	 * @return 게시물 목록정보
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectPostList(Map<String, Object> map) throws Exception {
		return selectList("boardMapperDao.selectPostList", map);
	}
	
	
	/**
	 * 게시판 정보 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectPostCatalInfo(Map<String, Object> map) throws Exception {
		return selectList("boardMapperDao.selectPostCatalInfo", map);
	}
	
	
	/**
	 * 페이지 총 개수
	 * @param map
	 * @return
	 * @throws Exception
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
	public Map<String, Object> selectPostInfo(Map<String, Object> map) throws Exception {
		return selectOne("boardMapperDao.selectPostInfo", map);
	}
	
	
	/**
	 * 게시물 댓글 목록정보 가져오기
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectRepleList(Map<String, Object> map) throws Exception {
		return selectList("boardMapperDao.selectRepleList", map);
	}


	/**
	 * 첨부파일 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectAttachListList(Map<String, Object> map) throws Exception {
		return selectList("boardMapperDao.selectAttachListList", map);
	}
	
	
	/**
	 * 게시글 조회수 정보 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectPostViewCnt(Map<String, Object> map) throws Exception {
		return selectOne("boardMapperDao.selectUserPostViewCnt", map);
	}
	
	
	/**
	 * 게시글 추천 정보 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectPostSuggest(Map<String, Object> map) throws Exception {
		return selectOne("boardMapperDao.selectPostSuggest", map);
	}
	
	
	/**
	 * 게시글 조회수 정보 저장
	 * @param map
	 * @throws Exception
	 */
	public void insertUserPostView(Map<String, Object> map) throws Exception {
		insert("boardMapperDao.insertUserPostView", map);
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
		update("boardMapperDao.deletePostInfo", map);
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
	 * @return
	 * @throws Exception
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


	/**
	 * 댓글정보 삭제
	 * @param map
	 * @throws Exception
	 */
	public void deletePostRepleInfo(Map<String, Object> map) throws Exception {
		update("boardMapperDao.deletePostRepleInfo", map);
	}


	/**
	 * 첨부파일 정보 조회
	 * @param fileMap
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectPostAttach(Map<String, Object> fileMap) throws Exception {
		return selectOne("boardMapperDao.selectPostAttach", fileMap);
	}


	/**
	 * 첨부파일 데이터 삭제
	 * @param fileMap
	 * @throws Exception
	 */
	public void deleteAttachInfo(Map<String, Object> fileMap) throws Exception {
		delete("boardMapperDao.deleteAttachInfo", fileMap);
	}


	/**
	 * 추천 클릭
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int insertPostSuggest(Map<String, Object> map) throws Exception {
		return insert("boardMapperDao.insertPostSuggest", map);
	}

	
}
