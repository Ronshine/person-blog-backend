package online.ronshine.blog.controller;

import online.ronshine.blog.service.TagService;
import online.ronshine.blog.vo.Result;
import online.ronshine.blog.vo.TagVO;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/tags")
@RequiredArgsConstructor
public class TagController {

    private final TagService tagService;

    @GetMapping
    public Result<List<TagVO>> listTags() {
        return Result.success(tagService.listTags());
    }
}
