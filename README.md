### 📦 环境变量配置说明

| 变量名 | 类型 | 默认值 | 示例 | 功能说明 |
| :--- | :---: | :---: | :--- | :--- |
| **CR_CADDY_REAL_IP** | String | `X-Forwarded-For` | `CF-Connecting-IP EO-Connecting-IP` | 设置反代时识别真实 IP 的请求头（如使用 Cloudflare 时修改） |
| **CR_CADDY_WORK_DIR** | String | `/var/www/` | `/var/www/aaa` | PHP网站目录 |

---
