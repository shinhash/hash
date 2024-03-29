package hash.com.board.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
	 * 게시글 조회수 정보 업데이트
	 * @param map
	 * @param userInfo 
	 * @throws Exception
	 */
	void updateUserPostViewCnt(Map<String, Object> map, Map<String, Object> userInfo) throws Exception;


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


	/**
	 * 첨부파일 다운로드
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	Map<String, Object> postAttachDownload(HttpServletRequest request, HttpServletResponse response) throws Exception;


	
	/**
	 * 추천 기능
	 * @param map
	 * @return
	 * @throws Exception
	 */
	void insertPostSuggest(Map<String, Object> map) throws Exception;

}
