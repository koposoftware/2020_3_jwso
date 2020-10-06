package hanacard.aop.logger;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;

import org.apache.logging.log4j.ThreadContext;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

//시작 시 LogAdvice가 생성되도록 하는 어노테이션
//AOP로 만들어주는 어노테이션
@Component
@Aspect
public class LogAdvice {
	
	private static final Logger logger = LoggerFactory.getLogger(LogAdvice.class);
	
	@Around("execution (* hanacard.dashboard.service..*.*(..))"
      + " or execution (* hanacard.employee.service..*.*(..))"
	  + " or execution (* hanacard.memo.service..*.*(..))"
	  + " or execution (* hanacard.mailing.service..*.*(..))")
	public Object logPrint(ProceedingJoinPoint joinPoint) throws Throwable {
		long start = System.currentTimeMillis();
		//핵심 로직으로 이동
		Object result = joinPoint.proceed();
		SimpleDateFormat current_format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
		SimpleDateFormat process_format = new SimpleDateFormat("mm:ss");
		Date date = new Date();
		long end = System.currentTimeMillis();
		long time = end - start;
		//실행 시간 연산
		ThreadContext.put("log_date", current_format.format(date));
		ThreadContext.put("log_level", "DEBUG");
		ThreadContext.put("package_class", joinPoint.getSignature().getDeclaringTypeName());
		ThreadContext.put("method_name", joinPoint.getSignature().getName());
		if(Arrays.toString(joinPoint.getArgs()).equals("")) {
			ThreadContext.put("params", " ");
		} else {
			ThreadContext.put("params", Arrays.toString(joinPoint.getArgs()));			
		}
		ThreadContext.put("processing_time", process_format.format(time));
		
		logger.debug(current_format.format(date) +  joinPoint.getSignature().getDeclaringTypeName() + "  " + joinPoint.getSignature().getName() + Arrays.toString(joinPoint.getArgs()) + process_format.format(time));
		return result;
	}
}
