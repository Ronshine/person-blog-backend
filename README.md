# 📝 Ronshine 个人博客 - 后端

[![Java](https://img.shields.io/badge/Java-17-ED8B00?logo=openjdk&logoColor=white)](https://adoptium.net/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.2.5-6DB33F?logo=springboot&logoColor=white)](https://spring.io/projects/spring-boot)
[![MyBatis](https://img.shields.io/badge/MyBatis-3.0.3-000000?logo=mybatis&logoColor=white)](https://mybatis.org/spring-boot-starter/)
[![MySQL](https://img.shields.io/badge/MySQL-8-4479A1?logo=mysql&logoColor=white)](https://www.mysql.com/)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

个人博客系统的后端 API 服务，提供 RESTful 接口给前端（Vue 3）调用。

- **配套前端仓库**: 待补充

---

## 📋 目录

- [技术栈](#-技术栈)
- [项目结构](#-项目结构)
- [快速开始](#-快速开始)
- [API 文档](#-api-文档)
- [数据库设计](#-数据库设计)
- [开发指南](#-开发指南)

---

## 🛠 技术栈

| 技术              | 版本    | 说明                        |
| ----------------- | ------- | --------------------------- |
| Java              | 17      | 运行环境                    |
| Spring Boot       | 3.2.5   | 应用框架                    |
| MyBatis           | 3.0.3   | ORM 框架                    |
| MySQL             | 8.x     | 数据库                      |
| Lombok            | —       | 代码简洁（编译期注解）      |
| Maven             | —       | 项目构建与管理              |
| Bean Validation   | —       | 参数校验（配合 DTO 使用）   |

---

## 📁 项目结构

```
blog-backend/
├── src/main/java/online/ronshine/blog/
│   ├── BlogApplication.java          # 启动入口
│   ├── config/
│   │   ├── CorsConfig.java           # CORS 跨域配置
│   │   └── WebMvcConfig.java         # 静态资源映射（/uploads/**）
│   ├── controller/
│   │   ├── BlogInfoController.java   # 博客信息 API
│   │   ├── PostController.java       # 文章 API
│   │   ├── CategoryController.java   # 分类 API
│   │   ├── TagController.java        # 标签 API
│   │   └── ArchiveController.java    # 归档 API
│   ├── service/
│   │   ├── BlogInfoService.java
│   │   ├── PostService.java
│   │   ├── CategoryService.java
│   │   ├── TagService.java
│   │   └── ArchiveService.java
│   │   └── impl/                     # 各 Service 实现类
│   ├── mapper/                       # MyBatis Mapper 接口
│   ├── pojo/
│   │   ├── entity/                   # 数据库实体（Post, Category, Tag 等）
│   │   └── dto/                      # 数据传输对象（PostQueryDTO）
│   └── vo/                           # 视图对象（Result, PageResult, PostVO 等）
├── src/main/resources/
│   ├── mapper/                       # MyBatis XML 映射文件
│   ├── schema.sql                    # 数据库建表脚本
│   └── seed.sql                      # 种子数据脚本
└── pom.xml                           # Maven 依赖配置
```

### 分层架构说明

```
Controller (接收请求 / 响应 JSON)
    ↓
Service (业务逻辑)
    ↓
Mapper (数据库访问，MyBatis)
    ↓
MySQL (数据存储)
```

---

## 🚀 快速开始

### 前置要求

- JDK 17+
- Maven 3.6+
- MySQL 8.0+

### 1. 克隆项目

```bash
git clone <仓库地址>
cd blog-backend
```

### 2. 创建数据库

```bash
mysql -u root -p < src/main/resources/schema.sql
mysql -u root -p < src/main/resources/seed.sql
```

`schema.sql` 创建 `person_blog` 数据库及所有表结构；`seed.sql` 插入示例博客数据（10 篇示例文章、6 个分类、16 个标签）。

### 3. 配置数据库连接

在 `src/main/resources/` 下创建 `application.yml`：

```yaml
server:
  port: 8080

spring:
  datasource:
    url: jdbc:mysql://localhost:3306/person_blog?useUnicode=true&characterEncoding=utf8mb4&serverTimezone=Asia/Shanghai
    username: root
    password: your_password
    driver-class-name: com.mysql.cj.jdbc.Driver

mybatis:
  mapper-locations: classpath:mapper/*.xml
  type-aliases-package: online.ronshine.blog.pojo.entity
  configuration:
    map-underscore-to-camel-case: true

logging:
  level:
    online.ronshine.blog.mapper: debug
```

> ⚠️ 本地敏感配置（如数据库密码）建议放入 `application-local.yml`，已被 `.gitignore` 排除。

### 4. 启动项目

```bash
mvn spring-boot:run
```

或编译后运行：

```bash
mvn clean package -DskipTests
java -jar target/blog-backend-1.0.0.jar
```

服务默认启动在 `http://localhost:8080`。

### 5. 验证

```bash
curl http://localhost:8080/api/blog/info
```

返回博客基本信息即表示启动成功。

---

## 📖 API 文档

所有接口统一返回 `Result<T>` 结构：

```json
{
  "code": 200,
  "message": "success",
  "data": { ... }
}
```

分页接口返回 `PageResult<T>`：

```json
{
  "code": 200,
  "message": "success",
  "data": {
    "items": [ ... ],
    "pagination": {
      "page": 1,
      "pageSize": 6,
      "total": 10,
      "totalPages": 2
    }
  }
}
```

### 博客信息

| 方法 | 路径            | 说明         | 返回                    |
|------|-----------------|--------------|------------------------|
| GET  | `/api/blog/info` | 获取博客基本信息 | `BlogInfoVO` |

### 文章

| 方法 | 路径                              | 说明                 | 返回              |
|------|------------------------------------|----------------------|--------------------|
| GET  | `/api/posts`                       | 分页获取文章列表     | `PageResult<PostSummaryVO>` |
| GET  | `/api/posts/{slug}`                | 根据 slug 获取文章详情 | `PostVO` |
| GET  | `/api/posts/id/{id}`               | 根据 ID 获取文章详情  | `PostVO` |
| GET  | `/api/posts/search?q=keyword`      | 搜索文章（标题 + 摘要） | `List<PostSummaryVO>` |
| GET  | `/api/posts/byTag?tagSlug=vue`     | 根据标签 slug 获取文章 | `List<PostSummaryVO>` |
| GET  | `/api/posts/byCategory?categorySlug=frontend` | 根据分类 slug 获取文章 | `List<PostSummaryVO>` |

**文章列表查询参数**（`/api/posts`）：

| 参数           | 类型     | 说明                     | 默认值 |
|----------------|----------|--------------------------|--------|
| `page`         | `Integer` | 页码                    | 1      |
| `pageSize`     | `Integer` | 每页条数                | 6      |
| `categorySlug` | `String`  | 按分类 slug 筛选        | —      |
| `tagSlug`      | `String`  | 按标签 slug 筛选        | —      |
| `keyword`      | `String`  | 按关键词搜索标题/摘要   | —      |

### 分类

| 方法 | 路径                | 说明         | 返回                  |
|------|---------------------|--------------|------------------------|
| GET  | `/api/categories`   | 获取所有分类 | `List<CategoryVO>` |

### 标签

| 方法 | 路径          | 说明       | 返回              |
|------|---------------|------------|-------------------|
| GET  | `/api/tags`   | 获取所有标签 | `List<TagVO>` |

### 归档

| 方法 | 路径             | 说明                       | 返回                |
|------|------------------|----------------------------|----------------------|
| GET  | `/api/archives`  | 按年月分组的文章归档       | `List<ArchiveVO>` |

---

## 🗄 数据库设计

### ER 关系

```
blog_info  (1) ----- 单行配置表
categories (1) ----- (*) posts (*) ----- (*) tags
                      通过 post_tags 关联
```

### 表结构

| 表名          | 说明                     | 关键字段                                       |
|---------------|--------------------------|------------------------------------------------|
| `blog_info`   | 博客基本信息（单行）      | title, subtitle, description, author_*, social_* |
| `categories`  | 文章分类                 | name, slug (唯一)                              |
| `tags`        | 文章标签                 | name, slug (唯一)                              |
| `posts`       | 文章（含 Markdown 正文） | title, slug, excerpt, content (LONGTEXT), category_id |
| `post_tags`   | 文章-标签关联表          | post_id, tag_id (联合唯一)                     |

### 建表脚本

参见 `src/main/resources/schema.sql`，使用 `utf8mb4` 字符集，支持中文和 Emoji。

### 种子数据

参见 `src/main/resources/seed.sql`，包含：

- 1 条博客基础配置
- 6 个文章分类（前端开发、后端开发、项目实践、运维部署、技术思考、编程语言）
- 16 个文章标签（Vue、TypeScript、Java、Spring Boot 等）
- 10 篇示例文章（含 Markdown 正文和封面图）

---

## 🧑‍💻 开发指南

### 添加新字段 / 表

1. 修改/新建 `entity` 类
2. 添加 `Mapper` 接口方法
3. 编写对应的 XML 映射 SQL
4. 在 `Service` 层处理业务逻辑
5. 在 `Controller` 层暴露 API
6. 更新 `VO` 响应对象

### 代码风格

- 使用 Lombok `@Data`, `@RequiredArgsConstructor` 等注解减少样板代码
- 统一通过 `Result.success()` / `Result.error()` 返回响应
- Controller 保持轻量，业务逻辑放在 Service 层
- Mapper XML 中合理使用 `<sql>` 片段进行 SQL 复用

### 静态资源

通过 `WebMvcConfig` 将 `/uploads/**` 映射到本地 `uploads/` 目录，用于封面图等文件访问。

### CORS

通过 `CorsConfig` 全局开启跨域支持，允许所有来源访问 `/api/**` 路径。

---

## 📄 License

[MIT](LICENSE)
