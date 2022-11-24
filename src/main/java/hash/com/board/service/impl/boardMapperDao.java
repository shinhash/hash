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
	public List<Map> selectBoardList(Map<String, Object> map) throws Exception {
		return null;
	}
	
	
	/**
	 * 게시물 선택
	 * @param map
	 * @return 게시물 정보
	 * @throws Exception
	 */
	public Map selectBoard(Map<String, Object> map) throws Exception {
		return null;
	}
	
	
	/**
	 * 게시물 저장
	 * @param map
	 * @throws Exception
	 */
	public void insertBoardInfo(Map<String, Object> map) throws Exception {
		
	}
	
	
	/**
	 * 게시물 수정
	 * @param map
	 * @throws Exception
	 */
	public void updateBoardInfo(Map<String, Object> map) throws Exception {
		
	}

	
	/**
	 * 게시물 삭제
	 * @param map
	 * @throws Exception
	 */
	public void deleteBoardInfo(Map<String, Object> map) throws Exception {
		
	}
	
}
