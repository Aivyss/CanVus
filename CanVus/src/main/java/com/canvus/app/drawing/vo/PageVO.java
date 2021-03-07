package com.canvus.app.drawing.vo;

import com.canvus.app.vo.CanVusVOs;
import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name="PAGE_LAYER")
@IdClass(PageVO.class)
public class PageVO implements CanVusVOs {
	@Column(name="ROOM_ID")
	private String room_Id;
	
	@Column(name="PAGE_NO")
	private int page_no;
	
	@Column(name="LAYER_NO")
	private int layer_no;
	
	@Column(name="STRINGIFY")
	@Lob
	private String stringify;
}
