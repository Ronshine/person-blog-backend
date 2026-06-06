package online.ronshine.blog.pojo.dto;

import lombok.Data;

/**
 * 文章查询参数
 */
@Data
public class PostQueryDTO {
    private Integer page = 1;
    private Integer pageSize = 6;
    private String categorySlug;
    private String tagSlug;
    private String keyword;
}
