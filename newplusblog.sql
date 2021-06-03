/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 80013
Source Host           : localhost:3306
Source Database       : newplusblog

Target Server Type    : MYSQL
Target Server Version : 80013
File Encoding         : 65001

Date: 2021-06-03 17:37:33
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `blog`
-- ----------------------------
DROP TABLE IF EXISTS `blog`;
CREATE TABLE `blog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '博客标题',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '博客描述',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '博客内容',
  `status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '博客状态(1:开启，0:关闭)',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(3) NOT NULL DEFAULT '0' COMMENT '逻辑删除(1:已删除，0:未删除)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of blog
-- ----------------------------
INSERT INTO `blog` VALUES ('1', '1', 'mavon-editor 使用教程', 'mavon-editor 关于图片上传的使用教程', 'mavon-editor是一款基于vue的markdown编辑器，比较适合博客系统。由于官网对于一些细节的说明不够详细，这里对这里对该编辑器的使用做一个总结。\n\n1. 安装\n2. 基本使用\n3. 图片上传(含服务端)\n安装\nnpm install mavon-editor --save\n\n基本使用\n在vue-cli构建的脚手架离得main.js可以像这样引用：\n```vue\n    // 全局注册\n    import Vue from \'vue\'\n    import mavonEditor from \'mavon-editor\'\n    import \'mavon-editor/dist/css/index.css\'\n    // use\n    Vue.use(mavonEditor)\n    new Vue({\n        \'el\': \'#main\'\n    })\n\n```\n在具体的组件里html里定义挂载点\n```vue\n\"main\">\n    <mavon-editor v-model=\"value\"/>\ndiv>\n```\n![mavon.jpg](https://newplusblog.oss-cn-hangzhou.aliyuncs.com/博客图片/2021/六月/01/b2061879bbcd4b4da0d6831c19b1b48cmavon.jpg)\n图1.1\n\n图片上传：\n先将挂在点里的方法写好，就像这样\n```vue\n class=\"content-content\">\n     <mavon-editor \n     v-model = \'editorContent\'\n     :ishljs=\"true\"\n      :codeStyle=\"code_style\"\n     ref=md @imgAdd=\"$imgAdd\" @imgDel=\"$imgDel\"\n      />\n el-main>\n```\n主要是将ref=md @imgAdd=\"$imgAdd\" @imgDel=\"$imgDel\"放进去，其他是我的其他代码。\n然后定义$imgAdd和$imgDel方法:\n```vue\n// 绑定@imgAdd event\n$imgAdd(pos, $file) {\n    // 第一步.将图片上传到服务器.\n    var formdata = new FormData();\n    formdata.append(\'image\', $file);\n    this.img_file[pos] = $file;\n    this.$http({\n        url: \'/api/edit/uploadimg\',\n        method: \'post\',\n        data: formdata,\n        headers: { \'Content-Type\': \'multipart/form-data\' },\n    }).then((res) => {\n        let _res = res.data;\n        // 第二步.将返回的url替换到文本原位置[外链图片转存失败(img-Anv63SQR-1564734760257)(0)] -> [外链图片转存失败(img-OVX7vZS4-1564734760259)(url)]\n        this.$refs.md.$img2Url(pos, _res.url);\n    })\n},\n$imgDel(pos) {\n    delete this.img_file[pos];\n}\n```\n这里注意我的this.$https就是我的axios对象（用过vue-cli的都懂的），然后this.img_file是我之前定义的一个空对象。this.$refs.md和挂在点定义的要保持一致。\n剩下的就是交给服务端去处理了：\nkoa解决文件上传\n大家有不明白的地方或者需要我补充更正的地方欢迎留言~', '1', '2021-06-01 13:38:58', '2021-06-01 13:38:58', '0');
INSERT INTO `blog` VALUES ('2', '1', 'vue表单验证错误', 'VUE表单验证报错：Error in v-on handler: \"TypeError: Cannot read property \'validate\' of undefined\"解决', '![vue表单验证错误.png](https://newplusblog.oss-cn-hangzhou.aliyuncs.com/博客图片/2021/六月/01/f475e9d48dce4c89a3762865d11acd57vue表单验证错误.png)\n去看一下表单验证的代码，找到这一句：\n\nthis.$refs[formName].validate((valid) => {\n看看这里refs的值与el-form上绑定的ref值一直不一致，注意：把refs和ref名字保持一致就行了', '1', '2021-06-01 13:40:14', '2021-06-01 13:40:14', '0');
INSERT INTO `blog` VALUES ('3', '1', 'springBoot 启动报错', 'springBoot 启动 If you want an embedded database (H2, HSQL or Derby), please put it on the classpath.', '产生这个错误的原因是springboot的自动配置，如果你没有配置DataSource就会导致下图这个错误\n\n![springboot自动装配数据库.png](https://newplusblog.oss-cn-hangzhou.aliyuncs.com/博客图片/2021/六月/01/bbe241f40596482abe33fe17a76ef8a1springboot自动装配数据库.png)\n不想连接数据库的话有以下解决方案\n\n解决方案1\n\n```java\n@SpringBootApplication(exclude = DataSourceAutoConfiguration.class)//排除自动配置\npublic class ErukaServerMain {\n    public static void main(String[] args) {\n        SpringApplication.run(ErukaServerMain.class,args);\n    }\n}\n```\n解决方案2\n\n如果以上方法不行那就，将pom文件带有数据库相关的删除，例如：jdbc、mysql-connect等等', '1', '2021-06-01 13:42:12', '2021-06-01 14:10:03', '0');
INSERT INTO `blog` VALUES ('4', '2', 'IDEA删除子模块并重建后MAVEN无法识别', 'IDEA删除子模块然后重新用相同的名字重建后MAVEN无法识别', '**IDEA问题**\n- 问题描述\n\n删除maven父工程的一个子工程并重新创建后，maven无法识别。问题现象会有：\n> 1.导入依赖但是项目无法识别\n2.右侧maven工具栏显示本子模块为（root）\n3.resouces的application.yml无法识别为springboot的配置文件\n\n**问题解决**\n\n- 问题原因\n本子模块可能被忽略掉了\n- 问题解决\nfile -> settings -> 搜索maven -> ignored Files 看看里面本子模块是不是本勾选了，去掉即可\n\n![springboot忽略.png](https://newplusblog.oss-cn-hangzhou.aliyuncs.com/博客图片/2021/六月/01/0d48c6a4ed7648ac97a3ba0f4a314261springboot忽略.png)', '1', '2021-06-01 13:46:30', '2021-06-01 13:46:30', '0');
INSERT INTO `blog` VALUES ('5', '2', 'idea配置service启动', 'service没有显示的问题解决', '1.打开idea，在左侧项目展示栏中找到.idea，双击打开.idea\n\n![idea.png](https://newplusblog.oss-cn-hangzhou.aliyuncs.com/博客图片/2021/六月/01/2b412bead62e437b9fca30c2d3279eefidea.png)\n\n2.在.idea下双击打开workspace.xml\n\n![workspace.png](https://newplusblog.oss-cn-hangzhou.aliyuncs.com/博客图片/2021/六月/01/b9ac7f1fc52f45fd85b57d53c3862981workspace.png)\n\n3.编辑workspace.xml文件，在结尾添加如下配置代码\n\n```xml\n<component name=\"RunDashboard\">\n\n  <option name=\"configurationTypes\">\n\n    <set>\n\n      <option value=\"SpringBootApplicationConfigurationType\" />\n\n    </set>\n\n  </option>\n\n</component>\n```\n\n![位置.png](https://newplusblog.oss-cn-hangzhou.aliyuncs.com/博客图片/2021/六月/01/af29b1a939404b1fbe4655b7a423ce1a位置.png)\n\n4.保存配置文件，重启idea开发工具，重启项目，此时可以在下方工具栏Services窗口看到如图的执行窗口了\n\n![执行窗口.png](https://newplusblog.oss-cn-hangzhou.aliyuncs.com/博客图片/2021/六月/01/2981b8c8713741d3939e3acf0f985b7b执行窗口.png)', '1', '2021-06-01 13:50:52', '2021-06-01 14:15:22', '0');
INSERT INTO `blog` VALUES ('6', '3', '程序员是做什么的', '程序员是做什么的呢？', '\n很多同学以为程序员一天到晚的工作就是写代码，写代码，写代码！\n\n其实不是的。写代码只是很少很少的一部分工作，其实更多的时候，我们：\n\n**读别人的代码**\n\n通常我们进入公司以后，不会是重头开始一个项目，而是在已有代码的基础上进行维护或新功能的开发，所以必须“读代码”。\n\n读有“泛读”，了解系统架构、功能模块，对系统有一个大致的认识，各个功能能找到相应代码实现的位置。\n\n还有“精读”，通常就是调试了，在fix bug的时候使用。此外还包括审核：一些规范一点的公司，都会有codereview，也是精读，但不用debug。\n\n对于一个成熟的项目来说，读代码——而不是写代码——可能是最耗时间的工作了。\n\n**写注释文档**\n\n为了减少“读代码”的时间，我们不得不花时间“写注释”“写文档”——这个程序员最深恶痛绝的工作。所以现在“烂代码才需要注释”的声音变得越来越强，但无论如何，文档还是要写的。（注意：要能区分注释和文档）\n\n**了解需求**\n\n好了，终于到了“写代码”的时间了。\n\n然而，在动手开始写代码之前，你必须花时间“了解需求”。和自己写个小程序玩玩不同，在公司，你是为别人写代码，所以你一定要了解别人究竟想实现什么功能。通常，这并没有你想像的那么简单，需要反复的沟通。\n\n当然，也有一些团队和个人，不愿意在这上面“浪费时间”，通常他们的下场就是不断的写代码，然后不断的改代码，加班加点的做大量的无用功，整个公司怨气冲天一地鸡毛。\n\n![被打.jpg](https://newplusblog.oss-cn-hangzhou.aliyuncs.com/博客图片/2021/六月/01/cef3740423104119be5e875128f3f622被打.jpg)\n\n**开发中的其他各种沟通**\n\n大家都恨产品经理。\n\n但其实产品经理只是我们最恨的人之一，我们还恨前端、后端、DBA、测试……承认吧！因为我们是团队开发，说好的团队精神有没有我不知道，但各种摩擦扯皮是必须的。\n\n比如前端要后台给一个接口，后台给不出来或者嫌麻烦；比如后台跪求DBA的权限，DBA优化数据库时说Developer都一群傻逼；比如测试一次又一次的报bug我特么像杀人的时候……\n\n这些都需要沟通，也就是需要时间和精力。\n\n**其他无聊的办公室活动**\n\n比如写日报周报，应付各种KPI，这是所有工种都干的活，就不多说了。\n\n总之，程序员真正写代码的时间其实不多。个人觉得，一天能有30%的时间安安静静的写代码，就算是不错的工作环境了。\n\n不论是我们的大学教育也好，培训机构也罢，都只知道知识的灌输，而忽略了程序员工作能力的培养。这些能力，即只能在工作中“自学”获得，所以你看这些公司的招聘，都要求“两年以上工作经验”，意思就是：一般的新人，起码要两年的时间，才能“习得”这些起码的工作技能。\n\n能不能有所改变呢？\n\n我想试一试。\n', '1', '2021-06-01 13:57:49', '2021-06-01 14:14:55', '0');
INSERT INTO `blog` VALUES ('7', '3', '如何当一个好的管理者', '如何当一个好的管理者', '　管理者应具备的六大能力 ：\n\n　　1、沟通能力。为了了解组织内部员工互动的状况，倾听职员心声，一个管理者需要具备良好的沟通能力，其中又以“善于倾听”最为重要。惟有如此，才不至于让下属离心离德，或者不敢提出建设性的提议与需求，而管理者也可借由下属的认同感、理解程度及共鸣，得知自己的沟通技巧是否成功。\n\n　　2、协调能力。管理者应该要能敏锐地觉察部属的情绪，并且建立疏通、宣泄的管道，切勿等到对立加深、矛盾扩大后，才急于着手处理与排解。此外，管理者对于情节严重的冲突，或者可能会扩大对立面的矛盾事件，更要果决地加以排解。即使在状况不明、是非不清的时候，也应即时采取降温、冷却的手段，并且在了解情况后，立刻以妥善、有效的策略化解冲突。只要把握消除矛盾的先发权和主动权，任何形式的对立都能迎刃而解。\n\n　　3、　规划与统整能力。管理者的规划能力，并非着眼于短期的策略规划，而是长期计划的制定。换言之，卓越的管理者必须深谋远虑、有远见，不能目光如豆，只看得见现在而看不到未来，而且要适时让员工了解公司的远景，才不会让员工迷失方向。特别是进行决策规划时，更要能妥善运用统整能力，有效地利用部属的智慧与既有的资源，避免人力浪费。\n\n　　4、决策与执行能力。在民主时代，虽然有许多事情以集体决策为宜，但是管理者仍经常须独立决策，包括分派工作、人力协调、化解员工纷争等等，这都往往考验着管理者的决断能力。\n\n　　5、培训能力。管理者必然渴望拥有一个实力坚强的工作团队，因此，培养优秀人才，也就成为管理者的重要任务。\n\n　　6、统驭能力。有句话是这样说的：“一个领袖不会去建立一个企业，但是他会建立一个组织来建立企业。”根据这种说法，当一个管理者的先决条件，就是要有能力建立团队，才能进一步建构企业。但无论管理者的角色再怎么复杂多变，赢得员工的信任都是首要的条件。\n\n　　管理者需要具备的管理技能主要有：\n\n　　1、技术技能\n\n　　技术技能是指对某一特殊活动——特别是包含方法、过程、程序或技术的活动——的理解和熟练。它包括专门知识、在专业范围内的分析能力以及灵活地运用该专业的工具和技巧的能力。技术技能主要是涉及到“物” ( 过程或有形的物体 ) 的工作。\n\n　　2、人事技能\n\n　　人事技能是指一个人能够以小组成员的身份有效地工作的行政能力，并能够在他所领导的小组中建立起合作的努力，也即协作精神和团队精神，创造一种良好的氛围，以使员工能够自由地无所顾忌地表达个人观点的能力。管理者的人事技能是指管理者为完成组织目标应具备的领导、激励和沟通能力。\n\n　　3、思想技能\n\n　　思想技能包含：“把企业看成一个整体的能力，包括识别一个组织中的彼此互相依赖的各种职能，一部分的改变如何能影响所有其他各部分，并进而影响个别企业与工业、社团之间，以及与国家的政治、社会和经济力量这一总体之间的关系。”即能够总揽全局，判断出重要因素并了解这些因素之间关系的能力。\n\n　　4、设计技能\n\n　　设计技能是指以有利于组织利益的种种方式解决问题的能力，特别是高层管理者不仅要发现问题，还必须像一名优秀的设计师那样具备找出某一问题切实可行的解决办法的能力。如果管理者只能看到问题的存在，并只是“看到问题的人”，他们就是不合格的管理者。管理者还必须具备这样一种能力，即能够根据所面临的现状找出行得通的解决方法的能力。\n\n　　这些技能对于不同管理层次的管理者的相对重要性是不同的。技术技能、人事技能的重要性依据管理者所处的组织层次从低到高逐渐下降，而思想技能和设计技能则相反。对基层管理者来说，具备技术技能是最为重要的，具备人事技能在同下层的频繁交往中也非常有帮助。当管理者在组织中的组织层次从基层往中层、高层发展时，随着他同下级直接接触的次数和频率的减少，人事技能的重要性也逐渐降低。也就是说，对于中层管理者来说，对技术技能的要求下降，而对思想技能的要求上升，同时具备人事技能仍然很重要。但对于高层管理者而言，思想技能和设计技能特别重要，而对技术技能、人事技能的要求相对来说则很低。当然，这种管理技能和组织层次的联系并不是绝对的，组织规模大小等一些因素对此也会产生一定的影响.', '1', '2021-06-01 13:58:38', '2021-06-01 14:13:49', '0');

