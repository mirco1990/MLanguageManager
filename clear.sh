#!/bin/bash
echo "🧹 开始清理 WangMing1998 相关配置..."
echo "========================================"

# 1. 备份当前配置
BACKUP_DIR="$HOME/wangming_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
echo "📦 备份目录: $BACKUP_DIR"

# 2. 备份并清理 SSH config
if [ -f ~/.ssh/config ]; then
    cp ~/.ssh/config "$BACKUP_DIR/ssh_config.backup"
    echo "已备份 SSH config"
    
    # 移除与 WangMing1998 相关的配置
    grep -v -i "wangming" ~/.ssh/config > ~/.ssh/config.tmp && mv ~/.ssh/config.tmp ~/.ssh/config
    echo "已清理 SSH config 中的 WangMing1998 配置"
fi

# 3. 备份并清理 Git 全局配置
echo ""
echo "🔧 清理 Git 全局配置..."
git config --global --list > "$BACKUP_DIR/git_config.backup"

# 移除 WangMing1998 相关的用户配置
git config --global --unset-all user.name "WangMing1998" 2>/dev/null
git config --global --unset-all user.email 2>/dev/null | grep -i "wangming" 2>/dev/null
echo "已清理 Git 用户配置"

# 4. 设置正确的 GitHub 用户
echo ""
echo "✅ 设置正确的 GitHub 用户..."
git config --global user.name "mirco1990"
git config --global user.email "你的 mirco1990 邮箱地址"  # 请修改为你的实际邮箱

# 5. 清理钥匙串凭证（可选）
echo ""
read -p "是否清理钥匙串中的相关凭证？(y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "清理钥匙串中的 GitHub/Gitee 凭证..."
    # 删除 GitHub 相关凭证
    security delete-internet-password -s "github.com" 2>/dev/null || true
    # 删除 Gitee 相关凭证
    security delete-internet-password -s "gitee.com" 2>/dev/null || true
    echo "钥匙串凭证已清理"
fi

# 6. 生成新的 SSH 配置
echo ""
echo "⚙️  生成新的 SSH 配置..."
cat > ~/.ssh/config << 'EOF'
# GitHub - mirco1990 (专用配置)
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_github_mirco1990
  IdentitiesOnly yes
  PreferredAuthentications publickey

# Gitee - WangMing1998 (专用配置，如果需要保留)
# Host gitee.com
#   HostName gitee.com
#   User git
#   IdentityFile ~/.ssh/id_ed25519_gitee
#   IdentitiesOnly yes

# 通用配置
Host *
  AddKeysToAgent yes
  UseKeychain yes
  ServerAliveInterval 60
EOF

chmod 600 ~/.ssh/config
echo "✅ 新的 SSH 配置已生成"

# 7. 验证清理结果
echo ""
echo "🧪 验证清理结果："
echo "1. Git 用户配置："
git config --global user.name
git config --global user.email

echo ""
echo "2. SSH 连接测试："
ssh -T git@github.com 2>&1 | head -1

echo ""
echo "🎯 清理完成！"
echo "所有配置已备份到: $BACKUP_DIR"
echo "现在请运行: ssh -T git@github.com"
echo "如果还显示 WangMing1998，请检查 GitHub 网站上的 SSH 密钥设置"