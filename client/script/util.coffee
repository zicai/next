@Next = {}
# 计算拖拽后排序
# item 是被拖拽元素
Next.caculateOrder = (container, item)->
  weight = 10000
  total = $(container).children().length
  index = $(container).children().index($(item))
  console.log '共', total, '第', index
  if index is 0
    suf = parseFloat($(item).next().attr('data-task-order'))
    return suf - weight
  else if index > 0 and index < total - 1
    pre = parseFloat($(item).prev().attr('data-task-order'))
    suf = parseFloat($(item).next().attr('data-task-order'))
    return (pre + suf) / 2
    console.log 'mid'
  else if index is total - 1
    pre = parseFloat($(item).prev().attr('data-task-order'))
    return pre + weight
    console.log 'last'
