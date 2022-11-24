package hash.com.board.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import hash.com.board.service.boardService;


@SuppressWarnings("rawtypes")
@Service("boardService")
public class boardServiceImpl implements boardService {
	
	@Resource(name="boardMapperDao")
	private boardMapperDao boardMapperDao;
	
	@Override
	public List<Map> selectBoardList(Map<String, Object> map) throws Exception {
		return boardMapperDao.selectBoardList(map);
	}
	
	
	@Override
	public Map selectBoard(Map<String, Object> map) throws Exception {
		return boardMapperDao.selectBoard(map);
	}

	
	@Override
	public void saveBoardInfo(Map<String, Object> map) throws Exception {
		
	}

}
