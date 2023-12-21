package hash.com.sign.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public interface signService {
	
	
	List<Map<String, Object>> loginCheck(Map<String, Object> map) throws Exception;

	int signUpIdChk(Map<String, Object> map) throws Exception;

	void signUpProcess(Map<String, Object> map) throws Exception;

	void updatePasswordAndSendMail(String inputUserEmail) throws Exception;

}
