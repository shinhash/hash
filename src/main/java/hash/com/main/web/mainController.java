package hash.com.main.web;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class mainController {
	
	
	@RequestMapping(value="/main/mainpage")
	public String mainPage(HttpSession session, Model model) {
		return "tiles/main/mainpage";
	}

}
