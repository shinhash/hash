package hash.com.sign.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public interface signService {
	
	
	List<?> selectSignInfo(Map<String, Object> map) throws Exception;
	
	public int selectTemp() throws Exception;

}
