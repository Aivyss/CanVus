package com.canvus.app.dao.mapper;

import com.canvus.app.vo.HistoryVO;
import org.apache.ibatis.session.RowBounds;

import java.util.List;

public interface HistoriesMapper {
    int getTotalRecordsOnHistories(String user_id);

    void addHistory(HistoryVO hisVO);

    void deleteHistory(HistoryVO hisVO);

    List<HistoryVO> historyDetail(RowBounds rb, String user_id);
}
