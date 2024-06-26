//+------------------------------------------------------------------+
//|                                                 Color Levels.mq4 |
//|                                        Copyright 2015, omutmoren |
//|                                       https://www.investlabfx.ru |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, omutmoren"
#property link      "https://www.investlabfx.ru"
#property version   "1.00"
#property strict
#property indicator_chart_window
//+------------------------------------------------------------------+
//| Custom indicator Parameters                                      |
//+------------------------------------------------------------------+
extern ENUM_BASE_CORNER InpCorner   =  CORNER_LEFT_UPPER;   // ���� ������� ��� ��������
extern color            panl_0_cl   =  clrGainsboro;        // ���� ������ ������������
extern bool             panl_0_st   =  true;                // ���������� ������?
extern color            rect_1_cl   =  clrDodgerBlue;       // 1. ���� �������
extern ENUM_LINE_STYLE  rect_1_st   =  STYLE_SOLID;         // 1. ����� �������
extern int              rect_1_wd   =  2;                   // 1. ������� �������
extern color            rect_2_cl   =  clrFireBrick;        // 2. ���� �������
extern ENUM_LINE_STYLE  rect_2_st   =  STYLE_SOLID;         // 2. ����� �������
extern int              rect_2_wd   =  2;                   // 2. ������� �������
extern color            rect_3_cl   =  clrBlue;             // 3. ���� ��������������
extern color            rect_4_cl   =  clrRed;              // 4. ���� ��������������
extern color            rect_5_cl   =  clrDarkGray;         // 5. ���� ��������������
extern color            line_1_cl   =  clrDodgerBlue;       // 6. ���� �����
extern ENUM_LINE_STYLE  line_1_st   =  STYLE_SOLID;         // 6. ����� �����
extern int              line_1_wd   =  2;                   // 6. ������� �����
extern color            line_2_cl   =  clrFireBrick;        // 7. ���� �����
extern ENUM_LINE_STYLE  line_2_st   =  STYLE_SOLID;         // 7. ����� �����
extern int              line_2_wd   =  2;                   // 7. ������� �����

// ��� ������
bool              InpSelection      =  false;               // �������� ��� �����������
bool              InpHidden         =  true;                // ����� � ������ ��������
bool              InpHidden_OBJ     =  false;               // ����� � ������ ��������
bool              InpBackRect       =  false;               // ������ �� ������ �����

// ����������
extern int x_coor = 10;    // ����� �� ��� X
extern int y_coor = 20;    // ����� �� ��� Y
int x_size = 155;
int y_size = 30;
int x_step = 5;
int y_panl = 20;
int x_rect = 20;
int y_rect = 20;
int y_line = 6;

