package com.nbtv.commons.container;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.nbtv.commons.context.AppContext;

public class Main {
	private static Log log = LogFactory.getLog(Main.class);

	private static volatile boolean running = true;

	public static void main(String[] args) {
		Runtime.getRuntime().addShutdownHook(new Thread() {
			public void run() {
				try {
					AppContext.stop();
					log.info(new SimpleDateFormat("[yyyy-MM-dd HH:mm:ss]").format(new Date()) + " Main server stopped!");
				} catch (Throwable t) {
					log.error("Main stop error:" + t);
				}
				synchronized (Main.class) {
					running = false;
					Main.class.notify();
				}
			}
		});

		try {
			AppContext.start();
		} catch (RuntimeException e) {
			log.error(e.getMessage(), e);
			throw e;
		}

		log.info(new SimpleDateFormat("[yyyy-MM-dd HH:mm:ss]").format(new Date()) + " Main server started!");

		synchronized (Main.class) {
			while (running) {
				try {
					Main.class.wait();
				} catch (Throwable e) {
				}
			}
		}
	}

}
