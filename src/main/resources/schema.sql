-- ============================================================================
-- 个人博客 - 数据库初始化脚本 (MySQL)
-- 对应前端 src/api/types.ts 中的所有数据结构
-- 使用建议: source schema.sql;
-- ============================================================================

-- 创建数据库
CREATE DATABASE IF NOT EXISTS `person_blog`
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE `person_blog`;

-- ============================================================================
-- 1. 博客信息表 (blog_info)
--    对应前端 BlogInfo 接口，单行配置
-- ============================================================================
CREATE TABLE IF NOT EXISTS `blog_info` (
  `id`            INT            NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title`         VARCHAR(100)   NOT NULL                COMMENT '博客标题',
  `subtitle`      VARCHAR(200)   NOT NULL                COMMENT '副标题',
  `description`   VARCHAR(500)   NOT NULL                COMMENT '博客描述',
  `author_name`   VARCHAR(50)    NOT NULL                COMMENT '作者名',
  `author_avatar` VARCHAR(500)   NOT NULL                COMMENT '作者头像URL',
  `author_bio`    VARCHAR(500)   NOT NULL                COMMENT '作者简介',
  `social_github` VARCHAR(200)   DEFAULT NULL            COMMENT 'GitHub链接',
  `social_twitter` VARCHAR(200)  DEFAULT NULL            COMMENT 'Twitter链接',
  `social_email`  VARCHAR(200)   DEFAULT NULL            COMMENT '邮箱',
  `created_at`    DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`    DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='博客基本信息';

-- ============================================================================
-- 2. 分类表 (categories)
--    对应前端 Category 接口
-- ============================================================================
CREATE TABLE IF NOT EXISTS `categories` (
  `id`          INT           NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name`        VARCHAR(50)   NOT NULL                COMMENT '分类名称',
  `slug`        VARCHAR(100)  NOT NULL                COMMENT 'URL友好标识',
  `description` VARCHAR(200)  DEFAULT NULL            COMMENT '分类描述',
  `created_at`  DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文章分类';

-- ============================================================================
-- 3. 标签表 (tags)
--    对应前端 Tag 接口
-- ============================================================================
CREATE TABLE IF NOT EXISTS `tags` (
  `id`         INT          NOT NULL AUTO_INCREMENT COMMENT '标签ID',
  `name`       VARCHAR(50)  NOT NULL                COMMENT '标签名称',
  `slug`       VARCHAR(100) NOT NULL                COMMENT 'URL友好标识',
  `created_at` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文章标签';

-- ============================================================================
-- 4. 文章表 (posts)
--    对应前端 Post 接口（不含 category 和 tags 关联字段，通过外键和多对多关联）
-- ============================================================================
CREATE TABLE IF NOT EXISTS `posts` (
  `id`          INT            NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  `title`       VARCHAR(200)   NOT NULL                COMMENT '文章标题',
  `slug`        VARCHAR(200)   NOT NULL                COMMENT 'URL友好标识',
  `excerpt`     VARCHAR(500)   NOT NULL                COMMENT '摘要',
  `content`     LONGTEXT       NOT NULL                COMMENT '正文(Markdown)',
  `cover_image` VARCHAR(500)   DEFAULT NULL            COMMENT '封面图URL',
  `category_id` INT            NOT NULL                COMMENT '分类ID',
  `published`   TINYINT(1)     NOT NULL DEFAULT 1      COMMENT '是否发布',
  `created_at`  DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at`  DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_slug` (`slug`),
  KEY `idx_category` (`category_id`),
  KEY `idx_published_created` (`published`, `created_at` DESC),
  CONSTRAINT `fk_posts_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文章';

-- ============================================================================
-- 5. 文章-标签关联表 (post_tags)
--    多对多关系：一篇文章可以有多个标签，一个标签可以对应多篇文章
-- ============================================================================
CREATE TABLE IF NOT EXISTS `post_tags` (
  `id`         INT      NOT NULL AUTO_INCREMENT COMMENT '主键',
  `post_id`    INT      NOT NULL                COMMENT '文章ID',
  `tag_id`     INT      NOT NULL                COMMENT '标签ID',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_post_tag` (`post_id`, `tag_id`),
  KEY `idx_tag` (`tag_id`),
  CONSTRAINT `fk_pt_post` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_pt_tag`  FOREIGN KEY (`tag_id`)  REFERENCES `tags` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文章-标签关联表';
