package online.ronshine.blog.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 分页结果
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PageResult<T> {
    private List<T> items;
    private Pagination pagination;

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Pagination {
        private int page;
        private int pageSize;
        private int total;
        private int totalPages;
    }

    public static <T> PageResult<T> of(List<T> items, int page, int pageSize, int total) {
        int totalPages = (int) Math.ceil((double) total / pageSize);
        return new PageResult<>(items, new Pagination(page, pageSize, total, totalPages));
    }
}
