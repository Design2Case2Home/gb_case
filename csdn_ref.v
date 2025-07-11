`timescale 1ns / 1ps


module vga(clk,yidong,disp_rgb,hsync,vsync,flag);
input       clk;						//系统时钟
input [4:0] yidong;					//四个按键
input [0:0] flag;
output[11:0] disp_rgb;
output      hsync,
            vsync;

reg[11:0]    hcount;    	//行信号
reg[11:0]    vcount;		//列信号
reg[11:0]    data;
reg[11:0]    h_dat;  			//12位的色素显示变量
reg[11:0]    z_dat;				
reg[11:0]    y_dat;
reg[11:0]    v_dat;
reg[11:0]    x_dat;
reg         over=0;				//游戏是否结束标志
wire        hcount_ov;
wire        vcount_ov;
wire        dat_act;
wire        hsync;
wire        vsync;
reg         vga_clk=0;
reg         clk_50ms=0;
reg         cnt_clk=0;
localparam DVSR=7000000;                //分频计数的阈值
 reg [28:0] js;				//分频信号的中间计数变量
reg [9:0] R [9:0];			//10X10的数组
reg [99:0] U;				//每个格子的状态标志
 reg[9:0]xsync,ysync;
 wire [11:0]x_pos, y_pos;
 

 wire [9:0]a;					
wire [9:0]b;

 //表示每个格子在100个格子的位置
wire [9:0]c;
wire [9:0]d;

wire [99:0] x;

assign         a=(hcount-220)/40;
assign         b=(vcount-70)/40;

 //计算每个格子在100个格子的位置
assign         c=(ball_x_pos-240)/40;
assign         d=(ball_y_pos-90)/40;


//一百个格子嘛
assign x[0] = ((hcount - 240)*(hcount - 240)+(vcount - 90)*(vcount - 90))<=400;
assign x[1] =((hcount - 280)*(hcount - 280)+(vcount - 90)*(vcount - 90))<=400;
assign x[2] =( (hcount - 320)*(hcount - 320)+(vcount - 90)*(vcount - 90))<=400;
assign x[3] = ((hcount - 360)*(hcount - 360)+(vcount - 90)*(vcount - 90))<=400;
assign x[4] =( (hcount - 400)*(hcount - 400)+(vcount - 90)*(vcount - 90))<=400;
assign x[5] = ((hcount - 440)*(hcount - 440)+(vcount - 90)*(vcount - 90))<=400;
assign x[6] = ((hcount - 480)*(hcount - 480)+(vcount - 90)*(vcount - 90))<=400;
assign x[7] = ((hcount - 520)*(hcount - 520)+(vcount - 90)*(vcount - 90))<=400;
assign x[8] =( (hcount - 560)*(hcount - 560)+(vcount - 90)*(vcount - 90))<=400;
assign x[9] = ((hcount - 600)*(hcount - 600)+(vcount - 90)*(vcount - 90))<=400;
assign x[10] = (hcount - 240)*(hcount - 240)+(vcount - 130)*(vcount - 130)<=400;
assign x[11] =  (hcount - 280)*(hcount - 280)+(vcount - 130)*(vcount - 130)<=400;
assign x[12] = (hcount - 320)*(hcount - 320)+(vcount - 130)*(vcount - 130)<=400;
assign x[13] =  (hcount - 360)*(hcount -360)+(vcount - 130)*(vcount - 130)<=400;
assign x[14] =  (hcount - 400)*(hcount - 400)+(vcount - 130)*(vcount - 130)<=400;
assign x[15] =  (hcount - 440)*(hcount - 440)+(vcount - 130)*(vcount - 130)<=400;
assign x[16] =  (hcount - 480)*(hcount -480)+(vcount - 130)*(vcount - 130)<=400;
assign x[17] =  (hcount -520)*(hcount - 520)+(vcount - 130)*(vcount - 130)<=400;
assign x[18] =  (hcount - 560)*(hcount - 560)+(vcount - 130)*(vcount - 130)<=400;
assign x[19] = (hcount - 600)*(hcount - 600)+(vcount - 130)*(vcount - 130)<=400;
assign x[20] = (hcount - 240)*(hcount - 240)+(vcount -170)*(vcount - 170)<=400;
assign x[21] = (hcount - 280)*(hcount - 280)+(vcount -170)*(vcount - 170)<=400;
assign x[22] = (hcount -320)*(hcount - 320)+(vcount -170)*(vcount - 170)<=400;
assign x[23] = (hcount -360)*(hcount - 360)+(vcount -170)*(vcount - 170)<=400;
assign x[24] =(hcount -400)*(hcount - 400)+(vcount -170)*(vcount - 170)<=400;
assign x[25] =(hcount - 440)*(hcount - 440)+(vcount -170)*(vcount - 170)<=400;
assign x[26] = (hcount - 480)*(hcount - 480)+(vcount -170)*(vcount - 170)<=400;
assign x[27] = (hcount - 520)*(hcount - 520)+(vcount -170)*(vcount - 170)<=400;
assign x[28] =(hcount - 560)*(hcount -560)+(vcount -170)*(vcount - 170)<=400;
assign x[29] =(hcount - 600)*(hcount - 600)+(vcount -170)*(vcount - 170)<=400;
assign x[30] = (hcount - 240)*(hcount - 240)+(vcount - 210)*(vcount - 210)<=400;
assign x[31] =(hcount - 280)*(hcount - 280)+(vcount - 210)*(vcount - 210)<=400;
assign x[32] =(hcount - 320)*(hcount - 320)+(vcount - 210)*(vcount - 210)<=400;
assign x[33] = (hcount - 360)*(hcount - 360)+(vcount - 210)*(vcount - 210)<=400;
assign x[34] =(hcount - 400)*(hcount - 400)+(vcount - 210)*(vcount - 210)<=400;
assign x[35] = (hcount - 440)*(hcount - 440)+(vcount - 210)*(vcount - 210)<=400;
assign x[36] = (hcount - 480)*(hcount -480)+(vcount - 210)*(vcount - 210)<=400;
assign x[37] = (hcount - 520)*(hcount - 520)+(vcount - 210)*(vcount - 210)<=400;
assign x[38] =(hcount - 560)*(hcount - 560)+(vcount - 210)*(vcount - 210)<=400;
assign x[39] =(hcount - 600)*(hcount - 600)+(vcount - 210)*(vcount - 210)<=400;
assign x[40] = (hcount - 240)*(hcount - 240)+(vcount - 250)*(vcount - 250)<=400;
assign x[41] = (hcount - 280)*(hcount - 280)+(vcount - 250)*(vcount - 250)<=400;
assign x[42] =  (hcount - 320)*(hcount - 320)+(vcount - 250)*(vcount - 250)<=400;
assign x[43] =  (hcount - 360)*(hcount - 360)+(vcount - 250)*(vcount - 250)<=400;
assign x[44] =  (hcount - 400)*(hcount - 400)+(vcount - 250)*(vcount - 250)<=400;
assign x[45] =  (hcount - 440)*(hcount - 440)+(vcount - 250)*(vcount - 250)<=400;
assign x[46] =  (hcount - 480)*(hcount -480)+(vcount - 250)*(vcount - 250)<=400;
assign x[47] =  (hcount - 520)*(hcount - 520)+(vcount - 250)*(vcount - 250)<=400;
assign x[48] = (hcount - 560)*(hcount -560)+(vcount - 250)*(vcount - 250)<=400;
assign x[49] =  (hcount - 600)*(hcount -600)+(vcount - 250)*(vcount - 250)<=400;
assign x[50] = (hcount - 240)*(hcount - 240)+(vcount - 290)*(vcount - 290)<=400;
assign x[51] =  (hcount - 280)*(hcount - 280)+(vcount - 290)*(vcount - 290)<=400;
assign x[52] =  (hcount - 320)*(hcount - 320)+(vcount - 290)*(vcount - 290)<=400;
assign x[53] =  (hcount - 360)*(hcount - 360)+(vcount - 290)*(vcount - 290)<=400;
assign x[54] =  (hcount - 400)*(hcount -400)+(vcount - 290)*(vcount - 290)<=400;
assign x[55] =  (hcount - 440)*(hcount - 440)+(vcount - 290)*(vcount - 290)<=400;
assign x[56] =  (hcount -480)*(hcount - 480)+(vcount - 290)*(vcount - 290)<=400;
assign x[57] = (hcount - 520)*(hcount - 520)+(vcount - 290)*(vcount - 290)<=400;
assign x[58] =  (hcount - 560)*(hcount - 560)+(vcount - 290)*(vcount - 290)<=400;
assign x[59] =  (hcount - 600)*(hcount - 600)+(vcount - 290)*(vcount - 290)<=400;
assign x[60] = (hcount - 240)*(hcount - 240)+(vcount -330)*(vcount - 330)<=400;
assign x[61] = (hcount - 280)*(hcount - 280)+(vcount -330)*(vcount - 330)<=400;
assign x[62] = (hcount -320)*(hcount - 320)+(vcount -330)*(vcount - 330)<=400;
assign x[63] = (hcount - 360)*(hcount - 360)+(vcount -330)*(vcount - 330)<=400;
assign x[64] = (hcount - 400)*(hcount - 400)+(vcount -330)*(vcount - 330)<=400;
assign x[65] =(hcount - 440)*(hcount - 440)+(vcount -330)*(vcount - 330)<=400;
assign x[66] = (hcount - 480)*(hcount - 480)+(vcount -330)*(vcount - 330)<=400;
assign x[67] =(hcount - 520)*(hcount -520)+(vcount -330)*(vcount - 330)<=400;
assign x[68] = (hcount -560)*(hcount - 560)+(vcount -330)*(vcount - 330)<=400;
assign x[69] =(hcount - 600)*(hcount - 600)+(vcount -330)*(vcount - 330)<=400;
assign x[70] = (hcount - 240)*(hcount - 240)+(vcount - 370)*(vcount - 370)<=400;
assign x[71] = (hcount - 280)*(hcount - 280)+(vcount - 370)*(vcount - 370)<=400;
assign x[72] =(hcount - 320)*(hcount - 320)+(vcount - 370)*(vcount - 370)<=400;
assign x[73] =(hcount -360)*(hcount - 360)+(vcount - 370)*(vcount - 370)<=400;
assign x[74] = (hcount - 400)*(hcount - 400)+(vcount - 370)*(vcount - 370)<=400;
assign x[75] =(hcount - 440)*(hcount - 440)+(vcount - 370)*(vcount - 370)<=400;
assign x[76] = (hcount - 480)*(hcount - 480)+(vcount - 370)*(vcount - 370)<=400;
assign x[77] =(hcount - 520)*(hcount - 520)+(vcount - 370)*(vcount - 370)<=400;
assign x[78] =(hcount - 560)*(hcount -560)+(vcount - 370)*(vcount - 370)<=400;
assign x[79] = (hcount - 600)*(hcount - 600)+(vcount - 370)*(vcount - 370)<=400;
assign x[80] = (hcount - 240)*(hcount - 240)+(vcount - 410)*(vcount -410)<=400;
assign x[81] = (hcount - 280)*(hcount - 280)+(vcount - 410)*(vcount -410)<=400;
assign x[82] = (hcount - 320)*(hcount - 320)+(vcount - 410)*(vcount -410)<=400;
assign x[83] = (hcount - 360)*(hcount - 360)+(vcount - 410)*(vcount -410)<=400;
assign x[84] =(hcount - 400)*(hcount - 400)+(vcount - 410)*(vcount -410)<=400;
assign x[85] = (hcount - 440)*(hcount - 440)+(vcount - 410)*(vcount -410)<=400;
assign x[86] = (hcount - 480)*(hcount - 480)+(vcount - 410)*(vcount -410)<=400;
assign x[87] =(hcount - 520)*(hcount - 520)+(vcount - 410)*(vcount -410)<=400;
assign x[88] = (hcount - 560)*(hcount - 560)+(vcount - 410)*(vcount -410)<=400;
assign x[89] = (hcount - 600)*(hcount - 600)+(vcount - 410)*(vcount -410)<=400;
assign x[90] = (hcount - 240)*(hcount - 240)+(vcount - 450)*(vcount - 450)<=400;
assign x[91] = (hcount - 280)*(hcount - 280)+(vcount - 450)*(vcount -450)<=400;
assign x[92] = (hcount - 320)*(hcount -320)+(vcount -450)*(vcount - 450)<=400;
assign x[93] = (hcount - 360)*(hcount - 360)+(vcount - 450)*(vcount - 450)<=400;
assign x[94] = (hcount - 400)*(hcount - 400)+(vcount - 450)*(vcount - 450)<=400;
assign x[95] = (hcount - 440)*(hcount - 440)+(vcount -450)*(vcount - 450)<=400;
assign x[96] = (hcount - 480)*(hcount - 480)+(vcount - 450)*(vcount - 450)<=400;
assign x[97] = (hcount - 520)*(hcount - 520)+(vcount -450)*(vcount - 450)<=400;
assign x[98] = (hcount - 560)*(hcount - 560)+(vcount -450)*(vcount -450)<=400;
assign x[99] = (hcount - 600)*(hcount - 600)+(vcount - 450)*(vcount - 450)<=400;


//VGA行，场扫描时序参数表
parameter 
hsync_end = 10'd95,
hdat_begin = 10'd143,
hdat_end   = 10'd783,
hpixel_end = 10'd799,
vsync_end  = 10'd1,
vdat_begin = 10'd34,
vdat_end   = 10'd514,
vline_end  = 10'd524; 
parameter ball_r=20;
always@(posedge clk)
begin
     if(cnt_clk == 1)
       begin
          vga_clk <= ~vga_clk;
          cnt_clk <= 0;
       end
      else
          cnt_clk <= cnt_clk + 1;
end             


/**********VGA驱动**********/
//行扫描
always@(posedge vga_clk)
begin
     if(hcount_ov)
        hcount <= 10'd0;
     else
        hcount <= hcount + 10'd1;
end
assign hcount_ov = (hcount == hpixel_end);

//场扫描
always@(posedge vga_clk)
begin
     if(hcount_ov)
     begin
        if(vcount_ov)
           vcount <= 10'd0;
        else
           vcount <= vcount + 10'd1;
     end
end
assign vcount_ov = (vcount == vline_end);
 
//数据、同步信号输入
assign dat_act = ((hcount >= hdat_begin) && (hcount < hdat_end)) && ((vcount > vdat_begin) && (vcount<vdat_end));
assign hsync   = (hcount > hsync_end);                    
assign vsync   = (vcount > vsync_end);
assign disp_rgb = (dat_act)?data:3'h000;         


//显示模块 
always@(posedge vga_clk)
begin
  if(over==0)
   data <=v_dat&h_dat&x_dat&y_dat;    //与计算显示色素块
   else
   data <=z_dat;    			//游戏结束则显示另外画面
end


 parameter  WIDTH = 40, //矩形长
            HEIGHT = 40,  //矩形宽         
            
          //显示区域的边界  （显示屏上总的显色区域）
            DISV_TOP = 10'd470,  
            DISV_DOWN =10'd70,  
            DISH_LEFT = 10'd220, 
            DISH_RIGHT = 10'd620;               
                  
              //变色区域（棋格）_右边界=左边界+格子宽度                   
            reg [9:0] ball_y_pos = 10'd90 ;
            reg [9:0] ball_x_pos = 10'd240 ;
            reg [9:0] rightbound = DISH_LEFT + WIDTH ;	 
       
//对100MHz的系统时钟进行分频
always @ (posedge clk)					
begin
         if(js==DVSR)
          begin
           js<=0;
           clk_50ms=~clk_50ms;
          end
        else
           begin
           js<=js+1;
           end 
end

//按键控制棋子移动
//每次按下改变待选择棋子的边界坐标
always@(posedge clk_50ms)
begin
    case(yidong[4:0])
         5'b00100:begin 
                                          if (ball_x_pos== 10'd240)
                                                 ball_x_pos<=10'd600;
                                             else 
                                                ball_x_pos<=ball_x_pos-10'd40;
                    end
         5'b01000:begin 
                                          if (ball_x_pos==10'd600)
                                                ball_x_pos<=10'd240;
                                             else 
                                                 ball_x_pos<= ball_x_pos+10'd40;
                                         end 
        5'b00001: begin 
                                           if (ball_y_pos== 10'd90)
                                               ball_y_pos<=10'd450;
                                           else 
                                                ball_y_pos<=ball_y_pos-10'd40;                                                
                                                 end
       5'b00010: begin
                                           if(ball_y_pos== 10'd450)
                                           ball_y_pos<=10'd90;
                                           else         
                                           ball_y_pos<=ball_y_pos+10'd40; 
                                           end      
       5'b10000: begin
                                          if(R[d][c]==0)
                                          begin
                                             R[d][c]<=1;                                     
                                              U[d*10+c]<=flag[0];
                                          end
                                           end     
         default: rightbound<=10'd220;
     endcase
end

//棋盘区域判断及上色
always@(posedge vga_clk)
begin
      if ( (hcount - ball_x_pos)*(hcount - ball_x_pos) + (vcount- ball_y_pos)*(vcount - ball_y_pos) <= (ball_r * ball_r)) 
        x_dat<= 12'h0ff;        
    else if (x[b*10+a]&&R[b][a]&&U[b*10+a])
    begin
           x_dat<= 12'hfff;
           y_dat <= 12'hf0f;
           end
    else if (x[b*10+a]&&R[b][a])
    begin
           x_dat<= 12'hfff;
           y_dat <= 12'hff0;
           end       
     else 
     begin
                x_dat<= 12'hfff;
               y_dat <= 12'hfff;         
           end    
end


//产生竖长条
always@(posedge vga_clk)
begin
    if(hcount<=200||hcount>=640)
	v_dat <= 12'h000;//hei
    else if(hcount ==240||hcount ==280||hcount ==320||hcount ==360||hcount ==400||hcount ==440||hcount ==480||hcount ==520||hcount==560||hcount==600)
      v_dat <= 12'h000;//hei
   else 
     v_dat <= 12'hfff;//bai
end


//产生横长条
always@(posedge vga_clk)
begin
    if(vcount<=50||vcount>=490)
	h_dat <= 12'h000;//hei
    else if(vcount ==90||vcount ==130||vcount ==170||vcount==210 ||vcount==250||vcount ==290||vcount ==330||vcount==370 ||vcount==410||vcount==450)
      h_dat <= 12'h000;//hei
   else
     h_dat <= 12'hfff;//bai
end  

//输赢状态判断
always@(posedge vga_clk)
begin
    if(b<=5&&U[b*10+a]==1&&U[b*10+a+1]==1&&U[b*10+a+2]==1&&U[b*10+a+3]==1&&U[b*10+a+4]==1)//heng
    over=1;
    else if(a<=5&&U[b*10+a]==1&&U[b*10+a+10]==1&&U[b*10+a+20]==1&&U[b*10+a+30]==1&&U[b*10+a+40]==1)//shu
    over=1;
    else if(a<=5&&b<=5&&U[b*10+a]==1&&U[b*10+a+11]==1&&U[b*10+a+22]==1&&U[b*10+a+33]==1&&U[b*10+a+44]==1)//chenggong
    over=1;
    else if(b<=5&&a>=4&&U[b*10+a]==1&&U[b*10+a+9]==1&&U[b*10+a+18]==1&&U[b*10+a+27]==1&&U[b*10+a+36]==1)
    over=1;
end        


//产生黑线（格子之间的黑线）
always@(posedge vga_clk)
begin
    if(((hcount>=240&&hcount<=260)||(hcount>=300&&hcount<=320)||(hcount>=360&&hcount<=380)||(hcount>=420&&hcount<=440)||(hcount>=480&&hcount<=500)||(hcount>=560&&hcount<=580))&&(vcount >=200&&vcount <=360))
	z_dat <= 12'h0f0;//hei
    else if(hcount>=260&&hcount<=380&&vcount>=340&&vcount <=360)
      z_dat <= 12'h0f0;
      else if(hcount>=500&&hcount<=560&&vcount>=200&&vcount <=220)
      z_dat <= 12'h0f0;
   else
     z_dat <= 12'hfff;
end       
//阿汪先生的博客.ws                                                              
endmodule

