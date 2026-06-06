package online.ronshine.blog.pojo.entity;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * 文章-标签关联 - 对应表 post_tags
 */
@Data
public class PostTag {
    private Integer id;
    private Integer postId;
    private Integer tagId;
    private LocalDateTime createdAt;
}
