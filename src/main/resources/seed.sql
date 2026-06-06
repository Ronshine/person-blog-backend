-- ============================================================================
-- 个人博客 - 种子数据脚本
-- 使用: source seed.sql;  (需先执行 schema.sql)
-- 注意: 此脚本会清空现有数据，请谨慎使用
-- ============================================================================

USE `person_blog`;

-- ============================================================================
-- 清空现有数据（按照外键依赖顺序，先删除子表，再删除父表）
-- ============================================================================
SET FOREIGN_KEY_CHECKS = 0;  -- 临时禁用外键检查

TRUNCATE TABLE `post_tags`;
TRUNCATE TABLE `posts`;
TRUNCATE TABLE `categories`;
TRUNCATE TABLE `tags`;
TRUNCATE TABLE `blog_info`;

SET FOREIGN_KEY_CHECKS = 1;  -- 恢复外键检查

-- ============================================================================
-- 博客信息
-- ============================================================================
INSERT INTO `blog_info` (`title`, `subtitle`, `description`, `author_name`, `author_avatar`, `author_bio`, `social_github`, `social_twitter`, `social_email`) VALUES
    ('代码与故事', '用代码构建世界，用文字记录生活', '一个关于编程、技术和生活的个人博客',
     'Ron',
     'https://api.dicebear.com/9.x/notionists/svg?seed=Ron',
     '全栈开发者 / 开源爱好者 / 热爱分享',
     'https://github.com/ron',
     'https://twitter.com/ron',
     'ron@example.com');

-- ============================================================================
-- 分类
-- ============================================================================
INSERT INTO `categories` (`name`, `slug`, `description`) VALUES
                                                             ('前端开发',   'frontend',  '前端技术相关，包括 Vue、React、CSS 等'),
                                                             ('后端开发',   'backend',   '后端技术相关，包括 Spring Boot、数据库等'),
                                                             ('项目实践',   'projects',  '项目实战经验分享'),
                                                             ('运维部署',   'devops',    'DevOps、Docker 和部署相关'),
                                                             ('技术思考',   'thinking',  '技术趋势与深度思考'),
                                                             ('编程语言',   'languages', '编程语言学习笔记');

-- ============================================================================
-- 标签
-- ============================================================================
INSERT INTO `tags` (`name`, `slug`) VALUES
                                        ('Vue',         'vue'),
                                        ('TypeScript',  'typescript'),
                                        ('JavaScript',  'javascript'),
                                        ('Java',        'java'),
                                        ('Spring Boot', 'spring-boot'),
                                        ('架构',        'architecture'),
                                        ('CSS',         'css'),
                                        ('前端',        'frontend-tag'),
                                        ('Git',         'git'),
                                        ('工具',        'tools'),
                                        ('Docker',      'docker'),
                                        ('DevOps',      'devops'),
                                        ('趋势',        'trends'),
                                        ('AI',          'ai'),
                                        ('VS Code',     'vscode'),
                                        ('Rust',        'rust');

