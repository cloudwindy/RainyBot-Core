<div id="top"></div>
<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/Xwdit/RainyBot-Core/">
    <img src=".github/images/logo.png" alt="Logo" width="100" height="100">
  </a>

  <h3 align="center">RainyBot</h3>

  <p align="center">
    新手友好，简单易上手的跨平台聊天机器人开发框架
    <br />
    <a href="https://github.com/Xwdit/RainyBot-Core/releases"><strong>立即下载</strong></a>
    <br />
    <br />
    <a href="https://github.com/Xwdit/RainyBot-API">API文档</a>
    ·
    <a href="https://github.com/Xwdit/RainyBot-Core/issues">问题报告</a>
    ·
    <a href="https://github.com/Xwdit/RainyBot-Core/issues">功能请求</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>本页目录</summary>
  <ol>
    <li>
      <a href="#about-the-project">关于本项目</a>
      <ul>
        <li><a href="#built-with">基于的项目</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">开始使用</a>
      <ul>
        <li><a href="#prerequisites">运行需求</a></li>
        <li><a href="#installation">配置与使用</a></li>
      </ul>
    </li>
    <li><a href="#usage">插件示例</a></li>
    <li><a href="#roadmap">开发路线图</a></li>
    <li><a href="#contributing">贡献指南</a></li>
    <li><a href="#license">项目许可</a></li>
    <li><a href="#contact">联系方式</a></li>
    <li><a href="#acknowledgments">更多信息</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## 关于本项目

<img src=".github/images/screenshot.png" alt="Logo" width="640" height="400">

这是一个跨平台，跨协议 (实现中) 的机器人开发框架，基于 Godot Engine 4.0 进行开发。
本项目成立的目的，是为了建立一个低门槛，简单易用的机器人开发框架。
通过提供大量精心设计的交互API/预置功能，结合GDScript脚本语言的简便语法，
来尽可能地提升开发效率且降低开发难度，让更多开发经验不足，乃至无经验的用户也能够轻松开发属于自己的各类机器人应用。


功能特色:
* 模块化设计，大部分API可独立于协议后端存在，通过不同适配器实现即可对接不同协议，实现一次编写多处运行 (当前仅支持Mirai-Http协议后端)
* 简单易懂的配置与管理，一次配置完成后自动管理各个协议后端的配置/运行/连接，无需每次手动启动或进行设置
* 完善易用的API与插件管理机制，支持插件间交互/热重载/热编辑等功能，同时内置功能较为全面的插件编辑器 (暂不支持自动补全)
* 人性化GUI控制台界面，全中文调试信息输出，未来还将支持插件与GUI的交互（如自定义GUI界面)
* 开箱即用的各类辅助功能接口，可便捷初始化并管理插件配置，插件数据，事件/命令注册等
* 活跃的功能开发与问题修复，且将以社区为驱动，广泛采纳各类建议与需求，共同打造属于所有人的RainyBot
* 更多功能陆续增加中.....


*注意：本项目仍处于较早期开发阶段，虽然目前核心功能已基本完备，但依然有在未经提前通知的基础上进行重大API/功能更改的可能，且可能存在未知的Bug/不稳定因素，请谨慎用于生产环境。*


<p align="right">(<a href="#top">返回顶部</a>)</p>



### 基于的项目

以下列表列出了本项目所基于的项目，使用本项目时请同时参考它们的许可信息。

