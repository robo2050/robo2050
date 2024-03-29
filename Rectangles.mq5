//+------------------------------------------------------------------+
//|                                                   Rectangles.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Designed By Arman"
#property link      "robo.2050@gmail.com"
#property version   "1.01"
#property indicator_chart_window
#property script_show_inputs
#property strict
input color clr=clrBlack;
input color LineClr=clrBlack;
input  ENUM_LINE_STYLE style_rect=STYLE_SOLID;
input  ENUM_LINE_STYLE style_line=STYLE_DOT;
input bool Filled_Rectangle = false;
input bool show_ruler=true;


//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
 ChartSetInteger(0,CHART_EVENT_OBJECT_DELETE,0,true);
 ChartSetInteger(0,CHART_EVENT_OBJECT_CREATE,0,true);
 ChartSetInteger(0,CHART_SHOW_OBJECT_DESCR,true);
//---

   return(INIT_SUCCEEDED);
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
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---

   
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
int objnum;
  datetime lastClickTime = 0;
  datetime lastClickTime2= 0; 
  double p1,p2,len; 
  bool flag_zero=false;
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {

         
           
            
          
            int objectType = ObjectGetInteger(0, sparam, OBJPROP_TYPE);
          if ((id==CHARTEVENT_OBJECT_CREATE) ||(id==CHARTEVENT_OBJECT_DRAG))   
          {  // Check if the object is a rectangle (OBJ_RECTANGLE) and Filled and created manually
            if (Filled_Rectangle)
            {
            if ((objectType == OBJ_RECTANGLE)&&(ObjectGetInteger(0,sparam,OBJPROP_FILL))&&(StringFind(sparam,"Rectangle",0)>0))
            {  ObjectSetInteger(0,sparam,OBJPROP_BACK,true);
              double yDistance1,yDistance2;
              datetime xDistance1 =(double) ObjectGetInteger(0, sparam, OBJPROP_TIME,0);
              datetime xDistance2 =(double) ObjectGetInteger(0, sparam, OBJPROP_TIME,1);
              ObjectGetDouble(0, sparam, OBJPROP_PRICE,0,yDistance1);
              ObjectGetDouble(0, sparam, OBJPROP_PRICE,1,yDistance2);
              ObjectSetInteger(0,sparam,OBJPROP_ZORDER,1);
             
              ObjectCreate(0,sparam+"TTTline",OBJ_TREND,0,xDistance1,(yDistance1+yDistance2)/2,xDistance2,(yDistance1+yDistance2)/2);
              ObjectSetInteger(0,sparam+"TTTline",OBJPROP_STYLE,style_line);
              ObjectSetInteger(0,sparam+"TTTline",OBJPROP_COLOR,LineClr);
              ObjectSetInteger(0,sparam+"TTTline",OBJPROP_BACK,true);
              ObjectSetInteger(0,sparam+"TTTline",OBJPROP_ZORDER,0);
             
              ObjectCreate(0,sparam+"RRRect",OBJ_RECTANGLE,0,xDistance1,yDistance1,xDistance2,yDistance2);
              ObjectSetInteger(0,sparam+"RRRect",OBJPROP_FILL,false);
              ObjectSetInteger(0,sparam+"RRRect",OBJPROP_STYLE,style_rect);
              ObjectSetInteger(0,sparam+"RRRect",OBJPROP_COLOR,clr);
              ObjectSetInteger(0,sparam+"RRRect",OBJPROP_BACK,true);
              ObjectSetInteger(0,sparam+"RRRect",OBJPROP_ZORDER,0);
            //  Print(yDistance1);
              
              ObjectSetInteger(0,sparam,OBJPROP_SELECTED,true);
              
            } 
            }else
            { if ((objectType == OBJ_RECTANGLE)&&(!ObjectGetInteger(0,sparam,OBJPROP_FILL))&&(StringFind(sparam,"Rectangle",0)>0))
            {
              double yDistance1,yDistance2;
              datetime xDistance1 =(double) ObjectGetInteger(0, sparam, OBJPROP_TIME,0);
              datetime xDistance2 =(double) ObjectGetInteger(0, sparam, OBJPROP_TIME,1);
              ObjectGetDouble(0, sparam, OBJPROP_PRICE,0,yDistance1);
              ObjectGetDouble(0, sparam, OBJPROP_PRICE,1,yDistance2);
              ObjectSetInteger(0,sparam,OBJPROP_ZORDER,1);
              ObjectCreate(0,sparam+"TTTline",OBJ_TREND,0,xDistance1,(yDistance1+yDistance2)/2,xDistance2,(yDistance1+yDistance2)/2);
              ObjectSetInteger(0,sparam+"TTTline",OBJPROP_STYLE,style_line);
              ObjectSetInteger(0,sparam+"TTTline",OBJPROP_COLOR,LineClr);
              ObjectSetInteger(0,sparam+"TTTline",OBJPROP_BACK,true);
              ObjectSetInteger(0,sparam+"TTTline",OBJPROP_ZORDER,0);
              ObjectCreate(0,sparam+"RRRect",OBJ_RECTANGLE,0,xDistance1,yDistance1,xDistance2,yDistance2);
              ObjectSetInteger(0,sparam+"RRRect",OBJPROP_FILL,true);
              ObjectSetInteger(0,sparam+"RRRect",OBJPROP_STYLE,style_rect);
              ObjectSetInteger(0,sparam+"RRRect",OBJPROP_COLOR,clr);
              ObjectSetInteger(0,sparam+"RRRect",OBJPROP_BACK,true);
              ObjectSetInteger(0,sparam+"RRRect",OBJPROP_ZORDER,0);
             // Print(yDistance1);
              
              ObjectSetInteger(0,sparam,OBJPROP_SELECTED,true);
             
            }
          
            }
          }
        
       
      if (id==CHARTEVENT_OBJECT_DELETE)
      {
      
         ObjectDelete(0,sparam+"TTTline");
         ObjectDelete(0,sparam+"RRRect");
    
      }   
  
       if (id == CHARTEVENT_OBJECT_CLICK)
   {
      // Check if it's a double click
      datetime currentTime = GetTickCount();
      int timeDifference = currentTime - lastClickTime;
       if (StringFind(sparam,"TTTline")>0)    
                                             {string temptext=sparam;
                                             StringReplace(temptext,"TTTline",NULL); 
                                             if (ObjectFind(0,temptext)<0) ObjectDelete(0,sparam); }
       if (StringFind(sparam,"RRRect")>0)    
                                             {string temptext=sparam;
                                             StringReplace(temptext,"RRRect",NULL); 
                                             if (ObjectFind(0,temptext)<0) ObjectDelete(0,sparam); }
      
      if (timeDifference < 300) // Adjust this threshold based on your preference
      {
         Print("Double click detected!");
         // Perform your actions for a double click here
        
         //*************************************************************************************************************************************
         
          if ((objectType == OBJ_TREND)&&(StringFind(sparam,"Trendline",0)>0))
            {
               double trend_price;
               ObjectGetDouble(0,sparam,OBJPROP_PRICE,0,trend_price);
               ObjectSetDouble(0,sparam,OBJPROP_PRICE,1,trend_price);
            }
         //***************************************************************************************************************************************
         else{
         
         datetime t1=(double)ObjectGetInteger(0,sparam,OBJPROP_TIME,0);
         datetime t2=ObjectGetInteger(0,sparam,OBJPROP_TIME,1);
         if (t1<t2)
         {
            ObjectSetInteger(0,sparam,OBJPROP_TIME,1,TimeCurrent()+PeriodSeconds(Period())*10);
            ObjectSetInteger(0,sparam+"TTTline",OBJPROP_TIME,1,TimeCurrent()+PeriodSeconds(Period())*10);
            ObjectSetInteger(0,sparam+"RRRect",OBJPROP_TIME,1,TimeCurrent()+PeriodSeconds(Period())*10);
         }else
         {
            ObjectSetInteger(0,sparam,OBJPROP_TIME,0,TimeCurrent()+PeriodSeconds(Period())*10);
            ObjectSetInteger(0,sparam+"TTTline",OBJPROP_TIME,0,TimeCurrent()+PeriodSeconds(Period())*10);
            ObjectSetInteger(0,sparam+"RRRect",OBJPROP_TIME,0,TimeCurrent()+PeriodSeconds(Period())*10);
         }
         }
         // Reset the last click time
         lastClickTime = 0;
      }
      else
      {
         // Update the last click time for the next check
         lastClickTime = currentTime;
      }
   }
   //************************Ruler***********************************
   
   if (((id==CHARTEVENT_OBJECT_DRAG)||(id==CHARTEVENT_OBJECT_CLICK))&&(show_ruler))
      {
         if (objectType==OBJ_FIBO)
         {
            ObjectGetDouble(0,sparam,OBJPROP_PRICE,0,p1);
            ObjectGetDouble(0,sparam,OBJPROP_PRICE,1,p2);
            len=MathAbs(p2-p1);
           string txt,rm1,rm5,rm15,rh1,rh4,rd1,rw,rmn;
           //*************************************************************
              rm1=IntegerToString(MathRound(10*len/GetAtr(ObjectGetString(0,"TrM1",OBJPROP_TEXT,0))/Point()));
              rm5=IntegerToString(MathRound(10*len/GetAtr(ObjectGetString(0,"TrM5",OBJPROP_TEXT,0))/Point()));
              rm15=IntegerToString(MathRound(10*len/GetAtr(ObjectGetString(0,"TrM15",OBJPROP_TEXT,0))/Point()));
              rh1=IntegerToString(MathRound(10*len/GetAtr(ObjectGetString(0,"TrH1",OBJPROP_TEXT,0))/Point()));
              rh4=IntegerToString(MathRound(10*len/GetAtr(ObjectGetString(0,"TrH4",OBJPROP_TEXT,0))/Point()));
              rd1=IntegerToString(MathRound(10*len/GetAtr(ObjectGetString(0,"TrD1",OBJPROP_TEXT,0))/Point()));
              rw=IntegerToString(MathRound(10*len/GetAtr(ObjectGetString(0,"TrW",OBJPROP_TEXT,0))/Point()));
              rmn=IntegerToString(MathRound(10*len/GetAtr(ObjectGetString(0,"TrMon",OBJPROP_TEXT,0))/Point()));
           //*************************************************************
        /*  if (p2<2)
           {
              rm1=IntegerToString(MathRound(1000000*len/GetAtr(ObjectGetString(0,"TrM1",OBJPROP_TEXT,0))));
              rm5=IntegerToString(MathRound(1000000*len/GetAtr(ObjectGetString(0,"TrM5",OBJPROP_TEXT,0))));
              rm15=IntegerToString(MathRound(1000000*len/GetAtr(ObjectGetString(0,"TrM15",OBJPROP_TEXT,0))));
              rh1=IntegerToString(MathRound(1000000*len/GetAtr(ObjectGetString(0,"TrH1",OBJPROP_TEXT,0))));
              rh4=IntegerToString(MathRound(1000000*len/GetAtr(ObjectGetString(0,"TrH4",OBJPROP_TEXT,0))));
              rd1=IntegerToString(MathRound(1000000*len/GetAtr(ObjectGetString(0,"TrD1",OBJPROP_TEXT,0))));
              rw=IntegerToString(MathRound(1000000*len/GetAtr(ObjectGetString(0,"TrW",OBJPROP_TEXT,0))));
              rmn=IntegerToString(MathRound(1000000*len/GetAtr(ObjectGetString(0,"TrMon",OBJPROP_TEXT,0))));
            } else if (p2<300)
            {
              rm1=IntegerToString(MathRound(10000*len/GetAtr(ObjectGetString(0,"TrM1",OBJPROP_TEXT,0))));
              rm5=IntegerToString(MathRound(10000*len/GetAtr(ObjectGetString(0,"TrM5",OBJPROP_TEXT,0))));
              rm15=IntegerToString(MathRound(10000*len/GetAtr(ObjectGetString(0,"TrM15",OBJPROP_TEXT,0))));
              rh1=IntegerToString(MathRound(10000*len/GetAtr(ObjectGetString(0,"TrH1",OBJPROP_TEXT,0))));
              rh4=IntegerToString(MathRound(10000*len/GetAtr(ObjectGetString(0,"TrH4",OBJPROP_TEXT,0))));
              rd1=IntegerToString(MathRound(10000*len/GetAtr(ObjectGetString(0,"TrD1",OBJPROP_TEXT,0))));
              rw=IntegerToString(MathRound(10000*len/GetAtr(ObjectGetString(0,"TrW",OBJPROP_TEXT,0))));
              rmn=IntegerToString(MathRound(10000*len/GetAtr(ObjectGetString(0,"TrMon",OBJPROP_TEXT,0))));
           } else 
            {
              rm1=IntegerToString(MathRound(1000*len/GetAtr(ObjectGetString(0,"TrM1",OBJPROP_TEXT,0))));
              rm5=IntegerToString(MathRound(1000*len/GetAtr(ObjectGetString(0,"TrM5",OBJPROP_TEXT,0))));
              rm15=IntegerToString(MathRound(1000*len/GetAtr(ObjectGetString(0,"TrM15",OBJPROP_TEXT,0))));
              rh1=IntegerToString(MathRound(1000*len/GetAtr(ObjectGetString(0,"TrH1",OBJPROP_TEXT,0))));
              rh4=IntegerToString(MathRound(1000*len/GetAtr(ObjectGetString(0,"TrH4",OBJPROP_TEXT,0))));
              rd1=IntegerToString(MathRound(1000*len/GetAtr(ObjectGetString(0,"TrD1",OBJPROP_TEXT,0))));
              rw=IntegerToString(MathRound(1000*len/GetAtr(ObjectGetString(0,"TrW",OBJPROP_TEXT,0))));
              rmn=IntegerToString(MathRound(1000*len/GetAtr(ObjectGetString(0,"TrMon",OBJPROP_TEXT,0))));
           } 
         */   
            
            if (Period()==PERIOD_M1)
            {
               ObjectSetString(0,sparam,OBJPROP_LEVELTEXT,0,"M1: "+rm1+"%"+"  M5: "+rm5+"%"+"  M15: "+rm15+"%");
            }
             if (Period()==PERIOD_M5)
            {
                ObjectSetString(0,sparam,OBJPROP_LEVELTEXT,0,"M5: "+rm5+"%"+"  M15: "+rm15+"%"+"  H1: "+rh1+"%");
            } if (Period()==PERIOD_M15)
            {
                ObjectSetString(0,sparam,OBJPROP_LEVELTEXT,0,"M15: "+rm15+"%"+"  H1: "+rh1+"%"+"  H4: "+rh4+"%");
            } if (Period()==PERIOD_H1)
            {
                 ObjectSetString(0,sparam,OBJPROP_LEVELTEXT,0,"H1: "+rh1+"%"+"  H4: "+rh4+"%"+"  D1: "+rd1+"%"); 
            } if (Period()==PERIOD_H4)
            {
                   ObjectSetString(0,sparam,OBJPROP_LEVELTEXT,0,"H4: "+rh4+"%"+"  D1: "+rd1+"%"+"  W1: "+rw+"%");
            }
             if (Period()==PERIOD_D1)
            {
                   ObjectSetString(0,sparam,OBJPROP_LEVELTEXT,0,"D1: "+rd1+"%"+"  W1: "+rw+"%"+"  Mn: "+rmn+"%");
            } if (Period()==PERIOD_W1)
            {
                   ObjectSetString(0,sparam,OBJPROP_LEVELTEXT,0,"W1: "+rw+"%"+"  Mn: "+rmn+"%");
            } if (Period()==PERIOD_MN1)
            {
                   ObjectSetString(0,sparam,OBJPROP_LEVELTEXT,0,"Mn: "+rmn+"%");
            }
           // Print(len);
         }
      }
   }
//+------------------------------------------------------------------+
   int GetAtr(string txt)
   {
   
      return(StringToInteger(StringSubstr(txt,5,-1)));
   }