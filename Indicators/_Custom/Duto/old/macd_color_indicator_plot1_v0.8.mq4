/*

*********************************************************************

                            MACD Color
                   Copyright © 2006  Akuma99
                  http://www.beginnertrader.com/

       For help on this indicator, tutorials and information
               visit http://www.beginnertrader.com/

*********************************************************************

*/

#property copyright ""
#property link ""

#property indicator_separate_window

//#property  indicator_buffers 6
//#property indicator_buffers 12//plot 1-2
//#property indicator_buffers 17//plot 1-3
#property indicator_buffers 22//plot 1-4

#property indicator_color1 FireBrick
#property indicator_color2 SeaGreen
#property indicator_color3 Red
#property indicator_color4 LimeGreen

#property indicator_color5 Yellow
#property indicator_color6 Aqua

#property indicator_color7 CLR_NONE
#property indicator_color8 DodgerBlue

// #property indicator_minimum -.0005
// #property indicator_maximum 0.0005

// PARAMETER INPUTS
extern int FastEMA = 12;
extern int SlowEMA = 26;
extern int SignalSMA = 9;

// index 0
// indicator buffer for light red, last negative value greater than previous negative value
double ind_buffer1[];

// index 1
// indicator buffer for light green, last positive value greater than previous positive value
double ind_buffer2[];

// index 2
// indicator buffer for dark red, last negative value less than previous negative value
double ind_buffer1b[];

// index 3
// indicator buffer for dark green, last positive value less than previous positive value
double ind_buffer2b[];

// index 4
double ind_buffer3[];

// index 5
double ind_buffer4[];

//index 6
double b[999999];

// double     ind_buffer5[];
// double     ind_buffer5b[];

double plot2_neg_dark_red[];
double plot2_pos_dark_green[];
double plot2_neg_light_red[];
double plot2_pos_light_green[];
double plot2[999999];

double plot3_neg_dark_red[];
double plot3_pos_dark_green[];
double plot3_neg_light_red[];
double plot3_pos_light_green[];
double plot3[999999];

double plot4_neg_dark_red[];
double plot4_pos_dark_green[];
double plot4_neg_light_red[];
double plot4_pos_light_green[];
double plot4[999999];

