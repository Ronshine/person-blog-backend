package online.ronshine.blog.pojo.entity;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * 标签 - 对应表 tags
 */
@Data
public class Tag {
    private Integer id;
    private String name;
    private String slug;
    private LocalDateTime createdAt;
}
