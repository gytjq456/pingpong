package kh.pingpong.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.pingpong.dao.NotificationDAO;

@Service
public class NotificationService {
	
	@Autowired
	NotificationDAO ndao;
}
