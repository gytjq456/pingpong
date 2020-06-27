package kh.pingpong.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kh.pingpong.dto.CommentDTO;
import kh.pingpong.dto.DiscussionDTO;
import kh.pingpong.dto.LanguageDTO;
import kh.pingpong.service.DiscussionService;


@Controller
@RequestMapping("/discussion/")
public class DiscussionController {
	
	@Autowired
	private DiscussionService disService;
	
	// 글쓰기 페이지 
	@RequestMapping("write")
	public String write(Model model) throws Exception{
		List<LanguageDTO> langList = disService.langSelectlAll();
		model.addAttribute("langList", langList);
		return "board/discussion/write";
	}
	
	// 글쓰기 완료 처리 
	@RequestMapping("writeProc")
	public String writeProc(DiscussionDTO disDTO) throws Exception{
		int result = disService.insert(disDTO);
		return "redirect:/discussion/list";
	}
	
	// 글 목록 페이지
	@RequestMapping("list")
	public String list(Model model) throws Exception{
		List<DiscussionDTO> list = disService.selectAll();
		model.addAttribute("list", list);
		return "board/discussion/list";
	}
	
	// 글 보기 
	@RequestMapping("view")
	public String view(DiscussionDTO disDto, Model model) throws Exception{
		disDto = disService.selectOne(disDto.getSeq());
		List<CommentDTO> commDto = disService.selectComment(disDto.getSeq());
		List<CommentDTO> bestCommDto = disService.bestComment(disDto.getSeq());
		
		
		model.addAttribute("commentList", commDto);
		model.addAttribute("bestCommentList", bestCommDto);
		model.addAttribute("disDto", disDto);
		return "board/discussion/view";
	}
	
	// 글 삭제
	@ResponseBody
	@RequestMapping("delete")
	public String delete(DiscussionDTO disDto) throws Exception{
		int result = disService.delete(disDto.getSeq());
		if(result > 0) {
			return String.valueOf(true);
		}else {
			return String.valueOf(false);
		}
	}

	// 수정하기 페이지로 이동
	@Transactional("txManager")
	@RequestMapping("modify")
	public String modify(DiscussionDTO disDto, Model model) throws Exception{
		List<LanguageDTO> langList = disService.langSelectlAll();
		disDto = disService.selectOne(disDto.getSeq());
		model.addAttribute("disDto", disDto);
		model.addAttribute("langList", langList);
		return "board/discussion/modify";
	}
	
	// 수정하기 처리
	@ResponseBody
	@RequestMapping("modifyProc")
	public String modifyProc(DiscussionDTO disDto) throws Exception{
		int result = disService.modify(disDto);
		if(result > 0) {
			return String.valueOf(true);
		}else {
			return String.valueOf(false);
		}
	}
	
	// 게시글 좋아요
		@ResponseBody
		@RequestMapping("like")
		public String like(DiscussionDTO disDto) throws Exception{
			int result = disService.like(disDto.getSeq());
			if(result > 0) {
				return String.valueOf(true);
			}else {
				return String.valueOf(false);
			}
		}
	
	// 댓글 쓰기
	@ResponseBody
	@RequestMapping("commentProc")
	public String commentProc(CommentDTO commDTO) throws Exception{
		int result = disService.commentInsert(commDTO);
		if(result > 0) {
			return String.valueOf(true);
		}else {
			return String.valueOf(false);
		}
	}
	
	
	
	
	// 댓글 좋아요
	@ResponseBody
	@RequestMapping("commentLike")
	public String commentLike(CommentDTO commDTO) throws Exception{
		int result = disService.commentLike(commDTO.getSeq());
		if(result > 0) {
			return String.valueOf(true);
		}else {
			return String.valueOf(false);
		}
	}
	
	// 댓글 싫어요
	@ResponseBody
	@RequestMapping("commentHate")
	public String commentHate(CommentDTO commDTO) throws Exception{
		int result = disService.commentHate(commDTO.getSeq());
		if(result > 0) {
			return String.valueOf(true);
		}else {
			return String.valueOf(false);
		}
	}
	
	
	//댓글 삭제
	@ResponseBody
	@RequestMapping("commentDelete")
	public String commentDelete(CommentDTO commDTO) throws Exception{
		int result = disService.commentDelete(commDTO.getSeq());
		if(result > 0) {
			return String.valueOf(true);
		}else {
			return String.valueOf(false);
		}
	}
	
	
	
}
