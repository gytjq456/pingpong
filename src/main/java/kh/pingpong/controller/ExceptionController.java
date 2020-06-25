package kh.pingpong.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class ExceptionController {
	//예외가 발생하면 이녀석이 처리해줌
	@ExceptionHandler
	public String exceptionHandler(Exception e) {
		e.printStackTrace();
		System.out.println("에러가 발생했습니다.");
		return "error";
	}
	
	@ExceptionHandler
	public String exceptionHandler(NumberFormatException e) {
		e.printStackTrace();
		System.out.println("NumberFormatException 발생했습니다.");
		return "error";
	}
	@ExceptionHandler
	public String exceptionHandler(NullPointerException e) {
		e.printStackTrace();
		System.out.println("NullPointerException 발생했습니다.");
		return "error";
	}
}
