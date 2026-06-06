package online.ronshine.blog.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 归档 VO
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ArchiveVO {
    private int year;
    private int month;
    private List<PostSummaryVO> posts;
}
