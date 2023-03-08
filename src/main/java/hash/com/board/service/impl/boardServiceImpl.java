package hash.com.board.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import hash.com.board.service.boardService;

@Service("boardService")
public class boardServiceImpl implements boardService {
	
	private static final Logger logger = LoggerFactory.getLogger(boardServiceImpl.class);
	
	@Resource(name="boardMapperDao")
	private boardMapperDao boardMapperDao;
	
	@Override
	public List<Map> selectPostList(Map<String, Object> map) throws Exception {
		return boardMapperDao.selectPostList(map);
	}
	

	@Override
	public String saveBoardInfo(Map<String, Object> map, MultipartHttpServletRequest multiPartrequest) throws Exception {
		
		int saveRst = 0;
		int updatePostInfoRst = 0;
		
			try {
				saveRst = boardMapperDao.insertPostInfo(map);
				updatePostInfoRst = boardMapperDao.updatePostInfo(map);
			} catch (Exception e) {
				e.printStackTrace();
				throw new Exception();
			}
			return (String) map.get("bbsPostId");
	}


	@Override
	public Map selectPostRepleInfo(Map<String, Object> map) throws Exception {
		
		Map<String, Object> selectPostRepleInfo = new HashMap<String, Object>();
		selectPostRepleInfo.put("postInfo", boardMapperDao.selectPostInfo(map));
		selectPostRepleInfo.put("repleList", boardMapperDao.selectRepleList(map));
		
		return selectPostRepleInfo;
	}


	@Override
	public int updatePostInfo(Map<String, Object> map, MultipartHttpServletRequest multiPartrequest) throws Exception {
		
		int multiPartRst = 0;
//		List<MultipartFile> mfList = multiPartrequest.getFiles("bbsPostContent");
//		
//		if(mfList.get(0).getSize() != 0 && !mfList.get(0).getOriginalFilename().equals("")){
//			for(MultipartFile mfile : mfList) {
//				String fileOriginalName = mfile.getOriginalFilename();
//				String contentId = UUID.randomUUID().toString();
//				
//				logger.debug("file = "+mfile);
//				
//				String saveFileName = contentId + ".jpg";
//				String saveFilePath = "C:\\eGovFrameDev-3.8.0-64bit\\fileTemp\\" + saveFileName;
//				try {
//					mfile.transferTo(new File(saveFilePath));
//				}catch(Exception e) {
//					e.printStackTrace();
//				}
//			}
//		}
		int updatePostInfoRst = 0;
		updatePostInfoRst = boardMapperDao.updatePostInfo(map);
		
		int updateRst = 0;
		if(multiPartRst != 0 && updatePostInfoRst != 0) {
			updateRst = 1;
		}
		
		return updateRst;
	}

}
