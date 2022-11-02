package hash.com.sign.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository("signMapperDao")
public class signMapperDao {
	
	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;

	public List<?> selectSignInfo(Map<String, Object> map) {
		return sqlSession.selectList("signMapperDao.selectSignInfo", map);
	}

}
