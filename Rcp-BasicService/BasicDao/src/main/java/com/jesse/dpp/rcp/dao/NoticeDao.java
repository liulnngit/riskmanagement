package com.jesse.dpp.rcp.dao;

import java.util.List;
import java.util.Map;

import com.jesse.dpp.rcp.po.Notice;
import com.jesse.dpp.rcp.vo.NoticeVo;

public interface NoticeDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Notice notice);

    int insertSelective(Notice notice);

    Notice selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Notice notice);

    int updateByPrimaryKeyWithBLOBs(Notice notice);

    int updateByPrimaryKey(Notice notice);

    public List<NoticeVo> selectNoticeList();

    public NoticeVo selectNoticeVoByPrimaryKey(Integer id);

    public int deleteByNoticeIds(String[] noticeArr);

    /**
     * 校验公告标题是不是存在
     * @param map
     * @return
     */
    public List<Notice> checkTitle(Map<String, Object> map);

    /**
     * 查询公告状态是已发布状态
     * @return
     */
    public List<NoticeVo> selectByActive();
}