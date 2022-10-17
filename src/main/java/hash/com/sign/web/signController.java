package hash.com.sign.web;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class signController {
	
	private static final Logger logger = LoggerFactory.getLogger(signController.class);
	
	@RequestMapping(value="/sign/login")
	public String signPage(HttpSession session, Model model) {
		return "sign/login";
	}

}
