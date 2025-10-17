package com.elon.boot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/community")
public class CommunityController {

    // 공지사항 목록
    @GetMapping("/notice")
    public String noticeList(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false, defaultValue = "1") int page,
            Model model) {

        // TODO: 실제 데이터베이스에서 공지사항 목록 가져오기
        // List<Notice> noticeList = noticeService.getNoticeList(keyword, page);
        // int totalCount = noticeService.getNoticeCount(keyword);
        // int totalPages = (int) Math.ceil((double) totalCount / 10);

        // model.addAttribute("noticeList", noticeList);
        // model.addAttribute("totalCount", totalCount);
        // model.addAttribute("currentPage", page);
        // model.addAttribute("totalPages", totalPages);
        // model.addAttribute("keyword", keyword);

        return "community/notice";
    }

    // 공지사항 상세
    @GetMapping("/notice/{id}")
    public String noticeDetail(@PathVariable Long id, Model model) {
        // TODO: 실제 데이터베이스에서 공지사항 상세 정보 가져오기
        // Notice notice = noticeService.getNoticeById(id);
        // noticeService.increaseViewCount(id);

        // model.addAttribute("notice", notice);

        return "community/notice-detail";
    }

    // 가이드 목록
    @GetMapping("/guide")
    public String guideList(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String category,
            @RequestParam(required = false, defaultValue = "1") int page,
            Model model) {

        // TODO: 실제 데이터베이스에서 가이드 목록 가져오기
        // List<Guide> guideList = guideService.getGuideList(keyword, category, page);
        // int totalCount = guideService.getGuideCount(keyword, category);
        // int totalPages = (int) Math.ceil((double) totalCount / 10);

        // model.addAttribute("guideList", guideList);
        // model.addAttribute("totalCount", totalCount);
        // model.addAttribute("currentPage", page);
        // model.addAttribute("totalPages", totalPages);
        // model.addAttribute("keyword", keyword);
        // model.addAttribute("category", category);

        return "community/guide";
    }

    // 가이드 상세
    @GetMapping("/guide/{id}")
    public String guideDetail(@PathVariable Long id, Model model) {
        // TODO: 실제 데이터베이스에서 가이드 상세 정보 가져오기
        // Guide guide = guideService.getGuideById(id);
        // guideService.increaseViewCount(id);
        // List<Comment> comments = commentService.getCommentsByGuideId(id);
        // Guide prevGuide = guideService.getPrevGuide(id);
        // Guide nextGuide = guideService.getNextGuide(id);

        // model.addAttribute("guide", guide);
        // model.addAttribute("comments", comments);
        // model.addAttribute("prevGuide", prevGuide);
        // model.addAttribute("nextGuide", nextGuide);

        return "community/guide-detail";
    }

    // 가이드 좋아요
    @PostMapping("/guide/{id}/like")
    @ResponseBody
    public String likeGuide(@PathVariable Long id, HttpSession session) {
        // TODO: 좋아요 처리
        // Object user = session.getAttribute("user");
        // if (user == null) {
        //     return "{\"success\": false, \"message\": \"로그인이 필요합니다.\"}";
        // }

        // boolean isLiked = likeService.toggleLike(userId, id);
        // int likeCount = likeService.getLikeCount(id);

        // return String.format("{\"success\": true, \"isLiked\": %b, \"likeCount\": %d}", isLiked, likeCount);

        return "{\"success\": true, \"isLiked\": true, \"likeCount\": 90}";
    }

    // 댓글 작성
    @PostMapping("/guide/{id}/comment")
    public String addComment(
            @PathVariable Long id,
            @RequestParam String content,
            HttpSession session) {

        // TODO: 댓글 작성
        // Object user = session.getAttribute("user");
        // if (user == null) {
        //     return "redirect:/login";
        // }

        // commentService.addComment(id, userId, content);

        return "redirect:/community/guide/" + id;
    }

    // 댓글 삭제
    @DeleteMapping("/guide/{guideId}/comment/{commentId}")
    @ResponseBody
    public String deleteComment(
            @PathVariable Long guideId,
            @PathVariable Long commentId,
            HttpSession session) {

        // TODO: 댓글 삭제
        // Object user = session.getAttribute("user");
        // if (user == null) {
        //     return "{\"success\": false, \"message\": \"로그인이 필요합니다.\"}";
        // }

        // boolean result = commentService.deleteComment(commentId, userId);

        // return String.format("{\"success\": %b}", result);

        return "{\"success\": true}";
    }
}
