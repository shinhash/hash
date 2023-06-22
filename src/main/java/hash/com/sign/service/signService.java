package hash.com.sign.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public interface signService {
	
	
	List<?> loginCheck(Map<String, Object> map) throws Exception;

	int singUpIdChk(Map<String, Object> map) throws Exception;

}
