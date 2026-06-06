package online.ronshine.blog.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 文章详情 VO
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PostVO {
    private Integer id;
    private String title;
    private String slug;
    private String excerpt;
    private String content;
    private String coverImage;
    private CategoryVO category;
    private List<TagVO> tags;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private Boolean published;
}
