package online.ronshine.blog.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 标签 VO
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TagVO {
    private Integer id;
    private String name;
    private String slug;
    private Integer count;
}
