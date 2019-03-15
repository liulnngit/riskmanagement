DROP TABLE IF EXISTS t_sys_account;
CREATE TABLE t_sys_account(
  id int(20) NOT NULL auto_increment COMMENT '用户表主键',
  system_id varchar(32) NOT NULL COMMENT '系统ID',
  login_name varchar(40) NOT NULL COMMENT '用户名',
  login_pwd varchar(255) NOT NULL COMMENT '登录密码',
  account_type char(1) NOT NULL COMMENT '用户类型(1：平台用户,2：系统用户)',
  email_address varchar(100) NOT NULL UNIQUE COMMENT '注册邮箱',
  last_login timestamp NULL COMMENT '最后登录时间',
  role_id varchar(40) NOT NULL COMMENT '角色ID(多个角色使用逗号分隔)',
  status char(1) NOT NULL COMMENT '状态(A=Active, I=Inactive, S=System)',
  creator_id int(20) NOT NULL COMMENT '创建人ID',
  create_date LONG NOT NULL COMMENT '创建时间(时间戳)',
  updater_id int(20) NOT NULL COMMENT '更新人ID',
  update_date LONG NOT NULL COMMENT '更新时间(时间戳)',
  primary key(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS t_sys_role;
CREATE TABLE t_sys_role(
  id int(20) NOT NULL auto_increment COMMENT '角色表主键',
  system_id varchar(32) NOT NULL COMMENT '系统ID',
  role_name varchar(40) NOT NULL COMMENT '角色名',
  status char(1) NOT NULL COMMENT '状态(A=Active, I=Inactive, S=System)',
  creator_id int(20) NOT NULL COMMENT '创建人ID',
  create_date LONG NOT NULL COMMENT '创建时间(时间戳)',
  updater_id int(20) NOT NULL COMMENT '更新人ID',
  update_date LONG NOT NULL COMMENT '更新时间(时间戳)',
  primary key(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS t_sys_menu;
CREATE TABLE t_sys_menu(
  id int(20) NOT NULL auto_increment COMMENT '菜单表主键',
  menu_name varchar(40) NOT NULL COMMENT '菜单名',
  menu_type char(1) NOT NULL COMMENT '菜单类型(1：平台用户可见,2：系统用户可见,3：所有人可见)',
  parent_id int(20) NOT NULL COMMENT '父菜单ID(一级菜单父菜单ID为0)',
  priority int(20) NOT NULL COMMENT '菜单优先级',
  link_url varchar(100) NULL COMMENT '菜单URL链接',
  status char(1) NOT NULL COMMENT '状态(A=Active, I=Inactive)',
  creator_id int(20) NOT NULL COMMENT '创建人ID',
  create_date LONG NOT NULL COMMENT '创建时间(时间戳)',
  updater_id int(20) NOT NULL COMMENT '更新人ID',
  update_date LONG NOT NULL COMMENT '更新时间(时间戳)',
  primary key(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS t_sys_account_role;
CREATE TABLE t_sys_account_role(
  id int(20) NOT NULL auto_increment COMMENT '用户角色关系表主键',
  account_id int(20) NOT NULL COMMENT '用户ID',
  role_id int(20) NOT NULL COMMENT '角色ID',
  status char(1) NOT NULL COMMENT '状态(A=Active, I=Inactive)',
  creator_id int(20) NOT NULL COMMENT '创建人ID',
  create_date LONG NOT NULL COMMENT '创建时间(时间戳)',
  updater_id int(20) NOT NULL COMMENT '更新人ID',
  update_date LONG NOT NULL COMMENT '更新时间(时间戳)',
  primary key(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS t_sys_role_menu;
CREATE TABLE t_sys_role_menu(
  id int(20) NOT NULL auto_increment COMMENT '角色菜单关系表主键',
  role_id int(20) NOT NULL COMMENT '角色ID',
  menu_id int(20) NOT NULL COMMENT '菜单表ID',
  status char(1) NOT NULL COMMENT '状态(A=Active, I=Inactive)',
  creator_id int(20) NOT NULL COMMENT '创建人ID',
  create_date LONG NOT NULL COMMENT '创建时间(时间戳)',
  updater_id int(20) NOT NULL COMMENT '更新人ID',
  update_date LONG NOT NULL COMMENT '更新时间(时间戳)',
  primary key(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS t_sys_permission;
CREATE TABLE t_sys_permission(
  id int(20) NOT NULL auto_increment COMMENT '权限表主键',
  permission_name varchar(10) NOT NULL COMMENT '权限名',
  permission_code varchar(2) NOT NULL COMMENT '权限代码',
  status char(1) NOT NULL COMMENT '状态(A=Active, I=Inactive)',
  creator_id int(20) NOT NULL COMMENT '创建人ID',
  create_date LONG NOT NULL COMMENT '创建时间(时间戳)',
  updater_id int(20) NOT NULL COMMENT '更新人ID',
  update_date LONG NOT NULL COMMENT '更新时间(时间戳)',
  primary key(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS t_system_type;
CREATE TABLE t_system_type(
  id varchar(32) NOT NULL COMMENT '系统表主键',
  token varchar(255) NOT NULL unique COMMENT '系统token',
  system_name varchar(32) NOT NULL COMMENT '系统名称',
  system_code varchar(10) NOT NULL unique COMMENT '系统编码',
  ip_address varchar(20) NOT NULL COMMENT 'IP地址',
  company_address varchar(100) NOT NULL COMMENT '公司地址',
  company_domain varchar(100) NOT NULL COMMENT '公司域名',
  contacts varchar(30) NOT NULL COMMENT '联系人姓名',
  phone_number varchar(20) NOT NULL COMMENT '联系电话',
  email varchar(100) NOT NULL COMMENT '邮箱',
  status char(1) NOT NULL COMMENT '状态(A=Active, I=Inactive)',
  creator_id int(20) NOT NULL COMMENT '创建人ID',
  create_date LONG NOT NULL COMMENT '创建时间(时间戳)',
  updater_id int(20) NOT NULL COMMENT '更新人ID',
  update_date LONG NOT NULL COMMENT '更新时间(时间戳)',
  primary key(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS t_sys_reset_password;
CREATE TABLE t_sys_reset_password(
  id int(20) NULL auto_increment COMMENT '用重置密码表主键',
  email_address varchar(100) NOT NULL COMMENT '注册邮箱',
  sid varchar(255) NOT NULL COMMENT '重置密码SID',
  expire_time LONG NOT NULL COMMENT '过期时间(时间戳)',
  status char(1) NOT NULL COMMENT '状态(A=Active, I=Inactive)',
  creator_id int(20) NOT NULL COMMENT '创建人ID',
  create_date LONG NOT NULL COMMENT '创建时间(时间戳)',
  updater_id int(20) NOT NULL COMMENT '更新人ID',
  update_date LONG NOT NULL COMMENT '更新时间(时间戳)',
  primary key(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--规则服务

DROP TABLE IF EXISTS t_rc_algorithm_type;
CREATE TABLE t_rc_algorithm_type(
  id int(20) NULL auto_increment COMMENT '规则算法表主键',
  type varchar(10) NOT NULL COMMENT '规则算法Code',
  title varchar(20) NOT NULL COMMENT '规则算法Title',
  status char(1) NOT NULL COMMENT '状态(A=Active, I=Inactive)',
  creator_id int(20) NOT NULL COMMENT '创建人ID',
  create_date LONG NOT NULL COMMENT '创建时间(时间戳)',
  updater_id int(20) NOT NULL COMMENT '更新人ID',
  update_date LONG NOT NULL COMMENT '更新时间(时间戳)',
  primary key(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

