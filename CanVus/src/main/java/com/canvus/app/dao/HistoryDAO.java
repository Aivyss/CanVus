package com.canvus.app.dao;

import com.canvus.app.dao.mapper.HistoriesMapper;
import com.canvus.app.vo.HistoryVO;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
}