int init()
{

   //MACD DATA ARRAYS

   // SET THE INDEX STYLE AND MAP THE INDICATOR BUFFERS TO AN INDEX.
   // HISTO DARK RED
   SetIndexStyle(0, DRAW_HISTOGRAM, STYLE_SOLID, 2, indicator_color1);
   SetIndexBuffer(0, ind_buffer1);

   // HISTO DARK GREEN
   SetIndexStyle(1, DRAW_HISTOGRAM, STYLE_SOLID, 2, indicator_color2);
   SetIndexBuffer(1, ind_buffer2);

   // HISTO LIGHT RED
   SetIndexStyle(2, DRAW_HISTOGRAM, STYLE_SOLID, 2, indicator_color3);
   SetIndexBuffer(2, ind_buffer1b);

   // HISTO LIGHT GREEN
   SetIndexStyle(3, DRAW_HISTOGRAM, STYLE_SOLID, 2, indicator_color4);
   SetIndexBuffer(3, ind_buffer2b);

   // LINE YELLOW
   //SetIndexStyle(4, DRAW_LINE, EMPTY, 1, indicator_color5);
   SetIndexStyle(4, DRAW_NONE, EMPTY, 1, indicator_color5);
   SetIndexBuffer(4, ind_buffer3);

   // LINE AQUA
   //SetIndexStyle(5, DRAW_LINE, EMPTY, 1, indicator_color6);
   SetIndexStyle(5, DRAW_NONE, EMPTY, 1, indicator_color6);
   SetIndexBuffer(5, ind_buffer4);

   //MACD INDICATOR BUFFERS
   //LINE BUFFER B
   //value 7
   SetIndexStyle(6, DRAW_LINE, EMPTY, 1, indicator_color8);
   SetIndexLabel(6, "Value 7, Buffer B");
   SetIndexBuffer(6, b);

   //plot 2
   //value 8
   SetIndexStyle(7, DRAW_LINE, STYLE_SOLID, 5, indicator_color1);  // line dark red
   SetIndexBuffer(7, plot2_neg_dark_red);     // line dark red
   //value 9
   SetIndexStyle(8, DRAW_LINE, STYLE_SOLID, 5, indicator_color2);  // line dark green
   SetIndexBuffer(8, plot2_pos_dark_green);   // line dark green
   //value 10
   SetIndexStyle(9, DRAW_LINE, STYLE_SOLID, 5, indicator_color3);  // line light red
   SetIndexBuffer(9, plot2_neg_light_red);    // line light red
   //value 11
   SetIndexStyle(10, DRAW_LINE, STYLE_SOLID, 5, indicator_color4); // line light green
   SetIndexBuffer(10, plot2_pos_light_green); // line light green
   //value 12
   SetIndexStyle(11, DRAW_HISTOGRAM, STYLE_SOLID, 2, indicator_color7); // histo none
   SetIndexLabel(11, "Value 12, MACD Plot2");
   SetIndexBuffer(11, plot2); // histo none

   //plot 3
   //value 13
   SetIndexStyle(12, DRAW_LINE, STYLE_SOLID, 5, indicator_color1);  // line light red
   SetIndexBuffer(12, plot3_neg_dark_red);     // 
   //value 14
   SetIndexStyle(13, DRAW_LINE, STYLE_SOLID, 5, indicator_color2);  // line light green
   SetIndexBuffer(13, plot3_pos_dark_green);   //
   //value 15
   SetIndexStyle(14, DRAW_LINE, STYLE_SOLID, 5, indicator_color3);  // line dark red
   SetIndexBuffer(14, plot3_neg_light_red);    // 
   //value 16
   SetIndexStyle(15, DRAW_LINE, STYLE_SOLID, 5, indicator_color4); // line dark green
   SetIndexBuffer(15, plot3_pos_light_green); //
   //value 17
   SetIndexStyle(16, DRAW_HISTOGRAM, STYLE_SOLID, 2, indicator_color7); // histo none
   SetIndexLabel(16, "Value 17, MACD Plot3");
   SetIndexBuffer(16, plot3); // histo none

   //plot 4
   //value 18
   SetIndexStyle(17, DRAW_LINE, STYLE_SOLID, 5, indicator_color1);  // line light red
   SetIndexBuffer(17, plot4_neg_dark_red);     //
   //value 19
   SetIndexStyle(18, DRAW_LINE, STYLE_SOLID, 5, indicator_color2);  // line light green
   SetIndexBuffer(18, plot4_pos_dark_green);   // 
   //value 20
   SetIndexStyle(19, DRAW_LINE, STYLE_SOLID, 5, indicator_color3);  // line dark red
   SetIndexBuffer(19, plot4_neg_light_red);    // 
   //value 21
   SetIndexStyle(20, DRAW_LINE, STYLE_SOLID, 5, indicator_color4); // line dark green
   SetIndexBuffer(20, plot4_pos_light_green); //
   //value 22
   SetIndexStyle(21, DRAW_HISTOGRAM, STYLE_SOLID, 2, indicator_color7); // histo none
   SetIndexLabel(21, "Value 22, MACD Plot4");
   SetIndexBuffer(21, plot4); // histo none

   IndicatorDigits(MarketInfo(Symbol(), MODE_DIGITS) + 1);
   Print(MarketInfo(Symbol(), MODE_DIGITS) + 1);
   // EventSetTimer(60);

   Print("plot 1 indicator init()");

   return (0);
}

