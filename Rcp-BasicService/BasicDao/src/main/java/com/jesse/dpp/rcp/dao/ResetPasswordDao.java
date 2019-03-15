package com.jesse.dpp.rcp.dao;

import java.util.List;
import java.util.Map;

import com.jesse.dpp.rcp.po.ResetPassword;

public interface ResetPasswordDao {
    int deleteByPrimaryKey(Integer id);

    int insert(ResetPassword resetPassword);

    int insertSelective(ResetPassword resetPassword);

    ResetPassword selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ResetPassword resetPassword);

    int updateByPrimaryKeyWithBLOBs(ResetPassword resetPassword);

    int updateByPrimaryKey(ResetPassword resetPassword);
    
    public ResetPassword selectResetPasswordBySid(String sid);
    
    public ResetPassword selectResetPasswordByEmail(String email);
    
    /**
     * 根据需重置密码用户ID查询
     * @param map
     * @return
     */
    public List<ResetPassword> selectResetPasswordByAccountId(Map<String, Object> map);
}