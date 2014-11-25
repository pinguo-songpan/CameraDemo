// 日志输出宏定义

#ifdef DEBUG
// 调试状态
#define MyLog(...) NSLog(__VA_ARGS__)
#else
// 发布状态
#define MyLog(...)
#endif

#define iPhoneW [UIScreen mainScreen].bounds.size.width
#define iPhoneH [UIScreen mainScreen].bounds.size.height