string obj_name[8] = {"name_1","name_2","name_3","name_4","name_5","name_6","name_7","name_8"};
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
   return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   Comment("");
   RectLabelDelete(0,obj_name[0]);
   RectLabelDelete(0,obj_name[1]);
   RectLabelDelete(0,obj_name[2]);
   RectLabelDelete(0,obj_name[3]);
   RectLabelDelete(0,obj_name[4]);
   RectLabelDelete(0,obj_name[5]);
   RectLabelDelete(0,obj_name[6]);
   RectLabelDelete(0,obj_name[7]);
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
   CreatePanel();
   CreateRect();

   return(rates_total);
}
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
{
   datetime dt_1     = 0;
   double   price_1  = 0;
   datetime dt_2     = 0;
   double   price_2  = 0;
   int      window   = 0;
   int      x        = 0;
   int      y        = 0;
   
   // ������� �� ������ �������������
   if (id == CHARTEVENT_OBJECT_CLICK) {
      string clickedChartObject = sparam;
      if (clickedChartObject == obj_name[1]) {
         string name = "name_" + IntegerToString(MathRand() + 100,0,' ');
         
         y = y_coor + y_rect + 2*x_step;
         ChartXYToTimePrice(0, x_coor + x_step, y, window, dt_1, price_1);
         
         y = y_coor + 2*y_rect + 3*x_step;
         ChartXYToTimePrice(0, x_coor + x_size, y, window, dt_2, price_2);
         
         RectangleCreate(0,name,0,dt_1,price_1,dt_2,price_2,rect_1_cl,rect_1_st,rect_1_wd,false,false,true,InpHidden_OBJ,0);
      }
   }
   // ������� �� ������ �������������
   if (id == CHARTEVENT_OBJECT_CLICK) {
      string clickedChartObject = sparam;
      if (clickedChartObject == obj_name[2]) {
         string name = "name_" + IntegerToString(MathRand() + 100,0,' ');
         
         y = y_coor + 2*y_rect + 3*x_step;
         ChartXYToTimePrice(0, x_coor + x_step, y, window, dt_1, price_1);
         
         y = y_coor + 3*y_rect + 4*x_step;
         ChartXYToTimePrice(0, x_coor + x_size, y, window, dt_2, price_2);         
         
         RectangleCreate(0,name,0,dt_1,price_1,dt_2,price_2,rect_2_cl,rect_2_st,rect_2_wd,false,false,true,InpHidden_OBJ,0);
      }
   }   
   // ������� �� ������ �������������
   if (id == CHARTEVENT_OBJECT_CLICK) {
      string clickedChartObject = sparam;
      if (clickedChartObject == obj_name[3]) {
         string name = "name_" + IntegerToString(MathRand() + 100,0,' ');

         y = y_coor + 3*y_rect + 4*x_step;
         ChartXYToTimePrice(0, x_coor + x_step, y, window, dt_1, price_1);
         
         y = y_coor + 4*y_rect + 5*x_step;
         ChartXYToTimePrice(0, x_coor + x_size, y, window, dt_2, price_2);   
         
         RectangleCreate(0,name,0,dt_1,price_1,dt_2,price_2,rect_3_cl,STYLE_SOLID,0,true,false,true,InpHidden_OBJ,0);
      }
   }
   // ������� �� �������� �������������
   if (id == CHARTEVENT_OBJECT_CLICK) {
      string clickedChartObject = sparam;
      if (clickedChartObject == obj_name[4]) {
         string name = "name_" + IntegerToString(MathRand() + 100,0,' ');

         y = y_coor + 4*y_rect + 5*x_step;
         ChartXYToTimePrice(0, x_coor + x_step, y, window, dt_1, price_1);
         
         y = y_coor + 5*y_rect + 6*x_step;
         ChartXYToTimePrice(0, x_coor + x_size, y, window, dt_2, price_2);
         
         RectangleCreate(0,name,0,dt_1,price_1,dt_2,price_2,rect_4_cl,STYLE_SOLID,0,true,false,true,InpHidden_OBJ,0);
      }
   }
   // ������� �� ����� �������������
   if (id == CHARTEVENT_OBJECT_CLICK) {
      string clickedChartObject = sparam;
      if (clickedChartObject == obj_name[5]) {
         string name = "name_" + IntegerToString(MathRand() + 100,0,' ');

         y = y_coor + 5*y_rect + 6*x_step;
         ChartXYToTimePrice(0, x_coor + x_step, y, window, dt_1, price_1);
         
         y = y_coor + 6*y_rect + 7*x_step;
         ChartXYToTimePrice(0, x_coor + x_size, y, window, dt_2, price_2);
         
         RectangleCreate(0,name,0,dt_1,price_1,dt_2,price_2,rect_5_cl,STYLE_SOLID,0,true,false,true,InpHidden_OBJ,0);
      }
   }
   // ������� �� ������ �����
   if (id == CHARTEVENT_OBJECT_CLICK) {
      string clickedChartObject = sparam;
      if (clickedChartObject == obj_name[6]) {
         string name = "name_" + IntegerToString(MathRand() + 100,0,' ');
         
         y = y_coor + 6*y_rect + 8*x_step;
         ChartXYToTimePrice(0, x_coor + x_step, y, window, dt_1, price_1);
         ChartXYToTimePrice(0, x_coor + x_size, y, window, dt_2, price_2);         
         
         TrendCreate(0,name,0,dt_1,price_1,dt_2,price_2,line_1_cl,line_1_st,line_1_wd,InpBackRect,true,false,false,InpHidden_OBJ,0);
      }
   }
   // ������� �� ������ �����
   if (id == CHARTEVENT_OBJECT_CLICK) {
      string clickedChartObject = sparam;
      if (clickedChartObject == obj_name[7]) {
         string name = "name_" + IntegerToString(MathRand() + 100,0,' ');
         
         y = y_coor + 6*y_rect + 10*x_step;
         ChartXYToTimePrice(0, x_coor + x_step, y, window, dt_1, price_1);
         ChartXYToTimePrice(0, x_coor + x_size, y, window, dt_2, price_2);         
         
         TrendCreate(0,name,0,dt_1,price_1,dt_2,price_2,line_2_cl,line_2_st,line_2_wd,InpBackRect,true,false,false,InpHidden_OBJ,0);
      }
   }
}

