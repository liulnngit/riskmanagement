package com.jesse.dpp.rcp.utils.lang;

import java.util.Arrays;
import java.util.List;

import org.apache.commons.lang.builder.ToStringStyle;

import com.jesse.dpp.rcp.utils.lang.ToStringStyleEx.FilterToStringStyle.InEx;


public abstract class ToStringStyleEx extends ToStringStyle {

	/** */
	private static final long serialVersionUID = 1L;
	
	public static final ToStringStyle FILTER_STYLE = new FilterToStringStyle();

	public static ToStringStyle createFilterToStringStyle(InEx ie, String... filed){
		return new FilterToStringStyle(ie, filed);
	}

	public static class FilterToStringStyle extends ToStringStyle {

		/** */
		private static final long serialVersionUID = 1L;

		protected final InEx ie;
		protected final List<String> fileds;
		
		public FilterToStringStyle() {
			this(InEx.EX);
		}

		public FilterToStringStyle(InEx ie, String... filed) {
			this.ie = ie;
			fileds = Arrays.asList(filed);
			this.setUseClassName(false);
            this.setUseIdentityHashCode(false);
            this.setContentStart("[");
            this.setContentEnd("]");
		}

		public void append(StringBuffer buffer, String fieldName, Object value, Boolean fullDetail) {
			if (value != null) {
				if(ie==InEx.EX){
					appendFieldStart(buffer, fieldName);
					if(fileds.contains(fieldName)){
						buffer.append("**");
					}else{
						appendInternal(buffer, fieldName, value, isFullDetail(fullDetail));
					}
					appendFieldEnd(buffer, fieldName);
				}else if(ie==InEx.IN&&fileds.contains(fieldName)){
					appendFieldStart(buffer, fieldName);
					appendInternal(buffer, fieldName, value, isFullDetail(fullDetail));
					appendFieldEnd(buffer, fieldName);
				}
			}
		}

		public static enum InEx {
			IN, EX
		}

	}
}
