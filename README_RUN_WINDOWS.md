# LightRAG Windows 本地运行指南（从零开始）

本文面向 Windows 用户，目标是：

1. 跑通 LightRAG 服务（API + WebUI）
2. 跑通官方最小 Demo（OpenAI）

> 说明：本文所有命令均为 **Windows cmd** 风格。请在项目根目录执行（即包含 `pyproject.toml` 的目录）。

---

## 0. 前置准备

- 已安装 Git
- 已安装 Python 3.10+（建议 3.10/3.11）
- 可访问网络下载依赖
- （可选）若要用本地模型，已安装并启动 Ollama

---

## 1. 克隆项目

```cmd
git clone https://github.com/HKUDS/LightRAG.git
cd LightRAG
```

---

## 2. 安装 uv（必须）

在 PowerShell 中执行官方安装命令：

```powershell
powershell -c "irm https://astral.sh/uv/install.ps1 | iex"
```

安装后，重新打开一个终端窗口，验证：

```cmd
uv --version
```

如果能输出版本号，说明 uv 可用。

---

## 3. 安装 Python 依赖（推荐离线全量依赖）

你可以直接运行仓库里的批处理：

```cmd
install_lightrag_env.bat
```

它本质上执行：

```cmd
uv sync --extra test --extra offline
```

完成后会在项目根目录生成 `.venv`。

---

## 4. 构建 WebUI 前端

在项目根目录执行：

```cmd
cd lightrag_webui
bun install --frozen-lockfile
bun run build
cd ..
```

> 若提示 `bun` 不存在，请先安装 Bun，再重试。

---

## 5. 准备 .env（重点）

### 5.1 复制模板

你可以任选其一：

```cmd
copy env.example .env
```

或

```cmd
copy .env.windows.example .env
```

### 5.2 编辑 .env，填写你自己的配置

#### 方案 A：OpenAI API（最容易先跑通）

你至少需要填写：

- `LLM_BINDING=openai`
- `LLM_BINDING_HOST=https://api.openai.com/v1`
- `LLM_BINDING_API_KEY=<你的OpenAI API Key>`  ← **这里必须自己填**
- `LLM_MODEL=<你要用的模型>`
- Embedding 相关参数（可用 OpenAI 或本地 Ollama）

#### 方案 B：Ollama 本地模型

你至少需要填写：

- `LLM_BINDING=ollama`
- `LLM_BINDING_HOST=http://127.0.0.1:11434`
- `LLM_MODEL=<你本地已拉取模型名>`
- `EMBEDDING_BINDING=ollama`
- `EMBEDDING_BINDING_HOST=http://127.0.0.1:11434`
- `EMBEDDING_MODEL=<你本地 embedding 模型名>`
- `EMBEDDING_DIM=<与模型一致的维度>`

> ⚠️ 注意：不要把真实密钥提交到 Git。`.env` 只保存在本地。

---

## 6. 启动 LightRAG 服务（API + WebUI）

直接运行：

```cmd
run_lightrag_server.bat
```

该脚本会：

1. 检查 `.venv` 是否存在
2. 激活虚拟环境
3. 检查 `.env` 是否存在
4. 启动 `lightrag-server`

默认端口通常是 `9621`（可在 `.env` 中调整）。

---

## 7. 运行官方最小 Demo（OpenAI）

### 7.1 先设置环境变量（当前 cmd 窗口）

```cmd
set OPENAI_API_KEY=你的OpenAI_API_Key
```

### 7.2 准备 demo 文本（可选但推荐）

```cmd
curl https://raw.githubusercontent.com/gusye1234/nano-graphrag/main/tests/mock_data.txt -o book.txt
```

### 7.3 运行 demo

```cmd
run_lightrag_demo.bat
```

脚本会检查 `OPENAI_API_KEY`，未设置则提示并退出。

---

## 8. 推荐执行顺序（照着做）

1. `git clone ...` 并进入项目目录
2. 安装 uv 并确认 `uv --version`
3. `install_lightrag_env.bat`
4. 构建前端（`bun install` + `bun run build`）
5. `copy .env.windows.example .env` 并编辑 `.env`（填写你自己的 Key/模型）
6. `run_lightrag_server.bat` 启动服务
7. （可选）`set OPENAI_API_KEY=...` 后执行 `run_lightrag_demo.bat`

完成以上步骤即可在 Windows 本地完成最小可用链路。
