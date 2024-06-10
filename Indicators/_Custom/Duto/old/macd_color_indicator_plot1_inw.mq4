/*

*********************************************************************
          
                            MACD Color
                   Copyright © 2006  Akuma99
                  http://www.beginnertrader.com/  

       For help on this indicator, tutorials and information 
               visit http://www.beginnertrader.com/
                  
*********************************************************************

*/

#property  copyright ""
#property  link      ""

#property  indicator_separate_window

#property  indicator_buffers 6
//#property  indicator_buffers 8

#property  indicator_color1  FireBrick
#property  indicator_color2  SeaGreen
#property  indicator_color3  Red
#property  indicator_color4  LimeGreen

#property  indicator_color5  Yellow  
#property  indicator_color6  Aqua

#property  indicator_color7  Red
#property  indicator_color8  FireBrick

//#property indicator_minimum -.0005
//#property indicator_maximum 0.0005

//PARAMETER INPUTS
extern int FastEMA=12;
extern int SlowEMA=26;
extern int SignalSMA=9;

double     ind_buffer1[];
double     ind_buffer2[];
double     ind_buffer1b[];
double     ind_buffer2b[];
double     ind_buffer3[];
double     ind_buffer4[];

//double     ind_buffer5[];
//double     ind_buffer5b[];

double     b[999999];

int init() {

   //HISTO DARK RED
   SetIndexStyle(0,DRAW_HISTOGRAM,STYLE_SOLID,2,indicator_color1);
   //HISTO DARK GREEN
   SetIndexStyle(1,DRAW_HISTOGRAM,STYLE_SOLID,2,indicator_color2);
   //HISTO LIGHT RED
   SetIndexStyle(2,DRAW_HISTOGRAM,STYLE_SOLID,2,indicator_color3);
   //HISTO LIGHT GREEN
   SetIndexStyle(3,DRAW_HISTOGRAM,STYLE_SOLID,2,indicator_color4);
   
   //LINE YELLOW
   SetIndexStyle(4,DRAW_LINE,EMPTY,1,indicator_color5);
   //LINE AQUA
   SetIndexStyle(5,DRAW_LINE,EMPTY,1,indicator_color6);
   
   //SetIndexStyle(6,DRAW_LINE,EMPTY,5,indicator_color7);
   //SetIndexStyle(6,DRAW_SECTION,5,indicator_color7);
   //SetIndexStyle(7,DRAW_LINE,EMPTY,5,indicator_color8);
   //SetIndexStyle(6,DRAW_LINE,EMPTY,5,indicator_color1);//line dark red
   //SetIndexStyle(7,DRAW_LINE,EMPTY,5,indicator_color3);//line light red
   
   //HISTO DARK RED
   SetIndexBuffer(0,ind_buffer1);
   //HISTO DARK GREEN
   SetIndexBuffer(1,ind_buffer2);
   //HISTO LIGHT RED
   SetIndexBuffer(2,ind_buffer1b);
   //HISTO LIGHT GREEN
   SetIndexBuffer(3,ind_buffer2b);
   
   //LINE YELLOW
   SetIndexBuffer(4,ind_buffer3);
   //LINE AQUA
   SetIndexBuffer(5,ind_buffer4);
   
   //SetIndexBuffer(6,ind_buffer5);//
   //SetIndexBuffer(7,ind_buffer5b);//
   //SetIndexBuffer(6,ind_buffer5);//line dark red
   //SetIndexBuffer(7,ind_buffer5b);//line light red
   
   IndicatorDigits(MarketInfo(Symbol(),MODE_DIGITS)+1);
   Print(MarketInfo(Symbol(),MODE_DIGITS)+1);
   EventSetTimer(60);
   
   Print("plot 1 indicator init");
    
   return(0);
}

