package online.ronshine.blog.mapper;

import online.ronshine.blog.pojo.entity.Tag;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

/**
 * 标签 Mapper
 */
@Mapper
public interface TagMapper {
    List<Tag> findAll();
    List<Map<String, Object>> findAllWithCount();
    Tag findById(Integer id);
    Tag findBySlug(String slug);
    List<Tag> findByPostId(Integer postId);
}
