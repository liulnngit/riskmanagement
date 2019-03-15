package com.jesse.dpp.rcp.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.jesse.dpp.rcp.dao.NoticeDao;
import com.jesse.dpp.rcp.po.Notice;
import com.jesse.dpp.rcp.service.INoticeService;
import com.jesse.dpp.rcp.utils.exception.BaseRuntimeException;
import com.jesse.dpp.rcp.vo.NoticeVo;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

public class NoticeServiceImpl implements INoticeService {

    private static final Log log = LogFactory.getLog(NoticeServiceImpl.class);

    @Autowired
    private NoticeDao noticeDao;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insert(Notice notice) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int insertSelective(Notice notice) {
        try {
            notice.setCreateDate(System.currentTimeMillis() + "");
            notice.setUpdaterId(notice.getCreatorId());
            notice.setUpdateDate(notice.getCreateDate());
            return this.noticeDao.insertSelective(notice);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public Notice selectByPrimaryKey(Integer id) {
        try {
            return noticeDao.selectByPrimaryKey(id);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int updateByPrimaryKeySelective(Notice notice) {
        try {
            notice.setUpdateDate(System.currentTimeMillis() + "");
            return this.noticeDao.updateByPrimaryKeySelective(notice);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int updateByPrimaryKeyWithBLOBs(Notice notice) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public int updateByPrimaryKey(Notice notice) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public PageInfo<NoticeVo> selectNoticeList(int currentPage, Integer limit, String systemId, String innerSystemId) {
        try {
            List<NoticeVo> noticeList = new ArrayList<NoticeVo>();
            if (innerSystemId.equals(systemId)) {
                PageHelper.startPage(currentPage, limit);
                noticeList = this.noticeDao.selectNoticeList();
            } else {
                PageHelper.startPage(currentPage, limit);
                noticeList = this.noticeDao.selectByActive();
            }
            PageInfo<NoticeVo> pageInfo = new PageInfo<NoticeVo>(noticeList);
            return pageInfo;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public NoticeVo selectNoticeVoByPrimaryKey(Integer id) {
        try {
            NoticeVo noticeVo = this.noticeDao.selectNoticeVoByPrimaryKey(id);
            return noticeVo;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int deleteByNoticeIds(String noticeIds) {
        try {
            String[] noticeArr = noticeIds.split(",");
            return this.noticeDao.deleteByNoticeIds(noticeArr);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public boolean checkTitle(String id, String title) {
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            if (StringUtils.isNotBlank(id)) {
                map.put("id", id);
            }
            if (StringUtils.isNotBlank(title)) {
                map.put("title", title);
            }
            List<Notice> notices = noticeDao.checkTitle(map);
            if (null != notices && notices.size() > 0) {
                return false;
            }
            return true;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

}
