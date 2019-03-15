package com.jesse.dpp.rcp.service.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.jesse.dpp.rcp.constant.Constant;
import com.jesse.dpp.rcp.po.SysParameter;
import com.jesse.dpp.rcp.po.SystemType;

public class GenerateSysParameterUtil {
    private static Log log = LogFactory.getLog(GenerateSysParameterUtil.class);

    public Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://192.168.46.161:8066/DATADB";
        String username = "root";
        String password = "123456";
        Connection conn = DriverManager.getConnection(url, username, password);
        log.info("Database connection established");
        return conn;
    }

    public void setPrepareStatement(java.sql.PreparedStatement preStat, int idx, Integer val) throws java.sql.SQLException {
        if (val == null) {
            preStat.setNull(idx, java.sql.Types.NUMERIC);
        } else {
            preStat.setInt(idx, val.intValue());
        }
    }

    public void setPrepareStatement(PreparedStatement preStat, int idx, Long val) throws SQLException {
        if (val == null) {
            preStat.setNull(idx, java.sql.Types.NUMERIC);
        } else {
            preStat.setLong(idx, val.longValue());
        }
    }

    public void setPrepareStatement(java.sql.PreparedStatement preStat, int idx, String val) throws java.sql.SQLException {
        if (val == null) {
            preStat.setNull(idx, java.sql.Types.VARCHAR);
        } else {
            if (StringUtils.isNotBlank(val)) {
                val = val.trim();
            }
            preStat.setString(idx, val);
        }
    }

    public void setPrepareStatement(java.sql.PreparedStatement preStat, int idx, byte[] val) throws java.sql.SQLException {
        if (val == null) {
            preStat.setNull(idx, java.sql.Types.BINARY);
        } else {
            preStat.setBytes(idx, val);
        }
    }
    
    public void deleteRule(Connection conn) throws Exception {
        try {
            PreparedStatement preStat = null;
            StringBuffer sqlStat = new StringBuffer();

            sqlStat.append("delete from t_rc_rule ");
            preStat = conn.prepareStatement(sqlStat.toString(), ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

            preStat.executeUpdate();
            log.info("delete rule success");
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
    }

    public void insertSysParameter(SysParameter sysParameter, Connection conn) throws Exception {
        try {
            PreparedStatement preStat = null;
            StringBuffer sqlStat = new StringBuffer();

            sqlStat.append("INSERT ");
            sqlStat.append("INTO t_sys_parameter (system_id, parameter_code, parameter_name, parameter_type, parameter_value, parameter_default_value, description, status, creator_id, create_date, updater_id, update_date) ");
            sqlStat.append("VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ");
            preStat = conn.prepareStatement(sqlStat.toString(), ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

            setPrepareStatement(preStat, 1, sysParameter.getSystemId());
            setPrepareStatement(preStat, 2, sysParameter.getParameterCode());
            setPrepareStatement(preStat, 3, sysParameter.getParameterName());
            setPrepareStatement(preStat, 4, sysParameter.getParameterType());
            setPrepareStatement(preStat, 5, sysParameter.getParameterValue());
            setPrepareStatement(preStat, 6, sysParameter.getParameterDefaultValue());
            setPrepareStatement(preStat, 7, sysParameter.getDescription());
            setPrepareStatement(preStat, 8, sysParameter.getStatus());
            setPrepareStatement(preStat, 9, sysParameter.getCreatorId());
            setPrepareStatement(preStat, 10, sysParameter.getCreateDate());
            setPrepareStatement(preStat, 11, sysParameter.getUpdaterId());
            setPrepareStatement(preStat, 12, sysParameter.getUpdateDate());
            preStat.executeUpdate();
            log.info("Insert success");
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            if (conn != null) {
                conn.rollback();
            }
        }
    }
    
    public void generateSql(SysParameter sysParameter){
        StringBuffer sqlStat = new StringBuffer();
        sqlStat.append("INSERT ");
        sqlStat.append("INTO t_sys_parameter (system_id, parameter_code, parameter_name, parameter_type, parameter_default_value, description, status, creator_id, create_date, updater_id, update_date) ");
        sqlStat.append("VALUES (");
        
        sqlStat.append("'").append(sysParameter.getSystemId()).append("', ");
        sqlStat.append("'").append(sysParameter.getParameterCode()).append("', ");
        sqlStat.append("'").append(sysParameter.getParameterName()).append("', ");
        sqlStat.append("'").append(sysParameter.getParameterType()).append("', ");
        sqlStat.append("'").append(sysParameter.getParameterDefaultValue()).append("', ");
        sqlStat.append("'").append(sysParameter.getDescription()).append("', ");
        sqlStat.append("'").append(sysParameter.getStatus()).append("', ");
        sqlStat.append("'").append(sysParameter.getCreatorId()).append("', ");
        sqlStat.append("'").append(sysParameter.getCreateDate()).append("', ");
        sqlStat.append("'").append(sysParameter.getUpdaterId()).append("', ");
        sqlStat.append("'").append(sysParameter.getUpdateDate()).append("'");
        sqlStat.append(");");
        System.out.println(sqlStat.toString());
    }

    public List<SystemType> querySystemType(Connection conn) throws Exception {
        try {
            Statement sql_statement = conn.createStatement();

            String query = "select * from t_system_type";
            ResultSet result = sql_statement.executeQuery(query);
            List<SystemType> list = new ArrayList<SystemType>();

            while (result.next()) {
                SystemType st = new SystemType();
                String id = result.getString("id");
                String systemName = result.getString("system_name");

                log.info("id: " + id + ", systemName: " + systemName);
                st.setId(id);
                st.setSystemName(systemName);
                list.add(st);
            }
            return list;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    public static void main(String[] args) throws Exception {
        Connection conn = null;
        try {
            GenerateSysParameterUtil uru = new GenerateSysParameterUtil();
            conn = uru.getConnection();
            conn.setAutoCommit(false);
            
            String parameterCode = "rcp.low.risk.event.email.receiver";
            String parameterName = "低级风险事件邮件接收人";
            String defaultValue = "tsx@ddbill.com";
            String description = "低级风险事件邮件接收人,多个邮箱请使用英文分号(;)隔开";
            
            List<SystemType> systemTypeList = uru.querySystemType(conn);
            for(SystemType systemType : systemTypeList){
                SysParameter sysParameter = new SysParameter();
                sysParameter.setSystemId(systemType.getId());
                sysParameter.setParameterCode(parameterCode);
                sysParameter.setParameterName(parameterName);
                sysParameter.setParameterType("S");
                sysParameter.setParameterDefaultValue(defaultValue);
                sysParameter.setDescription(description);
                sysParameter.setStatus(Constant.RECORD_ACTIVE);
                sysParameter.setCreatorId(1);
                sysParameter.setCreateDate(String.valueOf(System.currentTimeMillis()));
                sysParameter.setUpdaterId(1);
                sysParameter.setUpdateDate(String.valueOf(System.currentTimeMillis()));
                /*
                 * insert data to db
                 */
                uru.insertSysParameter(sysParameter, conn);
                /*
                 * generate sql script
                 */
                uru.generateSql(sysParameter);
            }
            conn.commit();
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        if (conn != null) {
            try {
                conn.close();
                log.info("Database connection terminated");
            } catch (Exception e) {
                log.error(e.getMessage(), e);
            }
        }
    }
}
