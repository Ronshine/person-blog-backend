package online.ronshine.blog.service;

import online.ronshine.blog.pojo.dto.PostQueryDTO;
import online.ronshine.blog.vo.PageResult;
import online.ronshine.blog.vo.PostSummaryVO;
import online.ronshine.blog.vo.PostVO;

import java.util.List;

public interface PostService {
    PageResult<PostSummaryVO> listPosts(PostQueryDTO query);
    PostVO getPostBySlug(String slug);
    PostVO getPostById(Integer id);
    List<PostSummaryVO> listPostsByTag(String tagSlug);
    List<PostSummaryVO> listPostsByCategory(String categorySlug);
    List<PostSummaryVO> searchPosts(String keyword);
}
