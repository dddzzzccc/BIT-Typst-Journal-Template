// 导入字体配置
#import "font-config.typ": fonts

// 手动添加目录条目的函数（支持跳转和自动获取页码）
#let manual-entry(title, label) = context {
  if label != none {
    // 通过 label 自动获取页码
    let page-num = counter(page).at(label).first()
    [#link(label)[#title] #box(width: 1fr, repeat[·]) #link(label)[#page-num]\ ]
  } else {
    [#title #box(width: 1fr, repeat[·]) ??\ ]
  }
}

// 自定义目录格式化函数
#let format-outline-entry(entry) = {
  let level = entry.level
  let element = entry.element
  
  // 获取标题编号
  let nums = counter(heading).at(element.location())
  let number-text = if nums.len() > 0 {
    if level == 1 {
      // 一级标题：一、二、三、...
      numbering("一、", nums.at(0))
    } else if level == 2 {
      // 二级标题：（一）（二）（三）...
      numbering("（一）", nums.at(1))
    } else if level == 3 {
      // 三级标题：1. 2. 3. ...
      numbering("1.", nums.at(2))
    } else {
      // 更深层级
      let remaining = nums.slice(2)
      numbering("1.", ..remaining)
    }
  } else {
    ""
  }
  
  // 获取页码
  let page-num = counter(page).at(element.location()).first()
  
  // 根据层级设置缩进和格式，使用点连接符填充
  if level == 1 {
    [#link(element.location())[#element.body] #box(width: 1fr, repeat[·]) #link(element.location())[#page-num]\ ]
  } else if level == 2 {
    [#h(2em)#link(element.location())[#number-text#element.body] #box(width: 1fr, repeat[·]) #link(element.location())[#page-num]\ ]
  } else {
    [#h(4em)#link(element.location())[#number-text#element.body] #box(width: 1fr, repeat[·]) #link(element.location())[#page-num]\ ]
  }
}

// 目录页
#{
  set align(center)
  set text(font: fonts.hei, size: 18pt, weight: "bold")
  [目录]
  v(2em)
}

#{
  set text(font: fonts.song, size: 10.5pt)
  set par(leading: 1.2em, first-line-indent: 0em)  // 取消目录中的首行缩进
  v(0.5em)
  // 自定义目录显示规则
  show outline.entry: format-outline-entry

  manual-entry("摘要", <abstract-cn>)

  outline(
    title: none,
    depth: 3
  )
  
  // 手动添加非标题条目（按一级标题格式显示，支持跳转和自动页码）
  manual-entry("参考文献", <references>)
  manual-entry("英文摘要", <abstract-en>)
  manual-entry("查重报告", <similarity-check>)
}

\ 注：人工智能在本文中主要帮助利用Typst代码进行排版和格式调整，相关文献推荐，学习了解道义论、后果论、美德伦理学三种伦理学分析视角，文本学术润色。

#pagebreak()