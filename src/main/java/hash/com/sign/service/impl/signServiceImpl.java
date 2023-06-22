package hash.com.sign.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import hash.com.sign.service.signService;

@Service("signService")
public class signServiceImpl implements signService{
	
	@Resource(name="signMapperDao")
	private signMapperDao signMapperDao;

	@Override
	public List<?> loginCheck(Map<String, Object> map) throws Exception{
		return signMapperDao.loginCheck(map);
	}

	@Override
	public int singUpIdChk(Map<String, Object> map) throws Exception {
		return signMapperDao.singUpIdChk(map);
	}

}
