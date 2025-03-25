#!/usr/bin/env ruby

require 'yaml'

def check_file(path)
  begin
    content = File.read(path)
    
    # 检查文件编码
    unless content.valid_encoding?
      puts "编码问题: #{path}"
      return false
    end
    
    # 检查YAML frontmatter
    if content.start_with?('---')
      parts = content.split('---', 3)
      if parts.length >= 3
        begin
          front_matter = YAML.safe_load(parts[1])
          unless front_matter.is_a?(Hash)
            puts "frontmatter格式有问题 (不是Hash): #{path}"
            return false
          end
        rescue => e
          puts "YAML解析错误 (#{e.message}): #{path}"
          return false
        end
      else
        puts "frontmatter格式有问题 (没有完整的---分隔符): #{path}"
        return false
      end
    else
      puts "没有frontmatter: #{path}"
      return false
    end
    
    return true
  rescue => e
    puts "文件读取错误 (#{e.message}): #{path}"
    return false
  end
end

# 检查所有文章
posts_dir = "_posts"
ok_count = 0
error_count = 0

Dir.glob("#{posts_dir}/*.{md,markdown}").each do |file|
  if check_file(file)
    ok_count += 1
  else
    error_count += 1
  end
end

puts "\n检查完成: #{ok_count}个正常, #{error_count}个有问题" 