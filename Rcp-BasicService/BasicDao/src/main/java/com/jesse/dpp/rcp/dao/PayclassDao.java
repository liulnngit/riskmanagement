package com.jesse.dpp.rcp.dao;

import java.util.List;
import java.util.Map;

import com.jesse.dpp.rcp.po.Payclass;
import com.jesse.dpp.rcp.vo.PayclassVo;

public interface PayclassDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Payclass payclass);

    int insertSelective(Payclass payclass);

    Payclass selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Payclass payclass);

    int updateByPrimaryKeyWithBLOBs(Payclass payclass);

    int updateByPrimaryKey(Payclass payclass);

    public List<Payclass> selectPayClassList(Map<String, Object> map);
    
    public List<PayclassVo> selectPayclassByPage(Payclass payclass);
    
    public List<Payclass> checkCode(Map<String, Object> map);
    
    public List<Payclass> checkName(Map<String, Object> map);
    
    public List<Payclass> checkNameEn(Map<String, Object> map);
    
    /**
     * 根据名称查询支付类型
     * @param map
     * @return
     */
    public Payclass selectPayclassByName(Map<String, Object> map);
    
    /**
     * 根据Code查询支付类型
     * @param map
     * @return
     */
    public Payclass selectPayclassByCode(Map<String, Object> map);
    
    /**
     * 查询默认支付类型
     * @param map
     * @return
     */
    public Payclass selectDefaultPayclass(Map<String, Object> map);
}