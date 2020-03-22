package org.zerock.service;

import java.util.*;

import javax.inject.*;

import org.springframework.stereotype.*;
import org.zerock.domain.*;
import org.zerock.persistence.*;

@Service
public class ReplyServiceImpl implements ReplyService {
	@Inject
	private ReplyDAO dao;

	@Override
	public List<ReplyVO> listReply(Integer bno) throws Exception {
		return dao.list(bno);
	}

	@Override
	public void addReply(ReplyVO vo) throws Exception {
		dao.create(vo);
	}

	@Override
	public void modifyReply(ReplyVO vo) throws Exception {
		dao.update(vo);
	}

	@Override
	public void removeReply(Integer rno) throws Exception {
		dao.delete(rno);
	}
}