int start(){
   
   //Print("----BEGIN");
   
   int limit;
   int counted_bars=IndicatorCounted();
   //Print("counted_bars1: " + counted_bars);

   if(counted_bars<0) return(-1);

   if(counted_bars>0) counted_bars--;
   //Print("counted_bars2: " + counted_bars);
   //Print("Bars: " + Bars);
   limit=Bars-counted_bars;
   Print("plot 1 indicator limit: " + limit);
   
   //---- main loop
   
   
   //Print("counted_bars2: " + counted_bars)
   
   ;
   
   for(int i=limit; i>=0; i--) { 
        
      b[i] = iMA(NULL,0,FastEMA,0,MODE_EMA,PRICE_CLOSE,i)-iMA(NULL,0,SlowEMA,0,MODE_EMA,PRICE_CLOSE,i);
      //Print("[i]: " + i);
      //Print("b[" + i + "]: " + b[i]);
      
      ind_buffer1[i]=iMA(NULL,0,FastEMA,0,MODE_EMA,PRICE_CLOSE,i)-iMA(NULL,0,SlowEMA,0,MODE_EMA,PRICE_CLOSE,i);
      
      //Print("iMA(NULL,0," + FastEMA + ",0,MODE_EMA,PRICE_CLOSE," + i + ")]: " + iMA(NULL,0,FastEMA,0,MODE_EMA,PRICE_CLOSE,i);
      
      
      //Print("ind_buffer1[" + i + "]: " + ind_buffer1[i]);
      
      clearBuffers(i);
      
      //ind_buffer5[i] = -0.000184;    
      //ind_buffer5b[i] = -0.000205;
      
      //if FastEMA - SlowEMA less than zero...
      //if histo negative value...
      if (b[i] < 0 ) {
         //Print("b[" + i + "] < 0: " + b[i]);
         //if the current bar is greater than the bar that follows...
         if (b[i] > b[i+1]) {
            //Print("b[i] > b[i+1]: " + b[i]);
            //set ind_buffer to the current bar
            ind_buffer1[i] = b[i];
            //zero out ind_buffer1b
            ind_buffer1b[i] = 0;
            
            //SetIndexStyle( 6, DRAW_NONE );
            //ind_buffer5[i] = -0.000200;
            //ind_buffer5b[i] = 0;
         //if the current bar is less than the bar that follows...
         } else if (b[i] < b[i+1]) {
            //set ind_buffer1b to the current bar
            ind_buffer1b[i] = b[i];;
            //zero out ind_buffer1
            ind_buffer1[i] = 0;
            
            //SetIndexStyle(6,DRAW_LINE,EMPTY,5,indicator_color7);
            //ind_buffer5[i] = 0;
            //ind_buffer5b[i] = -0.000200;
         }
      //if FastEMA - SlowEMA greater than zero...
      //if histo positive value...
      } else if (b[i] > 0) {
         //Print("b[" + i + "] > 0: " + b[i]);
         //if the current bar is less than the bar that follows...
          if (b[i] < b[i+1]) {
            ///set ind_buffer2 to the current bar
            ind_buffer2[i] = b[i];
            //zero out ind_buffer2b
            ind_buffer2b[i] = 0;
         //if the current bar is greater than the bar that follows...
         } else if (b[i] > b[i+1]) {
            //set ind_buffer2b to the current bar
            ind_buffer2b[i] = b[i];
            //zero out ind_buffer2
            ind_buffer2[i] = 0;
         }
      }
      
      //the yellow and blue lines
      ind_buffer3[i]=iMA(NULL,0,FastEMA,0,MODE_EMA,PRICE_CLOSE,i)-iMA(NULL,0,SlowEMA,0,MODE_EMA,PRICE_CLOSE,i);
      //Print("ind_buffer3[" + i + "]: " + ind_buffer3[i]);
      
      if(i == 1)
        {       
        //ind_buffer1[1] is the histogram for the last finishedcandle
        //Print("ind_buffer1[" + i + "]: " + ind_buffer1[i]);
        
        //ind_buffer3[1] is the line for the last finishedcandle.
        //should be same as ind_buffer1[1].  yellow line or indicator_color5.
        //i think i should use this for my measurement.  ind_buffer1[i] is forced to 0 when the histogram is negative
        //Print("ind_buffer3[" + i + "]: " + ind_buffer3[i]);
        
        //Print("iMA(NULL,0," + FastEMA + ",0,MODE_EMA,PRICE_CLOSE," + i + ")]: " + iMA(NULL,0,FastEMA,0,MODE_EMA,PRICE_CLOSE,i) );
        //Print("iMA(NULL,0," + SlowEMA + ",0,MODE_EMA,PRICE_CLOSE," + i + ")]: " + iMA(NULL,0,SlowEMA,0,MODE_EMA,PRICE_CLOSE,i) );
        
        //Print("Difference between FastEMA and SlowEMA for current candle - 1: " + (iMA(NULL,0,FastEMA,0,MODE_EMA,PRICE_CLOSE,i) - iMA(NULL,0,SlowEMA,0,MODE_EMA,PRICE_CLOSE,i)));
        //Print("Difference between FastEMA and SlowEMA for current candle - 2: " + (iMA(NULL,0,FastEMA,0,MODE_EMA,PRICE_CLOSE,i +1) - iMA(NULL,0,SlowEMA,0,MODE_EMA,PRICE_CLOSE,i + 1)));
        }
      
   }
   
   for(i=0; i<limit; i++) {
         //indicator_color6
         ind_buffer4[i]=iMAOnArray(ind_buffer3,Bars,SignalSMA,0,MODE_SMA,i);
         //Print("ind_buffer4[" + i + "]: " + ind_buffer4[i]);
         
         if(i == 1)
        {
        
        //Print("ind_buffer4[" + i + "]: " + ind_buffer4[i]);
         //Print("----END");
        }
      }
        
   return(0);
   
   //---- main loop
   
}

