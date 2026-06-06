package online.ronshine.blog.pojo.entity;

import lombok.Data;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 博客文章 - 对应表 posts
 */
@Data
public class Post {
    private Integer id;
    private String title;
    private String slug;
    private String excerpt;
    private String content;
    private String coverImage;
    private Integer categoryId;
    private Boolean published;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    /** 关联数据（非数据库字段） */
    private Category category;
    private List<Tag> tags;
}