int start()
{

   // Print("plot 1 indicator start()");

   int limit;
   int counted_bars = IndicatorCounted();
   //Print("start() counted_bars: " + counted_bars);

   if (counted_bars < 0)
      return (-1);

   if (counted_bars > 0)
      counted_bars--;
   // Print("counted_bars2: " + counted_bars);
   // Print("Bars: " + Bars);

   limit = Bars - counted_bars;
   // Print("plot 1 indicator Bars from indicator start(): " + Bars);
   // Print("plot 1 indicator counted_bars from indicator start(): " + counted_bars);
   // Print("plot 1 indicator limit from indicator start(): " + limit);

   // plot 1
   for (int i = limit; i >= 0; i--)
   {

      // b[i] holds the MACD result
      // b[0] is the current candle being built, b[1] is the most recently built candle, b[2] is the next most recently built candle
      b[i] = iMA(NULL, 0, FastEMA, 0, MODE_EMA, PRICE_CLOSE, i) - iMA(NULL, 0, SlowEMA, 0, MODE_EMA, PRICE_CLOSE, i);
      // b[i] = iMA(NULL, 0, 40, 0, MODE_EMA, PRICE_CLOSE, i) - iMA(NULL, 0, 85, 0, MODE_EMA, PRICE_CLOSE, i);

      // Print("b[" + i + "]: " + b[i]);

      ind_buffer1[i] = iMA(NULL, 0, FastEMA, 0, MODE_EMA, PRICE_CLOSE, i) - iMA(NULL, 0, SlowEMA, 0, MODE_EMA, PRICE_CLOSE, i);

      // Print("iMA(NULL,0," + FastEMA + ",0,MODE_EMA,PRICE_CLOSE," + i + ")]: " + iMA(NULL,0,FastEMA,0,MODE_EMA,PRICE_CLOSE,i);

      // null out buffers 1, 1b, 2 and 2b
      // clearBuffers(i);
      ind_buffer1[i] = NULL;
      ind_buffer1b[i] = NULL;
      ind_buffer2[i] = NULL;
      ind_buffer2b[i] = NULL;

      // if FastEMA - SlowEMA less than zero...
      // if histo is a negative value...
      if (b[i] < 0)
      {

         // Print("b[" + i + "] < 0: " + b[i]);
         // if the current bar is greater than the bar that follows...
         if (b[i] > b[i + 1])
         {
            // Print("b[i] > b[i+1]: " + b[i]);
            // set ind_buffer to the current bar
            ind_buffer1[i] = b[i];
            // zero out ind_buffer1b
            ind_buffer1b[i] = 0;

            // SetIndexStyle( 6, DRAW_NONE );
            // if the current bar is less than the bar that follows...
         }
         else if (b[i] < b[i + 1])
         {
            // set ind_buffer1b to the current bar
            ind_buffer1b[i] = b[i];
            ;
            // zero out ind_buffer1
            ind_buffer1[i] = 0;
         }
         // if FastEMA - SlowEMA greater than zero...
         // if histo is a positive value...
      }
      else if (b[i] > 0 || b[i] != 0)
      {

         // if the current bar is less than the bar that follows...
         if (b[i] < b[i + 1])
         {
            /// set ind_buffer2 to the current bar
            ind_buffer2[i] = b[i];
            // zero out ind_buffer2b
            ind_buffer2b[i] = 0;

            // if the current bar is greater than the bar that follows...
         }
         else if (b[i] > b[i + 1])
         {
            // set ind_buffer2b to the current bar
            ind_buffer2b[i] = b[i];
            // zero out ind_buffer2
            ind_buffer2[i] = 0;
         }
      }

      // the yellow and blue lines
      ind_buffer3[i] = iMA(NULL, 0, FastEMA, 0, MODE_SMMA, PRICE_CLOSE, i) - iMA(NULL, 0, SlowEMA, 0, MODE_EMA, PRICE_CLOSE, i);
      // Print("ind_buffer3[" + i + "]: " + ind_buffer3[i]);

      if (i == 1)
      {
         // ind_buffer1[1] is the histogram for the last finished candle
         // Print("ind_buffer1[" + i + "]: " + ind_buffer1[i]);

         // ind_buffer3[1] is the line for the last finishedcandle.
         // should be same as ind_buffer1[1].  yellow line or indicator_color5.
         // i think i should use this for my measurement.  ind_buffer1[i] is forced to 0 when the histogram is negative
         // Print("ind_buffer3[" + i + "]: " + ind_buffer3[i]);

         // Print("iMA(NULL,0," + FastEMA + ",0,MODE_EMA,PRICE_CLOSE," + i + ")]: " + iMA(NULL,0,FastEMA,0,MODE_EMA,PRICE_CLOSE,i) );
         // Print("iMA(NULL,0," + SlowEMA + ",0,MODE_EMA,PRICE_CLOSE," + i + ")]: " + iMA(NULL,0,SlowEMA,0,MODE_EMA,PRICE_CLOSE,i) );

         // Print("Difference between FastEMA and SlowEMA for current candle - 1: " + (iMA(NULL,0,FastEMA,0,MODE_EMA,PRICE_CLOSE,i) - iMA(NULL,0,SlowEMA,0,MODE_EMA,PRICE_CLOSE,i)));
         // Print("Difference between FastEMA and SlowEMA for current candle - 2: " + (iMA(NULL,0,FastEMA,0,MODE_EMA,PRICE_CLOSE,i +1) - iMA(NULL,0,SlowEMA,0,MODE_EMA,PRICE_CLOSE,i + 1)));
      }
   }

   // Print("---------END FOR LOOP-----------");

   for (i = 0; i < limit; i++)
   {
      // indicator_color6
      ind_buffer4[i] = iMAOnArray(ind_buffer3, Bars, SignalSMA, 0, MODE_SMA, i);
      // Print("ind_buffer4[" + i + "]: " + ind_buffer4[i]);

      if (i == 1)
      {

         // Print("ind_buffer4[" + i + "]: " + ind_buffer4[i]);
         // Print("----END");
      }
   }

   // plot 2
   for (int PL2 = limit; PL2 >= 0; PL2--)
   {

      // plot2[PL2] holds the MACD result
      // plot2[0] is the current candle being built, b[1] is the most recently built candle, b[2] is the next most recently built candle
      plot2[PL2] = iMA(NULL, 0, 40, 0, MODE_EMA, PRICE_CLOSE, PL2) - iMA(NULL, 0, 85, 0, MODE_EMA, PRICE_CLOSE, PL2);
      //plot2[PL2] = iMA(NULL, 0, FastEMA, 0, MODE_EMA, PRICE_CLOSE, PL2) - iMA(NULL, 0, SlowEMA, 0, MODE_EMA, PRICE_CLOSE, PL2);

      //Print("plot2[" + PL2 + "]: " + plot2[PL2]);

      plot2_neg_dark_red[PL2] = -0.000200;
      plot2_neg_light_red[PL2] = -0.000200;

      plot2_pos_dark_green[PL2] = -0.000200;
      plot2_pos_light_green[PL2] = -0.000200;

      // if FastEMA - SlowEMA less than zero...
      // if histo is a negative value...
      if (plot2[PL2] < 0)
      {
         // hide light green when negative
         plot2_pos_light_green[PL2] = EMPTY_VALUE;
         plot2_pos_dark_green[PL2] = EMPTY_VALUE;

         // Print("b[" + i + "] < 0: " + b[PL2]);
         // if the current bar is greater than the bar that follows...
         if (plot2[PL2] > plot2[PL2 + 1])
         {
            // hide bright red to show dark red beneath
            plot2_neg_light_red[PL2] = EMPTY_VALUE;

            // SetIndexStyle( 6, DRAW_NONE );
            // if the current bar is less than the bar that follows...
         }
         else if (plot2[PL2] < plot2[PL2 + 1])
         {
         }
         // if FastEMA - SlowEMA greater than zero...
         // if histo is a positive value...
      }
      else if (plot2[PL2] > 0)
      {

         // hide light red when positive
         plot2_neg_light_red[PL2] = EMPTY_VALUE;
         // hide dark red when positive
         plot2_neg_dark_red[PL2] = EMPTY_VALUE;

         // if the current bar is less than the bar that follows...
         if (plot2[PL2] < plot2[PL2 + 1])
         {
            plot2_pos_light_green[PL2] = EMPTY_VALUE;

            // if the current bar is greater than the bar that follows...
         }
         else if (plot2[PL2] > plot2[PL2 + 1])
         {
         }
      }
   }

   // plot 3
   for (int PL3 = limit; PL3 >= 0; PL3--)
   {

      // plot3[PL3] holds the MACD result
      // plot3[0] is the current candle being built, b[1] is the most recently built candle, b[2] is the next most recently built candle
      plot3[PL3] = iMA(NULL, 0, 80, 0, MODE_EMA, PRICE_CLOSE, PL3) - iMA(NULL, 0, 120, 0, MODE_EMA, PRICE_CLOSE, PL3);
      //Print("plot3[" + PL3 + "]: " + plot3[PL3]);

      plot3_neg_dark_red[PL3] = -0.000300;
      plot3_neg_light_red[PL3] = -0.000300;

      plot3_pos_dark_green[PL3] = -0.000300;
      plot3_pos_light_green[PL3] = -0.000300;

      // if FastEMA - SlowEMA less than zero...
      // if histo is a negative value...
      if (plot3[PL3] < 0)
      {
         // hide light green when negative
         plot3_pos_light_green[PL3] = EMPTY_VALUE;
         plot3_pos_dark_green[PL3] = EMPTY_VALUE;

         // Print("b[" + i + "] < 0: " + b[PL3]);
         // if the current bar is greater than the bar that follows...
         if (plot3[PL3] > plot3[PL3 + 1])
         {
            // hide bright red to show dark red beneath
            plot3_neg_light_red[PL3] = EMPTY_VALUE;

            // SetIndexStyle( 6, DRAW_NONE );
            // if the current bar is less than the bar that follows...
         }
         else if (plot3[PL3] < plot3[PL3 + 1])
         {
         }
         // if FastEMA - SlowEMA greater than zero...
         // if histo is a positive value...
      }
      else if (plot3[PL3] > 0)
      {

         // hide light red when positive
         plot3_neg_light_red[PL3] = EMPTY_VALUE;
         // hide dark red when positive
         plot3_neg_dark_red[PL3] = EMPTY_VALUE;

         // if the current bar is less than the bar that follows...
         if (plot3[PL3] < plot3[PL3 + 1])
         {
            plot3_pos_light_green[PL3] = EMPTY_VALUE;

            // if the current bar is greater than the bar that follows...
         }
         else if (plot3[PL3] > plot3[PL3 + 1])
         {
         }
      }
   }

   // plot 4
   for (int PL4 = limit; PL4 >= 0; PL4--)
   {

      // plot4[PL4] holds the MACD result
      // plot4[0] is the current candle being built, b[1] is the most recently built candle, b[2] is the next most recently built candle
      plot4[PL4] = iMA(NULL, 0, 78, 0, MODE_EMA, PRICE_CLOSE, PL4) - iMA(NULL, 0, 135, 0, MODE_EMA, PRICE_CLOSE, PL4);
      //Print("plot4[" + PL4 + "]: " + plot4[PL4]);

      plot4_neg_dark_red[PL4] = -0.000400;
      plot4_neg_light_red[PL4] = -0.000400;

      plot4_pos_dark_green[PL4] = -0.000400;
      plot4_pos_light_green[PL4] = -0.000400;

      // if FastEMA - SlowEMA less than zero...
      // if histo is a negative value...
      if (plot4[PL4] < 0)
      {
         // hide light green when negative
         plot4_pos_light_green[PL4] = EMPTY_VALUE;
         plot4_pos_dark_green[PL4] = EMPTY_VALUE;

         // Print("b[" + i + "] < 0: " + b[PL4]);
         // if the current bar is greater than the bar that follows...
         if (plot4[PL4] > plot4[PL4 + 1])
         {
            // hide bright red to show dark red beneath
            plot4_neg_light_red[PL4] = EMPTY_VALUE;

            // SetIndexStyle( 6, DRAW_NONE );
            // if the current bar is less than the bar that follows...
         }
         else if (plot4[PL4] < plot4[PL4 + 1])
         {
         }
         // if FastEMA - SlowEMA greater than zero...
         // if histo is a positive value...
      }
      else if (plot4[PL4] > 0)
      {

         // hide light red when positive
         plot4_neg_light_red[PL4] = EMPTY_VALUE;
         // hide dark red when positive
         plot4_neg_dark_red[PL4] = EMPTY_VALUE;

         // if the current bar is less than the bar that follows...
         if (plot4[PL4] < plot4[PL4 + 1])
         {
            plot4_pos_light_green[PL4] = EMPTY_VALUE;

            // if the current bar is greater than the bar that follows...
         }
         else if (plot4[PL4] > plot4[PL4 + 1])
         {
         }
      }
   }

   return (0);

   //---- main loop
}

