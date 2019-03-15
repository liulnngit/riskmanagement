package com.jesse.dpp.rcp.dao;

import java.util.List;
import java.util.Map;

import com.jesse.dpp.rcp.po.SysParameter;
import com.jesse.dpp.rcp.vo.SysParameterVo;

public interface SysParameterDao {
    int deleteByPrimaryKey(Integer id);

    int insert(SysParameter sysParameter);

    int insertSelective(SysParameter sysParameter);

    SysParameter selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SysParameter sysParameter);

    int updateByPrimaryKeyWithBLOBs(SysParameter sysParameter);

    int updateByPrimaryKey(SysParameter sysParameter);
    
    /**
     * 分页查询
     * @param map
     * @return
     */
    public List<SysParameterVo> selectSysParameterListByPagination(Map<String, Object> map);
    
    /**
     * 查询单个
     * @param map
     * @return
     */
    public SysParameter selectSysParameterByCode(Map<String, Object> map);
    
    /**
     * 根据systemId查询该系统下所有系统参数
     * @param map
     * @return
     */
    public List<SysParameter> selectListBySystemId(Map<String, Object> map);
}