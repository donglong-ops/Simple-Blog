/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longdh.listener;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Web application lifecycle listener.
 *
 * @author Cyrus
 */
public class ContextServletListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
//       // create pattern layout
//        PatternLayout layout = new PatternLayout();
//        String consersionPattern = "%d{yyyy-MM-dd HH:mm:ss} %-5p %c{1}:%L - %m%n";
//        layout.setConversionPattern(consersionPattern);
//
//        // create console appender
//        ConsoleAppender consoleAppender = new ConsoleAppender();
//        consoleAppender.setLayout(layout);
//        consoleAppender.activateOptions();
//
//        // create file appender
//        FileAppender fileAppender = new FileAppender();
//        String timeStamp = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
//        fileAppender.setFile("F:/Semester 5/LAB231 - Web Java Lab/First Project/FirstProject_Mini_Social_Network/Mini_Social_Network_log_" + timeStamp + ".log");
//        fileAppender.setLayout(layout);
//        fileAppender.activateOptions();
//        
//         // configures the root logger
//        Logger rootLogger = Logger.getRootLogger();
//        rootLogger.setLevel(Level.DEBUG);
//        rootLogger.addAppender(consoleAppender);
//        rootLogger.addAppender(fileAppender);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("Context destroyed successfully");
    }
}
