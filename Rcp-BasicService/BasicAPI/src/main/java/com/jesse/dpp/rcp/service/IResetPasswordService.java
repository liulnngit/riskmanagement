package com.jesse.dpp.rcp.service;

import java.util.List;

import com.jesse.dpp.rcp.po.Account;
import com.jesse.dpp.rcp.po.ResetPassword;

public interface IResetPasswordService {
    int deleteByPrimaryKey(Integer id);

    int insert(ResetPassword resetPassword);

    int insertSelective(ResetPassword resetPassword);

    ResetPassword selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ResetPassword resetPassword);

    int updateByPrimaryKeyWithBLOBs(ResetPassword resetPassword);

    int updateByPrimaryKey(ResetPassword resetPassword);
    
    public int addResetPassword(Account account, Integer creatorId, String basePath);
    
    public ResetPassword selectResetPasswordBySid(String sid);
    
    /**
     * 根据需重置密码用户ID查询
     * @param map
     * @return
     */
    public List<ResetPassword> selectResetPasswordByAccountId(Integer accountId);
}
