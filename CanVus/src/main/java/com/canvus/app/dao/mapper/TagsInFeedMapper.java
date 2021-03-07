package com.canvus.app.dao.mapper;

import com.canvus.app.vo.FeedComponentVO;
import com.canvus.app.vo.TagsInFeedVO;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.springframework.security.access.method.P;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public interface TagsInFeedMapper {

	public boolean inputTags(TagsInFeedVO tif);

	public boolean deleteTags(String feed_id);

    public int feedCountReferToTag(@Param("keyword") String keyword);

	public List<FeedComponentVO> getFeedIdBundleByTag(String keyword);

	public ArrayList<HashMap<String, Object>> getFeedIdBundleByTag(@Param("keyword") String keyword, @Param("rb") RowBounds rb);

	public ArrayList<HashMap<String, Object>> getFeedBundleByNickname(@Param("keyword") String keyword);



}
