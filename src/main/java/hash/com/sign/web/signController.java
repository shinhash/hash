package hash.com.sign.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.RandomStringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import hash.com.sign.service.signService;

@Controller
@SuppressWarnings({"unchecked","rawtypes"})
public class signController {
	
	private static final Logger logger = LoggerFactory.getLogger(signController.class);
	
	@Resource(name="signService")
	private signService signService;
	
	/**
	 * 로그인 페이지로 이동
	 * @param session
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sign/signInPage")
	public String signInloginPage(HttpSession session, Model model, HttpServletRequest request) throws Exception {
		
		// FlashMap으로 RedirectAttributes을 통해 받은 로그인 오류관련 정보를 가져온다.
		Map<String, Object> flashMap = (Map<String, Object>) RequestContextUtils.getInputFlashMap(request);
		String isError = "";
		if(flashMap != null && flashMap.get("errorRst") != null) {
			isError = (String) flashMap.get("errorRst");
		}
		model.addAttribute("errorRst", isError);
		return "/sign/signInPage";
	}
	
	/**
	 * 로그인 프로세스
	 * @param session
	 * @param model
	 * @param request
	 * @param rs
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sign/signInCheck")
	public String signInCheck(HttpSession session, Model model, HttpServletRequest request, RedirectAttributes rs) throws Exception {
		
		String inputUserId = request.getParameter("inputUserId");
		String inputUserPw = request.getParameter("inputUserPw");
//		logger.debug(inputUserId);
		
		String resultInfo = "";
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", inputUserId);
		
		ServletContext application = request.getServletContext();
		List<Map> userList = (List<Map>) application.getAttribute("userList");
		
		List<Map<String, Object>> signInfoList = signService.loginCheck(map);
		if(signInfoList != null && signInfoList.size() > 0) {
			for(Map<String, Object> userInfo : signInfoList) {
//				logger.debug(userInfo.toString());
				if(inputUserPw.equals(userInfo.get("userPw"))) {
					
					// session에 user정보 저장 후 메인페이지로 이동
					String ipInfo = getIpInfo();
					userInfo.put("login_ip", ipInfo);
//					logger.debug("userInfo = " + userInfo);
					
					session.setAttribute("loginSession", userInfo);
					resultInfo = "redirect:/main/mainpage";
					
					// 전체 로그인 유저리스트에 해당 유저정보 추가
					loginListSessionUpdate(application, userInfo, userList);
				}else {
					// RedirectAttributes으로 로그인 오류내용을 일시적으로 다음 requestMapping 위치에 보낸다.
					String errorRst = "입력하신 비밀번호가 일치하지 않습니다.";
					rs.addFlashAttribute("errorRst", errorRst);
					resultInfo = "redirect:/sign/signInPage";
				}
			}
		}else {
			// RedirectAttributes으로 로그인 오류내용을 일시적으로 다음 requestMapping 위치에 보낸다.
			String errorRst = "입력하신 ID는 없는 정보입니다.";
			rs.addFlashAttribute("errorRst", errorRst);
			resultInfo = "redirect:/sign/signInPage";
		}
		return resultInfo;
	}
	
	/**
	 * 회원가입 페이지 이동
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sign/signUpPage")
	public String signUpPage(HttpSession session, Model model) throws Exception {
		return "/sign/signUpPage";
	}
	
	/**
	 * 회원가입시 ID 중복체크
	 * @param session
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sign/signUpIdChk")
	public String signUpIdChk(HttpSession session, Model model, HttpServletRequest request) throws Exception {
		
		String userId = request.getParameter("inputId");
		boolean isAleadyUsed = false;
//		logger.debug("input userId = "+userId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		int signUpIdChk = signService.signUpIdChk(map);
//		logger.debug("signUpIdChk = "+signUpIdChk);
		if(signUpIdChk > 0) {
			isAleadyUsed = true;
		}
		model.addAttribute("isAleadyUsed", isAleadyUsed);
		
		return "ajaxJasonView";
	}
	
	/**
	 * 회원가입 프로세스
	 * @param session
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sign/signUpProcess")
	public String signUpProcess(HttpSession session, Model model, HttpServletRequest request) throws Exception {
		
		String userId = request.getParameter("inputUserId");
		String userPw = request.getParameter("inputUserPw");
		String userNm = request.getParameter("inputUserNm");
//		String userBirth = request.getParameter("inputUserBirth");
//		String userMail = request.getParameter("inputUserMail");
//		String userPhone = request.getParameter("inputUserPhone");
//		String userAddr = request.getParameter("inputUserAddr1");
//		String userAddrDetail = request.getParameter("inputUserAddr2");
//		String zipCode = request.getParameter("inputUserZipcode");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("userPw", userPw);
		map.put("userNm", userNm);
		
		signService.signUpProcess(map);
		
		return "redirect:/main/mainpage";
	}
	
	/**
	 * 비밀번호 초기화 페이지 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sign/resetPwLink")
	public String resetPwLink() throws Exception{
		return "/sign/resetPwLink";
	}
	
	
	/**
	 * 비밀번호 초기화
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sign/resetPwProcess")
	public String resetPw(HttpServletRequest request, Model model) throws Exception{
		
		String inputUserId = request.getParameter("inputUserId");
		String inputUserEmail = request.getParameter("inputUserEmail");
		
		String errorMsg = "";
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", inputUserId);
		map.put("userEmail", inputUserEmail);
		
		List<Map<String, Object>> signInfoList = (List<Map<String, Object>>) signService.loginCheck(map);
		if(signInfoList != null && signInfoList.size() > 0) {
			
			for(Map<String, Object> userInfo : signInfoList) {
				if(inputUserEmail.equals(userInfo.get("mail"))) {
					// 해당 이메일 주소로 임시비밀번호 보내기
					signService.updatePasswordAndSendMail(inputUserEmail);
					
				}else if(userInfo.get("mail") == null || userInfo.get("mail").equals("")){
					// errorRst 정보를 저장
					errorMsg = "입력하신 ID의 이메일정보가 없습니다.";
				}else if(!inputUserEmail.equals(userInfo.get("mail"))) {
					errorMsg = "입력하신 ID의 이메일정보와 일치하지 않습니다.";
				}
			}
		}else {
			// errorRst 정보를 저장
			errorMsg = "입력하신 ID는 없는 정보입니다.";
		}
		
		model.addAttribute("errorMsg", errorMsg);
		return "ajaxJasonView";
	}
	
	
	/**
	 * 접속한 브라우저의 ip정보 추출
	 * @param request
	 * @return
	 */
	public String getIpInfo() {
		
		String clientIp = null;
		boolean isIpInHeader = false;
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		List<String> headerList = new ArrayList<>();
	    headerList.add("X-Forwarded-For");
	    headerList.add("HTTP_CLIENT_IP");
	    headerList.add("HTTP_X_FORWARDED_FOR");
	    headerList.add("HTTP_X_FORWARDED");
	    headerList.add("HTTP_FORWARDED_FOR");
	    headerList.add("HTTP_FORWARDED");
	    headerList.add("Proxy-Client-IP");
	    headerList.add("WL-Proxy-Client-IP");
	    headerList.add("HTTP_VIA");    
	    headerList.add("IPV6_ADR");
	    
	    for (String header : headerList) {
	        clientIp = request.getHeader(header);
	        if (StringUtils.hasText(clientIp) && !clientIp.equals("unknown")) {
	            isIpInHeader = true;
	            break;
	        }
	    }
	    
	    if (!isIpInHeader) {
	        clientIp = request.getRemoteAddr();
	    }
		return clientIp;
	}
	
