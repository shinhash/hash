package hash.com.board.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import hash.com.board.service.boardService;

@Service("boardService")
public class boardServiceImpl implements boardService {
	
	private static final Logger logger = LoggerFactory.getLogger(boardServiceImpl.class);
	final static String POST_FILE_SAVE_PATH = "E:\\my_dev\\springToolsSuite3\\attachFiles\\bbs\\normal\\";
	
	@Resource(name="boardMapperDao")
	private boardMapperDao boardMapperDao;
	
	
	/**
	 * 게시글 목록 조회
	 */
	@Override
	public Map<String, Object> selectPostList(Map<String, Object> map) throws Exception {
		
		Map<String, Object> postListInfo = new HashMap<String, Object>();
		postListInfo.put("postList", boardMapperDao.selectPostList(map));
		postListInfo.put("bbsCatalInfo", boardMapperDao.selectPostCatalInfo(map));
		postListInfo.put("pageTotalCnt", boardMapperDao.selectPageTotalCnt(map));
		return postListInfo;
	}
	
	
	/**
	 * 게시글, 댓글, 첨부파일 정보 조회
	 */
	@Override
	public Map selectPostRepleAttInfo(Map<String, Object> map) throws Exception {
		
		Map<String, Object> selectPostRepleAttInfo = new HashMap<String, Object>();
		selectPostRepleAttInfo.put("postInfo", boardMapperDao.selectPostInfo(map));
		selectPostRepleAttInfo.put("repleList", boardMapperDao.selectRepleList(map));
		selectPostRepleAttInfo.put("attachList", boardMapperDao.selectAttachListList(map));
		
		return selectPostRepleAttInfo;
	}
	

	/**
	 * 게시글 정보 저장
	 */
	@Override
	public String insertPostInfo(MultipartHttpServletRequest multiPartrequest) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bbsCatalId", multiPartrequest.getParameter("bbsCatalId"));
		map.put("bbsPostTitle", multiPartrequest.getParameter("bbsPostTitle"));
		map.put("bbsPostContent", multiPartrequest.getParameter("bbsPostContent"));
		map.put("bbsPostRegId", multiPartrequest.getParameter("bbsPostRegId"));
		
		try {
			// 게시글 작성
			boardMapperDao.insertPostInfo(map);
			boardMapperDao.updatePostInfo(map);
			
			// 첨부파일 저장 및 DB등록
			saveBbsPostAttach(multiPartrequest, map);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception();
		}
		return (String) map.get("bbsPostId");
	}


	/**
	 * 게시글 정보 수정
	 */
	@Override
	public int updatePostInfo(MultipartHttpServletRequest multiPartrequest) throws Exception {
		int updatePostInfoRst = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("bbsCatalId", multiPartrequest.getParameter("bbsCatalId"));
		map.put("bbsPostId", multiPartrequest.getParameter("bbsPostId"));
		map.put("bbsPostTitle", multiPartrequest.getParameter("bbsPostTitle"));
		map.put("bbsPostContent", multiPartrequest.getParameter("bbsPostContent"));
		map.put("bbsPostRegId", multiPartrequest.getParameter("bbsPostRegId"));
		
		try {
			// 게시글 수정
			updatePostInfoRst = boardMapperDao.updatePostInfo(map);
			
			// 첨부파일 저장 및 DB등록
			saveBbsPostAttach(multiPartrequest, map);
			
		}catch(Exception e) {
			e.printStackTrace();
			throw new Exception();
		}
		return updatePostInfoRst;
	}
	
	
	/**
	 * 게시글 정보 삭제
	 */
	@Override
	public void deletePostInfo(Map<String, Object> map) throws Exception {
		try {
			boardMapperDao.deletePostInfo(map);
		}catch(Exception e) {
			e.printStackTrace();
			throw new Exception();
		}
	}
	
	
	/**
	 * 첨부파일 저장 및 DB등록
	 * @param multiPartrequest
	 * @param map
	 * @throws Exception
	 */
	public void saveBbsPostAttach(MultipartHttpServletRequest multiPartrequest, Map<String, Object> map) throws Exception {
		List<MultipartFile> mfList = multiPartrequest.getFiles("bbsPostAttchInfo");
		Map<String, Object> attchInfo = null;
		
		if(mfList.get(0).getSize() != 0 && !mfList.get(0).getOriginalFilename().equals("")){
			for(MultipartFile mfile : mfList) {
				String fileOriginalName = mfile.getOriginalFilename();
				String contentId = UUID.randomUUID().toString();
				String fileExt = fileOriginalName.substring(fileOriginalName.lastIndexOf(".")+1);
				
				String saveFileName = contentId + "." + fileExt;
				String saveFilePath = POST_FILE_SAVE_PATH + saveFileName;
				try {
					mfile.transferTo(new File(saveFilePath));
				}catch(Exception e) {
					e.printStackTrace();
				}
				
				// 첨부파일 정보 DB저장
				attchInfo = new HashMap<String, Object>();
				attchInfo.put("bbsCatalId", map.get("bbsCatalId"));
				attchInfo.put("bbsPostId", map.get("bbsPostId"));
				attchInfo.put("bbsAttachLoc", saveFilePath);
				attchInfo.put("bbsAttachSaveNm", saveFileName);
				attchInfo.put("bbsAttachOriginNm", fileOriginalName);
				attchInfo.put("bbsPostRegId", map.get("bbsPostRegId"));
				boardMapperDao.insertPostAttach(attchInfo);
			}
		}
	}

	
	/**
	 * 댓글 저장
	 */
	@Override
	public List<Map> insertPostRepleInfo(HttpServletRequest request) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bbsPostId", request.getParameter("bbsPostId"));
		map.put("bbsCatalId", request.getParameter("bbsCatalId"));
		map.put("bbsRepleRegId", request.getParameter("bbsRepleRegId"));
		map.put("bbsRepleContent", request.getParameter("bbsRepleContent"));
		
		List<Map> saveRepleInfoAndSelectRepleInfo = new ArrayList<Map>();
		
		try {
			// 댓글 저장
			boardMapperDao.insertRepleInfo(map);
			// 댓글 목록 조회
			saveRepleInfoAndSelectRepleInfo = boardMapperDao.selectRepleList(map);
		}catch(Exception e) {
			e.printStackTrace();
			throw new Exception();
		}
		
		return saveRepleInfoAndSelectRepleInfo;
	}
	
}
