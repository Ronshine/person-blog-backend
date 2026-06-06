package online.ronshine.blog.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 文章摘要 VO - 列表用，不含正文
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PostSummaryVO {
    private Integer id;
    private String title;
    private String slug;
    private String excerpt;
    private String coverImage;
    private CategoryVO category;
    private List<TagVO> tags;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
