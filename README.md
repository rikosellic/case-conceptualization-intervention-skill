# case-conceptualization-intervention-skill

以心理咨询师或督导师视角对来访者治疗记录进行个案概念化并提出干预指导建议的 AI Agent Skill。

## 安装

### GitHub Copilot（个人 skill）

将本仓库克隆到 Copilot 个人 skills 目录，**文件夹名必须与 skill name 一致**：

```bash
git clone https://github.com/rikosellic/case-conceptualization-intervention-skill.git \
  ~/.copilot/skills/case-conceptualization-intervention
```

或手动复制本仓库到以下任一位置（文件夹名改为 `case-conceptualization-intervention`）：

| 安装位置 | 范围 |
|----------|------|
| `~/.copilot/skills/case-conceptualization-intervention/` | 个人全局 |
| `~/.agents/skills/case-conceptualization-intervention/` | 个人全局 |
| `~/.claude/skills/case-conceptualization-intervention/` | 个人全局（Claude Code） |

> **注意**：安装时文件夹名必须为 `case-conceptualization-intervention`（与 SKILL.md 中的 `name` 字段一致），**不能**保留仓库原名 `case-conceptualization-intervention-skill`（含 `-skill` 后缀会导致 Agent 无法发现）。

### 项目级安装（团队共享）

将本仓库复制到项目根目录下的对应路径：

```bash
# 任选其一
<project>/.github/skills/case-conceptualization-intervention/
<project>/.agent/skills/case-conceptualization-intervention/
<project>/.claude/skills/case-conceptualization-intervention/
```

## 使用

安装后，在 Copilot/Copilot Chat 中可通过以下方式触发：
- 直接输入 `/case-conceptualization-intervention` 作为 slash command
- 或在对话中描述需求（如"帮我分析这份初访记录，做个案概念化"），Agent 会根据 description 自动加载本 skill

支持传入心理咨询记录、初访访谈、督导材料或个案报告草稿（Markdown/文本/PDF），自动生成中文个案概念化报告并提供干预指导。

### 输出模式

- 完整版报告（默认）
- 简版概念化
- 督导讨论版
- 指定流派版（CBT / 心理动力学 / 家庭系统 / 等）
- 干预指导版

## 结构

```
case-conceptualization-intervention/
├── SKILL.md              # Skill 入口（Agent 读取的指令）
├── skills/               # 知识库（个案概念化 / 综合理论 / 干预 / 诊断 / 模板）
└── tools/pdf-analyzer/   # PDF 内容提取工具
```