package com.jesse.dpp.rcp.service;

import java.util.List;

import com.jesse.dpp.rcp.po.Merchant;
import com.jesse.dpp.rcp.po.RiskLabel;
import com.jesse.dpp.rcp.vo.MerchantBusinessVo;
import com.github.pagehelper.PageInfo;

public interface IMerchantService {
    int deleteByPrimaryKey(Integer id);

    int insert(Merchant merchant);

    int insertSelective(Merchant merchant);

    Merchant selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Merchant merchant);

    int updateByPrimaryKeyWithBLOBs(Merchant merchant);

    int updateByPrimaryKey(Merchant merchant);

    /**
     * 查询商家
     * 
     * @param merchantId
     * @param systemId
     * @return
     */
    public Merchant selectMerchantByMerchantId(String merchantId, String systemId);

    /**
     * 查询没有关联行业的商家
     * 
     * @param systemId
     * @return
     */
    public List<Merchant> selectMerchantByNotSetBusiness(String systemId);

    /**
     * 分页查询商家列表
     * @param systemId
     * @param businessId
     * @return
     */
    public PageInfo<MerchantBusinessVo> selectListMerchant(Integer offset, Integer limit, String systemId, Integer businessId);
    
    /**
     * 
    * @Title: selectMerchantList 
    * @Description: TODO(用于风险画像模块中，对商户进行打标签) 
    * @author ll-t150
    * @date 2017年11月21日 下午5:15:12 
    * @throws
     */
    public PageInfo<Merchant> selectMerchantList(Integer offset, Integer limit, String systemId,String merchantId);
    
    /**
     * 
    * @Title: selectMerchantPortrait 
    * @Description: TODO(查询计算完成后的商户标签) 
    * @param @param systemId
    * @param @param merchantId
    * @param @return    设定文件 
    * @return RiskLabel    返回类型 
    * @author ll-t150
    * @date 2017年11月17日 上午11:21:42 
    * @throws
     */
    public RiskLabel selectMerchantPortrait(String systemId,String merchantId);

    public int merchantCount(String sysId);
}
