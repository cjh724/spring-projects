package org.zerock.service;

import java.util.*;

import org.zerock.domain.*;
import org.zerock.dto.*;

public interface UserService {
	public UserVO login(LoginDTO dto) throws Exception;
	public void keepLogin(String uid, String sessionId, Date next) throws Exception;
	public UserVO checkLoginBefore(String value);
	
}
