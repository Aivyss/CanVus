package com.canvus.app.dao;

import com.canvus.app.dao.mapper.HistoriesMapper;
import com.canvus.app.vo.HistoryVO;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Slf4j
@Repository
public class HistoryDAO {
    @Autowired
    private SqlSession session;

    /**
     * 열람 이력을 히스토리에 저장하는 메소드
     * 20210225
     * 이한결
     */
    public void addHistory(HistoryVO hisVO) {
        HistoriesMapper mapper = session.getMapper(HistoriesMapper.class);

        try {
            mapper.addHistory(hisVO);
        } catch (Exception e) {
            e.printStackTrace();
            log.info("히스토리 열람 SQL 오류 sql 문법이나 pk 위반(최신화 필요)");
            try {
                mapper.deleteHistory(hisVO);
                mapper.addHistory(hisVO);
            } catch (Exception ee) {
                ee.printStackTrace();
                log.info("이건 정말 오류야.");
            }
        }
    }

    /**
     * 히스토리 폴더안 프리뷰 셀렉
     * 20210226
     * 이한결
     * @param user_id
     * @param startRecord
     * @param countPerPage
     * @return
     */
    public List<HistoryVO> historyDetail(String user_id, int startRecord, int countPerPage) {
        List<HistoryVO> historyFeedList = null;
        RowBounds rb = new RowBounds(startRecord, countPerPage);

        try {
            HistoriesMapper mapper = session.getMapper(HistoriesMapper.class);
            historyFeedList = mapper.historyDetail(rb, user_id);
        } catch (Exception e) {
            e.printStackTrace();
            log.info("히스토리 상세 셀렉 sql오류");
        }

        return historyFeedList;
    }
}
