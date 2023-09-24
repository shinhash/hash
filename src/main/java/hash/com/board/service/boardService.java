package hash.com.board.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface boardService {
	
	/**
	 * 게시판 목록정보 가져오기
	 * @param map
	 * @return
	 * @throws Exception
	 */
	Map<String, Object> bbsCatalPostListInfo() throws Exception;
	
	
	/**
	 * 게시글 목록정보 가져오기
	 * @param map
	 * @return 게시판 목록정보
	 * @throws Exception
	 */
	Map<String, Object> selectPostList(Map<String, Object> map) throws Exception;
	
	
	/**
	 * 게시글 정보 저장
	 * @param map
	 * @param multiPartrequest 
	 * @return Integer
	 * @throws Exception
	 */
	String insertPostInfo(MultipartHttpServletRequest multiPartrequest) throws Exception;


	/**
	 * 게시글 정보 가져오기
	 * @param map
	 * @return 게시글 정보
	 * @throws Exception
	 */
	Map<String, Object> selectPostRepleAttInfo(Map<String, Object> map) throws Exception;


	/**
	 * 게시글 수정 정보 저장
	 * @param multiPartrequest 
	 * @return 게시글 수정
	 * @throws Exception
	 */
	int updatePostInfo(MultipartHttpServletRequest multiPartrequest) throws Exception;


	/**
	 * 게시글 정보 삭제
	 * @param map
	 * @throws Exception
	 */
	void deletePostInfo(Map<String, Object> map) throws Exception;
	
	
	/**
	 * 댓글 정보저장
	 * @param map
	 * @return
	 * @throws Exception
	 */
	List<Map<String, Object>> insertPostRepleInfo(HttpServletRequest request) throws Exception;

	
	/**
	 * 댓글 정보삭제
	 * @param map
	 * @throws Exception
	 */
	List<Map<String, Object>> deletePostRepleInfo(Map<String, Object> map) throws Exception;


}
