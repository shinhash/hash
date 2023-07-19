package hash.com.sign.web;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import hash.com.sign.service.signService;



@Controller
@SuppressWarnings({"unchecked","rawtypes"})
public class signController {
	
	private static final Logger logger = LoggerFactory.getLogger(signController.class);
	
	@Resource(name="signService")
	private signService signService;
	
	@RequestMapping(value="/sign/loginPage")
	public String signloginPage(HttpSession session, Model model, HttpServletRequest request) throws Exception {
		
		Map<String, Object> flashMap = (Map<String, Object>) RequestContextUtils.getInputFlashMap(request);
		String isError = "";
		if(flashMap != null && flashMap.get("errorRst") != null) {
			isError = (String) flashMap.get("errorRst");
		}
		model.addAttribute("errorRst", isError);
		return "/sign/loginPage";
	}
	
	
	@RequestMapping(value="/sign/loginCheck")
	public String loginCheck(HttpSession session, Model model, HttpServletRequest request, RedirectAttributes rs) throws Exception {
		
		String inputUserId = request.getParameter("inputUserId");
		String inputUserPw = request.getParameter("inputUserPw");
		logger.debug(inputUserId);
		
		String resultInfo = "";
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", inputUserId);
		
		List<Map> signInfoList = (List<Map>) signService.loginCheck(map);
		if(signInfoList != null && signInfoList.size() > 0) {
			for(Map<String, Object> userInfo : signInfoList) {
				logger.debug(userInfo.toString());
				if(inputUserPw.equals(userInfo.get("userPw"))) {
					// session에 user정보 저장 후 메인페이지로 이동
					resultInfo = "/main/mainpage";
				}else {
					String errorRst = "입력하신 비밀번호가 일치하지 않습니다.";
					rs.addFlashAttribute("errorRst", errorRst);
					resultInfo = "redirect:/sign/loginPage";
				}
			}
		}else {
			String errorRst = "입력하신 ID는 없는 정보입니다.";
			rs.addFlashAttribute("errorRst", errorRst);
			resultInfo = "redirect:/sign/loginPage";
		}
		return resultInfo;
	}
	
	@RequestMapping(value="/sign/signUpPage")
	public String signUpPage(HttpSession session, Model model) throws Exception {
		return "/sign/signUpPage";
	}
	
	@RequestMapping(value="/sign/singUpIdChk")
	public String singUpIdChk(HttpSession session, Model model, HttpServletRequest request) throws Exception {
		
		String userId = request.getParameter("inputId");
		boolean isAleadyUsed = false;
		logger.debug("input userId = "+userId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		int signUpIdChk = signService.singUpIdChk(map);
		logger.debug("signUpIdChk = "+signUpIdChk);
		if(signUpIdChk > 0) {
			isAleadyUsed = true;
		}
		model.addAttribute("isAleadyUsed", isAleadyUsed);
		
		return "jsonView";
	}
	
	
	@RequestMapping(value="/sign/singUpProcess")
	public String singUpProcess(HttpSession session, Model model, HttpServletRequest request) throws Exception {
		
		String userId = request.getParameter("inputUserId");
		String userPw = request.getParameter("inputUserPw");
		String userNm = request.getParameter("inputUserNm");
		String userBirth = request.getParameter("inputUserBirth");
		String userMail = request.getParameter("inputUserMail");
		String userPhone = request.getParameter("inputUserPhone");
		String userAddr = request.getParameter("inputUserAddr1");
		String userAddrDetail = request.getParameter("inputUserAddr2");
		String zipCode = request.getParameter("inputUserZipcode");
		
		return "redirect:/main/mainpage";
	}

}
