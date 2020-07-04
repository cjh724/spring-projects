package org.zerock.persistence;

import java.util.*;

import org.zerock.domain.*;
import org.zerock.dto.*;

public interface UserDAO {
	public UserVO login(LoginDTO dto) throws Exception;
	public void keepLogin(String uid, String sessionId, Date next);
	public UserVO checkUserWithSessionKey(String value);
	
}
