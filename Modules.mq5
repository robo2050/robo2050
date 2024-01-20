//+------------------------------------------------------------------+
//|                                                      Modules.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_chart_window

//input int X=300;//Module X Position
//input int Y=300;//Module Y Position
input int x=100;//TextBox X Position
input int y=335;//TextBox Y Position
input int width=80; // Width of Textbox 
input int height=30; // Height of Textbox
input color clr=clrNavy; // Textbox Background Color
input color txtclr=clrGold;// Text Color
input bool flag=true;//Show Alert
input bool bc=true;// Modules On Background
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
datetime tempt1,tempt2;
double tempp1,tempp2;
int w=0,X=0,Y=0;

int OnInit()
  {
//--- indicator buffers mapping
if (ObjectFind(0,"module")<0)
{
   ObjectCreate(0,"module",OBJ_EDIT,0,iTime(NULL,0,0),1);
   ObjectSetString(0,"module",OBJPROP_TEXT,"");

       
   
  
   
 }//  ObjectSetInteger(0,"envrec",OBJPROP_XDISTANCE,x);
  // ObjectSetInteger(0,"envrec",OBJPROP_YDISTANCE,y);
  //ObjectSetInteger(0,"envrec",OBJPROP_XSIZE,width*1.2);
 //  ObjectSetInteger(0,"envrec",OBJPROP_YSIZE,height*1.2);
    // ObjectSetInteger(0,"envrec",OBJPROP_CORNER,CORNER_RIGHT_LOWER);
  
    ObjectSetInteger(0,"module",OBJPROP_BGCOLOR,clr);
   ObjectSetInteger(0,"module",OBJPROP_COLOR,txtclr);
  ObjectSetInteger(0,"module",OBJPROP_CORNER,CORNER_RIGHT_LOWER);
  ObjectSetString(0,"module",OBJPROP_FONT,"tahoma bold");
  ObjectSetInteger(0,"module",OBJPROP_XSIZE,width);
   ObjectSetInteger(0,"module",OBJPROP_YSIZE,height);
  ObjectSetInteger(0,"module",OBJPROP_XDISTANCE,x);
   ObjectSetInteger(0,"module",OBJPROP_YDISTANCE,y);
   ObjectSetInteger(0,"module",OBJPROP_BORDER_TYPE,BORDER_SUNKEN);
   
//---

    /*         // datetime tempt1 =(double) ObjectGetInteger(0, "module", OBJPROP_TIME,0);
           //   datetime tempt2 =(double) ObjectGetInteger(0, "module", OBJPROP_TIME,1);
          //    ObjectGetDouble(0, "module", OBJPROP_PRICE,0,tempp1);
         //     ObjectGetDouble(0, "module", OBJPROP_PRICE,1,tempp2);    
                  ChartXYToTimePrice(0,x,y-10,w,tempt1,tempp1);
                 ChartXYToTimePrice(0,x+width,y+height,w,tempt2,tempp2);
               ObjectCreate(0,"envrec",OBJ_RECTANGLE,w,tempt1,tempp1,tempt2,tempp2);
               ObjectSetInteger(0,"envrec",OBJPROP_WIDTH,4);
               ObjectSetInteger(0,"envrec",OBJPROP_FILL,true);
               ObjectSetInteger(0,"envrec",OBJPROP_COLOR,clrRoyalBlue);
               ObjectSetString(0,"envrec",OBJPROP_TEXT,"Enter Module");
               
               
               
      */         
               //  ObjectSetInteger(0,"envrec",OBJPROP_CORNER,CORNER_LEFT_UPPER);
               ObjectCreate(0,"envrectext",OBJ_LABEL,w,0,0);
                 ObjectSetInteger(0,"envrectext",OBJPROP_XDISTANCE,x);
                    ObjectSetInteger(0,"envrectext",OBJPROP_YDISTANCE,y+(height*0.7));
               ObjectSetString(0,"envrectext",OBJPROP_TEXT,"Enter Module");
                    ObjectSetInteger(0,"envrectext",OBJPROP_COLOR,clr);
               
                 ObjectSetInteger(0,"envrectext",OBJPROP_CORNER,CORNER_RIGHT_LOWER);
               
               
   return(INIT_SUCCEEDED);
  }
  
void OnDeinit(const int reason)
{
if (reason==REASON_REMOVE)
 {
   ObjectDelete(0,"module");
   ObjectDelete(0,"BMP");ObjectDelete(0,"envrectext");
   }
}
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const int begin,
                const double &price[])
  {
//---
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
string loc;
datetime t;
double p;

void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
if (id==CHARTEVENT_KEYDOWN)
   {
      if (lparam==13)
      {
   loc="Modules\\"+ObjectGetString(0,"module",OBJPROP_TEXT)+".bmp";
 //  loc="c:\SG1.bmp";
  // Print((loc));
   // if (FileIsExist(loc))
      {
       ChartXYToTimePrice(0,X,Y,w,t,p);
         ObjectCreate(0,"BMP",OBJ_BITMAP_LABEL,w,t,p);
         ObjectSetInteger(0,"BMP",OBJPROP_ANCHOR,ANCHOR_RIGHT_LOWER);
         ObjectSetInteger(0,"BMP",OBJPROP_CORNER,CORNER_RIGHT_LOWER);
         ObjectSetInteger(0,"BMP",OBJPROP_BACK,bc);
         ObjectSetInteger(0,"BMP",OBJPROP_ZORDER,-1);
         
        if(!ObjectSetString(0,"BMP",OBJPROP_BMPFILE,loc)) 
     { 
    if (flag)  Alert(__FUNCTION__,": failed to load the image!  Address : MQL5\\Indicators\\"+loc);
     ObjectDelete(0,"BMP");       
     }  
      }
    //  else ObjectDelete(0,"BMP");
 }
   }
  }
//+------------------------------------------------------------------+
