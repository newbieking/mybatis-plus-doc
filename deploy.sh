#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

msg="来自Github Actions的自动部署，更新于$(TZ=UTC-8 date "+%Y-%m-%d %H:%M:%S")"
codingUrl=https://${CODING_USER}:${CODING_TOKEN}@e.coding.net/yangyang0507/mybatis-plus-doc.git
docDir=docs/.vuepress/dist

git config --global user.name "D.Yang"
git config --global user.email "koyangslash@gmail.com"

git clone $codingUrl $docDir

# 生成文档
yarn run build

# 进入生成的文件夹
cd docs/.vuepress/dist

# 部署到Coding
echo "baomidou.com" > CNAME
echo "www.baomidou.com" >> CNAME
echo "google.com, pub-4147143076931995, DIRECT, f08c47fec0942fa0" > ads.txt

git add -A
git commit -m "${msg}"
git push -f origin master

# 删除
cd -
rm -rf docs/.vuepress/dist