const fs = require('fs');
const path = require('path');

// 设置博客 posts 目录的路径
const postsDir = path.join(__dirname, '_posts');

// 获取当前日期
const today = new Date();

// 获取 7 天前的日期
const sevenDaysAgo = new Date(today.getTime() - 7 * 24 * 60 * 60 * 1000);

// 遍历 7 天
for (let i = 0; i < 7; i++) {
  const date = new Date(sevenDaysAgo.getTime() + i * 24 * 60 * 60 * 1000);
  const filename = `${date.toISOString().slice(0, 10)}-daily.md`;
  const filePath = path.join(postsDir, filename);

  // 检查文件是否已经存在
  if (!fs.existsSync(filePath)) {
    // 创建日常博文文件
    const fileContent = `---
layout: mypost
author: 咕咚
tags: think
categories: daily
title: ""
---

`;
    fs.writeFileSync(filePath, fileContent);
    console.log(`Created file: ${filename}`);
  } else {
    console.log(`File ${filename} already exists.`);
  }
}