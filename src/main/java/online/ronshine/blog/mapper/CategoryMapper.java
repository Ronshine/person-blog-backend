package online.ronshine.blog.mapper;

import online.ronshine.blog.pojo.entity.Category;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 分类 Mapper
 */
@Mapper
public interface CategoryMapper {
    List<Category> findAll();
    Category findById(Integer id);
    Category findBySlug(String slug);
}
