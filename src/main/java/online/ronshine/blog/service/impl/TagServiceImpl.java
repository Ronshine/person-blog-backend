package online.ronshine.blog.service.impl;

import online.ronshine.blog.mapper.TagMapper;
import online.ronshine.blog.service.TagService;
import online.ronshine.blog.vo.TagVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class TagServiceImpl implements TagService {

    private final TagMapper tagMapper;

    @Override
    public List<TagVO> listTags() {
        List<Map<String, Object>> rows = tagMapper.findAllWithCount();
        return rows.stream()
                .map(row -> new TagVO(
                        ((Number) row.get("id")).intValue(),
                        (String) row.get("name"),
                        (String) row.get("slug"),
                        ((Number) row.get("count")).intValue()
                ))
                .collect(Collectors.toList());
    }
}