void clearBuffers (int i) {
         
      ind_buffer1[i] = NULL;
      ind_buffer1b[i] = NULL;
      ind_buffer2[i] = NULL;
      ind_buffer2b[i] = NULL;
      
      //ind_buffer5[i] = NULL;
      //ind_buffer5b[i] = NULL;            
}

void OnTimer(){

        Print("M1 TIMERx");
        //Print("ind_buffer3[1]: " + ind_buffer3[1]);
        
        Print("TOHLCV data for current candle - 1: " + "Time: " + TimeToStr(Time[1]) + " Open: " + Open[1] + " High: " + High[1] + " Low: " + Low[1] + " Close: " + Close[1] +" Volume: " + Volume[1]);
        Print("Histo value for current candle - 1: " + (iMA(NULL,0,FastEMA,0,MODE_EMA,PRICE_CLOSE,1) - iMA(NULL,0,SlowEMA,0,MODE_EMA,PRICE_CLOSE,1)));
        
        /*Print("{" + 
        "symbol: " + "\"" + Symbol() + "\", " + 
        "period: " + "\"" + Period() + "\", " + 
        "time: " + "\"" + TimeToStr(Time[1]) + "\", " + 
        
        "open: " + "\"" + Open[1] + "\", " + 
        "high: " + "\"" + High[1] + "\", " + 
        "low: " + "\"" + Low[1] + "\", " + 
        "close: " + "\"" + Close[1] + "\", " + 
        "volume: " + "\"" + Volume[1] + "\"" + 
        "}");*/
        
        //Print("Chart Id: " + ChartID());
        
        LogOperations();
}
       
void LogOperations()
{
   //int handle;
   int handle2;
   //string str = TimeToStr(TimeCurrent()) + " The current Bid is " + Bid + "\r\n";
   //string str2 = "Time: " + TimeToStr(Time[1]) + ",Open:," + Open[1] + ",High:," + High[1] + ",Low: " + Low[1] + ",Close: " + Close[1] + ",Volume: ," + Volume[1] + "\r\n";
   string str2 = "{" + 
        "symbol: " + "\"" + Symbol() + "\", " + 
        "period: " + "\"" + Period() + "\", " + 
        "time: " + "\"" + TimeToStr(Time[1]) + "\", " + 
        "open: " + "\"" + Open[1] + "\", " + 
        "high: " + "\"" + High[1] + "\", " + 
        "low: " + "\"" + Low[1] + "\", " + 
        "close: " + "\"" + Close[1] + "\", " + 
        "volume: " + "\"" + Volume[1] + "\", " + 
        
        "histo_1: " + "\"" + (iMA(NULL,0,FastEMA,0,MODE_EMA,PRICE_CLOSE,1) - iMA(NULL,0,SlowEMA,0,MODE_EMA,PRICE_CLOSE,1)) + "\", " + 
        
        "}" + "\r\n";
   
   //string str3 = "Time: " + TimeToStr(Time[1]) + ",Open:," + Open[1] + ",High:," + High[1] + ",Low: " + Low[1] + ",Close: " + Close[1] + ",Volume: ," + Volume[1] + "\r\n";
   
   //handle=FileOpen("myLog.txt", FILE_BIN|FILE_READ|FILE_WRITE);
   handle2=FileOpen("goss_data.txt", FILE_BIN|FILE_READ|FILE_WRITE);
    //if(handle<1)
    if(handle2<1)
    {
     Print("can't open file error-",GetLastError());
     return(0);
    }
   //FileSeek(handle, 0, SEEK_END);
   FileSeek(handle2, 0, SEEK_END);
   //FileWriteString(handle, str, StringLen(str));
   FileWriteString(handle2, str2, StringLen(str2));
   //FileClose(handle);
   FileClose(handle2);
} 
         
