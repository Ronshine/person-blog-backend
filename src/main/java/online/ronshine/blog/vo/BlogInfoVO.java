package online.ronshine.blog.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 博客信息 VO
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class BlogInfoVO {
    private String title;
    private String subtitle;
    private String description;
    private Author author;
    private SocialLinks socialLinks;

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Author {
        private String name;
        private String avatar;
        private String bio;
    }

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class SocialLinks {
        private String github;
        private String twitter;
        private String email;
    }
}
