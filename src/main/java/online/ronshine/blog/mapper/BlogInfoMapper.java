package online.ronshine.blog.mapper;

import online.ronshine.blog.pojo.entity.BlogInfo;
import org.apache.ibatis.annotations.Mapper;

/**
 * 博客信息 Mapper
 */
@Mapper
public interface BlogInfoMapper {
    BlogInfo findById(Integer id);
    BlogInfo findFirst();
    int update(BlogInfo blogInfo);
}