//+------------------------------------------------------------------+
void CreatePanel()
{
   // ������ ������������
   
   if (panl_0_st) {
   
      int x_pn = x_coor, y_pn = y_coor;
      if (InpCorner == 1)  x_pn = x_coor + x_size + x_step;
      if (InpCorner == 2)  y_pn = y_coor + y_rect + x_step;
      if (InpCorner == 3) {x_pn = x_coor + x_size + x_step; y_pn = y_coor + y_rect + x_step;}
   
      if (!RectLabelCreate(0,obj_name[0],0,x_pn,y_pn,x_size,y_size,panl_0_cl,BORDER_SUNKEN,InpCorner,
           clrBlack,STYLE_SOLID,2,true,InpSelection,true,0)) {
         return;
      }   
   } else {
      panl_0_cl = ChartBackColorGet(0);
   }
}
//+------------------------------------------------------------------+
void CreateRect()
{
   // ������ �������������
   int x_pn = x_coor + x_step, y_pn = y_coor + x_step;
   if (InpCorner == 1)  x_pn = x_coor + x_size;
   if (InpCorner == 2)  y_pn = y_coor + y_rect;
   if (InpCorner == 3) {x_pn = x_coor + x_size; y_pn = y_coor + y_rect;}
   
   if (!RectLabelCreate(0,obj_name[1],0,x_pn,y_pn,x_rect,y_rect,panl_0_cl,BORDER_FLAT,InpCorner,
        rect_1_cl,rect_1_st,rect_1_wd,InpBackRect,InpSelection,InpHidden,0)) {
      return;
   }   

   // ������ �������������
   x_pn = x_coor + x_rect + 2*x_step; y_pn = y_coor + x_step;
   if (InpCorner == 1)  x_pn = x_coor + x_size - x_step - x_rect;
   if (InpCorner == 2)  y_pn = y_coor + y_rect;
   if (InpCorner == 3) {x_pn = x_coor + x_size - x_step - x_rect; y_pn = y_coor + y_rect;}
   
   if (!RectLabelCreate(0,obj_name[2],0,x_pn,y_pn,x_rect,y_rect,panl_0_cl,BORDER_FLAT,InpCorner,
        rect_2_cl,rect_2_st,rect_2_wd,InpBackRect,InpSelection,InpHidden,0)) {
      return;
   }  

   // ������ �������������
   x_pn = x_coor + 2*x_rect + 3*x_step; y_pn = y_coor + x_step;
   if (InpCorner == 1)  x_pn = x_coor + x_size - 2*x_step - 2*x_rect;
   if (InpCorner == 2)  y_pn = y_coor + y_rect;
   if (InpCorner == 3) {x_pn = x_coor + x_size - 2*x_step - 2*x_rect; y_pn = y_coor + y_rect;}
   
   if (!RectLabelCreate(0,obj_name[3],0,x_pn,y_pn,x_rect,y_rect,rect_3_cl,BORDER_FLAT,InpCorner,
        rect_3_cl,STYLE_SOLID,0,InpBackRect,InpSelection,InpHidden,0)) {
      return;
   }  

   // �������� �������������
   x_pn = x_coor + 3*x_rect + 4*x_step; y_pn = y_coor + x_step;
   if (InpCorner == 1)  x_pn = x_coor + x_size - 3*x_step - 3*x_rect;
   if (InpCorner == 2)  y_pn = y_coor + y_rect;
   if (InpCorner == 3) {x_pn = x_coor + x_size - 3*x_step - 3*x_rect; y_pn = y_coor + y_rect;}
   
   if (!RectLabelCreate(0,obj_name[4],0,x_pn,y_pn,x_rect,y_rect,rect_4_cl,BORDER_FLAT,InpCorner,
        rect_4_cl,STYLE_SOLID,0,InpBackRect,InpSelection,InpHidden,0)) {
      return;
   }

   // ����� �������������
   x_pn = x_coor + 4*x_rect + 5*x_step; y_pn = y_coor + x_step;
   if (InpCorner == 1)  x_pn = x_coor + x_size - 4*x_step - 4*x_rect;
   if (InpCorner == 2)  y_pn = y_coor + y_rect;
   if (InpCorner == 3) {x_pn = x_coor + x_size - 4*x_step - 4*x_rect; y_pn = y_coor + y_rect;}
   
   if (!RectLabelCreate(0,obj_name[5],0,x_pn,y_pn,x_rect,y_rect,rect_5_cl,BORDER_FLAT,InpCorner,
        rect_5_cl,STYLE_SOLID,0,InpBackRect,InpSelection,InpHidden,0)) {
      return;
   }
   
   // ������ �����
   x_pn = x_coor + 5*x_rect + 6*x_step; y_pn = y_coor + x_step;
   if (InpCorner == 1)  x_pn = x_coor + x_size - 5*x_step - 5*x_rect;
   if (InpCorner == 2)  y_pn = y_coor + y_rect;
   if (InpCorner == 3) {x_pn = x_coor + x_size - 5*x_step - 5*x_rect; y_pn = y_coor + y_rect;}
   
   if (!RectLabelCreate(0,obj_name[6],0,x_pn,y_pn,x_rect,y_line,line_1_cl,BORDER_FLAT,InpCorner,
        line_1_cl,STYLE_SOLID,0,InpBackRect,InpSelection,InpHidden,0)) {
      return;
   }

   // ������ �����
   x_pn = x_coor + 5*x_rect + 6*x_step; y_pn = y_coor + y_rect;
   if (InpCorner == 1)  x_pn = x_coor + x_size - 5*x_step - 5*x_rect;
   if (InpCorner == 2)  y_pn = y_coor + x_step;
   if (InpCorner == 3) {x_pn = x_coor + x_size - 5*x_step - 5*x_rect; y_pn = y_coor + x_step;}
   
   if (!RectLabelCreate(0,obj_name[7],0,x_pn,y_pn,x_rect,y_line,line_2_cl,BORDER_FLAT,InpCorner,
        line_2_cl,STYLE_SOLID,0,InpBackRect,InpSelection,InpHidden,0)) {
      return;
   }
}
//+------------------------------------------------------------------+
//| ������� ������������� �����                                      |
//+------------------------------------------------------------------+
bool RectLabelCreate(const long             chart_ID=0,               // ID �������
                     const string           name="RectLabel",         // ��� �����
                     const int              sub_window=0,             // ����� �������
                     const int              x=0,                      // ���������� �� ��� X
                     const int              y=0,                      // ���������� �� ��� Y
                     const int              width=50,                 // ������
                     const int              height=18,                // ������
                     const color            back_clr=C'236,233,216',  // ���� ����
                     const ENUM_BORDER_TYPE border=BORDER_SUNKEN,     // ��� �������
                     const ENUM_BASE_CORNER corner=CORNER_LEFT_UPPER, // ���� ������� ��� ��������
                     const color            clr=clrRed,               // ���� ������� ������� (Flat)
                     const ENUM_LINE_STYLE  style=STYLE_SOLID,        // ����� ������� �������
                     const int              line_width=1,             // ������� ������� �������
                     const bool             back=false,               // �� ������ �����
                     const bool             selection=false,          // �������� ��� �����������
                     const bool             hidden=true,              // ����� � ������ ��������
                     const long             z_order=0)                // ��������� �� ������� �����
{
   //--- ������� �������� ������
   ResetLastError();
   //--- �������� ������������� �����
   if (ObjectFind(name) == -1)
      ObjectCreate(chart_ID,name,OBJ_RECTANGLE_LABEL,sub_window,0,0);

   ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);              // ��������� ���������� �����
   ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
   ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);              // ��������� ������� �����
   ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
   ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr);         // ��������� ���� ����
   ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_TYPE,border);       // ��������� ��� �������
   ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);            // ��������� ���� �������, ������������ �������� ����� ������������ ���������� �����
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);                // ��������� ���� ������� ����� (� ������ Flat)
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);              // ��������� ����� ����� ������� �����
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,line_width);         // ��������� ������� ������� �������
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);                // ��������� �� �������� (false) ��� ������ (true) �����
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);     // ������� (true) ��� �������� (false) ����� ����������� ����� �����
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);            // ������ (true) ��� ��������� (false) ��� ������������ ������� � ������ ��������
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);           // ��������� ��������� �� ��������� ������� ������� ���� �� �������
   
   return(true);
}
//+------------------------------------------------------------------+
//| ������� ������������� �����                                      |
//+------------------------------------------------------------------+
bool RectLabelDelete(const long   chart_ID=0,       // ID �������
                     const string name="RectLabel") // ��� �����
{
   //--- ������� �������� ������
   ResetLastError();
   //--- ������ �����
   if (ObjectFind(chart_ID,name) >= 0) 
      ObjectDelete(chart_ID,name);
   //--- �������� ����������
   return(true);
}
//+------------------------------------------------------------------+
//| ������� �������� ���� ���� �������.                              |
//+------------------------------------------------------------------+
color ChartBackColorGet(const long chart_ID=0)
  {
//--- ���������� ���������� ��� ��������� �����
   long result=clrNONE;
//--- ������� �������� ������
   ResetLastError();
//--- ������� ���� ���� �������
   if(!ChartGetInteger(chart_ID,CHART_COLOR_BACKGROUND,0,result))
     {
      //--- ������� ��������� �� ������ � ������ "��������"
      Print(__FUNCTION__+", Error Code = ",GetLastError());
     }
//--- ������ �������� �������� �������
   return((color)result);
  }
  
  
