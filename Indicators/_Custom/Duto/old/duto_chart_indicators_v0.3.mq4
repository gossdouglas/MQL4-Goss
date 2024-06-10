//+------------------------------------------------------------------+
//|                                        duto_chart_indicators.mq4 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_chart_window

//moving average indicators
//--- plot FastMA
#property indicator_label1  "FastMA"
#property indicator_type1   DRAW_LINE
#property indicator_color1  clrYellow
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1
//--- plot SlowMA
#property indicator_label2  "SlowMA"
#property indicator_type2   DRAW_LINE
#property indicator_color2  clrRed
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1
//--- input parameters
input int      FastMA=15;
input int      SlowMA=25;
//--- indicator buffers
double         FastMABuffer[];
double         SlowMABuffer[];

//moving averages 2
//--- plot FastMA
#property indicator_label3  "FastMA2"
#property indicator_type3   DRAW_LINE
#property indicator_color3  clrYellow
#property indicator_style3  STYLE_SOLID
#property indicator_width3  1
//--- plot SlowMA
#property indicator_label4  "SlowMA2"
#property indicator_type4   DRAW_LINE
#property indicator_color4  clrRed
#property indicator_style4  STYLE_SOLID
#property indicator_width4  1
//--- input parameters
input int      FastMA2=20;
input int      SlowMA2=30;
//--- indicator buffers
double         FastMABuffer2[];
double         SlowMABuffer2[];

//delta indicator
#property indicator_label5  "Delta1"
#property indicator_type5   DRAW_LINE
#property indicator_color5  clrBlue
#property indicator_style5  STYLE_SOLID
#property indicator_width5  1

#property indicator_label6  "Delta2"
#property indicator_type6   DRAW_LINE
#property indicator_color6  clrRed
#property indicator_style6  STYLE_SOLID
#property indicator_width6  1

//#property indicator_color5 Blue
//#property indicator_color6 Red
//---- input parameters
extern int       sper=60;
extern int       fper=13;
extern int       test=0;
extern int       nBars=100;
//---- buffers
double ExtMapBuffer1[];
double ExtMapBuffer2[];
//double shift, sdel, fdel, mas, maf, mBar;
int shift;
double sdel, fdel, mas, maf, mBar;


//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
SetIndexStyle(0, DRAW_LINE, EMPTY, 1, indicator_color1);
SetIndexBuffer(0,FastMABuffer);
SetIndexStyle(1, DRAW_LINE, EMPTY, 1, indicator_color2);
SetIndexBuffer(1,SlowMABuffer);

///*
SetIndexStyle(2, DRAW_LINE, EMPTY, 1, indicator_color3);
SetIndexBuffer(2,FastMABuffer2);
SetIndexStyle(3, DRAW_LINE, EMPTY, 1, indicator_color4);
SetIndexBuffer(3,SlowMABuffer2);
//*/

///*
//delta indicator
//SetIndexStyle(4, DRAW_LINE, EMPTY, 1, indicator_color5);
SetIndexStyle(4, DRAW_NONE, EMPTY, 1, indicator_color5);
SetIndexBuffer(4,ExtMapBuffer1);
//SetIndexStyle(5, DRAW_LINE, EMPTY, 1, indicator_color6);
SetIndexStyle(5, DRAW_NONE, EMPTY, 1, indicator_color6);
SetIndexBuffer(5,ExtMapBuffer2);
//*/

//IndicatorDigits(MarketInfo(Symbol(), MODE_DIGITS) + 1);
IndicatorDigits(MarketInfo(Symbol(), MODE_DIGITS));
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---

int limit;
   int counted_bars = IndicatorCounted();
   // Print("start() counted_bars: " + counted_bars);

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
   
   for (int i = 0; i < limit; i++)
   {
      // indicator_color6
      FastMABuffer[i] = iMA(NULL, 0, FastMA, 0, MODE_SMMA, PRICE_WEIGHTED, i);
      SlowMABuffer[i] = iMA(NULL, 0, SlowMA, 0, MODE_SMMA, PRICE_MEDIAN, i);
      
      /*
      FastMABuffer2[i] = iMA(NULL, 0, FastMA2, 0, MODE_SMMA, PRICE_WEIGHTED, i);
      SlowMABuffer2[i] = iMA(NULL, 0, SlowMA2, 0, MODE_SMMA, PRICE_MEDIAN, i);
      */
      
      // Print("ind_buffer4[" + i + "]: " + ind_buffer4[i]);

      if (i == 1)
      {

         // Print("ind_buffer4[" + i + "]: " + ind_buffer4[i]);
         // Print("----END");
      }
   }

   //delta logic
   for(int shift=Bars-1; shift>0; shift--)
     {
      ExtMapBuffer1[shift]=0;
      ExtMapBuffer2[shift]=0;
     }
   if (test==1) {mBar=nBars;} else {mBar=Bars;}
   for(shift=Bars-1; shift>0; shift--)
     {
      mas=iMA(NULL, 0, sper, 0, MODE_EMA, PRICE_CLOSE,shift-1);
      maf=iMA(NULL, 0, fper, 0, MODE_EMA, PRICE_CLOSE,shift-1);
      sdel=MathRound((mas-Close[0])/Point);
      fdel=MathRound((maf-Close[0])/Point);
      if (sdel==0) {sdel=0.0001;}
      if (fdel==0) {fdel=0.0001;}
      if (sdel!=0) {ExtMapBuffer1[shift-1]=sdel;}
      if (fdel!=0) {ExtMapBuffer2[shift-1]=fdel;}

      //Print("ExtMapBuffer1[" + (shift-1) + "] sdel= " + sdel + ", ExtMapBuffer2[" + (shift-1) + "] fdel= " + fdel);
      int sdelFdelDiff = sdel - fdel;
      //Print("The difference is: " + sdelFdelDiff);
     }
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
