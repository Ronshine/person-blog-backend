package online.ronshine.blog.pojo.entity;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * 文章分类 - 对应表 categories
 */
@Data
public class Category {
    private Integer id;
    private String name;
    private String slug;
    private String description;
    private LocalDateTime createdAt;
}
