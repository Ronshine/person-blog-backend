package online.ronshine.blog.service.impl;

import online.ronshine.blog.mapper.CategoryMapper;
import online.ronshine.blog.pojo.entity.Category;
import online.ronshine.blog.service.CategoryService;
import online.ronshine.blog.vo.CategoryVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CategoryServiceImpl implements CategoryService {

    private final CategoryMapper categoryMapper;

    @Override
    public List<CategoryVO> listCategories() {
        return categoryMapper.findAll().stream()
                .map(this::toVO)
                .collect(Collectors.toList());
    }

    private CategoryVO toVO(Category category) {
        return new CategoryVO(
                category.getId(),
                category.getName(),
                category.getSlug(),
                category.getDescription()
        );
    }
}
