INSERT INTO t_system_type VALUES ('4bc5ccdc9eba428fb0514fe001322df4', 'QtMxaUDrFc1J+J9vpONe9kbEZ18T640A5V4N0g6P2XQF0J6NYTyzV+ySid9M+jVZjgWinsg1r8hwDAIcnxAUlTq/KRRvawv+WkP84OTF0Bg=', '平台用户', 'PTYH', '192.168.1.1', '深圳市罗湖区畔山路85号叮叮电商大厦', 'http://www.zhiduntech.com', '汤守禧', '18682257247', 'tsx@zhiduntech.com', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_account VALUES (1, '4bc5ccdc9eba428fb0514fe001322df4', 'admin', 'dJpIDBdLb4D10vlztYTNFql1IJzS5QVtDo+MUksr0lGsTU3I8EK9e8ZYb5y9FXve2h8hPZa4kYA+JWIhCrVL5v8MRVC4+eSP0l5Y4UpkwIk=', 1, 'tsx@zhiduntech.com', NOW(), 1, 'S', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_account VALUES (2, '78a32170ac304db9b2ec4ceb2b9eae9f', 'zhAdmin', 'dJpIDBdLb4D10vlztYTNFql1IJzS5QVtDo+MUksr0lGsTU3I8EK9e8ZYb5y9FXve2h8hPZa4kYA+JWIhCrVL5v8MRVC4+eSP0l5Y4UpkwIk=', 2, 'zh@ddbill.com', NOW(), 6, 'S', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_role VALUES (1, '4bc5ccdc9eba428fb0514fe001322df4', 'Administrator', 'S', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_role VALUES (2, '4bc5ccdc9eba428fb0514fe001322df4', '风控经理', 'S', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_role VALUES (3, '4bc5ccdc9eba428fb0514fe001322df4', '风控组长', 'S', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_role VALUES (4, '4bc5ccdc9eba428fb0514fe001322df4', '风控专员', 'S', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_role VALUES (5, '4bc5ccdc9eba428fb0514fe001322df4', '审计', 'S', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_account_role VALUES (1, 1, 1, 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_role_menu VALUES (1, 1, 23, 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_role_menu VALUES (2, 1, 231, 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_role_menu VALUES (3, 1, 232, 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_role_menu VALUES (4, 1, 999, 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_role_menu VALUES (5, 2, 999, 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_role_menu VALUES (6, 3, 999, 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_role_menu VALUES (7, 4, 999, 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_role_menu VALUES (8, 5, 999, 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);



INSERT INTO t_sys_menu VALUES (11, '我的流程', 3, 0, 0, NULL, 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (111, '我的待办件', 3, 11, 1, '/listToDoTask', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (112, '我的经办件', 3, 11, 2, '/listDoneTask', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);

INSERT INTO t_sys_menu VALUES (12, '设备指纹', 3, 0, 10, NULL, 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (121, '指纹参数', 3, 12, 11, '/fingerPrintParameters', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (122, '指纹查询', 3, 12, 12, '/searchFingerPrint', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);

INSERT INTO t_sys_menu VALUES (13, '规则引擎', 3, 0, 20, NULL, 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (131, '规则管理', 3, 13, 21, '/listRule', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (132, '规则类别', 1, 13, 22, '/listRuleType', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (133, '规则参数', 2, 13, 23, '/listRuleParameter', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (134, '行业参数', 2, 13, 24, '/listBusinessRuleParameter', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (135, '风险级别', 1, 13, 25, '/listRiskLevel', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (136, '规则监控', 3, 13, 26, '/listRuleMonitor', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (137, '支付类型', 2, 13, 27, '/listPayclass', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (138, '规则统计', 1, 13, 28, '/listRuleInvoke', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);

INSERT INTO t_sys_menu VALUES (14, '黑名单库', 3, 0, 30, NULL, 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (141, '黑名单搜索', 3, 14, 31, '/searchBlackList', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (142, '黑名单档案', 3, 14, 32, '/blackListHistory', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);

INSERT INTO t_sys_menu VALUES (15, '白名单库', 3, 0, 40, null, 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (151, '白名单搜索', 3, 15, 41, '/searchWhiteList', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (152, '白名单档案', 3, 15, 42, '/whiteListHistory', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);

INSERT INTO t_sys_menu VALUES (16, '平台管理', 1, 0, 50, NULL, 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (161, '接入系统管理', 1, 16, 51, '/listSystemType', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (162, '外部接口管理', 1, 16, 52, '/listExternalInterface', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (163, '外部接口监控', 1, 16, 52, '/listInterfaceMonitor', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);

INSERT INTO t_sys_menu VALUES (17, '操作日志', 3, 0, 60, NULL, 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (171, '日志查询', 3, 17, 61, '/listLog', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);

INSERT INTO t_sys_menu VALUES (18, '报表中心', 3, 0, 70, NULL, 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (181, '交易趋势报表', 3, 18, 71, '/transactionTrendReport', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (182, '风险事件报表', 3, 18, 73, '/riskEventReport', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (183, '风控规则报表', 3, 18, 74, '/rcRuleReport', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (184, '关注名单报表', 3, 18, 75, '/attentionListReport', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (185, '大额订单报表', 3, 18, 76, '/bigOrderReport', 'A', '1', unix_timestamp(now())*1000, '1', unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (186, '可疑订单报表', 3, 18, 77, '/doubtfulOrderReport', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);


INSERT INTO t_sys_menu VALUES (20, '风险管理', 2, 0, 90, NULL, 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (201, '风险事件', 2, 20, 91, '/listRiskEvent', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (202, '投诉事件', 2, 20, 92, '/listComplaint', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);

INSERT INTO t_sys_menu VALUES (21, '关注名单', 2, 0, 100, NULL, 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (211, '关注管理', 2, 21, 101, '/listAttention', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (212, '关注档案', 2, 21, 102, '/listAttentionHistory', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);

INSERT INTO t_sys_menu VALUES (22, '预警中心', 2, 0, 110, NULL, 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (221, '预警中心', 2, 22, 111, '/alertCenter', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);

INSERT INTO t_sys_menu VALUES (23, '基础管理', 3, 0, 120, NULL, 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (231, '用户管理', 3, 23, 121, '/listAccount', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (232, '角色管理', 3, 23, 122, '/listRole', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (233, '流程管理', 1, 23, 123, '/listWorkflow', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (234, '公告管理', 3, 23, 124, '/listNotice', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (236, '行业管理', 2, 23, 126, '/listBusinessType', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (237, '政策管理', 3, 23, 127, '/listRcPolicy', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (238, '参数管理', 2, 23, 129, '/listSysParameter', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_menu VALUES (239, '商家管理', 2, 23, 130, '/listMerchantBusiness', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);

INSERT INTO t_sys_menu VALUES (999, '主页面', 3, 0, 999, '/index', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);

INSERT INTO t_sys_permission VALUES (1, '新增', 'I', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_permission VALUES (2, '删除', 'D', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_permission VALUES (3, '修改', 'U', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_permission VALUES (4, '禁用', 'F', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_permission VALUES (5, '打印', 'P', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_sys_permission VALUES (6, '导出', 'E', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);

INSERT INTO t_rc_algorithm_type VALUES ('1', 'MDMPA', '商家每日最大交易金额', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_rc_algorithm_type VALUES ('2', 'MDMPC', '商家每日最大交易笔数', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_rc_algorithm_type VALUES ('3', 'MMMPA', '商家每月最大交易金额', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);
INSERT INTO t_rc_algorithm_type VALUES ('4', 'MMMPC', '商家每月最大交易笔数', 'A', 1, unix_timestamp(now())*1000, 1, unix_timestamp(now())*1000);


