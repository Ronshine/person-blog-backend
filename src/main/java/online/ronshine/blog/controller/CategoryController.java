package online.ronshine.blog.controller;

import online.ronshine.blog.service.CategoryService;
import online.ronshine.blog.vo.CategoryVO;
import online.ronshine.blog.vo.Result;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/categories")
@RequiredArgsConstructor
public class CategoryController {

    private final CategoryService categoryService;

    @GetMapping
    public Result<List<CategoryVO>> listCategories() {
        return Result.success(categoryService.listCategories());
    }
}