void clearBuffers(int i)
{

   ind_buffer1[i] = NULL;
   ind_buffer1b[i] = NULL;
   ind_buffer2[i] = NULL;
   ind_buffer2b[i] = NULL;

   // plot2_neg_dark_red[i] = NULL;
   // plot2_pos_dark_green[i] = NULL;
   // plot2_neg_light_red[i] = NULL;
   // plot2_pos_light_green[i] = NULL;

   // ind_buffer5[i] = NULL;
   // ind_buffer5b[i] = NULL;
}

void OnTimer()
{

   Print("M1 TIMERx");
   // Print("ind_buffer3[1]: " + ind_buffer3[1]);

   Print("TOHLCV data for current candle - 1: " + "Time: " + TimeToStr(Time[1]) + " Open: " + Open[1] + " High: " + High[1] + " Low: " + Low[1] + " Close: " + Close[1] + " Volume: " + Volume[1]);
   Print("Histo value for current candle - 1: " + (iMA(NULL, 0, FastEMA, 0, MODE_EMA, PRICE_CLOSE, 1) - iMA(NULL, 0, SlowEMA, 0, MODE_EMA, PRICE_CLOSE, 1)));

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

   // Print("Chart Id: " + ChartID());

   // LogOperations();
}

void LogOperations()
{
   // int handle;
   int handle2;
   // string str = TimeToStr(TimeCurrent()) + " The current Bid is " + Bid + "\r\n";
   // string str2 = "Time: " + TimeToStr(Time[1]) + ",Open:," + Open[1] + ",High:," + High[1] + ",Low: " + Low[1] + ",Close: " + Close[1] + ",Volume: ," + Volume[1] + "\r\n";
   string str2 = "{" +
                 "symbol: " + "\"" + Symbol() + "\", " +
                 "period: " + "\"" + Period() + "\", " +
                 "time: " + "\"" + TimeToStr(Time[1]) + "\", " +
                 "open: " + "\"" + Open[1] + "\", " +
                 "high: " + "\"" + High[1] + "\", " +
                 "low: " + "\"" + Low[1] + "\", " +
                 "close: " + "\"" + Close[1] + "\", " +
                 "volume: " + "\"" + Volume[1] + "\", " +

                 "histo_1: " + "\"" + (iMA(NULL, 0, FastEMA, 0, MODE_EMA, PRICE_CLOSE, 1) - iMA(NULL, 0, SlowEMA, 0, MODE_EMA, PRICE_CLOSE, 1)) + "\", " +

                 "}" + "\r\n";

   // string str3 = "Time: " + TimeToStr(Time[1]) + ",Open:," + Open[1] + ",High:," + High[1] + ",Low: " + Low[1] + ",Close: " + Close[1] + ",Volume: ," + Volume[1] + "\r\n";

   // handle=FileOpen("myLog.txt", FILE_BIN|FILE_READ|FILE_WRITE);
   handle2 = FileOpen("goss_data.txt", FILE_BIN | FILE_READ | FILE_WRITE);
   // if(handle<1)
   if (handle2 < 1)
   {
      Print("can't open file error-", GetLastError());
      return (0);
   }
   // FileSeek(handle, 0, SEEK_END);
   FileSeek(handle2, 0, SEEK_END);
   // FileWriteString(handle, str, StringLen(str));
   FileWriteString(handle2, str2, StringLen(str2));
   // FileClose(handle);
   FileClose(handle2);
}
