
 //+------------------------------------------------------------------+ 
 //| BaseCandle.mq5 | //| | //| This indicator finds and marks the base candles on the chart. |
  //+------------------------------------------------------------------+ 
  #property indicator_chart_window
   #property indicator_buffers 2
    #property indicator_plots 2 
    //--- plot UpBase #property indicator_label1 "UpBase" 
 

       double UpBaseBuffer[];
        double DownBaseBuffer[];
        bool flag=true;
        //+------------------------------------------------------------------+ 
        //| Custom indicator initialization function | 
        //+------------------------------------------------------------------+ 
        double po1,po2,po3,po4,ph1,ph2,ph3,ph4,pl1,pl2,pl3,pl4,pc1,pc2,pc3,pc4;
        datetime to,tc;
        int shb=0;
        input int Number_Bars=10;
        input bool ActiveAlert=true;
        input color ArrowColor = clrRed;
        enum bn {Two_Candles =2,Three_Candles=3};
        input bn base_number=Three_Candles;
        ENUM_TIMEFRAMES TF_Bar;
        int OnInit()
         { 
             for (int i=0;i<=Number_Bars;i++) ObjectDelete(0,"pointer"+DoubleToString(i));  
            flag=true;
           return(INIT_SUCCEEDED); 
           }
           
         void OnDeinit()
         {
            for (int i=0;i<=Number_Bars;i++) ObjectDelete(0,"pointer"+DoubleToString(i));  
            
         }
 string cp(ENUM_TIMEFRAMES  currentPeriod)
   {
   // Get the current period (timeframe) of the chart in seconds
  
   // Convert the period from seconds to a string for printing
   string periodString;
   if (currentPeriod == PERIOD_M1) periodString = "M1";
   else if (currentPeriod == PERIOD_M5) periodString = "M5";
   else if (currentPeriod == PERIOD_M15) periodString = "M15";
   else if (currentPeriod == PERIOD_M30) periodString = "M30";
   else if (currentPeriod == PERIOD_H1) periodString = "H1";
   else if (currentPeriod == PERIOD_H4) periodString = "H4";
   else if (currentPeriod == PERIOD_D1) periodString = "D1";
   else if (currentPeriod == PERIOD_W1) periodString = "W1";
   else if (currentPeriod == PERIOD_MN1) periodString = "MN1";
   else periodString = "Unknown Period";

   // Print the current period
   return(periodString);
   }
            //+------------------------------------------------------------------+
             //| Custom indicator iteration function |
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
              
               shb=0;
            //for (int i=0;i<=Number_Bars;i++) ObjectDelete(0,"pointer"+DoubleToString(i));
            while ((shb<Number_Bars)&&(flag))
            {
                
               TF_Bar=Period();
               to = iTime(Symbol(), TF_Bar, shb);                    // Время открытия
           //    tc = iTime(Symbol(), TF_Bar, shb) + PeriodSeconds(TF_Bar);      // Время закрытия
               po1 = iOpen(Symbol(), TF_Bar, shb);                    // Цена открытия
               pc1 = iClose(Symbol(), TF_Bar, shb);                   // Цена закрытия
               ph1 = iHigh(Symbol(), TF_Bar, shb);                    // Цена максимальная
               pl1 = iLow(Symbol(), TF_Bar, shb);                     // Цена минимальная
               
               po2 = iOpen(Symbol(), TF_Bar, shb+1);                    // Цена открытия
               pc2 = iClose(Symbol(), TF_Bar, shb+1);                   // Цена закрытия
               ph2 = iHigh(Symbol(), TF_Bar, shb+1);                    // Цена максимальная
               pl2 = iLow(Symbol(), TF_Bar, shb+1);                     // Цена минимальная
               
               po3 = iOpen(Symbol(), TF_Bar, shb+2);                    // Цена открытия
               pc3 = iClose(Symbol(), TF_Bar, shb+2);                   // Цена закрытия
               ph3 = iHigh(Symbol(), TF_Bar, shb+2);                    // Цена максимальная
               pl3 = iLow(Symbol(), TF_Bar, shb+2);                     // Цена минимальная
               
               po4 = iOpen(Symbol(), TF_Bar, shb+3);                    // Цена открытия
               pc4 = iClose(Symbol(), TF_Bar, shb+3);                   // Цена закрытия
               ph4 = iHigh(Symbol(), TF_Bar, shb+3);                    // Цена максимальная
               pl4 = iLow(Symbol(), TF_Bar, shb+3);                     // Цена минимальная
               
               
              if ((po1<=ph2)&&
                  (pc1<=ph2)&&
                  (po1>=pl2)&&
                  (pc1>=pl2))
                  {
                   if ((po2<=ph3)&&
                     (pc2<=ph3)&&
                     (po2>=pl3)&&
                     (pc2>=pl3))
                     { 
                       if (base_number==Three_Candles)
                       {    
                         if ((po3<=ph4)&&
                           (pc3<=ph4)&&
                           (po3>=pl4)&&
                           (pc3>=pl4))
                           {
                                 
                                 if (ActiveAlert)  Alert("Base Found in "+Symbol()+" in Timeframe : "+cp(Period()));
                                  
                                  ObjectCreate(0,"pointer"+DoubleToString(shb),OBJ_ARROW_UP,0,to,MathMin(MathMin(MathMin(pl1,pl2),pl3),pl4));
                                  ObjectSetInteger(0,"pointer"+DoubleToString(shb),OBJPROP_COLOR,ArrowColor);
                                  ObjectSetInteger(0,"pointer"+DoubleToString(shb),OBJPROP_BACK,true);
                               //   Print("Base Found in "+Symbol()+" in Timeframe : "+cp(Period()));
                                  shb=shb+3;
                                  
                                  
                            }
                            }
                            else if (base_number==Two_Candles)
                            {
                                if (ActiveAlert)  Alert("Base Found in "+Symbol()+" in Timeframe : "+cp(Period()));
                                  
                                  ObjectCreate(0,"pointer"+DoubleToString(shb),OBJ_ARROW_UP,0,to,MathMin(MathMin(MathMin(pl1,pl2),pl3),pl4));
                                  ObjectSetInteger(0,"pointer"+DoubleToString(shb),OBJPROP_COLOR,ArrowColor);
                                  ObjectSetInteger(0,"pointer"+DoubleToString(shb),OBJPROP_BACK,true);
                              //    Print("Base Found in "+Symbol()+" in Timeframe : "+cp(Period()));
                                  shb=shb+3;
                                  
                            }
                     }
                   }
           shb++;
           }flag=false;
                    return(rates_total); 
                    
                    }
