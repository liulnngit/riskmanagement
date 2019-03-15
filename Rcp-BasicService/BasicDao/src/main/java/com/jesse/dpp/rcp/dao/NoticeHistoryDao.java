package com.jesse.dpp.rcp.dao;

import com.jesse.dpp.rcp.po.NoticeHistory;

public interface NoticeHistoryDao {
    int deleteByPrimaryKey(Integer id);

    int insert(NoticeHistory noticeHistory);

    int insertSelective(NoticeHistory noticeHistory);

    NoticeHistory selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(NoticeHistory noticeHistory);

    int updateByPrimaryKeyWithBLOBs(NoticeHistory noticeHistory);

    int updateByPrimaryKey(NoticeHistory noticeHistory);
}