package hash.com.board.service.impl;

import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
	 * 게시판 및 게시글 목록 조회
	 */
	@Override
	public Map<String, Object> bbsCatalPostListInfo() throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pageNumInfo", "1");
		map.put("pageRowInfo", "5");
		
		Map<String, Object> bbsCatalPostListInfo = new HashMap<String, Object>();
		
		List<Map<String, Object>> postList = null;

		// 게시판 리스트 조회
		List<Map<String, Object>> bbsCatalList = boardMapperDao.selectPostCatalInfo(map);
		
		if(bbsCatalList.size() > 0) {
			postList = new ArrayList<Map<String,Object>>();
			
			// 게시판 리스트 만큼 게시글 리스트 조회
			for(Map<String, Object> catalMap : bbsCatalList) {
				map.put("bbsCatalId", catalMap.get("bbsCatalId"));
				
				// 게시글 리스트 조회
				List<Map<String, Object>> addPostList = boardMapperDao.selectPostList(map);
				if(addPostList.size() > 0) {
					
					// 게시글 정보 List<Map> 에 put
					for(Map<String, Object> postInfo : addPostList) {
						postList.add(postInfo);
					}
				}
			}
		}
		
		bbsCatalPostListInfo.put("bbsCatalList", bbsCatalList);
		bbsCatalPostListInfo.put("postList", postList);
		return bbsCatalPostListInfo;
	}
	
	
	/**
	 * 게시글 목록 조회
	 */
	@Override
	public Map<String, Object> selectPostList(Map<String, Object> map) throws Exception {
		Map<String, Object> postListInfo = new HashMap<String, Object>();
		postListInfo.put("postList", boardMapperDao.selectPostList(map));
		
		Map<String, Object> bbsCatalInfo = new HashMap<String, Object>();
		bbsCatalInfo.put("bbsCatalId", "ALL");
		bbsCatalInfo.put("bbsCatalNm", "전체보기");
		if(!map.get("bbsCatalId").equals("ALL")) {
			bbsCatalInfo = boardMapperDao.selectPostCatalInfo(map).get(0);
		}
		postListInfo.put("bbsCatalInfo", bbsCatalInfo);
		
		postListInfo.put("pageTotalCnt", boardMapperDao.selectPageTotalCnt(map));
		return postListInfo;
	}
	
	
	/**
	 * 게시글 조회수 정보 업데이트
	 */
	@Override
	public void updateUserPostViewCnt(Map<String, Object> map, Map<String, Object> userInfo) throws Exception {
		Map<String, Object> userPostViewInfo = new HashMap<String, Object>();
		userPostViewInfo.put("bbsPostId", map.get("bbsPostId"));
		userPostViewInfo.put("userId", userInfo.get("userId").toString());
		int userPostViewCnt = boardMapperDao.selectPostViewCnt(userPostViewInfo);
		if(userPostViewCnt == 0) {
			boardMapperDao.insertUserPostView(userPostViewInfo);
		}
	}
	
	
	/**
	 * 게시글, 댓글, 첨부파일 정보 조회
	 */
	@Override
	public Map<String, Object> selectPostRepleAttInfo(Map<String, Object> map) throws Exception {
		
		Map<String, Object> selectPostRepleAttInfo = new HashMap<String, Object>();
		selectPostRepleAttInfo.put("postInfo", boardMapperDao.selectPostInfo(map));
		selectPostRepleAttInfo.put("repleList", boardMapperDao.selectRepleList(map));
		selectPostRepleAttInfo.put("attachList", boardMapperDao.selectAttachListList(map));
		selectPostRepleAttInfo.put("postViewCnt", boardMapperDao.selectPostViewCnt(map));
		selectPostRepleAttInfo.put("postSuggest", boardMapperDao.selectPostSuggest(map));
		
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
		
		// 첨부파일 삭제
		String mfRemoveAttachStr = multiPartrequest.getParameter("removeFileInfo");
		if(mfRemoveAttachStr != null && !mfRemoveAttachStr.equals("")) {
			String[] mfRemoveAttachArr = mfRemoveAttachStr.split(",");
			logger.debug("mfRemoveAttachStr = "+mfRemoveAttachStr);
			if(mfRemoveAttachArr != null && mfRemoveAttachArr.length > 0 && !mfRemoveAttachStr.equals("")) {
				for(String mfRemoveAttachId : mfRemoveAttachArr) {
					Map<String, Object> fileMap = new HashMap<String, Object>();
					fileMap.put("bbsPostId", map.get("bbsPostId"));
					fileMap.put("bbsAttachId", mfRemoveAttachId);
					String removeAttachLoc = (String) (boardMapperDao.selectAttachListList(fileMap)).get(0).get("bbsAttachLoc");
					
					File rmFile = new File(removeAttachLoc);
					if(rmFile.exists()) {
						rmFile.delete();
					}
					boardMapperDao.deleteAttachInfo(fileMap);
				}
			}
		}
		
		
		// 첨부파일 저장
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
					File file = new File(saveFilePath);
					mfile.transferTo(file);
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
	 * 첨부파일 다운로드
	 */
	@Override
	public Map<String, Object> postAttachDownload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bbsPostId", request.getParameter("bbsPostId"));
		map.put("bbsAttachId", request.getParameter("bbsAttachId"));
		
		return boardMapperDao.selectPostAttach(map);
	}

	
	/**
	 * 댓글 저장
	 */
	@Override
	public List<Map<String, Object>> insertPostRepleInfo(HttpServletRequest request) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bbsPostId", request.getParameter("bbsPostId"));
		map.put("bbsCatalId", request.getParameter("bbsCatalId"));
		map.put("bbsRepleRegId", request.getParameter("bbsRepleRegId"));
		map.put("bbsRepleContent", request.getParameter("bbsRepleContent"));
		
		List<Map<String, Object>> saveRepleInfoAndSelectRepleInfo = new ArrayList<Map<String, Object>>();
		
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


	
	/**
	 * 댓글 삭제
	 */
	@Override
	public List<Map<String, Object>> deletePostRepleInfo(Map<String, Object> map) throws Exception {
		
		List<Map<String, Object>> delteRepleInfoAndSelectRepleInfo = new ArrayList<Map<String, Object>>();
		
		try {
			// 댓글 삭제
			boardMapperDao.deletePostRepleInfo(map);
			// 댓글 목록 조회
			delteRepleInfoAndSelectRepleInfo = boardMapperDao.selectRepleList(map);
		}catch(Exception e) {
			e.printStackTrace();
			throw new Exception();
		}
		
		return delteRepleInfoAndSelectRepleInfo;
	}


	/**
	 * 추천 기능
	 */
	@Override
	public void insertPostSuggest(Map<String, Object> map) throws Exception {
		
		try {
			// 추천 기능
			boardMapperDao.insertPostSuggest(map);
		}catch(Exception e) {
			e.printStackTrace();
			throw new Exception();
		}
	}

}
