package online.ronshine.blog.service.impl;

import online.ronshine.blog.mapper.BlogInfoMapper;
import online.ronshine.blog.pojo.entity.BlogInfo;
import online.ronshine.blog.service.BlogInfoService;
import online.ronshine.blog.vo.BlogInfoVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class BlogInfoServiceImpl implements BlogInfoService {

    private final BlogInfoMapper blogInfoMapper;

    @Override
    public BlogInfoVO getBlogInfo() {
        BlogInfo info = blogInfoMapper.findFirst();
        if (info == null) {
            return null;
        }

        BlogInfoVO vo = new BlogInfoVO();
        vo.setTitle(info.getTitle());
        vo.setSubtitle(info.getSubtitle());
        vo.setDescription(info.getDescription());
        vo.setAuthor(new BlogInfoVO.Author(
                info.getAuthorName(),
                info.getAuthorAvatar(),
                info.getAuthorBio()
        ));
        vo.setSocialLinks(new BlogInfoVO.SocialLinks(
                info.getSocialGithub(),
                info.getSocialTwitter(),
                info.getSocialEmail()
        ));
        return vo;
    }
}
