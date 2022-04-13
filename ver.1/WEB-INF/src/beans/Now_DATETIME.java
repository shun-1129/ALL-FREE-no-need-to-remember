package beans;

import java.io.Serializable;
import java.util.Date;
import java.util.Calendar;

@SuppressWarnings("serial")
public class Now_DATETIME implements Serializable {
	public Now_DATETIME() {super();}
	
	private String now_date;
	
	private int Year;
	private int Month;
	private int Day;
	private int Hour;
	private int Minute;
	private int Second;
	
	public void now_date() {
		Date Date = new Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(Date);
		
		this.Year = calendar.get(Calendar.YEAR);
		this.Month = calendar.get(Calendar.MONTH) + 1;
		this.Day = calendar.get(Calendar.DATE);
		this.Hour = calendar.get(Calendar.HOUR_OF_DAY);
		this.Minute = calendar.get(Calendar.MINUTE);
		this.Second = calendar.get(Calendar.SECOND);
		
		this.now_date = String.valueOf(this.Year);
		if(this.Month >= 1 && this.Month <= 9)	this.now_date += ("/0" + this.Month);
		else							this.now_date += ("/" + this.Month);
		if(this.Day >= 1 && this.Day <= 9)	this.now_date += ("/0" + this.Day + " ");
		else						this.now_date += ("/" + this.Day + " ");
		
		if(this.Hour >= 0 && this.Hour <= 9)	this.now_date += ("0" + this.Hour + ":");
		else						this.now_date += (this.Hour + ":");
		if(this.Minute >= 0 && this.Minute <= 9)	this.now_date += ("0" + this.Minute + ":");
		else							this.now_date += (Minute + ":");
		if(this.Second >= 0 && this.Second <= 9)	this.now_date += ("0" + this.Second);
		else							this.now_date += String.valueOf(this.Second);
	}
	
	public String getDATE() {return this.now_date;}
	public int getDATA() {
		int DATE = this.Year;
		
		return DATE;
	}
}