-- ----------------------------
-- Table structure for `oauth_client_details`
-- ----------------------------
DROP TABLE IF EXISTS `oauth_client_details`;
CREATE TABLE `oauth_client_details` (
  `client_id` varchar(255) NOT NULL,
  `resource_ids` varchar(255) DEFAULT NULL,
  `client_secret` varchar(255) DEFAULT NULL,
  `scope` varchar(255) DEFAULT NULL,
  `authorized_grant_types` varchar(255) DEFAULT NULL,
  `web_server_redirect_uri` varchar(255) DEFAULT NULL,
  `authorities` varchar(255) DEFAULT NULL,
  `access_token_validity` int(11) DEFAULT NULL,
  `refresh_token_validity` int(11) DEFAULT NULL,
  `additional_information` longtext,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `archived` tinyint(4) DEFAULT NULL,
  `trusted` tinyint(4) DEFAULT NULL,
  `autoapprove` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of oauth_client_details
-- ----------------------------
INSERT INTO `oauth_client_details` VALUES ('c1', 'res1', '$2a$10$Dappn49nM8ZjkCO3ASwR/evnHQN3iPH4npP45js0d9Ug3Vm4ui.sq', 'ROLE_ADMIN,ROLE_USER,ROLE_API', 'authorization_code,password,client_credentials,implicit,refresh_token', 'https://www.baidu.com', null, '7200', '259200', null, '2020-12-13 15:53:10', '0', '0', 'false');
INSERT INTO `oauth_client_details` VALUES ('c2', 'res2', 'secret', 'ROLE_API', 'authorization_code,password,client_credentials,implicit,refresh_token', 'https://www.baidu.com', null, '7200', '259200', null, '2020-12-13 15:53:10', '0', '0', 'false');

-- ----------------------------
-- Table structure for `permission`
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '权限码',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '权限描述',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '权限地址',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(3) NOT NULL DEFAULT '0' COMMENT '逻辑删除(1:已删除，0:未删除)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES ('1', 'p1', '管理员模块操作', '/blog', '2021-04-29 09:02:06', '2021-06-01 13:12:34', '0');
INSERT INTO `permission` VALUES ('2', 'p2', '运维模块操作', '/r/r2', '2021-04-29 09:02:06', '2021-06-01 13:13:10', '0');
INSERT INTO `permission` VALUES ('3', 'p3', '用户模块操作', '/r/r2', '2021-04-29 09:02:06', '2021-06-01 13:12:58', '0');

-- ----------------------------
-- Table structure for `role`
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` tinyint(3) NOT NULL DEFAULT '1',
  `deleted` tinyint(3) NOT NULL DEFAULT '0' COMMENT '用户状态(1:开启，0:关闭)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_idx_t_role_role_name` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '管理员', '系统的管理员', '2020-11-14 15:16:22', '2021-05-23 14:05:08', '1', '0');
INSERT INTO `role` VALUES ('2', '运维', '负责博客系统的运维', '2021-05-20 09:34:42', '2021-06-01 13:12:03', '1', '0');
INSERT INTO `role` VALUES ('3', '测试人员', '负责系统功能的测试', '2021-05-21 13:18:55', '2021-06-01 13:12:01', '1', '0');
INSERT INTO `role` VALUES ('4', '用户', '使用博客的基本操作', '2021-05-25 19:48:54', '2021-06-01 13:11:53', '1', '0');

-- ----------------------------
-- Table structure for `role_permission`
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `role_id` bigint(20) NOT NULL,
  `permission_id` bigint(20) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(3) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色(role)权限(permission)关系表';

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES ('1', '1', '2021-06-01 13:13:41', '0');
INSERT INTO `role_permission` VALUES ('1', '2', '2021-06-01 13:13:45', '0');
INSERT INTO `role_permission` VALUES ('1', '3', '2021-06-01 13:13:51', '0');
INSERT INTO `role_permission` VALUES ('2', '2', '2021-06-01 13:13:55', '0');
INSERT INTO `role_permission` VALUES ('2', '3', '2021-06-01 13:13:57', '0');
INSERT INTO `role_permission` VALUES ('3', '2', '2021-06-01 13:13:59', '0');
INSERT INTO `role_permission` VALUES ('3', '3', '2021-06-01 13:14:37', '0');
INSERT INTO `role_permission` VALUES ('4', '3', '2021-06-01 13:14:40', '0');

