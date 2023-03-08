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
	
	
	@RequestMapping(value="/board/postList")
	public String postList(HttpSession session, Model model) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 게시글 리스트 추출
		model.addAttribute("postList", boardService.selectPostList(map));
		return "board/postList";
	}
	
	 
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
		return "board/postInfoView";
	}
	
	
	
	@RequestMapping(value="/board/postRegistView")
	public String postRegistView(HttpSession session, Model model) throws Exception {
		return "board/postRegistView";
	}
	
	
	
	
	@RequestMapping(value="/board/postInfoRegist")
	public String postInfoRegist(HttpSession session, Model model, HttpServletRequest request, MultipartHttpServletRequest multiPartrequest) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		logger.debug("bbsPostTitle = "+request.getParameter("bbsPostTitle"));
		
		map.put("bbsPostTitle", request.getParameter("bbsPostTitle"));
		map.put("bbsPostContent", request.getParameter("bbsPostContent"));
		
		String bbsPostId = boardService.saveBoardInfo(map, multiPartrequest);
		
		// 게시글 리스트 추출
		model.addAttribute("bbsPostId", bbsPostId);
		return "redirect:/board/postInfoView";
	}
	
	
	@RequestMapping(value="/board/postModifyView")
	public String postModifyView(HttpSession session, Model model, HttpServletRequest request) throws Exception {
		
		String bbsPostId = request.getParameter("bbsPostId");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bbsPostId", bbsPostId);
		
		Map<String, Object> postInfo = (Map<String, Object>) boardService.selectPostRepleInfo(map).get("postInfo");
		
		// 게시글 리스트 추출
		model.addAttribute("postInfo", postInfo);
		return "board/postModifyView";
	}
	
	
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
