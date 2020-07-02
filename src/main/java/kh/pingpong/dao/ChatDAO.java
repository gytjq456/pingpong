package kh.pingpong.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ChatDAO {

	@Autowired
	private SqlSessionTemplate mybatis;
	
	public int chatInsert(Map<String,String> chatInfp) throws Exception{
		return mybatis.insert("Chat.insert",chatInfp);
	}	
	
	public int chatRoomSch(Map<String,String> chatInfp) throws Exception{
		return mybatis.selectOne("Chat.chatRoomSch",chatInfp);
	}	
	
}
