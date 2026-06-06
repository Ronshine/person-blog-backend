package online.ronshine.blog.controller;

import online.ronshine.blog.pojo.dto.PostQueryDTO;
import online.ronshine.blog.service.PostService;
import online.ronshine.blog.vo.PageResult;
import online.ronshine.blog.vo.PostSummaryVO;
import online.ronshine.blog.vo.PostVO;
import online.ronshine.blog.vo.Result;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/posts")
@RequiredArgsConstructor
public class PostController {

    private final PostService postService;

    @GetMapping
    public Result<PageResult<PostSummaryVO>> listPosts(PostQueryDTO query) {
        return Result.success(postService.listPosts(query));
    }

    @GetMapping("/{slug}")
    public Result<PostVO> getPostBySlug(@PathVariable String slug) {
        PostVO post = postService.getPostBySlug(slug);
        if (post == null) {
            return Result.error(404, "文章未找到");
        }
        return Result.success(post);
    }

    @GetMapping("/id/{id}")
    public Result<PostVO> getPostById(@PathVariable Integer id) {
        PostVO post = postService.getPostById(id);
        if (post == null) {
            return Result.error(404, "文章未找到");
        }
        return Result.success(post);
    }

    @GetMapping("/search")
    public Result<List<PostSummaryVO>> searchPosts(@RequestParam String q) {
        return Result.success(postService.searchPosts(q));
    }

    @GetMapping("/byTag")
    public Result<List<PostSummaryVO>> getPostsByTag(@RequestParam String tagSlug) {
        return Result.success(postService.listPostsByTag(tagSlug));
    }

    @GetMapping("/byCategory")
    public Result<List<PostSummaryVO>> getPostsByCategory(@RequestParam String categorySlug) {
        return Result.success(postService.listPostsByCategory(categorySlug));
    }
}
