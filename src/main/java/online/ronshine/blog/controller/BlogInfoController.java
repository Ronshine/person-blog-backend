package online.ronshine.blog.controller;

import online.ronshine.blog.service.BlogInfoService;
import online.ronshine.blog.vo.BlogInfoVO;
import online.ronshine.blog.vo.Result;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/blog")
@RequiredArgsConstructor
public class BlogInfoController {

    private final BlogInfoService blogInfoService;

    @GetMapping("/info")
    public Result<BlogInfoVO> getBlogInfo() {
        return Result.success(blogInfoService.getBlogInfo());
    }
}
