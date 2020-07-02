package kh.pingpong.dao;

import java.util.List;
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
	
	public String chatRoomSch(Map<String,String> chatInfo) throws Exception{
		return mybatis.selectOne("Chat.chatRoomSch",chatInfo);
	}	
	public List<String> chatRoomAll() throws Exception{
		return mybatis.selectList("Chat.chatRoomAll");
	}	
	
}
