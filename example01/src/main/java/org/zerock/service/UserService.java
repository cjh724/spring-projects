package org.zerock.service;

import org.zerock.domain.*;
import org.zerock.dto.*;

public interface UserService {
	public UserVO login(LoginDTO dto) throws Exception;
}
