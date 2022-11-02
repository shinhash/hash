package hash.com.sign.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import hash.com.sign.service.signService;



@Controller
public class signController {
	
	private static final Logger logger = LoggerFactory.getLogger(signController.class);
	
	@Resource(name="signService")
	private signService signService;
	
	@RequestMapping(value="/sign/login")
	public String signPage(HttpSession session, Model model) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<Map> signInfoList = (List<Map>) signService.selectSignInfo(map);
		if(signInfoList != null && signInfoList.size() > 0) {
			for(Map<String, Object> tempMap : signInfoList) {
				System.out.println(tempMap.toString());
			}			
		}
		
		return "sign/login";
	}

}