-- ----------------------------
-- Table structure for `systemlog`
-- ----------------------------
DROP TABLE IF EXISTS `systemlog`;
CREATE TABLE `systemlog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `operation` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `params` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of systemlog
-- ----------------------------
INSERT INTO `systemlog` VALUES ('1', 'tom', '根据用户id查看具体用户', '[1]', 'com.zwu.controller.UserController.findById', '0:0:0:0:0:0:0:1', '2021-06-01 13:15:56');
INSERT INTO `systemlog` VALUES ('2', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:16:00');
INSERT INTO `systemlog` VALUES ('3', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:16:00');
INSERT INTO `systemlog` VALUES ('4', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:16:49');
INSERT INTO `systemlog` VALUES ('5', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:16:49');
INSERT INTO `systemlog` VALUES ('6', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:17:06');
INSERT INTO `systemlog` VALUES ('7', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:17:06');
INSERT INTO `systemlog` VALUES ('8', 'tom', '根据用户id查看具体用户', '[1]', 'com.zwu.controller.UserController.findById', '0:0:0:0:0:0:0:1', '2021-06-01 13:17:09');
INSERT INTO `systemlog` VALUES ('9', 'tom', '根据用户id查看具体用户', '[1]', 'com.zwu.controller.UserController.findById', '0:0:0:0:0:0:0:1', '2021-06-01 13:17:21');
INSERT INTO `systemlog` VALUES ('10', 'tom', '根据用户id查看具体用户', '[1]', 'com.zwu.controller.UserController.findById', '0:0:0:0:0:0:0:1', '2021-06-01 13:17:32');
INSERT INTO `systemlog` VALUES ('11', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:17:35');
INSERT INTO `systemlog` VALUES ('12', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:17:35');
INSERT INTO `systemlog` VALUES ('13', 'tom', '更新用户', '[{\"avatar\":\"https://newplusblog.oss-cn-hangzhou.aliyuncs.com/用户头像/2021/六月/01/ce0add2e53674b6bb832f2a6f4325360dog.jpg\",\"email\":\"9068521999@qq.com\",\"fullName\":\"汤姆\",\"id\":1,\"mobile\":\"138585243102\",\"password\":\"$2a$10$/tHUEWcuiuPkx9D3mIhq9e2YTzc2nff13K3Xki4UULb4aFMtT/0Le\",\"roleId\":1,\"status\":1,\"username\":\"tom\"}]', 'com.zwu.controller.UserController.singleUpdate', '0:0:0:0:0:0:0:1', '2021-06-01 13:17:51');
INSERT INTO `systemlog` VALUES ('14', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:17:51');
INSERT INTO `systemlog` VALUES ('15', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:17:51');
INSERT INTO `systemlog` VALUES ('16', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:17:53');
INSERT INTO `systemlog` VALUES ('17', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:17:53');
INSERT INTO `systemlog` VALUES ('18', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:17:56');
INSERT INTO `systemlog` VALUES ('19', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 13:17:56');
INSERT INTO `systemlog` VALUES ('20', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 13:17:59');
INSERT INTO `systemlog` VALUES ('21', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 13:18:00');
INSERT INTO `systemlog` VALUES ('22', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 13:18:05');
INSERT INTO `systemlog` VALUES ('23', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 13:18:06');
INSERT INTO `systemlog` VALUES ('24', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 13:18:07');
INSERT INTO `systemlog` VALUES ('25', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 13:18:08');
INSERT INTO `systemlog` VALUES ('26', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 13:18:09');
INSERT INTO `systemlog` VALUES ('27', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 13:18:10');
INSERT INTO `systemlog` VALUES ('28', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 13:18:11');
INSERT INTO `systemlog` VALUES ('29', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:18:24');
INSERT INTO `systemlog` VALUES ('30', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 13:18:24');
INSERT INTO `systemlog` VALUES ('31', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 13:18:25');
INSERT INTO `systemlog` VALUES ('32', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 13:18:26');
INSERT INTO `systemlog` VALUES ('33', 'tom', '查看日志列表', '[1,10,\" \"]', 'com.zwu.controller.SystemLogController.list', '0:0:0:0:0:0:0:1', '2021-06-01 13:18:29');
INSERT INTO `systemlog` VALUES ('34', 'tom', '查看日志列表', '[2,10,\" \"]', 'com.zwu.controller.SystemLogController.list', '0:0:0:0:0:0:0:1', '2021-06-01 13:18:32');
INSERT INTO `systemlog` VALUES ('35', 'tom', '查看日志列表', '[3,10,\" \"]', 'com.zwu.controller.SystemLogController.list', '0:0:0:0:0:0:0:1', '2021-06-01 13:18:34');
INSERT INTO `systemlog` VALUES ('36', 'tom', '查看日志列表', '[1,10,\" \"]', 'com.zwu.controller.SystemLogController.list', '0:0:0:0:0:0:0:1', '2021-06-01 13:18:38');
INSERT INTO `systemlog` VALUES ('37', 'tom', '根据用户id查看具体用户', '[1]', 'com.zwu.controller.UserController.findById', '0:0:0:0:0:0:0:1', '2021-06-01 13:18:39');
INSERT INTO `systemlog` VALUES ('38', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:18:40');
INSERT INTO `systemlog` VALUES ('39', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:18:40');
INSERT INTO `systemlog` VALUES ('40', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:19:55');
INSERT INTO `systemlog` VALUES ('41', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:19:55');
INSERT INTO `systemlog` VALUES ('42', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:20:00');
INSERT INTO `systemlog` VALUES ('43', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:20:00');
INSERT INTO `systemlog` VALUES ('44', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:21:59');
INSERT INTO `systemlog` VALUES ('45', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:21:59');
INSERT INTO `systemlog` VALUES ('46', 'tom', '更新用户', '[{\"avatar\":\"https://newplusblog.oss-cn-hangzhou.aliyuncs.com/用户头像/2021/六月/01/bf5e3f7ace1a43848331ac0478a0f60adog2.jpg\",\"email\":\"wlc@qq.com\",\"fullName\":\"汪立潮\",\"id\":2,\"mobile\":\"18888604001\",\"password\":\"$2a$10$RGUIl2F3U80cX1E9FIU8m.RJSK9aLrUbGZN4nq3GTI66L18X4fjBi\",\"roleId\":2,\"status\":1,\"username\":\"wlc\"}]', 'com.zwu.controller.UserController.singleUpdate', '0:0:0:0:0:0:0:1', '2021-06-01 13:22:57');
INSERT INTO `systemlog` VALUES ('47', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:22:57');
INSERT INTO `systemlog` VALUES ('48', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:22:57');
INSERT INTO `systemlog` VALUES ('49', 'tom', '更新用户', '[{\"avatar\":\"https://newplusblog.oss-cn-hangzhou.aliyuncs.com/用户头像/2021/六月/01/ce0add2e53674b6bb832f2a6f4325360dog.jpg\",\"email\":\"tom@qq.com\",\"fullName\":\"汤姆\",\"id\":1,\"mobile\":\"18888604000\",\"password\":\"$2a$10$/tHUEWcuiuPkx9D3mIhq9e2YTzc2nff13K3Xki4UULb4aFMtT/0Le\",\"roleId\":1,\"status\":1,\"username\":\"tom\"}]', 'com.zwu.controller.UserController.singleUpdate', '0:0:0:0:0:0:0:1', '2021-06-01 13:23:20');
INSERT INTO `systemlog` VALUES ('50', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:23:20');
INSERT INTO `systemlog` VALUES ('51', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:23:20');
INSERT INTO `systemlog` VALUES ('52', 'tom', '更新用户', '[{\"avatar\":\"https://newplusblog.oss-cn-hangzhou.aliyuncs.com/用户头像/2021/六月/01/becb13cf1cc4422eb401e79514f95353fox.jpg\",\"email\":\"xyj@qq.com\",\"fullName\":\"小樱姐\",\"id\":3,\"mobile\":\"18888604002\",\"password\":\"$2a$10$cAjNOCRJj3jimFBcARhKBulk/ZqoXIGd.uKU6dehP/Xf7KRtOlAey\",\"roleId\":3,\"status\":1,\"username\":\"xyj\"}]', 'com.zwu.controller.UserController.singleUpdate', '0:0:0:0:0:0:0:1', '2021-06-01 13:23:56');
INSERT INTO `systemlog` VALUES ('53', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:23:56');
INSERT INTO `systemlog` VALUES ('54', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:23:56');
INSERT INTO `systemlog` VALUES ('55', 'tom', '更新用户', '[{\"avatar\":\"https://newplusblog.oss-cn-hangzhou.aliyuncs.com/用户头像/2021/六月/01/a26b71aafc4643e386835d1c3e94a07egirl.jpg\",\"email\":\"mgb@qq.com\",\"fullName\":\"马果缤\",\"id\":4,\"mobile\":\"18888604003\",\"password\":\"$2a$10$2.edTAhszM9V4fldQuU8kOo9Clri2AgTTapXJpyB2/nwSXKnfwN1G\",\"roleId\":4,\"status\":1,\"username\":\"mgb\"}]', 'com.zwu.controller.UserController.singleUpdate', '0:0:0:0:0:0:0:1', '2021-06-01 13:24:41');
INSERT INTO `systemlog` VALUES ('56', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:24:41');
INSERT INTO `systemlog` VALUES ('57', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:24:41');
INSERT INTO `systemlog` VALUES ('58', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:24:45');
INSERT INTO `systemlog` VALUES ('59', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:24:45');
INSERT INTO `systemlog` VALUES ('60', 'tom', '查看用户列表', '[1,10,\"\",\"2\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:24:48');
INSERT INTO `systemlog` VALUES ('61', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:24:48');
INSERT INTO `systemlog` VALUES ('62', 'tom', '查看用户列表', '[1,10,\"\",\"1\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:24:50');
INSERT INTO `systemlog` VALUES ('63', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:24:50');
INSERT INTO `systemlog` VALUES ('64', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:24:51');
INSERT INTO `systemlog` VALUES ('65', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:24:51');
INSERT INTO `systemlog` VALUES ('66', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:25:03');
INSERT INTO `systemlog` VALUES ('67', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 13:25:03');
INSERT INTO `systemlog` VALUES ('68', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 13:25:04');
INSERT INTO `systemlog` VALUES ('69', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 13:25:06');
INSERT INTO `systemlog` VALUES ('70', 'tom', '根据用户id查看具体用户', '[1]', 'com.zwu.controller.UserController.findById', '0:0:0:0:0:0:0:1', '2021-06-01 13:25:07');
INSERT INTO `systemlog` VALUES ('71', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:25:13');
INSERT INTO `systemlog` VALUES ('72', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 13:25:13');
INSERT INTO `systemlog` VALUES ('73', 'tom', '根据用户id查看具体用户', '[1]', 'com.zwu.controller.UserController.findById', '0:0:0:0:0:0:0:1', '2021-06-01 13:25:16');
INSERT INTO `systemlog` VALUES ('74', 'tom', '查看日志列表', '[1,10,\" \"]', 'com.zwu.controller.SystemLogController.list', '0:0:0:0:0:0:0:1', '2021-06-01 13:25:37');
INSERT INTO `systemlog` VALUES ('75', 'tom', '新增博客', '[{\"content\":\"mavon-editor是一款基于vue的markdown编辑器，比较适合博客系统。由于官网对于一些细节的说明不够详细，这里对这里对该编辑器的使用做一个总结。\\n\\n1. 安装\\n2. 基本使用\\n3. 图片上传(含服务端)\\n安装\\nnpm install mavon-editor --save\\n\\n基本使用\\n在vue-cli构建的脚手架离得main.js可以像这样引用：\\n```vue\\n    // 全局注册\\n    import Vue from \'vue\'\\n    import mavonEditor from \'mavon-editor\'\\n    import \'mavon-editor/dist/css/index.css\'\\n    // use\\n    Vue.use(mavonEditor)\\n    new Vue({\\n        \'el\': \'#main\'\\n    })\\n\\n```\\n在具体的组件里html里定义挂载点\\n```vue\\n\\\"main\\\">\\n    <mavon-editor v-model=\\\"value\\\"/>\\ndiv>\\n```\\n![mavon.jpg](https://newplusblog.oss-cn-hangzhou.aliyuncs.com/博客图片/2021/六月/01/b2061879bbcd4b4da0d6831c19b1b48cmavon.jpg)\\n图1.1\\n\\n图片上传：\\n先将挂在点里的方法写好，就像这样\\n```vue\\n class=\\\"content-content\\\">\\n     <mavon-editor \\n     v-model = \'editorContent\'\\n     :ishljs=\\\"true\\\"\\n      :codeStyle=\\\"code_style\\\"\\n     ref=md @imgAdd=\\\"$imgAdd\\\" @imgDel=\\\"$imgDel\\\"\\n      />\\n el-main>\\n```\\n主要是将ref=md @imgAdd=\\\"$imgAdd\\\" @imgDel=\\\"$imgDel\\\"放进去，其他是我的其他代码。\\n然后定义$imgAdd和$imgDel方法:\\n```vue\\n// 绑定@imgAdd event\\n$imgAdd(pos, $file) {\\n    // 第一步.将图片上传到服务器.\\n    var formdata = new FormData();\\n    formdata.append(\'image\', $file);\\n    this.img_file[pos] = $file;\\n    this.$http({\\n        url: \'/api/edit/uploadimg\',\\n        method: \'post\',\\n        data: formdata,\\n        headers: { \'Content-Type\': \'multipart/form-data\' },\\n    }).then((res) => {\\n        let _res = res.data;\\n        // 第二步.将返回的url替换到文本原位置[外链图片转存失败(img-Anv63SQR-1564734760257)(0)] -> [外链图片转存失败(img-OVX7vZS4-1564734760259)(url)]\\n        this.$refs.md.$img2Url(pos, _res.url);\\n    })\\n},\\n$imgDel(pos) {\\n    delete this.img_file[pos];\\n}\\n```\\n这里注意我的this.$https就是我的axios对象（用过vue-cli的都懂的），然后this.img_file是我之前定义的一个空对象。this.$refs.md和挂在点定义的要保持一致。\\n剩下的就是交给服务端去处理了：\\nkoa解决文件上传\\n大家有不明白的地方或者需要我补充更正的地方欢迎留言~\",\"description\":\"mavon-editor 关于图片上传的使用教程\",\"id\":1,\"title\":\"mavon-editor 使用教程\",\"userId\":1}]', 'com.zwu.controller.BlogController.save', '0:0:0:0:0:0:0:1', '2021-06-01 13:38:58');
INSERT INTO `systemlog` VALUES ('76', 'tom', '查看我的博客', '[1,7,\"\",1]', 'com.zwu.controller.BlogController.myList', '0:0:0:0:0:0:0:1', '2021-06-01 13:39:16');
INSERT INTO `systemlog` VALUES ('77', 'tom', '新增博客', '[{\"content\":\"![vue表单验证错误.png](https://newplusblog.oss-cn-hangzhou.aliyuncs.com/博客图片/2021/六月/01/f475e9d48dce4c89a3762865d11acd57vue表单验证错误.png)\\n去看一下表单验证的代码，找到这一句：\\n\\nthis.$refs[formName].validate((valid) => {\\n看看这里refs的值与el-form上绑定的ref值一直不一致，注意：把refs和ref名字保持一致就行了\",\"description\":\"VUE表单验证报错：Error in v-on handler: \\\"TypeError: Cannot read property \'validate\' of undefined\\\"解决\",\"id\":2,\"title\":\"vue表单验证错误\",\"userId\":1}]', 'com.zwu.controller.BlogController.save', '0:0:0:0:0:0:0:1', '2021-06-01 13:40:15');
INSERT INTO `systemlog` VALUES ('78', 'tom', '新增博客', '[{\"content\":\"产生这个错误的原因是springboot的自动配置，如果你没有配置DataSource就会导致下图这个错误\\n![springboot自动装配数据库.png](https://newplusblog.oss-cn-hangzhou.aliyuncs.com/博客图片/2021/六月/01/bbe241f40596482abe33fe17a76ef8a1springboot自动装配数据库.png)\\n不想连接数据库的话有以下解决方案\\n解决方案1\\n```java\\n@SpringBootApplication(exclude = DataSourceAutoConfiguration.class)//排除自动配置\\npublic class ErukaServerMain {\\n    public static void main(String[] args) {\\n        SpringApplication.run(ErukaServerMain.class,args);\\n    }\\n}\\n```\\n解决方案2\\n如果以上方法不行那就，将pom文件带有数据库相关的删除，例如：jdbc、mysql-connect等等\",\"description\":\"springBoot 启动 If you want an embedded database (H2, HSQL or Derby), please put it on the classpath.\",\"id\":3,\"title\":\"springBoot 启动报错\",\"userId\":1}]', 'com.zwu.controller.BlogController.save', '0:0:0:0:0:0:0:1', '2021-06-01 13:42:12');
INSERT INTO `systemlog` VALUES ('79', 'tom', '查看我的博客', '[1,7,\"\",1]', 'com.zwu.controller.BlogController.myList', '0:0:0:0:0:0:0:1', '2021-06-01 13:42:43');
INSERT INTO `systemlog` VALUES ('80', 'wlc', '查看我的博客', '[1,7,\"\",2]', 'com.zwu.controller.BlogController.myList', '0:0:0:0:0:0:0:1', '2021-06-01 13:42:52');
INSERT INTO `systemlog` VALUES ('81', 'wlc', '新增博客', '[{\"content\":\"**IDEA问题**\\n- 问题描述\\n\\n删除maven父工程的一个子工程并重新创建后，maven无法识别。问题现象会有：\\n> 1.导入依赖但是项目无法识别\\n2.右侧maven工具栏显示本子模块为（root）\\n3.resouces的application.yml无法识别为springboot的配置文件\\n\\n**问题解决**\\n\\n- 问题原因\\n本子模块可能被忽略掉了\\n- 问题解决\\nfile -> settings -> 搜索maven -> ignored Files 看看里面本子模块是不是本勾选了，去掉即可\\n\\n![springboot忽略.png](https://newplusblog.oss-cn-hangzhou.aliyuncs.com/博客图片/2021/六月/01/0d48c6a4ed7648ac97a3ba0f4a314261springboot忽略.png)\",\"description\":\"IDEA删除子模块然后重新用相同的名字重建后MAVEN无法识别\",\"id\":4,\"title\":\"IDEA删除子模块并重建后MAVEN无法识别\",\"userId\":2}]', 'com.zwu.controller.BlogController.save', '0:0:0:0:0:0:0:1', '2021-06-01 13:46:30');
INSERT INTO `systemlog` VALUES ('82', 'wlc', '查看我的博客', '[1,7,\"\",2]', 'com.zwu.controller.BlogController.myList', '0:0:0:0:0:0:0:1', '2021-06-01 13:46:36');
INSERT INTO `systemlog` VALUES ('83', 'wlc', '新增博客', '[{\"content\":\"1.打开idea，在左侧项目展示栏中找到.idea，双击打开.idea\\n![idea.png](https://newplusblog.oss-cn-hangzhou.aliyuncs.com/博客图片/2021/六月/01/2b412bead62e437b9fca30c2d3279eefidea.png)\\n2.在.idea下双击打开workspace.xml\\n![workspace.png](https://newplusblog.oss-cn-hangzhou.aliyuncs.com/博客图片/2021/六月/01/b9ac7f1fc52f45fd85b57d53c3862981workspace.png)\\n3.编辑workspace.xml文件，在结尾添加如下配置代码\\n```xml\\n<component name=\\\"RunDashboard\\\">\\n\\n  <option name=\\\"configurationTypes\\\">\\n\\n    <set>\\n\\n      <option value=\\\"SpringBootApplicationConfigurationType\\\" />\\n\\n    </set>\\n\\n  </option>\\n\\n</component>\\n```\\n![位置.png](https://newplusblog.oss-cn-hangzhou.aliyuncs.com/博客图片/2021/六月/01/af29b1a939404b1fbe4655b7a423ce1a位置.png)\\n4.保存配置文件，重启idea开发工具，重启项目，此时可以在下方工具栏Services窗口看到如图的执行窗口了\\n![执行窗口.png](https://newplusblog.oss-cn-hangzhou.aliyuncs.com/博客图片/2021/六月/01/2981b8c8713741d3939e3acf0f985b7b执行窗口.png)\",\"description\":\"service没有显示的问题解决\",\"id\":5,\"title\":\"idea配置service启动\",\"userId\":2}]', 'com.zwu.controller.BlogController.save', '0:0:0:0:0:0:0:1', '2021-06-01 13:50:52');
INSERT INTO `systemlog` VALUES ('84', 'tom', '查看日志列表', '[1,10,\" \"]', 'com.zwu.controller.SystemLogController.list', '0:0:0:0:0:0:0:1', '2021-06-01 13:52:13');
INSERT INTO `systemlog` VALUES ('85', 'tom', '查看日志列表', '[2,10,\" \"]', 'com.zwu.controller.SystemLogController.list', '0:0:0:0:0:0:0:1', '2021-06-01 13:52:20');
INSERT INTO `systemlog` VALUES ('86', 'tom', '查看日志列表', '[3,10,\" \"]', 'com.zwu.controller.SystemLogController.list', '0:0:0:0:0:0:0:1', '2021-06-01 13:52:21');
INSERT INTO `systemlog` VALUES ('87', 'tom', '查看日志列表', '[1,10,\" \"]', 'com.zwu.controller.SystemLogController.list', '0:0:0:0:0:0:0:1', '2021-06-01 13:52:22');
INSERT INTO `systemlog` VALUES ('88', 'xyj', '新增博客', '[{\"content\":\"\\n很多同学以为程序员一天到晚的工作就是写代码，写代码，写代码！\\n其实不是的。写代码只是很少很少的一部分工作，其实更多的时候，我们：\\n**读别人的代码**\\n通常我们进入公司以后，不会是重头开始一个项目，而是在已有代码的基础上进行维护或新功能的开发，所以必须“读代码”。\\n读有“泛读”，了解系统架构、功能模块，对系统有一个大致的认识，各个功能能找到相应代码实现的位置。\\n还有“精读”，通常就是调试了，在fix bug的时候使用。此外还包括审核：一些规范一点的公司，都会有code review，也是精读，但不用debug。\\n对于一个成熟的项目来说，读代码——而不是写代码——可能是最耗时间的工作了。\\n**写注释文档**\\n为了减少“读代码”的时间，我们不得不花时间“写注释”“写文档”——这个程序员最深恶痛绝的工作。所以现在“烂代码才需要注释”的声音变得越来越强，但无论如何，文档还是要写的。（注意：要能区分注释和文档）\\n**了解需求**\\n好了，终于到了“写代码”的时间了。\\n然而，在动手开始写代码之前，你必须花时间“了解需求”。和自己写个小程序玩玩不同，在公司，你是为别人写代码，所以你一定要了解别人究竟想实现什么功能。通常，这并没有你想像的那么简单，需要反复的沟通。\\n当然，也有一些团队和个人，不愿意在这上面“浪费时间”，通常他们的下场就是不断的写代码，然后不断的改代码，加班加点的做大量的无用功，整个公司怨气冲天一地鸡毛。\\n![被打.jpg](https://newplusblog.oss-cn-hangzhou.aliyuncs.com/博客图片/2021/六月/01/cef3740423104119be5e875128f3f622被打.jpg)\\n**开发中的其他各种沟通**\\n大家都恨产品经理。\\n但其实产品经理只是我们最恨的人之一，我们还恨前端、后端、DBA、测试……承认吧！因为我们是团队开发，说好的团队精神有没有我不知道，但各种摩擦扯皮是必须的。\\n比如前端要后台给一个接口，后台给不出来或者嫌麻烦；比如后台跪求DBA的权限，DBA优化数据库时说Developer都一群傻逼；比如测试一次又一次的报bug我特么像杀人的时候……\\n这些都需要沟通，也就是需要时间和精力。\\n**其他无聊的办公室活动**\\n比如写日报周报，应付各种KPI，这是所有工种都干的活，就不多说了。\\n总之，程序员真正写代码的时间其实不多。个人觉得，一天能有30%的时间安安静静的写代码，就算是不错的工作环境了。\\n不论是我们的大学教育也好，培训机构也罢，都只知道知识的灌输，而忽略了程序员工作能力的培养。这些能力，即只能在工作中“自学”获得，所以你看这些公司的招聘，都要求“两年以上工作经验”，意思就是：一般的新人，起码要两年的时间，才能“习得”这些起码的工作技能。\\n能不能有所改变呢？\\n我想试一试。\\n\",\"description\":\"程序员是做什么的呢？\",\"id\":6,\"title\":\"程序员是做什么的\",\"userId\":3}]', 'com.zwu.controller.BlogController.save', '0:0:0:0:0:0:0:1', '2021-06-01 13:57:49');
INSERT INTO `systemlog` VALUES ('89', 'xyj', '新增博客', '[{\"content\":\"　管理者应具备的六大能力 ：\\n　　1、沟通能力。为了了解组织内部员工互动的状况，倾听职员心声，一个管理者需要具备良好的沟通能力，其中又以“善于倾听”最为重要。惟有如此，才不至于让下属离心离德，或者不敢提出建设性的提议与需求，而管理者也可借由下属的认同感、理解程度及共鸣，得知自己的沟通技巧是否成功。\\n　　2、协调能力。管理者应该要能敏锐地觉察部属的情绪，并且建立疏通、宣泄的管道，切勿等到对立加深、矛盾扩大后，才急于着手处理与排解。此外，管理者对于情节严重的冲突，或者可能会扩大对立面的矛盾事件，更要果决地加以排解。即使在状况不明、是非不清的时候，也应即时采取降温、冷却的手段，并且在了解情况后，立刻以妥善、有效的策略化解冲突。只要把握消除矛盾的先发权和主动权，任何形式的对立都能迎刃而解。\\n　　3、　规划与统整能力。管理者的规划能力，并非着眼于短期的策略规划，而是长期计划的制定。换言之，卓越的管理者必须深谋远虑、有远见，不能目光如豆，只看得见现在而看不到未来，而且要适时让员工了解公司的远景，才不会让员工迷失方向。特别是进行决策规划时，更要能妥善运用统整能力，有效地利用部属的智慧与既有的资源，避免人力浪费。\\n　　4、决策与执行能力。在民主时代，虽然有许多事情以集体决策为宜，但是管理者仍经常须独立决策，包括分派工作、人力协调、化解员工纷争等等，这都往往考验着管理者的决断能力。\\n　　5、培训能力。管理者必然渴望拥有一个实力坚强的工作团队，因此，培养优秀人才，也就成为管理者的重要任务。\\n　　6、统驭能力。有句话是这样说的：“一个领袖不会去建立一个企业，但是他会建立一个组织来建立企业。”根据这种说法，当一个管理者的先决条件，就是要有能力建立团队，才能进一步建构企业。但无论管理者的角色再怎么复杂多变，赢得员工的信任都是首要的条件。\\n　　管理者需要具备的管理技能主要有：\\n　　1、技术技能\\n　　技术技能是指对某一特殊活动——特别是包含方法、过程、程序或技术的活动——的理解和熟练。它包括专门知识、在专业范围内的分析能力以及灵活地运用该专业的工具和技巧的能力。技术技能主要是涉及到“物” ( 过程或有形的物体 ) 的工作。\\n　　2、人事技能\\n　　人事技能是指一个人能够以小组成员的身份有效地工作的行政能力，并能够在他所领导的小组中建立起合作的努力，也即协作精神和团队精神，创造一种良好的氛围，以使员工能够自由地无所顾忌地表达个人观点的能力。管理者的人事技能是指管理者为完成组织目标应具备的领导、激励和沟通能力。\\n　　3、思想技能\\n　　思想技能包含：“把企业看成一个整体的能力，包括识别一个组织中的彼此互相依赖的各种职能，一部分的改变如何能影响所有其他各部分，并进而影响个别企业与工业、社团之间，以及与国家的政治、社会和经济力量这一总体之间的关系。”即能够总揽全局，判断出重要因素并了解这些因素之间关系的能力。\\n　　4、设计技能\\n　　设计技能是指以有利于组织利益的种种方式解决问题的能力，特别是高层管理者不仅要发现问题，还必须像一名优秀的设计师那样具备找出某一问题切实可行的解决办法的能力。如果管理者只能看到问题的存在，并只是“看到问题的人”，他们就是不合格的管理者。管理者还必须具备这样一种能力，即能够根据所面临的现状找出行得通的解决方法的能力。\\n　　这些技能对于不同管理层次的管理者的相对重要性是不同的。技术技能、人事技能的重要性依据管理者所处的组织层次从低到高逐渐下降，而思想技能和设计技能则相反。对基层管理者来说，具备技术技能是最为重要的，具备人事技能在同下层的频繁交往中也非常有帮助。当管理者在组织中的组织层次从基层往中层、高层发展时，随着他同下级直接接触的次数和频率的减少，人事技能的重要性也逐渐降低。也就是说，对于中层管理者来说，对技术技能的要求下降，而对思想技能的要求上升，同时具备人事技能仍然很重要。但对于高层管理者而言，思想技能和设计技能特别重要，而对技术技能、人事技能的要求相对来说则很低。当然，这种管理技能和组织层次的联系并不是绝对的，组织规模大小等一些因素对此也会产生一定的影响\",\"description\":\"如何当一个好的管理者\",\"id\":7,\"title\":\"如何当一个好的管理者\",\"userId\":3}]', 'com.zwu.controller.BlogController.save', '0:0:0:0:0:0:0:1', '2021-06-01 13:58:38');
INSERT INTO `systemlog` VALUES ('90', 'tom', '根据用户id查看具体用户', '[1]', 'com.zwu.controller.UserController.findById', '0:0:0:0:0:0:0:1', '2021-06-01 14:03:43');
INSERT INTO `systemlog` VALUES ('91', 'tom', '查看用户列表', '[1,2,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 14:03:44');
INSERT INTO `systemlog` VALUES ('92', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 14:03:44');
INSERT INTO `systemlog` VALUES ('93', 'tom', '查看用户列表', '[2,5,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 14:03:46');
INSERT INTO `systemlog` VALUES ('94', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 14:03:46');
INSERT INTO `systemlog` VALUES ('95', 'tom', '查看用户列表', '[1,2,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 14:03:50');
INSERT INTO `systemlog` VALUES ('96', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 14:03:50');
INSERT INTO `systemlog` VALUES ('97', 'tom', '根据用户id查看具体用户', '[1]', 'com.zwu.controller.UserController.findById', '0:0:0:0:0:0:0:1', '2021-06-01 14:09:41');
INSERT INTO `systemlog` VALUES ('98', 'tom', '查看我的博客', '[1,7,\"\",1]', 'com.zwu.controller.BlogController.myList', '0:0:0:0:0:0:0:1', '2021-06-01 14:09:47');
INSERT INTO `systemlog` VALUES ('99', 'tom', '修改博客内容', '[{\"content\":\"产生这个错误的原因是springboot的自动配置，如果你没有配置DataSource就会导致下图这个错误\\n\\n![springboot自动装配数据库.png](https://newplusblog.oss-cn-hangzhou.aliyuncs.com/博客图片/2021/六月/01/bbe241f40596482abe33fe17a76ef8a1springboot自动装配数据库.png)\\n不想连接数据库的话有以下解决方案\\n\\n解决方案1\\n\\n```java\\n@SpringBootApplication(exclude = DataSourceAutoConfiguration.class)//排除自动配置\\npublic class ErukaServerMain {\\n    public static void main(String[] args) {\\n        SpringApplication.run(ErukaServerMain.class,args);\\n    }\\n}\\n```\\n解决方案2\\n\\n如果以上方法不行那就，将pom文件带有数据库相关的删除，例如：jdbc、mysql-connect等等\",\"description\":\"springBoot 启动 If you want an embedded database (H2, HSQL or Derby), please put it on the classpath.\",\"id\":3,\"title\":\"springBoot 启动报错\"}]', 'com.zwu.controller.BlogController.update', '0:0:0:0:0:0:0:1', '2021-06-01 14:10:04');
INSERT INTO `systemlog` VALUES ('100', 'tom', '查看我的博客', '[1,7,\"\",1]', 'com.zwu.controller.BlogController.myList', '0:0:0:0:0:0:0:1', '2021-06-01 14:10:16');
INSERT INTO `systemlog` VALUES ('101', 'tom', '查看我的博客', '[1,7,\"\",1]', 'com.zwu.controller.BlogController.myList', '0:0:0:0:0:0:0:1', '2021-06-01 14:10:19');
INSERT INTO `systemlog` VALUES ('102', 'tom', '查看我的博客', '[1,7,\"\",1]', 'com.zwu.controller.BlogController.myList', '0:0:0:0:0:0:0:1', '2021-06-01 14:10:22');
INSERT INTO `systemlog` VALUES ('103', 'tom', '根据用户id查看具体用户', '[1]', 'com.zwu.controller.UserController.findById', '0:0:0:0:0:0:0:1', '2021-06-01 14:10:50');
INSERT INTO `systemlog` VALUES ('104', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 14:10:51');
INSERT INTO `systemlog` VALUES ('105', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 14:10:51');
INSERT INTO `systemlog` VALUES ('106', 'tom', '修改博客内容', '[{\"content\":\"　管理者应具备的六大能力 ：\\n\\n　　1、沟通能力。为了了解组织内部员工互动的状况，倾听职员心声，一个管理者需要具备良好的沟通能力，其中又以“善于倾听”最为重要。惟有如此，才不至于让下属离心离德，或者不敢提出建设性的提议与需求，而管理者也可借由下属的认同感、理解程度及共鸣，得知自己的沟通技巧是否成功。\\n\\n　　2、协调能力。管理者应该要能敏锐地觉察部属的情绪，并且建立疏通、宣泄的管道，切勿等到对立加深、矛盾扩大后，才急于着手处理与排解。此外，管理者对于情节严重的冲突，或者可能会扩大对立面的矛盾事件，更要果决地加以排解。即使在状况不明、是非不清的时候，也应即时采取降温、冷却的手段，并且在了解情况后，立刻以妥善、有效的策略化解冲突。只要把握消除矛盾的先发权和主动权，任何形式的对立都能迎刃而解。\\n\\n　　3、　规划与统整能力。管理者的规划能力，并非着眼于短期的策略规划，而是长期计划的制定。换言之，卓越的管理者必须深谋远虑、有远见，不能目光如豆，只看得见现在而看不到未来，而且要适时让员工了解公司的远景，才不会让员工迷失方向。特别是进行决策规划时，更要能妥善运用统整能力，有效地利用部属的智慧与既有的资源，避免人力浪费。\\n\\n　　4、决策与执行能力。在民主时代，虽然有许多事情以集体决策为宜，但是管理者仍经常须独立决策，包括分派工作、人力协调、化解员工纷争等等，这都往往考验着管理者的决断能力。\\n\\n　　5、培训能力。管理者必然渴望拥有一个实力坚强的工作团队，因此，培养优秀人才，也就成为管理者的重要任务。\\n\\n　　6、统驭能力。有句话是这样说的：“一个领袖不会去建立一个企业，但是他会建立一个组织来建立企业。”根据这种说法，当一个管理者的先决条件，就是要有能力建立团队，才能进一步建构企业。但无论管理者的角色再怎么复杂多变，赢得员工的信任都是首要的条件。\\n\\n　　管理者需要具备的管理技能主要有：\\n\\n　　1、技术技能\\n\\n　　技术技能是指对某一特殊活动——特别是包含方法、过程、程序或技术的活动——的理解和熟练。它包括专门知识、在专业范围内的分析能力以及灵活地运用该专业的工具和技巧的能力。技术技能主要是涉及到“物” ( 过程或有形的物体 ) 的工作。\\n\\n　　2、人事技能\\n\\n　　人事技能是指一个人能够以小组成员的身份有效地工作的行政能力，并能够在他所领导的小组中建立起合作的努力，也即协作精神和团队精神，创造一种良好的氛围，以使员工能够自由地无所顾忌地表达个人观点的能力。管理者的人事技能是指管理者为完成组织目标应具备的领导、激励和沟通能力。\\n\\n　　3、思想技能\\n\\n　　思想技能包含：“把企业看成一个整体的能力，包括识别一个组织中的彼此互相依赖的各种职能，一部分的改变如何能影响所有其他各部分，并进而影响个别企业与工业、社团之间，以及与国家的政治、社会和经济力量这一总体之间的关系。”即能够总揽全局，判断出重要因素并了解这些因素之间关系的能力。\\n\\n　　4、设计技能\\n\\n　　设计技能是指以有利于组织利益的种种方式解决问题的能力，特别是高层管理者不仅要发现问题，还必须像一名优秀的设计师那样具备找出某一问题切实可行的解决办法的能力。如果管理者只能看到问题的存在，并只是“看到问题的人”，他们就是不合格的管理者。管理者还必须具备这样一种能力，即能够根据所面临的现状找出行得通的解决方法的能力。\\n\\n　　这些技能对于不同管理层次的管理者的相对重要性是不同的。技术技能、人事技能的重要性依据管理者所处的组织层次从低到高逐渐下降，而思想技能和设计技能则相反。对基层管理者来说，具备技术技能是最为重要的，具备人事技能在同下层的频繁交往中也非常有帮助。当管理者在组织中的组织层次从基层往中层、高层发展时，随着他同下级直接接触的次数和频率的减少，人事技能的重要性也逐渐降低。也就是说，对于中层管理者来说，对技术技能的要求下降，而对思想技能的要求上升，同时具备人事技能仍然很重要。但对于高层管理者而言，思想技能和设计技能特别重要，而对技术技能、人事技能的要求相对来说则很低。当然，这种管理技能和组织层次的联系并不是绝对的，组织规模大小等一些因素对此也会产生一定的影响.\",\"description\":\"如何当一个好的管理者\",\"id\":7,\"title\":\"如何当一个好的管理者\"}]', 'com.zwu.controller.BlogController.update', '0:0:0:0:0:0:0:1', '2021-06-01 14:12:15');
INSERT INTO `systemlog` VALUES ('107', 'tom', '修改博客内容', '[{\"content\":\"　管理者应具备的六大能力 ：\\n\\n　　1、沟通能力。为了了解组织内部员工互动的状况，倾听职员心声，一个管理者需要具备良好的沟通能力，其中又以“善于倾听”最为重要。惟有如此，才不至于让下属离心离德，或者不敢提出建设性的提议与需求，而管理者也可借由下属的认同感、理解程度及共鸣，得知自己的沟通技巧是否成功。\\n\\n　　2、协调能力。管理者应该要能敏锐地觉察部属的情绪，并且建立疏通、宣泄的管道，切勿等到对立加深、矛盾扩大后，才急于着手处理与排解。此外，管理者对于情节严重的冲突，或者可能会扩大对立面的矛盾事件，更要果决地加以排解。即使在状况不明、是非不清的时候，也应即时采取降温、冷却的手段，并且在了解情况后，立刻以妥善、有效的策略化解冲突。只要把握消除矛盾的先发权和主动权，任何形式的对立都能迎刃而解。\\n\\n　　3、　规划与统整能力。管理者的规划能力，并非着眼于短期的策略规划，而是长期计划的制定。换言之，卓越的管理者必须深谋远虑、有远见，不能目光如豆，只看得见现在而看不到未来，而且要适时让员工了解公司的远景，才不会让员工迷失方向。特别是进行决策规划时，更要能妥善运用统整能力，有效地利用部属的智慧与既有的资源，避免人力浪费。\\n\\n　　4、决策与执行能力。在民主时代，虽然有许多事情以集体决策为宜，但是管理者仍经常须独立决策，包括分派工作、人力协调、化解员工纷争等等，这都往往考验着管理者的决断能力。\\n\\n　　5、培训能力。管理者必然渴望拥有一个实力坚强的工作团队，因此，培养优秀人才，也就成为管理者的重要任务。\\n\\n　　6、统驭能力。有句话是这样说的：“一个领袖不会去建立一个企业，但是他会建立一个组织来建立企业。”根据这种说法，当一个管理者的先决条件，就是要有能力建立团队，才能进一步建构企业。但无论管理者的角色再怎么复杂多变，赢得员工的信任都是首要的条件。\\n\\n　　管理者需要具备的管理技能主要有：\\n\\n　　1、技术技能\\n\\n　　技术技能是指对某一特殊活动——特别是包含方法、过程、程序或技术的活动——的理解和熟练。它包括专门知识、在专业范围内的分析能力以及灵活地运用该专业的工具和技巧的能力。技术技能主要是涉及到“物” ( 过程或有形的物体 ) 的工作。\\n\\n　　2、人事技能\\n\\n　　人事技能是指一个人能够以小组成员的身份有效地工作的行政能力，并能够在他所领导的小组中建立起合作的努力，也即协作精神和团队精神，创造一种良好的氛围，以使员工能够自由地无所顾忌地表达个人观点的能力。管理者的人事技能是指管理者为完成组织目标应具备的领导、激励和沟通能力。\\n\\n　　3、思想技能\\n\\n　　思想技能包含：“把企业看成一个整体的能力，包括识别一个组织中的彼此互相依赖的各种职能，一部分的改变如何能影响所有其他各部分，并进而影响个别企业与工业、社团之间，以及与国家的政治、社会和经济力量这一总体之间的关系。”即能够总揽全局，判断出重要因素并了解这些因素之间关系的能力。\\n\\n　　4、设计技能\\n\\n　　设计技能是指以有利于组织利益的种种方式解决问题的能力，特别是高层管理者不仅要发现问题，还必须像一名优秀的设计师那样具备找出某一问题切实可行的解决办法的能力。如果管理者只能看到问题的存在，并只是“看到问题的人”，他们就是不合格的管理者。管理者还必须具备这样一种能力，即能够根据所面临的现状找出行得通的解决方法的能力。\\n\\n　　这些技能对于不同管理层次的管理者的相对重要性是不同的。技术技能、人事技能的重要性依据管理者所处的组织层次从低到高逐渐下降，而思想技能和设计技能则相反。对基层管理者来说，具备技术技能是最为重要的，具备人事技能在同下层的频繁交往中也非常有帮助。当管理者在组织中的组织层次从基层往中层、高层发展时，随着他同下级直接接触的次数和频率的减少，人事技能的重要性也逐渐降低。也就是说，对于中层管理者来说，对技术技能的要求下降，而对思想技能的要求上升，同时具备人事技能仍然很重要。但对于高层管理者而言，思想技能和设计技能特别重要，而对技术技能、人事技能的要求相对来说则很低。当然，这种管理技能和组织层次的联系并不是绝对的，组织规模大小等一些因素对此也会产生一定的影响.\",\"description\":\"如何当一个好的管理者\",\"id\":7,\"title\":\"如何当一个好的管理者\"}]', 'com.zwu.controller.BlogController.update', '0:0:0:0:0:0:0:1', '2021-06-01 14:13:50');
INSERT INTO `systemlog` VALUES ('108', 'tom', '修改博客内容', '[{\"content\":\"\\n很多同学以为程序员一天到晚的工作就是写代码，写代码，写代码！\\n\\n其实不是的。写代码只是很少很少的一部分工作，其实更多的时候，我们：\\n\\n**读别人的代码**\\n\\n通常我们进入公司以后，不会是重头开始一个项目，而是在已有代码的基础上进行维护或新功能的开发，所以必须“读代码”。\\n\\n读有“泛读”，了解系统架构、功能模块，对系统有一个大致的认识，各个功能能找到相应代码实现的位置。\\n\\n还有“精读”，通常就是调试了，在fix bug的时候使用。此外还包括审核：一些规范一点的公司，都会有codereview，也是精读，但不用debug。\\n\\n对于一个成熟的项目来说，读代码——而不是写代码——可能是最耗时间的工作了。\\n\\n**写注释文档**\\n\\n为了减少“读代码”的时间，我们不得不花时间“写注释”“写文档”——这个程序员最深恶痛绝的工作。所以现在“烂代码才需要注释”的声音变得越来越强，但无论如何，文档还是要写的。（注意：要能区分注释和文档）\\n\\n**了解需求**\\n\\n好了，终于到了“写代码”的时间了。\\n\\n然而，在动手开始写代码之前，你必须花时间“了解需求”。和自己写个小程序玩玩不同，在公司，你是为别人写代码，所以你一定要了解别人究竟想实现什么功能。通常，这并没有你想像的那么简单，需要反复的沟通。\\n\\n当然，也有一些团队和个人，不愿意在这上面“浪费时间”，通常他们的下场就是不断的写代码，然后不断的改代码，加班加点的做大量的无用功，整个公司怨气冲天一地鸡毛。\\n\\n![被打.jpg](https://newplusblog.oss-cn-hangzhou.aliyuncs.com/博客图片/2021/六月/01/cef3740423104119be5e875128f3f622被打.jpg)\\n\\n**开发中的其他各种沟通**\\n\\n大家都恨产品经理。\\n\\n但其实产品经理只是我们最恨的人之一，我们还恨前端、后端、DBA、测试……承认吧！因为我们是团队开发，说好的团队精神有没有我不知道，但各种摩擦扯皮是必须的。\\n\\n比如前端要后台给一个接口，后台给不出来或者嫌麻烦；比如后台跪求DBA的权限，DBA优化数据库时说Developer都一群傻逼；比如测试一次又一次的报bug我特么像杀人的时候……\\n\\n这些都需要沟通，也就是需要时间和精力。\\n\\n**其他无聊的办公室活动**\\n\\n比如写日报周报，应付各种KPI，这是所有工种都干的活，就不多说了。\\n\\n总之，程序员真正写代码的时间其实不多。个人觉得，一天能有30%的时间安安静静的写代码，就算是不错的工作环境了。\\n\\n不论是我们的大学教育也好，培训机构也罢，都只知道知识的灌输，而忽略了程序员工作能力的培养。这些能力，即只能在工作中“自学”获得，所以你看这些公司的招聘，都要求“两年以上工作经验”，意思就是：一般的新人，起码要两年的时间，才能“习得”这些起码的工作技能。\\n\\n能不能有所改变呢？\\n\\n我想试一试。\\n\",\"description\":\"程序员是做什么的呢？\",\"id\":6,\"title\":\"程序员是做什么的\"}]', 'com.zwu.controller.BlogController.update', '0:0:0:0:0:0:0:1', '2021-06-01 14:14:56');
INSERT INTO `systemlog` VALUES ('109', 'tom', '修改博客内容', '[{\"content\":\"1.打开idea，在左侧项目展示栏中找到.idea，双击打开.idea\\n\\n![idea.png](https://newplusblog.oss-cn-hangzhou.aliyuncs.com/博客图片/2021/六月/01/2b412bead62e437b9fca30c2d3279eefidea.png)\\n\\n2.在.idea下双击打开workspace.xml\\n\\n![workspace.png](https://newplusblog.oss-cn-hangzhou.aliyuncs.com/博客图片/2021/六月/01/b9ac7f1fc52f45fd85b57d53c3862981workspace.png)\\n\\n3.编辑workspace.xml文件，在结尾添加如下配置代码\\n\\n```xml\\n<component name=\\\"RunDashboard\\\">\\n\\n  <option name=\\\"configurationTypes\\\">\\n\\n    <set>\\n\\n      <option value=\\\"SpringBootApplicationConfigurationType\\\" />\\n\\n    </set>\\n\\n  </option>\\n\\n</component>\\n```\\n\\n![位置.png](https://newplusblog.oss-cn-hangzhou.aliyuncs.com/博客图片/2021/六月/01/af29b1a939404b1fbe4655b7a423ce1a位置.png)\\n\\n4.保存配置文件，重启idea开发工具，重启项目，此时可以在下方工具栏Services窗口看到如图的执行窗口了\\n\\n![执行窗口.png](https://newplusblog.oss-cn-hangzhou.aliyuncs.com/博客图片/2021/六月/01/2981b8c8713741d3939e3acf0f985b7b执行窗口.png)\",\"description\":\"service没有显示的问题解决\",\"id\":5,\"title\":\"idea配置service启动\"}]', 'com.zwu.controller.BlogController.update', '0:0:0:0:0:0:0:1', '2021-06-01 14:15:22');
INSERT INTO `systemlog` VALUES ('110', 'tom', '查看日志列表', '[1,10,\" \"]', 'com.zwu.controller.SystemLogController.list', '0:0:0:0:0:0:0:1', '2021-06-01 14:15:43');
INSERT INTO `systemlog` VALUES ('111', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 14:15:46');
INSERT INTO `systemlog` VALUES ('112', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 14:15:46');
INSERT INTO `systemlog` VALUES ('113', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 14:15:47');
INSERT INTO `systemlog` VALUES ('114', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 14:17:06');
INSERT INTO `systemlog` VALUES ('115', 'tom', '查看用户列表', '[1,10,\"\",\"2\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 14:17:06');
INSERT INTO `systemlog` VALUES ('116', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 14:17:06');
INSERT INTO `systemlog` VALUES ('117', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 14:17:06');
INSERT INTO `systemlog` VALUES ('118', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 14:17:11');
INSERT INTO `systemlog` VALUES ('119', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 14:17:12');
INSERT INTO `systemlog` VALUES ('120', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 14:17:12');
INSERT INTO `systemlog` VALUES ('121', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 14:17:19');
INSERT INTO `systemlog` VALUES ('122', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 14:17:20');
INSERT INTO `systemlog` VALUES ('123', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 14:17:21');
INSERT INTO `systemlog` VALUES ('124', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 14:17:21');
INSERT INTO `systemlog` VALUES ('125', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 14:17:22');
INSERT INTO `systemlog` VALUES ('126', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 14:17:22');
INSERT INTO `systemlog` VALUES ('127', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 14:17:23');
INSERT INTO `systemlog` VALUES ('128', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 14:17:23');
INSERT INTO `systemlog` VALUES ('129', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 14:17:24');
INSERT INTO `systemlog` VALUES ('130', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 14:17:24');
INSERT INTO `systemlog` VALUES ('131', 'tom', '查看日志列表', '[1,10,\" \"]', 'com.zwu.controller.SystemLogController.list', '0:0:0:0:0:0:0:1', '2021-06-01 14:17:25');
INSERT INTO `systemlog` VALUES ('132', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 14:17:29');
INSERT INTO `systemlog` VALUES ('133', 'wlc', '根据用户id查看具体用户', '[2]', 'com.zwu.controller.UserController.findById', '0:0:0:0:0:0:0:1', '2021-06-01 14:17:35');
INSERT INTO `systemlog` VALUES ('134', 'tom', '根据用户id查看具体用户', '[1]', 'com.zwu.controller.UserController.findById', '0:0:0:0:0:0:0:1', '2021-06-01 16:49:56');
INSERT INTO `systemlog` VALUES ('135', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 16:49:57');
INSERT INTO `systemlog` VALUES ('136', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 16:49:57');
INSERT INTO `systemlog` VALUES ('137', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 16:50:01');
INSERT INTO `systemlog` VALUES ('138', 'tom', '查看权限列表', '[1,10,\"\"]', 'com.zwu.controller.PermissionController.list', '0:0:0:0:0:0:0:1', '2021-06-01 16:50:01');
INSERT INTO `systemlog` VALUES ('139', 'tom', '查看日志列表', '[1,10,\" \"]', 'com.zwu.controller.SystemLogController.list', '0:0:0:0:0:0:0:1', '2021-06-01 16:50:02');
INSERT INTO `systemlog` VALUES ('140', 'tom', '根据用户id查看具体用户', '[1]', 'com.zwu.controller.UserController.findById', '0:0:0:0:0:0:0:1', '2021-06-01 16:50:22');
INSERT INTO `systemlog` VALUES ('141', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 16:50:29');
INSERT INTO `systemlog` VALUES ('142', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-01 16:50:29');
INSERT INTO `systemlog` VALUES ('143', 'tom', '根据用户id查看具体用户', '[1]', 'com.zwu.controller.UserController.findById', '0:0:0:0:0:0:0:1', '2021-06-02 16:42:10');
INSERT INTO `systemlog` VALUES ('144', 'tom', '根据用户id查看具体用户', '[1]', 'com.zwu.controller.UserController.findById', '0:0:0:0:0:0:0:1', '2021-06-02 16:45:28');
INSERT INTO `systemlog` VALUES ('145', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 16:48:37');
INSERT INTO `systemlog` VALUES ('146', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 16:48:37');
INSERT INTO `systemlog` VALUES ('147', 'tom', '根据用户id查看具体用户', '[1]', 'com.zwu.controller.UserController.findById', '0:0:0:0:0:0:0:1', '2021-06-02 16:51:02');
INSERT INTO `systemlog` VALUES ('148', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 16:51:04');
INSERT INTO `systemlog` VALUES ('149', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 16:51:04');
INSERT INTO `systemlog` VALUES ('150', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 16:51:42');
INSERT INTO `systemlog` VALUES ('151', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 16:51:42');
INSERT INTO `systemlog` VALUES ('152', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 16:54:14');
INSERT INTO `systemlog` VALUES ('153', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 16:54:14');
INSERT INTO `systemlog` VALUES ('154', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 16:56:19');
INSERT INTO `systemlog` VALUES ('155', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 16:56:19');
INSERT INTO `systemlog` VALUES ('156', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:01:43');
INSERT INTO `systemlog` VALUES ('157', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:01:43');
INSERT INTO `systemlog` VALUES ('158', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:01:48');
INSERT INTO `systemlog` VALUES ('159', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:01:48');
INSERT INTO `systemlog` VALUES ('160', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:02:16');
INSERT INTO `systemlog` VALUES ('161', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:02:16');
INSERT INTO `systemlog` VALUES ('162', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:02:29');
INSERT INTO `systemlog` VALUES ('163', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:02:29');
INSERT INTO `systemlog` VALUES ('164', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:02:32');
INSERT INTO `systemlog` VALUES ('165', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:02:32');
INSERT INTO `systemlog` VALUES ('166', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:02:44');
INSERT INTO `systemlog` VALUES ('167', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:02:44');
INSERT INTO `systemlog` VALUES ('168', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:03:46');
INSERT INTO `systemlog` VALUES ('169', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:03:46');
INSERT INTO `systemlog` VALUES ('170', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:03:50');
INSERT INTO `systemlog` VALUES ('171', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:03:50');
INSERT INTO `systemlog` VALUES ('172', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:04:45');
INSERT INTO `systemlog` VALUES ('173', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:04:45');
INSERT INTO `systemlog` VALUES ('174', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:04:47');
INSERT INTO `systemlog` VALUES ('175', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:04:47');
INSERT INTO `systemlog` VALUES ('176', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:06:25');
INSERT INTO `systemlog` VALUES ('177', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:06:25');
INSERT INTO `systemlog` VALUES ('178', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:06:27');
INSERT INTO `systemlog` VALUES ('179', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:06:27');
INSERT INTO `systemlog` VALUES ('180', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:06:53');
INSERT INTO `systemlog` VALUES ('181', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:06:53');
INSERT INTO `systemlog` VALUES ('182', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:07:10');
INSERT INTO `systemlog` VALUES ('183', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:07:10');
INSERT INTO `systemlog` VALUES ('184', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:07:32');
INSERT INTO `systemlog` VALUES ('185', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:07:32');
INSERT INTO `systemlog` VALUES ('186', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:07:34');
INSERT INTO `systemlog` VALUES ('187', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:07:34');
INSERT INTO `systemlog` VALUES ('188', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:07:47');
INSERT INTO `systemlog` VALUES ('189', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:07:47');
INSERT INTO `systemlog` VALUES ('190', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:11:33');
INSERT INTO `systemlog` VALUES ('191', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:11:33');
INSERT INTO `systemlog` VALUES ('192', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:12:27');
INSERT INTO `systemlog` VALUES ('193', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:12:27');
INSERT INTO `systemlog` VALUES ('194', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:12:29');
INSERT INTO `systemlog` VALUES ('195', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:12:29');
INSERT INTO `systemlog` VALUES ('196', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:14:51');
INSERT INTO `systemlog` VALUES ('197', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:14:51');
INSERT INTO `systemlog` VALUES ('198', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:14:54');
INSERT INTO `systemlog` VALUES ('199', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:14:54');
INSERT INTO `systemlog` VALUES ('200', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:15:22');
INSERT INTO `systemlog` VALUES ('201', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:15:22');
INSERT INTO `systemlog` VALUES ('202', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:17:37');
INSERT INTO `systemlog` VALUES ('203', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:17:37');
INSERT INTO `systemlog` VALUES ('204', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:17:56');
INSERT INTO `systemlog` VALUES ('205', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:17:56');
INSERT INTO `systemlog` VALUES ('206', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:19:26');
INSERT INTO `systemlog` VALUES ('207', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:19:26');
INSERT INTO `systemlog` VALUES ('208', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:19:27');
INSERT INTO `systemlog` VALUES ('209', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:19:27');
INSERT INTO `systemlog` VALUES ('210', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:20:07');
INSERT INTO `systemlog` VALUES ('211', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:20:07');
INSERT INTO `systemlog` VALUES ('212', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:21:48');
INSERT INTO `systemlog` VALUES ('213', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:21:48');
INSERT INTO `systemlog` VALUES ('214', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:21:49');
INSERT INTO `systemlog` VALUES ('215', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:21:49');
INSERT INTO `systemlog` VALUES ('216', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:24:12');
INSERT INTO `systemlog` VALUES ('217', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:24:12');
INSERT INTO `systemlog` VALUES ('218', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:24:14');
INSERT INTO `systemlog` VALUES ('219', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:24:14');
INSERT INTO `systemlog` VALUES ('220', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:25:29');
INSERT INTO `systemlog` VALUES ('221', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:25:29');
INSERT INTO `systemlog` VALUES ('222', 'tom', '新增用户', '[{\"email\":\"12752354@qq.com\",\"fullName\":\"gbjjj\",\"id\":5,\"mobile\":\"13758758758\",\"password\":\"$2a$10$QGVAGAneSn9afNWXY6E69OR6ZbbqvtIjWiBXWl0MojH2pDMw4FrMK\",\"roleId\":3,\"status\":1,\"username\":\"gbjjj\"}]', 'com.zwu.controller.UserController.singleSave', '0:0:0:0:0:0:0:1', '2021-06-02 17:25:57');
INSERT INTO `systemlog` VALUES ('223', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:25:57');
INSERT INTO `systemlog` VALUES ('224', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:25:57');
INSERT INTO `systemlog` VALUES ('225', 'tom', '更新用户', '[{\"avatar\":\"https://newplusblog.oss-cn-hangzhou.aliyuncs.com/用户头像/2021/六月/02/af8087542d0b4a85b7db25a26a033436qwe.jpg\",\"email\":\"12752354@qq.com\",\"fullName\":\"gbjjj\",\"id\":5,\"mobile\":\"13758758758\",\"password\":\"$2a$10$QGVAGAneSn9afNWXY6E69OR6ZbbqvtIjWiBXWl0MojH2pDMw4FrMK\",\"roleId\":3,\"status\":1,\"username\":\"gbjjj\"}]', 'com.zwu.controller.UserController.singleUpdate', '0:0:0:0:0:0:0:1', '2021-06-02 17:26:28');
INSERT INTO `systemlog` VALUES ('226', 'tom', '查看用户列表', '[1,10,\"\",\"\"]', 'com.zwu.controller.UserController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:26:28');
INSERT INTO `systemlog` VALUES ('227', 'tom', '查看角色列表', '[1,100]', 'com.zwu.controller.RoleController.findAll', '0:0:0:0:0:0:0:1', '2021-06-02 17:26:28');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `username` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '账号',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '密码',
  `avatar` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '头像',
  `fullName` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '昵称',
  `mobile` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '手机信息',
  `email` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '邮箱信息',
  `status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '用户状态(1:开启，0:关闭)',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint(3) NOT NULL DEFAULT '0' COMMENT '逻辑删除(1:已删除，0:未删除)',
  PRIMARY KEY (`id`),
  KEY `UK_USERNAME` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'tom', '$2a$10$/tHUEWcuiuPkx9D3mIhq9e2YTzc2nff13K3Xki4UULb4aFMtT/0Le', 'https://newplusblog.oss-cn-hangzhou.aliyuncs.com/用户头像/2021/六月/01/ce0add2e53674b6bb832f2a6f4325360dog.jpg', '汤姆', '18888604000', 'tom@qq.com', '1', '2021-04-29 09:03:45', '2021-06-01 13:23:20', '0');
INSERT INTO `user` VALUES ('2', 'wlc', '$2a$10$RGUIl2F3U80cX1E9FIU8m.RJSK9aLrUbGZN4nq3GTI66L18X4fjBi', 'https://newplusblog.oss-cn-hangzhou.aliyuncs.com/用户头像/2021/六月/01/bf5e3f7ace1a43848331ac0478a0f60adog2.jpg', '汪立潮', '18888604001', 'wlc@qq.com', '1', '2021-06-01 13:19:55', '2021-06-01 13:22:56', '0');
INSERT INTO `user` VALUES ('3', 'xyj', '$2a$10$cAjNOCRJj3jimFBcARhKBulk/ZqoXIGd.uKU6dehP/Xf7KRtOlAey', 'https://newplusblog.oss-cn-hangzhou.aliyuncs.com/用户头像/2021/六月/01/becb13cf1cc4422eb401e79514f95353fox.jpg', '小樱姐', '18888604002', 'xyj@qq.com', '1', '2021-06-01 13:19:55', '2021-06-01 13:23:56', '0');
INSERT INTO `user` VALUES ('4', 'mgb', '$2a$10$2.edTAhszM9V4fldQuU8kOo9Clri2AgTTapXJpyB2/nwSXKnfwN1G', 'https://newplusblog.oss-cn-hangzhou.aliyuncs.com/用户头像/2021/六月/01/a26b71aafc4643e386835d1c3e94a07egirl.jpg', '马果缤', '18888604003', 'mgb@qq.com', '1', '2021-06-01 13:19:55', '2021-06-01 13:24:41', '0');
INSERT INTO `user` VALUES ('5', 'gbjjj', '$2a$10$QGVAGAneSn9afNWXY6E69OR6ZbbqvtIjWiBXWl0MojH2pDMw4FrMK', 'https://newplusblog.oss-cn-hangzhou.aliyuncs.com/用户头像/2021/六月/02/af8087542d0b4a85b7db25a26a033436qwe.jpg', 'gbjjj', '13758758758', '12752354@qq.com', '1', '2021-06-02 17:25:56', '2021-06-02 17:26:28', '0');

-- ----------------------------
-- Table structure for `user_role`
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(3) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('1', '1', '2021-05-13 15:12:21', '0');
INSERT INTO `user_role` VALUES ('2', '2', '2021-06-01 13:19:55', '0');
INSERT INTO `user_role` VALUES ('3', '2', '2021-06-01 13:19:55', '1');
INSERT INTO `user_role` VALUES ('4', '2', '2021-06-01 13:19:55', '1');
INSERT INTO `user_role` VALUES ('3', '3', '2021-06-01 13:19:55', '0');
INSERT INTO `user_role` VALUES ('4', '4', '2021-06-01 13:19:55', '0');
INSERT INTO `user_role` VALUES ('5', '3', '2021-06-02 17:25:56', '0');
