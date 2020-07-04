package org.zerock.service;

import java.util.*;

import javax.inject.*;

import org.springframework.stereotype.*;
import org.zerock.domain.*;
import org.zerock.dto.*;
import org.zerock.persistence.*;

@Service
public class UserServiceImpl implements UserService {
	@Inject
	private UserDAO dao;
	
	@Override
	public UserVO login(LoginDTO dto) throws Exception {
		return dao.login(dto);
	}

	@Override
	public void keepLogin(String uid, String sessionId, Date next) throws Exception {
		dao.keepLogin(uid, sessionId, next);
	}

	@Override
	public UserVO checkLoginBefore(String value) {
		return dao.checkUserWithSessionKey(value);
	}

}
