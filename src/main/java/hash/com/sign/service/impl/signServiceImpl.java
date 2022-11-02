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
	public List<?> selectSignInfo(Map<String, Object> map) throws Exception{
		return signMapperDao.selectSignInfo(map);
	}

	@Override
	public int selectTemp() throws Exception{
		return 0;
	}

}
