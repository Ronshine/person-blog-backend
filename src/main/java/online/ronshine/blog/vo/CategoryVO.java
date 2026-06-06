package online.ronshine.blog.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 分类 VO
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CategoryVO {
    private Integer id;
    private String name;
    private String slug;
    private String description;
}
