package hash.com.sign.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("signMapperDao")
public class signMapperDao extends EgovAbstractMapper{

	public List<?> loginCheck(Map<String, Object> map) {
		return selectList("signMapperDao.loginCheck", map);
	}

	public int signUpIdChk(Map<String, Object> map) {
		return selectOne("signMapperDao.signUpIdChk", map);
	}

	public void signUpProcess(Map<String, Object> map) {
		insert("signMapperDao.signUpProcess", map);
	}

}
