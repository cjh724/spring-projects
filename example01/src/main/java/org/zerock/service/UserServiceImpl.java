package org.zerock.service;

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

}
