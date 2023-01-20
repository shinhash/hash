package hash.com.board.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
}