* [Godot Engine](https://github.com/godotengine/godot)
* [Mirai-Api-HTTP](https://github.com/project-mirai/mirai-api-http)
* [Mirai](https://github.com/mamoe/mirai)

<p align="right">(<a href="#top">返回顶部</a>)</p>



<!-- GETTING STARTED -->
## 开始使用

接下来的部分将介绍如何配置与使用RainyBot

### 运行需求

支持的操作系统：64位 Windows 7 或以上版本 (Mac OS/Linux支持将在后续版本中添加)

Java 版本 >= 11 (此需求来源于RainyBot默认集成的Mirai协议后端，核心无需任何运行环境)

可选：支持Vulkan渲染器的图形卡 (可通过硬件加速提升性能)

### 配置与使用

1. 从GitHub发布页下载最新的发布版本: <a href="https://github.com/Xwdit/RainyBot-Core/releases"><strong>立即下载</strong></a>
2. 运行RainyBot，随后按照控制台显示的说明，打开指定的配置文件进行配置
3. 配置完毕后请重新启动RainyBot。此时若配置正确，将自动开始加载内置的协议后端（当前版本内置了Mirai协议库)
4. 请留意 *协议后端* 的控制台信息，可能会要求您进行登陆验证等操作，您可以从以下链接获取相关帮助: <a href="https://mirai.mamoe.net/topic/223/%E6%97%A0%E6%B3%95%E7%99%BB%E5%BD%95%E7%9A%84%E4%B8%B4%E6%97%B6%E5%A4%84%E7%90%86%E6%96%B9%E6%A1%88"><strong>Mirai协议库</strong></a>
5. 若一切顺利，协议后端的控制台中将出现中文或英文的登录成功/加载成功字样，且RainyBot控制台中将出现加载成功字样
6. 此时起可最小化协议后端的控制台窗口，后续操作均只需在RainyBot控制台中进行即可。从此处开始，将直接使用“控制台”来表示RainyBot的控制台界面
7. 在控制台中输入指令`help`(或`/help`)来查看所有可用的控制台指令，如输入`plugins`可查看插件管理相关指令
8. 恭喜！您成功完成了RainyBot的基本配置，开始尽情使用吧~

<p align="right">(<a href="#top">返回顶部</a>)</p>



<!-- USAGE EXAMPLES -->
## 插件示例

当前的发布版本中随附了四个示例插件，分别为：聊天机器人，随机动漫音乐/图片，简易群管，好友/拉群请求管理插件。您可以在`plugins`文件夹下找到它们，并使用`plugins edit`指令来进行编辑。
同时，对于使用`plugins create`指令新建的插件，将自动使用内置的插件模板，以便于您快速开始开发流程。

_若需查看更详细的已分类API文档与插件示例，请访问 [RainyBot-API](https://github.com/Xwdit/RainyBot-API) 储存库_

<p align="right">(<a href="#top">返回顶部</a>)</p>



<!-- ROADMAP -->
## 功能开发路线图

- [x] 核心功能完备
- [x] 整理并将项目开源
- [ ] 实现插件编辑器的自动补全
- [ ] 添加版本检测与更新功能
- [ ] 添加在线插件市场功能

对于更详细的功能计划，已知问题或功能建议，请访问储存库的 [Issues](https://github.com/Xwdit/RainyBot-Core/issues) 页面

<p align="right">(<a href="#top">返回顶部</a>)</p>



<!-- CONTRIBUTING -->
## 贡献指南

我们非常感谢您有兴趣为本项目贡献源码来让它变得更好。对于代码贡献的流程，我们建议您遵循以下贡献指南：

1. 在您的储存库中Fork本项目
2. 创建一个您准备开发的功能或修复的问题的分支 (`git checkout -b feature/AmazingFeature`)
3. 提交您的更改 (`git commit -m '添加一些功能'`)
4. 将更改上传到您的储存库 (`git push origin feature/AmazingFeature`)
5. 在本项目储存库中打开一个此分支的Pull Request，来让我们看到并对其进行审阅

<p align="right">(<a href="#top">返回顶部</a>)</p>



<!-- LICENSE -->
## 项目许可

项目基于AGPL-3.0许可进行开源，具体内容请参见LICENSE文件

<p align="right">(<a href="#top">返回顶部</a>)</p>



<!-- CONTACT -->
## 联系信息

交流QQ群: 429787496

Xwdit - xwditfr@gmail.com

项目地址: [https://github.com/Xwdit/RainyBot-Core](https://github.com/Xwdit/RainyBot-Core)

<p align="right">(<a href="#top">返回顶部</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## 更多信息

此处提供了一些可能与本项目有关，或对您有帮助的信息

* [Godot使用文档](https://docs.godotengine.org/en/latest/)
* [GDScript语言教程](https://docs.godotengine.org/en/latest/tutorials/scripting/gdscript/)
* [Godot类参考API](https://docs.godotengine.org/en/latest/classes/index.html)
* [Mirai-Api-Http文档](https://github.com/project-mirai/mirai-api-http/blob/master/docs/api/API.md)

<p align="right">(<a href="#top">返回顶部</a>)</p>


[product-screenshot]: .github/images/screenshot.png