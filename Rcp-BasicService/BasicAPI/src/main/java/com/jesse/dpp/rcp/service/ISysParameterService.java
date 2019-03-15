package com.jesse.dpp.rcp.service;

import java.util.List;

import com.jesse.dpp.rcp.po.SysParameter;
import com.jesse.dpp.rcp.vo.SysParameterVo;
import com.github.pagehelper.PageInfo;

public interface ISysParameterService {
    int deleteByPrimaryKey(Integer id);

    int insert(SysParameter sysParameter);

    int insertSelective(SysParameter sysParameter);

    SysParameter selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SysParameter sysParameter);

    int updateByPrimaryKeyWithBLOBs(SysParameter sysParameter);

    int updateByPrimaryKey(SysParameter sysParameter);
    
    /**
     * 分页查询
     * @param currentPage
     * @param limit
     * @param systemId
     * @return
     */
    public PageInfo<SysParameterVo> selectSysParameterListByPagination(int currentPage, Integer limit, String systemId);
    
    /**
     * 查询单个
     * @param parameterCode
     * @param systemId
     * @return
     */
    public SysParameter selectSysParameterByCode(String parameterCode, String systemId);
    
    /**
     * 更新参数
     * @param sysParameter
     * @param updaterId
     * @return
     */
    public int updateSysParameter(SysParameter sysParameter, Integer updaterId, String ipAddress);
    
    /**
     * 根据systemId查询该系统下所有系统参数
     * @param systemId
     * @return
     */
    public List<SysParameter> selectListBySystemId(String systemId);
    
    public int addSysParameter(SysParameter sysParameter, Integer creatorId);
}
