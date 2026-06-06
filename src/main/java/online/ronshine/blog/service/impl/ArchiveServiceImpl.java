package online.ronshine.blog.service.impl;

import online.ronshine.blog.mapper.PostMapper;
import online.ronshine.blog.pojo.entity.Post;
import online.ronshine.blog.service.ArchiveService;
import online.ronshine.blog.vo.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.YearMonth;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ArchiveServiceImpl implements ArchiveService {

    private final PostMapper postMapper;

    @Override
    public List<ArchiveVO> listArchives() {
        List<Post> posts = postMapper.findAllOrderByCreatedAt();

        Map<YearMonth, List<Post>> grouped = new LinkedHashMap<>();
        for (Post post : posts) {
            YearMonth ym = YearMonth.from(post.getCreatedAt());
            grouped.computeIfAbsent(ym, k -> new ArrayList<>()).add(post);
        }

        return grouped.entrySet().stream()
                .map(entry -> {
                    int year = entry.getKey().getYear();
                    int month = entry.getKey().getMonthValue();
                    List<PostSummaryVO> postVOs = entry.getValue().stream()
                            .map(this::toSummaryVO)
                            .collect(Collectors.toList());
                    return new ArchiveVO(year, month, postVOs);
                })
                .collect(Collectors.toList());
    }

    private PostSummaryVO toSummaryVO(Post post) {
        CategoryVO categoryVO = post.getCategory() != null
                ? new CategoryVO(post.getCategory().getId(), post.getCategory().getName(),
                post.getCategory().getSlug(), post.getCategory().getDescription())
                : null;

        List<TagVO> tagVOs = post.getTags() != null
                ? post.getTags().stream()
                .map(t -> new TagVO(t.getId(), t.getName(), t.getSlug(), null))
                .collect(Collectors.toList())
                : Collections.emptyList();

        return new PostSummaryVO(
                post.getId(), post.getTitle(), post.getSlug(),
                post.getExcerpt(), post.getCoverImage(),
                categoryVO, tagVOs,
                post.getCreatedAt(), post.getUpdatedAt()
        );
    }
}
