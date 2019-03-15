package com.jesse.dpp.rcp.entity;

import java.io.Serializable;

public class SeriesData implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5283215126325863445L;
	
	private String name;
	
	private boolean selected;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public boolean isSelected() {
		return selected;
	}

	public void setSelected(boolean selected) {
		this.selected = selected;
	}

	public SeriesData(String name, boolean selected) {
		super();
		this.name = name;
		this.selected = selected;
	}

	public SeriesData() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}
