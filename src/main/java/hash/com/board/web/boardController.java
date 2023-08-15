package hash.com.board.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import hash.com.board.service.boardService;


@Controller
public class boardController {
	
	private static final Logger logger = LoggerFactory.getLogger(boardController.class);
	
	@Resource(name="boardService")
	private boardService boardService;
	
	/**
	 * 게시글 리스트 조회
	 * @param request
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/board/postList")
	public String postList(HttpServletRequest request, HttpSession session, Model model) throws Exception {
		
		// pagenation and pageRowCnt info
		String pageViewInfo = request.getParameter("pageViewInfo") == null ? "1" : request.getParameter("pageViewInfo");
		String pageRowInfo = request.getParameter("pageRowInfo") == null ? "10" : request.getParameter("pageRowInfo");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pageViewInfo", pageViewInfo);
		map.put("pageRowInfo", pageRowInfo);
		
		// 게시글 리스트 추출 
		model.addAttribute("postList", boardService.selectPostList(map).get("postList"));
		model.addAttribute("pageTotalCnt", boardService.selectPostList(map).get("pageTotalCnt"));
		model.addAttribute("pageViewInfo", pageViewInfo);
		model.addAttribute("pageRowInfo", pageRowInfo);
		return "tiles/board/postList";
	}
	
	
	/**
	 * 게시글 조회
	 * @param session
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/board/postInfoView")
	public String postInfoView(HttpSession session, Model model, HttpServletRequest request) throws Exception {
		
		String bbsPostId = request.getParameter("bbsPostId");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bbsPostId", bbsPostId);
		
		Map<String, Object> postInfo = (Map<String, Object>) boardService.selectPostRepleInfo(map).get("postInfo");
		List<Map> RepleList = (List<Map>) boardService.selectPostRepleInfo(map).get("repleList");
		
//		logger.debug("bbsPostId = "+(String) postInfo.get("bbsPostId"));
//		logger.debug("bbsPostTitle = "+(String) postInfo.get("bbsPostTitle"));
//		logger.debug("bbsPostContent = "+(String) postInfo.get("bbsPostContent"));
		
		// 게시글 리스트 추출
		model.addAttribute("postInfo", postInfo);
		model.addAttribute("RepleList", RepleList);
		return "tiles/board/postInfoView";
	}
	
	
	/**
	 * 게시글 작성 페이지
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/board/postRegistView")
	public String postRegistView(HttpSession session, Model model) throws Exception {
		return "tiles/board/postRegistView";
	}
	
	
	/**
	 * 게시글 작성 저장
	 * @param session
	 * @param model
	 * @param request
	 * @param multiPartrequest
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/board/postInfoRegist")
	public String postInfoRegist(HttpSession session, Model model, MultipartHttpServletRequest multiPartrequest) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		logger.debug("bbsPostTitle = "+multiPartrequest.getParameter("bbsPostTitle"));
		
		map.put("bbsPostTitle", multiPartrequest.getParameter("bbsPostTitle"));
		map.put("bbsPostContent", multiPartrequest.getParameter("bbsPostContent"));
		
		// 게시글 저장 및 첨부파일 저장
		String bbsPostId = boardService.saveBoardInfo(map, multiPartrequest);
		
		// 게시글 저장 성공여부
		model.addAttribute("bbsPostId", bbsPostId);
		return "ajaxJasonView";
	}
	
	
	/**
	 * 게시글 수정 페이지
	 * @param session
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/board/postModifyView")
	public String postModifyView(HttpSession session, Model model, HttpServletRequest request) throws Exception {
		
		String bbsPostId = request.getParameter("bbsPostId");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bbsPostId", bbsPostId);
		
		Map<String, Object> postInfo = (Map<String, Object>) boardService.selectPostRepleInfo(map).get("postInfo");
		
		// 게시글 리스트 추출
		model.addAttribute("postInfo", postInfo);
		return "tiles/board/postModifyView";
	}
	
	
	/**
	 * 게시글 수정 저장
	 * @param session
	 * @param model
	 * @param request
	 * @param multiPartrequest
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/board/postModiEdit")
	public String postModiEdit(	HttpSession session, Model model, HttpServletRequest request, MultipartHttpServletRequest multiPartrequest) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		String bbsPostId = request.getParameter("bbsPostId");
		String bbsPostTitle = request.getParameter("bbsPostTitle");
		String bbsPostContent = request.getParameter("bbsPostContent");
		
		map.put("bbsPostId", bbsPostId);
		map.put("bbsPostTitle", bbsPostTitle);
		map.put("bbsPostContent", bbsPostContent);
		
		logger.debug("bbsPostContent = "+bbsPostContent);
		
		
		int modiEditRst = boardService.updatePostInfo(map, multiPartrequest);
		
		// 게시글 리스트 추출
		model.addAttribute("bbsPostId", bbsPostId);
		return "redirect:/board/postInfoView";
	}
	
	
}
