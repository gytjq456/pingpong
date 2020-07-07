package kh.pingpong.config;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kh.pingpong.chat.Room;
import kh.pingpong.dto.ChatRecordDTO;

public class Configuration {
	public static final int RECORD_COUNT_PER_PAGE = 12; // 한 페이지에 몇개씩 보일건지
	public static final int DISCUSSION_COUNT_PER_PAGE = 10; // 토론 게시판 한 페이지에 몇개씩 보일건지
	public static final int NAVI_COUNT_PER_PAGE = 10; // 한 페이지에 네비게이터를 몇개씩 보일건지
	
	
	public static Map<String,Room> chatCreate = new HashMap<>();
	public static List<ChatRecordDTO> chatRecord = new ArrayList();
	//public static String room;
	public static List<String> room = new ArrayList();
}
