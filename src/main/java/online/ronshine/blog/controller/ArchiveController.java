package online.ronshine.blog.controller;

import online.ronshine.blog.service.ArchiveService;
import online.ronshine.blog.vo.ArchiveVO;
import online.ronshine.blog.vo.Result;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/archives")
@RequiredArgsConstructor
public class ArchiveController {

    private final ArchiveService archiveService;

    @GetMapping
    public Result<List<ArchiveVO>> listArchives() {
        return Result.success(archiveService.listArchives());
    }
}
