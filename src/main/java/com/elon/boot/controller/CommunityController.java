package com.elon.boot.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.elon.boot.domain.community.guide.model.service.GuideCommentLikeService;
import com.elon.boot.domain.community.guide.model.service.GuideCommentService;
import com.elon.boot.domain.community.guide.model.service.GuideLikeService;
import com.elon.boot.domain.community.guide.model.service.GuideService;
import com.elon.boot.domain.community.guide.model.vo.Guide;
import com.elon.boot.domain.community.guide.model.vo.GuideComment;
import com.elon.boot.domain.user.model.vo.User;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/community")
@RequiredArgsConstructor
public class CommunityController {

   private final GuideService gService;
   private final GuideCommentService cService;
   private final GuideLikeService lService;
   private final GuideCommentLikeService clService;

    // 가이드 목록
    @GetMapping("/guide")
    public String guideList(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false, defaultValue = "all") String category,
            @RequestParam(required = false, defaultValue = "1") int page,
            Model model) {
       try {
          // 카테고리 처리 ('all'이면 null로)
          String searchCategory = (category != null && !"all".equals(category)) ? category : null;
          
           int boardLimit = 10;
           int pageLimit = 5;
           int totalCount = gService.getGuideCount(keyword, searchCategory);
           int maxPage = (int) Math.ceil((double) totalCount / boardLimit);
           int startPage = ((page-1)/pageLimit) * pageLimit + 1; // 시작페이지(1, 6, 11, 16 ...)
           int endPage = startPage + pageLimit - 1;
           if(endPage > maxPage) {
        	   endPage = maxPage;
           }
           
           int offset = (page - 1) * boardLimit;
           
           List<Guide> guideList = gService.getGuideList(keyword, searchCategory, offset, boardLimit);
           
           List<Guide> popularGuides = gService.getPopularGuides();
          
          // List
          model.addAttribute("guideList", guideList);
          model.addAttribute("popularGuides", popularGuides);
          model.addAttribute("keyword", keyword);
          model.addAttribute("category", category);
          
          // 페이징
          model.addAttribute("currentPage", page);
          model.addAttribute("maxPage", maxPage);
          model.addAttribute("startPage", startPage);
          model.addAttribute("endPage", endPage);
          model.addAttribute("totalCount", totalCount);
          
      } catch (Exception e) {
         e.printStackTrace();
           model.addAttribute("errorMessage", "게시글 목록을 불러오는데 실패했습니다.");
      }
       
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
    public String guideDetail(@PathVariable("id") int guideNo, 
            HttpSession session,
            Model model) {
        try {
            // 세션에서 현재 사용자 정보 가져오기
            String currentUserId = null;
            User loginUser = (User) session.getAttribute("loginUser");
            if (loginUser != null) {
                currentUserId = loginUser.getUserId();
            }
            
            // 가이드 상세 정보 조회 (조회수 증가 포함)
            Guide guide = gService.getGuideDetail(guideNo, currentUserId);
            
            if (guide == null) {
                model.addAttribute("errorMessage", "존재하지 않는 게시글입니다.");
                return "redirect:/community/guide";
            }
            
            // 이전/다음 글 조회
            Guide prevGuide = gService.getPrevGuide(guideNo);
            Guide nextGuide = gService.getNextGuide(guideNo);
            
            // 댓글 목록 조회
            List<GuideComment> comments = cService.getCommentsByGuideNo(guideNo);
            
         // 각 가이드 댓글의 좋아요 상태 설정
            if (currentUserId != null && comments != null && !comments.isEmpty()) {
                for (GuideComment comment : comments) {
                    boolean commentLiked = clService.isGuideCommentLikedByUser(comment.getCommentId(), currentUserId);
                    comment.setLiked(commentLiked);  // setIsLiked → setLiked
                }
            }
            
            // 좋아요 정보 조회
            int likeCount = lService.getLikeCount(guideNo);
            boolean isLiked = false;
            if (currentUserId != null) {
                isLiked = lService.isLikedByUser(guideNo, currentUserId);
            }
            
            model.addAttribute("guide", guide);
            model.addAttribute("prevGuide", prevGuide);
            model.addAttribute("nextGuide", nextGuide);
            model.addAttribute("comments", comments);
            model.addAttribute("likeCount", likeCount);
            model.addAttribute("isLiked", isLiked);
            
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "게시글을 불러오는데 실패했습니다.");
            return "redirect:/community/guide";
        }
    	
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
    public Map<String, Object> likeGuide(@PathVariable("id") int guideNo, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            User loginUser = (User) session.getAttribute("loginUser");
            if (loginUser == null) {
                response.put("success", false);
                response.put("message", "로그인이 필요합니다.");
                return response;
            }
            
            String userId = loginUser.getUserId();
            
            // 좋아요 토글
            boolean isLiked = lService.toggleLike(guideNo, userId);
            int likeCount = lService.getLikeCount(guideNo);
            
            response.put("success", true);
            response.put("isLiked", isLiked);
            response.put("likeCount", likeCount);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "좋아요 처리 중 오류가 발생했습니다.");
        }
    	
        // TODO: 좋아요 처리
        // Object user = session.getAttribute("user");
        // if (user == null) {
        //     return "{\"success\": false, \"message\": \"로그인이 필요합니다.\"}";
        // }

        // boolean isLiked = likeService.toggleLike(userId, id);
        // int likeCount = likeService.getLikeCount(id);

        // return String.format("{\"success\": true, \"isLiked\": %b, \"likeCount\": %d}", isLiked, likeCount);
        return response;
    }

    @PostMapping("/guide/{id}/comment")
    public String addComment(
            @PathVariable("id") int guideNo,
            @RequestParam String content,
            HttpSession session,
            Model model) {
        
        try {
            User loginUser = (User) session.getAttribute("loginUser");
            if (loginUser == null) {
                return "redirect:/login";
            }
            
            GuideComment comment = new GuideComment();
            comment.setGuideNo(guideNo);
            comment.setUserId(loginUser.getUserId());
            comment.setContent(content);
            
            cService.addComment(comment);
            
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "댓글 작성 중 오류가 발생했습니다.");
        }

        // TODO: 댓글 작성
        // Object user = session.getAttribute("user");
        // if (user == null) {
        //     return "redirect:/login";
        // }

        // commentService.addComment(id, userId, content);

        return "redirect:/community/guide/" + guideNo;
    }

 // 댓글 삭제
    @DeleteMapping("/guide/{guideId}/comment/{commentId}")
    @ResponseBody
    public Map<String, Object> deleteComment(
            @PathVariable("guideId") int guideNo,
            @PathVariable("commentId") int commentId,
            HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();
        
        try {
            User loginUser = (User) session.getAttribute("loginUser");
            if (loginUser == null) {
                response.put("success", false);
                response.put("message", "로그인이 필요합니다.");
                return response;
            }
            
            String userId = loginUser.getUserId();
            int result = cService.deleteComment(commentId, userId);
            
            if (result > 0) {
                response.put("success", true);
            } else {
                response.put("success", false);
                response.put("message", "댓글 삭제에 실패했습니다.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "댓글 삭제 중 오류가 발생했습니다.");
        }

        // TODO: 댓글 삭제
        // Object user = session.getAttribute("user");
        // if (user == null) {
        //     return "{\"success\": false, \"message\": \"로그인이 필요합니다.\"}";
        // }

        // boolean result = commentService.deleteComment(commentId, userId);

        // return String.format("{\"success\": %b}", result);

        return response;
    }
    
 // 가이드 댓글 좋아요
    @PostMapping("/guide/comment/{commentId}/like")
    @ResponseBody
    public Map<String, Object> toggleGuideCommentLike(
            @PathVariable("commentId") int commentId,
            HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();
        
        try {
            User loginUser = (User) session.getAttribute("loginUser");
            if (loginUser == null) {
                response.put("success", false);
                response.put("message", "로그인이 필요합니다.");
                return response;
            }
            
            String userId = loginUser.getUserId();
            
            // 가이드 댓글 좋아요 토글
            boolean isLiked = clService.toggleGuideCommentLike(commentId, userId);
            int likeCount = clService.getGuideCommentLikeCount(commentId);
            
            response.put("success", true);
            response.put("isLiked", isLiked);
            response.put("likeCount", likeCount);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "가이드 댓글 좋아요 처리 중 오류가 발생했습니다.");
        }
        
        return response;
    }
}