-- ============================================================================
-- 文章
-- ============================================================================
INSERT INTO `posts` (`title`, `slug`, `excerpt`, `content`, `cover_image`, `category_id`, `published`, `created_at`, `updated_at`) VALUES
                                                                                                                                       ('深入理解 Vue 3 组合式 API：从 Options 到 Composition 的优雅蜕变',
                                                                                                                                        'understanding-vue3-composition-api',
                                                                                                                                        'Vue 3 的组合式 API（Composition API）为组件逻辑组织带来了全新的可能性。本文将从实际场景出发，带你理解为什么需要组合式 API，以及如何优雅地组织代码。',
                                                                                                                                        '## 为什么需要组合式 API？\n\n在 Vue 2 的 Options API 中，我们习惯将组件代码按照 `data`、`methods`、`computed` 等选项进行组织。这种方式的优点是直观、规范，但随着组件复杂度的提升，同一个功能的代码会被分散在不同的选项中，导致代码可维护性下降。\n\n## 组合式 API 的核心优势\n\n### 1. 按功能组织代码\n\n组合式 API 允许我们将同一个功能的响应式状态、计算属性和方法组织在一起，而不是分散在不同的选项中。\n\n```vue\n<script setup lang="ts">\nimport { ref, computed } from \'vue\'\n\n// 用户相关功能\nconst user = ref<User | null>(null)\nconst isLoggedIn = computed(() => user.value !== null)\nfunction login() { /* ... */ }\nfunction logout() { /* ... */ }\n\n// 文章列表功能\nconst posts = ref<Post[]>([])\nconst loading = ref(false)\nasync function fetchPosts() { /* ... */ }\n</script>\n```\n\n### 2. 逻辑复用\n\n通过自定义 Hook（Composables），我们可以轻松地在组件间复用逻辑。\n\n## 总结\n\n组合式 API 不是对 Options API 的替代，而是对它的补充和增强。在简单组件中，Options API 仍然是一个好选择；而在复杂场景下，组合式 API 会带来更好的可维护性和复用性。',
                                                                                                                                        'https://picsum.photos/seed/vue3/800/400',
                                                                                                                                        (SELECT id FROM categories WHERE slug = 'frontend'), 1,
                                                                                                                                        '2026-05-28 09:00:00', '2026-05-28 09:00:00'),

                                                                                                                                       ('TypeScript 5 进阶指南：类型体操与实用技巧',
                                                                                                                                        'typescript-5-advanced-guide',
                                                                                                                                        'TypeScript 的类型系统远比想象中强大。本文将深入探讨条件类型、模板字面量类型、递归类型等高级用法，帮助你写出更安全的代码。',
                                                                                                                                        '## 条件类型：像 if/else 一样处理类型\n\n条件类型是 TypeScript 类型系统中最有威力的工具之一：\n\n```typescript\ntype IsString<T> = T extends string ? true : false\n// 使用\ntype A = IsString<\'hello\'>  // true\ntype B = IsString<42>        // false\n```\n\n## 模板字面量类型\n\nTypeScript 4.1+ 引入了模板字面量类型，让我们可以在类型层面操作字符串。\n\n## 递归类型\n\n递归类型在处理树形结构时特别有用。\n\n## 实用技巧\n\n1. 使用 `satisfies` 操作符确保类型的同时保留具体类型\n2. 用 `as const` 断言获取字面量类型\n3. 合理使用泛型约束',
                                                                                                                                        'https://picsum.photos/seed/typescript/800/400',
                                                                                                                                        (SELECT id FROM categories WHERE slug = 'frontend'), 1,
                                                                                                                                        '2026-05-25 14:30:00', '2026-05-25 14:30:00'),

                                                                                                                                       ('Spring Boot 3 + JPA 构建 RESTful API 的最佳实践',
                                                                                                                                        'spring-boot3-jpa-rest-api',
                                                                                                                                        'Spring Boot 3 带来了全新的体验。本文分享在实际项目中使用 Spring Boot 3 + JPA 构建 RESTful API 的经验和最佳实践。',
                                                                                                                                        '## 项目结构\n\n一个好的项目结构是代码可维护性的基础。\n\n## 使用 JPA 的最佳实践\n\n### 1. 实体设计\n\n```java\n@Entity\n@Table(name = "posts")\n@Data\n@NoArgsConstructor\npublic class Post {\n    @Id\n    @GeneratedValue(strategy = GenerationType.IDENTITY)\n    private Long id;\n\n    @NotBlank\n    @Column(nullable = false)\n    private String title;\n\n    @Lob\n    @Column(columnDefinition = "TEXT")\n    private String content;\n\n    @ManyToOne(fetch = FetchType.LAZY)\n    @JoinColumn(name = "category_id")\n    private Category category;\n\n    @CreationTimestamp\n    private LocalDateTime createdAt;\n}\n```\n\n### 2. Repository 设计\n\n利用 Spring Data JPA 的派生查询方法，大幅减少样板代码。\n\n### 3. 统一异常处理\n\n使用 `@RestControllerAdvice` 实现全局异常处理。',
                                                                                                                                        'https://picsum.photos/seed/springboot/800/400',
                                                                                                                                        (SELECT id FROM categories WHERE slug = 'backend'), 1,
                                                                                                                                        '2026-05-20 10:00:00', '2026-05-20 10:00:00'),

                                                                                                                                       ('从零开始搭建个人博客：技术栈选型与架构设计',
                                                                                                                                        'build-personal-blog-from-scratch',
                                                                                                                                        '搭建个人博客是每个开发者的里程碑项目。本文分享我的技术栈选择理由、前后端架构设计思路，以及开发过程中的经验教训。',
                                                                                                                                        '## 技术栈选型\n\n### 前端\n- **Vue 3**：轻量、灵活、生态成熟\n- **TypeScript**：类型安全，更好的开发体验\n- **Vite**：极速的开发服务器和构建\n- **Pinia**：简洁的状态管理\n\n### 后端\n- **Spring Boot 3**：企业级开发框架\n- **JPA / Hibernate**：ORM 解决方案\n- **MySQL**：稳定可靠的关系型数据库\n\n## 架构设计\n\n采用前后端分离架构：\n- 前端负责 UI 渲染和交互\n- 后端提供 RESTful API\n- 通过 JSON 进行数据交换\n\n## 开发经验\n\n1. 先规划好 API 接口再开发前端\n2. 做好 TypeScript 类型定义，减少运行时错误\n3. 使用 Git 进行版本控制，养成良好习惯\n4. 注重移动端适配，响应式设计',
                                                                                                                                        'https://picsum.photos/seed/blog/800/400',
                                                                                                                                        (SELECT id FROM categories WHERE slug = 'projects'), 1,
                                                                                                                                        '2026-05-15 08:00:00', '2026-05-15 08:00:00'),

                                                                                                                                       ('CSS Grid 与 Flexbox：现代布局完全指南',
                                                                                                                                        'css-grid-flexbox-guide',
                                                                                                                                        'CSS 布局已经进入了 Grid 和 Flexbox 的时代。本文将深入对比两种布局方式的使用场景，并通过大量实战示例帮助你掌握现代 CSS 布局。',
                                                                                                                                        '## Flexbox：一维布局的王者\n\nFlexbox 最适合处理**一维布局**——要么是行，要么是列。\n\n### 经典案例：导航栏\n\n```css\n.nav {\n  display: flex;\n  justify-content: space-between;\n  align-items: center;\n}\n```\n\n## CSS Grid：二维布局的终极方案\n\nGrid 适合处理**二维布局**——同时控制行和列。\n\n### 经典案例：博客卡片网格\n\n```css\n.card-grid {\n  display: grid;\n  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));\n  gap: 24px;\n}\n```\n\n## 何时使用什么？\n\n- **Flexbox**：导航栏、居中、表单布局、小部件排列\n- **Grid**：页面整体布局、卡片网格、仪表盘\n\n两者不是替代关系，而是互补关系。',
                                                                                                                                        'https://picsum.photos/seed/css/800/400',
                                                                                                                                        (SELECT id FROM categories WHERE slug = 'frontend'), 1,
                                                                                                                                        '2026-05-10 16:00:00', '2026-05-10 16:00:00'),

                                                                                                                                       ('Git 工作流实战：团队协作中的最佳实践',
                                                                                                                                        'git-workflow-best-practices',
                                                                                                                                        'Git 是现代软件开发不可或缺的工具。本文将介绍几种主流的 Git 工作流，分享在实际团队协作中的经验。',
                                                                                                                                        '## 主流 Git 工作流\n\n### GitHub Flow\n- main 分支始终可部署\n- 从 main 创建功能分支\n- 通过 Pull Request 合并代码\n\n### Git Flow\n- main：生产分支\n- develop：开发分支\n- feature/*：功能分支\n- release/*：发布分支\n- hotfix/*：紧急修复\n\n## 实用的 Git 技巧\n\n### 1. 交互式 rebase\n整理提交历史，保持提交记录的整洁。\n\n### 2. 修复上一次提交\n```bash\ngit commit --amend\n```\n\n### 3. 暂存工作进度\n```bash\ngit stash\ngit stash pop\n```\n\n## 提交信息规范\n\n推荐使用 Conventional Commits 规范：\n```\nfeat: 添加用户登录功能\nfix: 修复文章列表分页错误\nrefactor: 重构博客 API 调用逻辑\ndocs: 更新 README 文档\n```',
                                                                                                                                        'https://picsum.photos/seed/git/800/400',
                                                                                                                                        (SELECT id FROM categories WHERE slug = 'projects'), 1,
                                                                                                                                        '2026-05-05 11:00:00', '2026-05-05 11:00:00'),

                                                                                                                                       ('Docker 容器化部署：从开发到生产的完整流程',
                                                                                                                                        'docker-container-deployment',
                                                                                                                                        'Docker 让"在我机器上能跑"成为过去式。本文从实际项目出发，介绍如何使用 Docker 和 Docker Compose 实现应用的一键部署。',
                                                                                                                                        '## Dockerfile 编写最佳实践\n\n### 多阶段构建\n\n```dockerfile\n# 构建阶段\nFROM node:20 AS builder\nWORKDIR /app\nCOPY package*.json ./\nRUN npm ci\nCOPY . .\nRUN npm run build\n\n# 运行阶段\nFROM nginx:alpine\nCOPY --from=builder /app/dist /usr/share/nginx/html\nEXPOSE 80\nCMD ["nginx", "-g", "daemon off;"]\n```\n\n## Docker Compose 编排\n\n```yaml\nversion: \'3.8\'\nservices:\n  frontend:\n    build: ./frontend\n    ports:\n      - "80:80"\n  backend:\n    build: ./backend\n    ports:\n      - "8080:8080"\n  db:\n    image: mysql:8\n    environment:\n      MYSQL_ROOT_PASSWORD: example\n    volumes:\n      - db_data:/var/lib/mysql\n\nvolumes:\n  db_data:\n```\n\n## 部署到服务器\n\n使用 Docker Compose 实现一键部署。配合 CI/CD 流水线，实现自动化构建和部署。',
                                                                                                                                        'https://picsum.photos/seed/docker/800/400',
                                                                                                                                        (SELECT id FROM categories WHERE slug = 'devops'), 1,
                                                                                                                                        '2026-04-28 09:00:00', '2026-04-28 09:00:00'),

                                                                                                                                       ('2026 年 Web 开发趋势展望',
                                                                                                                                        'web-development-trends-2026',
                                                                                                                                        'Web 开发领域日新月异。本文展望 2026 年最值得关注的技术趋势，包括 AI 辅助开发、WebAssembly、边缘计算等方向。',
                                                                                                                                        '## AI 辅助开发\n\n2026 年，AI 已经成为开发者不可或缺的工具：\n- **代码补全**：从简单的补全到上下文感知的代码生成\n- **自动化测试**：AI 自动生成测试用例\n- **代码审查**：AI 辅助发现潜在问题\n\n## WebAssembly（Wasm）的崛起\n\nWebAssembly 正在改变 Web 开发的格局。\n\n## 边缘计算\n\n边缘计算让应用更快、更可靠。\n\n## 元框架时代\n\nNext.js、Nuxt 等元框架继续引领全栈开发趋势，服务端渲染（SSR）和静态站点生成（SSG）成为标配。',
                                                                                                                                        'https://picsum.photos/seed/trends/800/400',
                                                                                                                                        (SELECT id FROM categories WHERE slug = 'thinking'), 1,
                                                                                                                                        '2026-04-20 14:00:00', '2026-04-20 14:00:00'),

                                                                                                                                       ('VS Code 插件推荐：提升开发效率的 10 个必备工具',
                                                                                                                                        'vscode-essentials-plugins',
                                                                                                                                        'VS Code 的强大之处在于其丰富的插件生态。本文精选 10 个经过实战检验的插件，从代码编辑到项目管理，全方位提升你的开发效率。',
                                                                                                                                        '## 1. Error Lens\n\n将错误信息直接显示在代码行尾，无需悬停鼠标查看。\n\n## 2. GitHub Copilot\n\nAI 代码补全的标杆，2026 年已经成为开发者的标配工具。\n\n## 3. Prettier\n\n代码格式化工具，配合 ESLint 使用效果更佳。\n\n## 4. GitLens\n\n在代码中直观显示 Git 历史信息。\n\n## 5. Thunder Client\n\n轻量级 API 测试工具。\n\n## 6. Tailwind CSS IntelliSense\n\nTailwind CSS 的智能提示插件。\n\n## 7. Docker\n\n直接在 VS Code 中管理 Docker 容器和镜像。\n\n## 8. Better Comments\n\n用颜色区分不同类型的注释。\n\n## 9. Material Icon Theme\n\n文件图标主题，通过图标快速识别文件类型。\n\n## 10. Live Share\n\n实时协作编辑，支持远程结对编程。',
                                                                                                                                        'https://picsum.photos/seed/vscode/800/400',
                                                                                                                                        (SELECT id FROM categories WHERE slug = 'projects'), 1,
                                                                                                                                        '2026-04-15 10:00:00', '2026-04-15 10:00:00'),

                                                                                                                                       ('Rust 入门笔记：为什么它值得学习？',
                                                                                                                                        'rust-introduction-notes',
                                                                                                                                        'Rust 连续多年被评为最受喜爱的编程语言。本文从初学者的视角，分享 Rust 的学习心得及在前端工具链和系统编程领域的应用。',
                                                                                                                                        '## 为什么学习 Rust？\n\nRust 结合了 C/C++ 的性能和现代语言的安全性：\n- **内存安全**：所有权系统在编译期防止内存错误\n- **零成本抽象**：高级抽象没有运行时开销\n- **优秀的工具链**：Cargo、rustfmt、clippy\n- **活跃的社区**：连续多年 Stack Overflow 最受喜爱语言\n\n## 核心概念速览\n\n### 所有权\n```rust\nfn main() {\n    let s = String::from("hello");\n    takes_ownership(s);\n    // println!("{}", s); // 这里会编译错误，因为 s 的所有权已经转移\n}\n\nfn takes_ownership(some_string: String) {\n    println!("{}", some_string);\n}\n```\n\n### 借用\n```rust\nfn main() {\n    let s = String::from("hello");\n    let len = calculate_length(&s);\n    println!("The length of \'{}\' is {}.", s, len);\n}\n\nfn calculate_length(s: &String) -> usize {\n    s.len()\n}\n```\n\n## Rust 在 Web 开发中的应用\n\n- **SWC**：基于 Rust 的 JavaScript/TypeScript 编译器\n- **TurboPack**：Rust 编写的 Webpack 继任者\n- **Deno**：Node.js 的竞争者，部分使用 Rust',
                                                                                                                                        'https://picsum.photos/seed/rust/800/400',
                                                                                                                                        (SELECT id FROM categories WHERE slug = 'languages'), 1,
                                                                                                                                        '2026-04-10 08:30:00', '2026-04-10 08:30:00');

