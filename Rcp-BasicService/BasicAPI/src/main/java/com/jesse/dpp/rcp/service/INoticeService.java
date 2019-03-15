package com.jesse.dpp.rcp.service;

import com.jesse.dpp.rcp.po.Notice;
import com.jesse.dpp.rcp.vo.NoticeVo;
import com.github.pagehelper.PageInfo;

public interface INoticeService {

    int deleteByPrimaryKey(Integer id);

    int insert(Notice notice);

    int insertSelective(Notice notice);

    Notice selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Notice notice);

    int updateByPrimaryKeyWithBLOBs(Notice notice);

    int updateByPrimaryKey(Notice notice);

    public PageInfo<NoticeVo> selectNoticeList(int currentPage, Integer limit, String systemId, String innerSystemId);

    NoticeVo selectNoticeVoByPrimaryKey(Integer id);

    public int deleteByNoticeIds(String noticeIds);

    public boolean checkTitle(String id, String title);
}
