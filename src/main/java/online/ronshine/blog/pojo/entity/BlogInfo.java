package online.ronshine.blog.pojo.entity;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * 博客全局信息 - 对应表 blog_info
 */
@Data
public class BlogInfo {
    private Integer id;
    private String title;
    private String subtitle;
    private String description;
    private String authorName;
    private String authorAvatar;
    private String authorBio;
    private String socialGithub;
    private String socialTwitter;
    private String socialEmail;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
