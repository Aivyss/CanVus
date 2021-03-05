package com.canvus.app.dao.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.canvus.app.drawing.vo.FeedVO;
import com.canvus.app.vo.FeedComponentVO;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

public interface FeedsMapper {

	public List<FeedVO> getFeedBundle(RowBounds rb, String user_id);

	public boolean createFeedTableRow(FeedVO feedVO);

	public FeedVO selectFeed(String feed_id);

	public boolean updateFeed(FeedVO feed);

    int getFeedTotalCount(String user_id);
    int getFeedTotalCountLogin(@Param("user_id") String user_id);

	List<FeedComponentVO> selectFeedBundle(RowBounds rb, String user_id);

    List<FeedComponentVO> getFeedsBundleByIdList(List<FeedComponentVO> idBundle);

    FeedVO readFeedAbstract(String feed_id);

    List<FeedComponentVO> homePreview();
    ArrayList<HashMap<String, Object>> homePreviewLogin(@Param("rb") RowBounds rb, @Param("user_id") String user_id);

    int getFeedCountAboutSpecificUser(String user_id);

    // 피드삭제
    void deleteFeedFD(FeedComponentVO feedInfo);
    void deleteFeedH(FeedComponentVO feedInfo);
    void deleteFeedBF(FeedComponentVO feedInfo);
    void deleteFeedTIF(FeedComponentVO feedInfo);
    void deleteFeedFC(FeedComponentVO feedInfo);
    void deleteFeedL(FeedComponentVO feedInfo);
    void deleteFeedF(FeedComponentVO feedInfo);
}
