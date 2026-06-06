package online.ronshine.blog.service.impl;

import online.ronshine.blog.mapper.PostMapper;
import online.ronshine.blog.mapper.TagMapper;
import online.ronshine.blog.pojo.dto.PostQueryDTO;
import online.ronshine.blog.pojo.entity.Post;
import online.ronshine.blog.pojo.entity.Tag;
import online.ronshine.blog.service.PostService;
import online.ronshine.blog.vo.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PostServiceImpl implements PostService {

    private final PostMapper postMapper;
    private final TagMapper tagMapper;

    @Override
    public PageResult<PostSummaryVO> listPosts(PostQueryDTO query) {
        int page = query.getPage() != null ? query.getPage() : 1;
        int pageSize = query.getPageSize() != null ? query.getPageSize() : 6;
        int offset = (page - 1) * pageSize;

        List<Post> posts;
        int total;

        if (query.getCategorySlug() != null) {
            posts = postMapper.findPageByCategorySlug(query.getCategorySlug(), offset, pageSize);
            total = postMapper.countByCategorySlug(query.getCategorySlug());
        } else if (query.getTagSlug() != null) {
            posts = postMapper.findPageByTagSlug(query.getTagSlug(), offset, pageSize);
            total = postMapper.countByTagSlug(query.getTagSlug());
        } else if (query.getKeyword() != null) {
            posts = postMapper.searchByKeyword(query.getKeyword(), offset, pageSize);
            total = postMapper.countByKeyword(query.getKeyword());
        } else {
            posts = postMapper.findPage(offset, pageSize);
            total = postMapper.countAll();
        }

        List<PostSummaryVO> items = posts.stream()
                .map(this::toSummaryVO)
                .collect(Collectors.toList());

        return PageResult.of(items, page, pageSize, total);
    }

    @Override
    public PostVO getPostBySlug(String slug) {
        Post post = postMapper.findBySlug(slug);
        return post != null ? toPostVO(post) : null;
    }

    @Override
    public PostVO getPostById(Integer id) {
        Post post = postMapper.findById(id);
        return post != null ? toPostVO(post) : null;
    }

    @Override
    public List<PostSummaryVO> listPostsByTag(String tagSlug) {
        List<Post> posts = postMapper.findPageByTagSlug(tagSlug, 0, Integer.MAX_VALUE);
        return posts.stream().map(this::toSummaryVO).collect(Collectors.toList());
    }

    @Override
    public List<PostSummaryVO> listPostsByCategory(String categorySlug) {
        List<Post> posts = postMapper.findPageByCategorySlug(categorySlug, 0, Integer.MAX_VALUE);
        return posts.stream().map(this::toSummaryVO).collect(Collectors.toList());
    }

    @Override
    public List<PostSummaryVO> searchPosts(String keyword) {
        if (keyword == null || keyword.isBlank()) {
            return Collections.emptyList();
        }
        List<Post> posts = postMapper.searchByKeyword(keyword, 0, Integer.MAX_VALUE);
        return posts.stream().map(this::toSummaryVO).collect(Collectors.toList());
    }

    private PostVO toPostVO(Post post) {
        return new PostVO(
                post.getId(),
                post.getTitle(),
                post.getSlug(),
                post.getExcerpt(),
                post.getContent(),
                post.getCoverImage(),
                toCategoryVO(post),
                toTagVOList(post.getTags()),
                post.getCreatedAt(),
                post.getUpdatedAt(),
                post.getPublished()
        );
    }

    private PostSummaryVO toSummaryVO(Post post) {
        return new PostSummaryVO(
                post.getId(),
                post.getTitle(),
                post.getSlug(),
                post.getExcerpt(),
                post.getCoverImage(),
                toCategoryVO(post),
                toTagVOList(post.getTags()),
                post.getCreatedAt(),
                post.getUpdatedAt()
        );
    }

    private CategoryVO toCategoryVO(Post post) {
        if (post.getCategory() == null) return null;
        return new CategoryVO(
                post.getCategory().getId(),
                post.getCategory().getName(),
                post.getCategory().getSlug(),
                post.getCategory().getDescription()
        );
    }

    private List<TagVO> toTagVOList(List<Tag> tags) {
        if (tags == null) return Collections.emptyList();
        return tags.stream()
                .map(t -> new TagVO(t.getId(), t.getName(), t.getSlug(), null))
                .collect(Collectors.toList());
    }
}
