package org.zerock.persistence;

import org.zerock.domain.*;
import org.zerock.dto.*;

public interface UserDAO {
	public UserVO login(LoginDTO dto) throws Exception;
	
}