	/**
	 * 유저리스트 최신화
	 * @param application
	 * @param userInfo
	 * @param userList
	 */
	public void loginListSessionUpdate(ServletContext application, Map<String, Object> userInfo, List<Map> userList) {
		if(userList == null) {
			userList = new ArrayList<Map>();
		}
		userList.add(userInfo);
		application.setAttribute("userList", userList);
	}
	
	/**
	 * 로그아웃 프로세스
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/sign/logoutProcess")
	public String logoutProcess(HttpSession session, HttpServletRequest request) {
		// 로그인한 유저 리스트
		ServletContext application = request.getServletContext();
		List<Map> userList = (List<Map>) application.getAttribute("userList");
		
		// 로그아웃 유저를 제외한 유저리스트
		List<Map> reUserList = new ArrayList<Map>();
		
		// 로그인한 유저 리스트에서 로그아웃한 유저를 제외한 유저리스트를 reUserList에 추가
		if(userList != null) {
			for(Map userInfo : userList) {
				if(!userInfo.get("userId").equals(((Map)session.getAttribute("loginSession")).get("userId"))) {
					reUserList.add(userInfo);
				}
			}
		}
		application.setAttribute("userList", reUserList);
		session.removeAttribute("loginSession");
		
		return "redirect:/main/mainpage";
	}

}
