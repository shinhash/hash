package hash.com.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SessionFilterConfiguration extends HandlerInterceptorAdapter {

	private static final Logger logger = LoggerFactory.getLogger(SessionFilterConfiguration.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		String getRequestURIInfo = request.getRequestURI();
		
		logger.debug("=====================================================================================");
		logger.debug("getPath : "+getRequestURIInfo);
		logger.debug("=====================================================================================");
		
		if(getRequestURIInfo.equals("/board/postListView")) {
			if(request.getParameter("bbsCatalId") == null || request.getParameter("bbsCatalId").equals("")) {
				response.sendRedirect(request.getContextPath()+"/board/bbsCatalList");
				return false;
			}
		}else if(getRequestURIInfo.equals("/board/postInfoView")) {
			if(request.getParameter("bbsPostId") == null || request.getParameter("bbsPostId").equals("")) {
				response.sendRedirect(request.getContextPath()+"/board/bbsCatalList");
				return false;
			}
		}
		return true;
	}
	
}
