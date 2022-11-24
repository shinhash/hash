package hash.com.board.service;

import java.util.List;
import java.util.Map;

@SuppressWarnings("rawtypes")
public interface boardService {
	
	/**
	 * 게시판 목록정보 가져오기
	 * @param map
	 * @return 게시판 목록정보
	 * @throws Exception
	 */
	List<Map> selectBoardList(Map<String, Object> map) throws Exception;
	
	
	/**
	 * 게시물 선택
	 * @param map
	 * @return 게시물 정보
	 * @throws Exception
	 */
	Map selectBoard(Map<String, Object> map) throws Exception;
	
	
	/**
	 * 게시판 정보 저장
	 * @param map
	 * @throws Exception
	 */
	void saveBoardInfo(Map<String, Object> map) throws Exception;
	
}
