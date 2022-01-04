package com.inkombizz.common;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Retention(RetentionPolicy.RUNTIME)
public @interface EntityConfig {
	public abstract boolean permanentDelete();
}
