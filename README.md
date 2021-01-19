----仿照IT营视频编写的flutter项目-仿京东商城，基本和视频大同小异，主要熟悉下flutter开发---
1.项目搭建，Tabs.dart 底部设置BottomNavigationBar，四个BottomNavigationBarItem，对应四个Pageview展示页面（主要是AutomaticKeepAliveClientMixin保持页面状态设置的，在6.下面有说明）
2.设置跳转路由routes.dart
3.首页布局，顶部点击跳转到搜索页面，上面轮播图Swiper控件，猜你喜欢container包一个listview...
热门推荐container包一个warp组件，数据加载json_to_dart 自动生成模型类
4.利用flutter_screenutil这个库封装不同终端的适配（ScreenAdaper.dart）类似于OC自己封装的flame控件
5.分类页面：整体是一个Row，左边是一个container包含listView，右边expanded包含个container，然后再gridView
6.保持页面状态：IndexedStack 保持页面状态（不方便单独控制每个页面的状态）
                            AutomaticKeepAliveClientMixin 结合 tab 切换保持页面状态（具体说明看PDF文件）
7.商品分类页面跳转到商品详情：跳转时传map。
   分类商品详情页面布局：顶部Appbar，child是一个textfield，右侧添加个筛选按钮。
    body 详情页面：stack，顶部是一个80高度的Positioned组件，商品列表对应的是一个container包含一个listview，具体数据加载看代码，有点复杂，涉及到上拉加载更多，点击销量价格不同显示排序，还有搜索展示等等...此外这里用到了GlobalKey缓存数据...据说这个GlobalKey代价很大，尽量少用
8.首页热门推荐商品点击跳转：将Scaffold组件包裹在DefaultTabController组件内，DefaultTabController把TabBar和TabBarView关联起来，是给TabBar和TabBarView设置各种属性来满足需求。

2021-1-19日 此次更新是最终更新，基本上实现了课堂上的功能....

    
                             

