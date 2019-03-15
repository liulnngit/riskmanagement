package com.jesse.dpp.rcp.po;

public class IndexView {

	private long count;
	private double radio;
	
	
	public IndexView() {
	}
	
	public long getCount() {
		return count;
	}
	public void setCount(long count) {
		this.count = count;
	}
	public double getRadio() {
		return radio;
	}
	public void setRadio(double radio) {
		this.radio = radio;
	}
	@Override
	public String toString() {
		return "IndexView [count=" + count + ", radio=" + radio + "]";
	}
	
}
