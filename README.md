## 动态高度
flowLayout 高度有个固定的算法, 让看上去比较错落有致.不能使用随机.要不每次都会刷新
接口中返回图片宽高,这边做缩放, 如果提高性能,将attrArray做缓存.而不是每次有数据了重新算

## Json-server
npm install -g json-server
json-server --watch db.json --routes routes.json

## Mock API
* http://localhost:3000/doodles?_start=0&_end=20
* http://localhost:3000/doodles?tags=funny
* http://localhost:3000/doodles/570858f9c14954e756ef4570
* http://localhost:3000/doodles/570858f9c14954e756ef4570/detail

## 参考资料
[tutuge 目录结构](http://tutuge.me/2015/02/01/iOS%E9%A1%B9%E7%9B%AE%E7%9A%84%E7%9B%AE%E5%BD%95%E7%BB%93%E6%9E%84-%E5%8E%9F%E5%88%9B/)
