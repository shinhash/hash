package hash.com.board.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import hash.com.board.service.boardService;


@SuppressWarnings({"rawtypes","unchecked"})
@Service("boardService")
public class boardServiceImpl implements boardService {
	
	@Resource(name="boardMapperDao")
	private boardMapperDao boardMapperDao;
	
	@Override
	public List<Map> selectPostList(Map<String, Object> map) throws Exception {
		return boardMapperDao.selectPostList(map);
	}
	
	
	@Override
	public Map selectPost(Map<String, Object> map) throws Exception {
		
		Map<String, Object> selectBoardInfo = new HashMap<String, Object>();
		
		selectBoardInfo.put("selectBoard", boardMapperDao.selectPost(map));
		selectBoardInfo.put("selectRepleList", boardMapperDao.selectRepleList(map));
		
		return selectBoardInfo;
	}

	
	@Override
	public void saveBoardInfo(Map<String, Object> map) throws Exception {
		
	}

}
