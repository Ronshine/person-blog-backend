package online.ronshine.blog.mapper;

import online.ronshine.blog.pojo.entity.Post;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 文章 Mapper
 */
@Mapper
public interface PostMapper {
    Post findById(Integer id);
    Post findBySlug(String slug);
    List<Post> findPage(int offset, int limit);
    int countAll();
    List<Post> findPageByCategorySlug(String categorySlug, int offset, int limit);
    int countByCategorySlug(String categorySlug);
    List<Post> findPageByTagSlug(String tagSlug, int offset, int limit);
    int countByTagSlug(String tagSlug);
    List<Post> searchByKeyword(String keyword, int offset, int limit);
    int countByKeyword(String keyword);
    List<Post> findAllOrderByCreatedAt();
}
