package com.canvus.app.drawing.vo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Lob;
import javax.persistence.Table;

import com.canvus.app.vo.CanVusVOs;

import lombok.Data;

@Data
@Entity
@Table(name="PAGE_LAYER")
@IdClass(PageVO.class)
public class PageVO implements CanVusVOs {
	@Id
	@Column(name="PL_ID")
	private int pl_id;
	
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
