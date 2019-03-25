#风控规则执行多线程简单Demo

首先为了提高规则引擎的执行规则的返回时间，这里采用多线程进行处理

RiskCheckClient 风控检查客户端

RiskCheckService 风控检查服务

IRuleExecutor 兼容各规则场景的规则执行器接口

BeforeRuleExecutor 事前规则执行器

DuringRuleExecutor 事中规则执行器

RiskResponse 风险返回结果

Rule 规则类

RuleTypeEnum 规则类型枚举