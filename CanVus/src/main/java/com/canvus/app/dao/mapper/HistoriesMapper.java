package com.canvus.app.dao.mapper;

import com.canvus.app.vo.HistoryVO;

public interface HistoriesMapper {
    int getTotalRecordsOnHistories(String user_id);

    void addHistory(HistoryVO hisVO);

    void deleteHistory(HistoryVO hisVO);
}
