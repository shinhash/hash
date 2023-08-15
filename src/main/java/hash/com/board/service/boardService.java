package hash.com.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface boardService {
	
	/**
	 * 게시판 목록정보 가져오기
	 * @param map
	 * @return 게시판 목록정보
	 * @throws Exception
	 */
	Map<String, Object> selectPostList(Map<String, Object> map) throws Exception;
	
	
	/**
	 * 게시판 정보 저장
	 * @param map
	 * @param multiPartrequest 
	 * @return Integer
	 * @throws Exception
	 */
	String saveBoardInfo(Map<String, Object> map, MultipartHttpServletRequest multiPartrequest) throws Exception;


	/**
	 * 게시글 정보 가져오기
	 * @param map
	 * @return 게시글 정보
	 * @throws Exception
	 */
	Map selectPostRepleInfo(Map<String, Object> map) throws Exception;


	/**
	 * 게시글 수정 정보 저장
	 * @param map
	 * @param multiPartrequest 
	 * @return 게시글 수정
	 * @throws Exception
	 */
	int updatePostInfo(Map<String, Object> map, MultipartHttpServletRequest multiPartrequest) throws Exception;
	
}
