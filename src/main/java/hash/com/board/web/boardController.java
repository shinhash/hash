package hash.com.board.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import hash.com.board.service.boardService;

@Controller
@SuppressWarnings({"unchecked"})
public class boardController {
	
	private static final Logger logger = LoggerFactory.getLogger(boardController.class);
	
	@Resource(name="boardService")
	private boardService boardService;
	
	
	/**
	 * 게시판 및 게시글 리스트 조회
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/board/bbsCatalList")
	public String bbsCatalogList(HttpServletRequest request, Model model) throws Exception {
		
		Map<String, Object> bbsCatalPostListInfo = boardService.bbsCatalPostListInfo();

		model.addAttribute("bbsCatalList", bbsCatalPostListInfo.get("bbsCatalList"));
		model.addAttribute("postList", bbsCatalPostListInfo.get("postList"));
		return "tiles/board/bbsCatalList";
	}
	
	
	/**
	 * 게시글 리스트 조회
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/board/postListView")
	public String postListView(HttpServletRequest request, Model model) throws Exception {
		
		// pagenation and pageRowCnt info
		int pageViewInfo = request.getParameter("pageViewInfo") == null ? 1 : Integer.parseInt(request.getParameter("pageViewInfo"));
		int pageRowInfo = request.getParameter("pageRowInfo") == null ? 10 :  Integer.parseInt(request.getParameter("pageRowInfo"));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pageViewInfo", pageViewInfo);
		map.put("pageRowInfo", pageRowInfo);
		map.put("bbsCatalId", request.getParameter("bbsCatalId"));
		logger.debug("bbsCatalId = "+request.getParameter("bbsCatalId"));
		
		Map<String, Object> postListInfo = boardService.selectPostList(map);
		
		logger.debug("bbsCatalInfo = "+postListInfo.get("bbsCatalInfo").toString());
		// 게시글 리스트 추출 
		model.addAttribute("postList", postListInfo.get("postList"));
		model.addAttribute("bbsCatalInfo", postListInfo.get("bbsCatalInfo"));
		model.addAttribute("pageTotalCnt", postListInfo.get("pageTotalCnt"));
		model.addAttribute("pageViewInfo", pageViewInfo);
		model.addAttribute("pageRowInfo", pageRowInfo);
		return "tiles/board/postList";
	}
	
	
	/**
	 * 게시글 작성 페이지
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/board/postRegistView")
	public String postRegistView(Model model, HttpServletRequest request) throws Exception {
		model.addAttribute("bbsCatalId", request.getParameter("bbsCatalId"));
		return "tiles/board/postRegistView";
	}
	
	
	/**
	 * 게시글 조회
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/board/postInfoView")
	public String postInfoView(Model model, HttpServletRequest request) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bbsCatalId", request.getParameter("bbsCatalId"));
		map.put("bbsPostId", request.getParameter("bbsPostId"));
		
		Map<String, Object> postRepleAttInfo = boardService.selectPostRepleAttInfo(map);
		
		Map<String, Object> postInfo = (Map<String, Object>) postRepleAttInfo.get("postInfo");
		List<Map<String, Object>> repleList = (List<Map<String, Object>>) postRepleAttInfo.get("repleList");
		List<Map<String, Object>> attachList = (List<Map<String, Object>>) postRepleAttInfo.get("attachList");
		
		// 게시글 리스트 추출
		model.addAttribute("postInfo", postInfo);
		model.addAttribute("repleList", repleList);
		model.addAttribute("attachList", attachList);
		return "tiles/board/postInfoView";
	}
	
	
	/**
	 * 게시글 수정 페이지
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/board/postModifyView")
	public String postModifyView(Model model, HttpServletRequest request) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bbsPostId", request.getParameter("bbsPostId"));
		map.put("bbsCatalId", request.getParameter("bbsCatalId"));
		
		Map<String, Object> postRepleAttInfo = boardService.selectPostRepleAttInfo(map);
		
		Map<String, Object> postInfo = (Map<String, Object>) postRepleAttInfo.get("postInfo");
		List<Map<String, Object>> attachList = (List<Map<String, Object>>) postRepleAttInfo.get("attachList");
		
		// 게시글 리스트 추출
		model.addAttribute("bbsCatalId", map.get("bbsCatalId"));
		model.addAttribute("postInfo", postInfo);
		model.addAttribute("attachList", attachList);
		return "tiles/board/postModifyView";
	}
	
	
	/**
	 * 게시글 작성 저장
	 * @param model
	 * @param request
	 * @param multiPartrequest
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/board/insertPostInfo")
	public String insertPostInfo(Model model, MultipartHttpServletRequest multiPartrequest) throws Exception {
		
		// 게시글 저장 및 첨부파일 저장
		String bbsPostId = boardService.insertPostInfo(multiPartrequest);
		
		// 게시글 저장 성공여부
		model.addAttribute("bbsPostId", bbsPostId);
		return "ajaxJasonView";
	}
	
	
	/**
	 * 게시글 수정 저장
	 * @param model
	 * @param request
	 * @param multiPartrequest
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/board/updatePostInfo")
	public String updatePostInfo(Model model, MultipartHttpServletRequest multiPartrequest) throws Exception {
		
		boardService.updatePostInfo(multiPartrequest);
		return "ajaxJasonView";
	}
	
	
	/**
	 * 게시글 정보 삭제
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/board/deletePostInfo")
	public String deletePostInfo(Model model, HttpServletRequest request) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bbsCatalId", request.getParameter("bbsCatalId"));
		map.put("bbsPostId", request.getParameter("bbsPostId"));
		
		boardService.deletePostInfo(map);
		
		model.addAttribute("bbsCatalId", map.get("bbsCatalId"));
		return "ajaxJasonView";
	}
	
	
	/**
	 * 댓글 저장
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/board/insertPostReple")
	public String insertPostReple(HttpServletRequest request, Model model) throws Exception {
		
		List<Map<String, Object>> postRepleList = boardService.insertPostRepleInfo(request);
		
		model.addAttribute("postRepleList", postRepleList);
		
		return "ajaxJasonView";
	}
	
	
	/**
	 * 댓글 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/board/deletePostReple")
	public String deletePostReple(HttpServletRequest request, Model model) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bbsPostId", request.getParameter("bbsPostId"));
		map.put("bbsRepleId", request.getParameter("bbsRepleId"));
		
		List<Map<String, Object>> postRepleList = boardService.deletePostRepleInfo(map);
		
		model.addAttribute("postRepleList", postRepleList);
		return "ajaxJasonView";
	}
	
	
}