-- ============================================================================
-- 文章-标签关联
-- ============================================================================
INSERT INTO `post_tags` (`post_id`, `tag_id`) VALUES
-- 文章1: Vue + TypeScript
((SELECT id FROM posts WHERE slug = 'understanding-vue3-composition-api'), (SELECT id FROM tags WHERE slug = 'vue')),
((SELECT id FROM posts WHERE slug = 'understanding-vue3-composition-api'), (SELECT id FROM tags WHERE slug = 'typescript')),

-- 文章2: TypeScript + JavaScript
((SELECT id FROM posts WHERE slug = 'typescript-5-advanced-guide'), (SELECT id FROM tags WHERE slug = 'typescript')),
((SELECT id FROM posts WHERE slug = 'typescript-5-advanced-guide'), (SELECT id FROM tags WHERE slug = 'javascript')),

-- 文章3: Java + Spring Boot
((SELECT id FROM posts WHERE slug = 'spring-boot3-jpa-rest-api'), (SELECT id FROM tags WHERE slug = 'java')),
((SELECT id FROM posts WHERE slug = 'spring-boot3-jpa-rest-api'), (SELECT id FROM tags WHERE slug = 'spring-boot')),

-- 文章4: Vue + Spring Boot + 架构
((SELECT id FROM posts WHERE slug = 'build-personal-blog-from-scratch'), (SELECT id FROM tags WHERE slug = 'vue')),
((SELECT id FROM posts WHERE slug = 'build-personal-blog-from-scratch'), (SELECT id FROM tags WHERE slug = 'spring-boot')),
((SELECT id FROM posts WHERE slug = 'build-personal-blog-from-scratch'), (SELECT id FROM tags WHERE slug = 'architecture')),