//+------------------------------------------------------------------+
//| C������ ������������� �� �������� �����������                    |
//+------------------------------------------------------------------+
bool RectangleCreate(const long            chart_ID=0,        // ID �������
                     const string          name="Rectangle",  // ��� ��������������
                     const int             sub_window=0,      // ����� ������� 
                     datetime              time1=0,           // ����� ������ �����
                     double                price1=0,          // ���� ������ �����
                     datetime              time2=0,           // ����� ������ �����
                     double                price2=0,          // ���� ������ �����
                     const color           clr=clrRed,        // ���� ��������������
                     const ENUM_LINE_STYLE style=STYLE_SOLID, // ����� ����� ��������������
                     const int             width=1,           // ������� ����� ��������������
                     const bool            fill=false,        // ������� �������������� ������
                     const bool            back=false,        // �� ������ �����
                     const bool            selection=true,    // �������� ��� �����������
                     const bool            hidden=true,       // ����� � ������ ��������
                     const long            z_order=0)         // ��������� �� ������� �����
{
   //--- ������� �������� ������
   ResetLastError();
   //--- �������� ������������� �� �������� �����������
   if (ObjectFind(name) == -1)
      ObjectCreate(chart_ID,name,OBJ_RECTANGLE,sub_window,time1,price1,time2,price2);

   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);             //--- ��������� ���� ��������������
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);           //--- ��������� ����� ����� ��������������
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);           //--- ��������� ������� ����� ��������������
   ObjectSetInteger(chart_ID,name,OBJPROP_FILL,fill);             //--- ������� (true) ��� �������� (false) ����� ������� ��������������
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);             //--- ��������� �� �������� (false) ��� ������ (true) ����� 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);  //--- ������� (true) ��� �������� (false) ����� ��������� �������������� ��� �����������
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);    //--- ��� �������� ������������ ������� �������� ObjectCreate, �� ��������� ������
                                                                  //--- ������ �������� � ����������. ������ �� ����� ������ �������� selection
                                                                  //--- �� ��������� ����� true, ��� ��������� �������� � ���������� ���� ������
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);         //--- ������ (true) ��� ��������� (false) ��� ������������ ������� � ������ ��������
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);        //--- ��������� ��������� �� ��������� ������� ������� ���� �� �������

   return(true);
}
//+------------------------------------------------------------------+
//| ������� �������������                                            |
//+------------------------------------------------------------------+
bool RectangleDelete(const long   chart_ID=0,       // ID �������
                     const string name="Rectangle") // ��� ��������������
{
   //--- ������� �������� ������
   ResetLastError();
   //--- ������ �������������
   if (ObjectFind(chart_ID,name) >= 0) 
      ObjectDelete(chart_ID,name);

   return(true);
}
//+------------------------------------------------------------------+
//| ������� ����� ������ �� �������� �����������                     |
//+------------------------------------------------------------------+
bool TrendCreate(const long            chart_ID=0,        // ID �������
                 const string          name="TrendLine",  // ��� �����
                 const int             sub_window=0,      // ����� �������
                 datetime              time1=0,           // ����� ������ �����
                 double                price1=0,          // ���� ������ �����
                 datetime              time2=0,           // ����� ������ �����
                 double                price2=0,          // ���� ������ �����
                 const color           clr=clrRed,        // ���� �����
                 const ENUM_LINE_STYLE style=STYLE_SOLID, // ����� �����
                 const int             width=1,           // ������� �����
                 const bool            back=false,        // �� ������ �����
                 const bool            selection=true,    // �������� ��� �����������
                 const bool            ray_left=false,    // ����������� ����� �����
                 const bool            ray_right=false,   // ����������� ����� ������
                 const bool            hidden=true,       // ����� � ������ ��������
                 const long            z_order=0)         // ��������� �� ������� �����
{
   //--- ������� �������� ������
   ResetLastError();
   //--- �������� ��������� ����� �� �������� �����������
   if (ObjectFind(name) == -1)
      ObjectCreate(chart_ID,name,OBJ_TREND,sub_window,time1,price1,time2,price2);
   
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);             //--- ��������� ���� �����
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);           //--- ��������� ����� ����������� �����
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);           //--- ��������� ������� �����
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);             //--- ��������� �� �������� (false) ��� ������ (true) �����
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);  //--- ������� (true) ��� �������� (false) ����� ����������� ����� �����
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);    //--- ��� �������� ������������ ������� �������� ObjectCreate, �� ��������� ������
                                                                  //--- ������ �������� � ����������. ������ �� ����� ������ �������� selection
                                                                  //--- �� ��������� ����� true, ��� ��������� �������� � ���������� ���� ������
   ObjectSetInteger(chart_ID,name,OBJPROP_RAY_LEFT,ray_left);     //--- ������� (true) ��� �������� (false) ����� ����������� ����������� ����� �����
   ObjectSetInteger(chart_ID,name,OBJPROP_RAY_RIGHT,ray_right);   //--- ������� (true) ��� �������� (false) ����� ����������� ����������� ����� ������
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);         //--- ������ (true) ��� ��������� (false) ��� ������������ ������� � ������ ��������
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);        //--- ��������� ��������� �� ��������� ������� ������� ���� �� �������

   return(true);
}
//+------------------------------------------------------------------+
//| ������� ������� ����� ������ � �������.                          |
//+------------------------------------------------------------------+
bool TrendDelete(const long   chart_ID=0,       // ID �������
                 const string name="TrendLine") // ��� �����
{
   //--- ������� �������� ������
   ResetLastError();
   //--- ������ ����� ������
   if (!ObjectDelete(chart_ID,name))
   {
      Print(__FUNCTION__,
            ": �� ������� ������� ����� ������! ��� ������ = ",GetLastError());
      return(false);
   }
   //--- �������� ����������
   return(true);
}