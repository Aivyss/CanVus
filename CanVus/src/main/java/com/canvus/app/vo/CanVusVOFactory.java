package com.canvus.app.vo;

import com.canvus.app.drawing.vo.DrawingRoomVO;
import com.canvus.app.drawing.vo.DrawingUserVO;
import com.canvus.app.drawing.vo.FeedVO;
import com.canvus.app.drawing.vo.PageVO;

public class CanVusVOFactory {
	
	public static <T> T newInstance(CanVusVOType type) {
		T t = null;
		
		switch (type) {
			case DrawingRoomVO:
				t = (T) new DrawingRoomVO();
				break;
			case DrawingUserVO:
				t = (T) new DrawingUserVO();
				break;
			case PageVO:
				t = (T) new PageVO();
				break;
			case BillVO:
				t = (T) new BillVO();
				break;
			case BookmarkVO:
				t = (T) new BookmarkVO();
				break;
			case FeedDrawingsVO:
				t = (T) new FeedDrawingsVO();
				break;
			case FeedVO:
				t = (T) new FeedVO();
				break;
			case FollowingsVO:
				t = (T) new FollowingsVO();
				break;
			case PaymentCompleteInfo:
				t = (T) new PaymentCompleteInfo();
				break;
			case TagsInFeedVO:
				t = (T) new TagsInFeedVO();
				break;
			case TagVO:
				t = (T) new TagVO();
				break;
			case UserVO:
				t = (T) new UserVO();
				break;
			case TransactionPixelVO:
				t = (T) new TransactionPixelVO();
				break;
		}
		
		return t;
	}
}