-- 文章5: CSS + 前端
((SELECT id FROM posts WHERE slug = 'css-grid-flexbox-guide'), (SELECT id FROM tags WHERE slug = 'css')),
((SELECT id FROM posts WHERE slug = 'css-grid-flexbox-guide'), (SELECT id FROM tags WHERE slug = 'frontend-tag')),

-- 文章6: Git + 工具
((SELECT id FROM posts WHERE slug = 'git-workflow-best-practices'), (SELECT id FROM tags WHERE slug = 'git')),
((SELECT id FROM posts WHERE slug = 'git-workflow-best-practices'), (SELECT id FROM tags WHERE slug = 'tools')),

-- 文章7: Docker + DevOps
((SELECT id FROM posts WHERE slug = 'docker-container-deployment'), (SELECT id FROM tags WHERE slug = 'docker')),
((SELECT id FROM posts WHERE slug = 'docker-container-deployment'), (SELECT id FROM tags WHERE slug = 'devops')),

-- 文章8: 趋势 + AI
((SELECT id FROM posts WHERE slug = 'web-development-trends-2026'), (SELECT id FROM tags WHERE slug = 'trends')),
((SELECT id FROM posts WHERE slug = 'web-development-trends-2026'), (SELECT id FROM tags WHERE slug = 'ai')),

-- 文章9: 工具 + VS Code
((SELECT id FROM posts WHERE slug = 'vscode-essentials-plugins'), (SELECT id FROM tags WHERE slug = 'tools')),
((SELECT id FROM posts WHERE slug = 'vscode-essentials-plugins'), (SELECT id FROM tags WHERE slug = 'vscode')),

-- 文章10: Rust + JavaScript
((SELECT id FROM posts WHERE slug = 'rust-introduction-notes'), (SELECT id FROM tags WHERE slug = 'rust')),
((SELECT id FROM posts WHERE slug = 'rust-introduction-notes'), (SELECT id FROM tags WHERE slug = 'javascript'));