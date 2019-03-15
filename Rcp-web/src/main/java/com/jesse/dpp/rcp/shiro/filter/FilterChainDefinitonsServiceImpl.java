/**
 * 
 */package com.jesse.dpp.rcp.shiro.filter;

import java.util.LinkedHashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.cache.MemoryConstrainedCacheManager;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.filter.mgt.DefaultFilterChainManager;
import org.apache.shiro.web.filter.mgt.NamedFilterList;
import org.apache.shiro.web.filter.mgt.PathMatchingFilterChainResolver;
import org.apache.shiro.web.filter.mgt.SimpleNamedFilterList;
import org.apache.shiro.web.servlet.AbstractShiroFilter;
import org.springframework.beans.factory.annotation.Autowired;

import com.jesse.dpp.rcp.shiro.IFilterChainDefinitionMapService;
import com.jesse.dpp.rcp.shiro.IFilterChainDefinitonsService;
import com.jesse.dpp.rcp.shiro.realm.RiskRealm;

/** 
* @author  作者 E-mail: plus-t178
* @date 创建时间：2017年5月3日 下午6:48:25 
* @version 1.0 
* @since  
*/

public class FilterChainDefinitonsServiceImpl implements IFilterChainDefinitonsService {

	private static Log log = LogFactory.getLog(FilterChainDefinitonsServiceImpl.class);

	@Autowired
	ShiroFilterFactoryBean shiroFilter;
	
	@Autowired
	IFilterChainDefinitionMapService filterChainDefinitionMapService;
	
	@Autowired
	RiskRealm riskRealm;
	
	@Autowired
	MemoryConstrainedCacheManager cacheManager;
	
	@Override
	public void reloadFilterChain() {
		
		synchronized (shiroFilter) {
			
			DefaultFilterChainManager manager = getFilterChainManager();
			manager.getFilterChains().clear();

			shiroFilter.getFilterChainDefinitionMap().clear();
			LinkedHashMap<String, String> bfMap = filterChainDefinitionMapService.buildFilterChainDefinitionMap();
			Map<String, NamedFilterList> filterChains = new LinkedHashMap<String, NamedFilterList>();
			for (Map.Entry<String, String> entry : bfMap.entrySet()) {
			//	ensureChain(filterChains, entry.getKey());
				manager.createChain(entry.getKey(), entry.getValue());
			}
			shiroFilter.setFilterChainDefinitionMap(bfMap);
			log.info("filterChains 3 : " + filterChains.size());
		}
	}
	
	private DefaultFilterChainManager getFilterChainManager() {
		
		AbstractShiroFilter aShiroFilter = null;
		try {
			aShiroFilter = (AbstractShiroFilter) shiroFilter.getObject();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		PathMatchingFilterChainResolver filterChainResolver = (PathMatchingFilterChainResolver) aShiroFilter.getFilterChainResolver();
		
		DefaultFilterChainManager filterChainManager = (DefaultFilterChainManager) filterChainResolver.getFilterChainManager();
		
		return filterChainManager;
	}
	
	 protected void ensureChain(Map<String, NamedFilterList> filterChains, String chainName) {
        
        NamedFilterList chain = new SimpleNamedFilterList(chainName);
        filterChains.put(chainName, chain);
		
        log.info(chainName + "--" + chain);
	 }
}
