package org.zerock.persistence;

import javax.inject.*;

import org.apache.ibatis.session.*;
import org.springframework.stereotype.*;
import org.zerock.domain.*;
import org.zerock.dto.*;

@Repository
public class UserDAOImpl implements UserDAO {
	@Inject
	private SqlSession session;
	
	private static String namespace = "org.zerock.mapper.UserMapper";

	@Override
	public UserVO login(LoginDTO dto) throws Exception {
		return session.selectOne(namespace + ".login", dto);
	}

}
