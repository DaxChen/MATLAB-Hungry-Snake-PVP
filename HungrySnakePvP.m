function HungrySnakePvP

%--------------------------------------------------------------------------
%Snake
%Version 1.00
%Created by Stepen
%Created 26 November 2011
%Last modified 4 December 2012
%--------------------------------------------------------------------------
%Snake starts GUI game of classic snake.
%--------------------------------------------------------------------------
%How to play Snake:
%Player collects score by controlling the snake's movement using w-s-a-d
%button or directional arrow button to the food while avoid crashing the
%walls and its own tail. Use shift to speed up your snake, ctrl to slow
%down your snake, and p to pause your game.
%--------------------------------------------------------------------------

%CodeStart-----------------------------------------------------------------
%Reseting MATLAB environment
    close all
    clear all
%Declaring global variables
    playstat=0;
    pausestat=0;
    quitstat=0;
    field=zeros(50);
    arenaindex=1;
    snakepos1=zeros(15,2);
    snakepos2=zeros(15,2);
    snakevel=1;
    snakedir1='right';
    truedir1='right';
    snakedir2='right';
    truedir2='right';
    snakescore1=0;
    snakescore2=0;
    foodpos=zeros(3,2);
%Defining variables for deffield
    deffield=cell(1,3);
    deffield{1}=zeros(50);
    deffield{2}=zeros(50);
    deffield{2}([1,50],:)=9;
    deffield{2}(:,[1,50])=9;
    deffield{3}=zeros(50);
    deffield{3}([1,50],:)=9;
    deffield{3}(:,[1,50])=9;
    deffield{3}(25,2:22)=9;
    deffield{3}(25,29:49)=9;
    deffield{4}=zeros(50);
    for i=1:20
        deffield{4}(i,i)=9;
        deffield{4}(51-i,51-i)=9;
        deffield{4}(i,51-i)=9;
        deffield{4}(51-i,i)=9;
    end
%Generating GUI
    ScreenSize=get(0,'ScreenSize');
    mainwindow=figure('Name','貪吃蛇大戰',...
                      'NumberTitle','Off',...
                      'Menubar','none',...
                      'Resize','off',...
                      'color',[0 0 0],...
                      'Units','pixels',...
                      'Position',[0.5*(ScreenSize(3)-800),...
                                  0.5*(ScreenSize(4)-600),...
                                  800,650],...
                      'WindowKeyPressFcn',@pressfcn,...
                      'DeleteFcn',@closegamefcn);
                  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%做動畫~~~
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% loading
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
loading=uicontrol('Parent',mainwindow,...
              'Style','text',...
              'String','Loading ... 0 %',...
              'Visible','on',...
              'FontSize',20,...
              'HorizontalAlignment','center',...
              'BackgroundColor',[0 0 0],...
              'ForegroundColor',[1,1,1],...
              'Units','pixels',...
              'Position',[250,50,300,50]);
title1=uicontrol('Parent',mainwindow,...
                        'Style','text',...
                        'String','貪',...
                        'FontSize',1,...
                        'Visible','off',...
                        'FontName','微軟正黑體',...
                        'FontWeight','bold',...
                        'HorizontalAlignment','center',...
                        'BackgroundColor',[0 0 0],...
                        'ForegroundColor',[0,0,1],...
                        'Units','pixels',...
                        'Position',[399,398,2,2]);
title2=uicontrol('Parent',mainwindow,...
                        'Style','text',...
                        'String','吃',...
                        'FontSize',1,...
                        'FontName','微軟正黑體',...
                        'Visible','off',...
                        'FontWeight','bold',...
                        'HorizontalAlignment','center',...
                        'BackgroundColor',[0 0 0],...
                        'ForegroundColor',[0,0,1],...
                        'Units','pixels',...
                        'Position',[399,398,2,2]);
title3=uicontrol('Parent',mainwindow,...
                        'Style','text',...
                        'String','蛇',...
                        'FontSize',1,...
                        'FontName','微軟正黑體',...
                        'Visible','off',...
                        'FontWeight','bold',...
                        'HorizontalAlignment','center',...
                        'BackgroundColor',[0 0 0],...
                        'ForegroundColor',[0,0,1],...
                        'Units','pixels',...
                        'Position',[399,398,2,2]);
title4=uicontrol('Parent',mainwindow,...
                        'Style','text',...
                        'String','大',...
                        'FontSize',1,...
                        'FontName','微軟正黑體',...
                        'Visible','off',...
                        'FontWeight','bold',...
                        'HorizontalAlignment','center',...
                        'BackgroundColor',[0 0 0],...
                        'ForegroundColor',[0,0,1],...
                        'Units','pixels',...
                        'Position',[399,398,2,2]);
title5=uicontrol('Parent',mainwindow,...
                        'Style','text',...
                        'String','戰',...
                        'FontSize',1,...
                        'FontName','微軟正黑體',...
                        'Visible','off',...
                        'FontWeight','bold',...
                        'HorizontalAlignment','center',...
                        'BackgroundColor',[0 0 0],...
                        'ForegroundColor',[0,0,1],...
                        'Units','pixels',...
                        'Position',[399,398,2,2]);
loadingsnake1=axes('Parent',mainwindow,...
              'Visible','on',...
              'Units','pixels',...
              'Position',[-150,400,160,10]);
          loadingsnakegraphics=zeros(10,150,3);
          loadingsnakegraphics(:,1:140,2)=0.8;
          loadingsnakegraphics(:,1:140,3)=0.2;
          loadingsnakegraphics(:,141:150,2)=0.5;
          loadingsnakegraphics(:,141:150,3)=0;
          imshow(loadingsnakegraphics)

loadingsnake2=axes('Parent',mainwindow,...
              'Visible','on',...
              'Units','pixels',...
              'Position',[800,400,160,10]);
          loadingsnakegraphics2=zeros(10,150,3);
          loadingsnakegraphics2(:,11:150,1)=0.2;
          loadingsnakegraphics2(:,11:150,2)=0.6;
          loadingsnakegraphics2(:,11:150,3)=1;
          loadingsnakegraphics2(:,1:10,3)=1;
          imshow(loadingsnakegraphics2)
%LOADING BAR & snakes come out and kiss
for i=1:100
    set(loading,'String',sprintf('Loading ... %s %s',num2str(i),'%'))
    set(loadingsnake1,'Position',[-150+4*i,150,150,10])
    set(loadingsnake2,'Position',[800-4*i,150,150,10])
    pause(0.01)
end
pause(0.5)
    set(loading,'Visible','off');
    set(title1,'Visible','on');
    set(title2,'Visible','on');
    set(title3,'Visible','on');
    set(title4,'Visible','on');
    set(title5,'Visible','on');
                           %背景'color',[1,0.6,0.784]  pink
                           %貪吃蛇大戰字樣
                           %'Position',[50,557,700,80]
                           %           [50,537,700,100]
                           %'FontSize',50,...
%change background color and 
%ANIMATION of the title
for i=1:150
    if i<=50
    set(mainwindow,'color',[0.02*i,0.02*i,0.02*i])
    set(title1,'backgroundcolor',[0.02*i,0.02*i,0.02*i])
    set(title2,'backgroundcolor',[0.02*i,0.02*i,0.02*i])
    set(title3,'backgroundcolor',[0.02*i,0.02*i,0.02*i])
    set(title4,'backgroundcolor',[0.02*i,0.02*i,0.02*i])
    set(title5,'backgroundcolor',[0.02*i,0.02*i,0.02*i])
    elseif i>=100
    set(mainwindow,'color',[1,1.8-0.008*i,1.432-0.00432*i])
    set(title1,'backgroundcolor',[1,1.8-0.008*i,1.432-0.00432*i])
    set(title2,'backgroundcolor',[1,1.8-0.008*i,1.432-0.00432*i])
    set(title3,'backgroundcolor',[1,1.8-0.008*i,1.432-0.00432*i])
    set(title4,'backgroundcolor',[1,1.8-0.008*i,1.432-0.00432*i])
    set(title5,'backgroundcolor',[1,1.8-0.008*i,1.432-0.00432*i])
    end
    if i<=20
        set(title1,'Fontsize',200-0.5*(i-20)^2)
        set(title1,'Position',[350-5*i 300-5*i 300-0.5*(i-20)^2 300-0.5*(i-20)^2])
    elseif i>=21 && i<=30
        set(title1,'Fontsize',200-1.5*(i-20)^2)
        set(title1,'Position',[650-20*i 30*i-350 300-2*(i-20)^2 300-2*(i-20)^2])
        
    elseif i>=31 && i<=50
        set(title2,'Fontsize',200-0.5*(i-50)^2)
        set(title2,'Position',[500-5*i 450-5*i 300-0.5*(i-50)^2 300-0.5*(i-50)^2])
    elseif i>=51 && i<=60
        set(title2,'Fontsize',200-1.5*(i-50)^2)
        set(title2,'Position',[450-4*i 30*i-1250 300-2*(i-50)^2 300-2*(i-50)^2])
    elseif i>=61 && i<=80
        set(title3,'Fontsize',200-0.5*(i-80)^2)
        set(title3,'Position',[650-5*i 600-5*i 300-0.5*(i-80)^2 300-0.5*(i-80)^2])
    elseif i>=81 && i<=90
        set(title3,'Fontsize',200-1.5*(i-80)^2)
        set(title3,'Position',[12*i-710 30*i-2150 300-2*(i-80)^2 300-2*(i-80)^2])
    elseif i>=91 && i<=110
        set(title4,'Fontsize',200-0.5*(i-110)^2)
        set(title4,'Position',[800-5*i 750-5*i 300-0.5*(i-110)^2 300-0.5*(i-110)^2])
    elseif i>=111 && i<=120
        set(title4,'Fontsize',200-1.5*(i-110)^2)
        set(title4,'Position',[28*i-2830 30*i-3050 300-2*(i-110)^2 300-2*(i-110)^2])
    elseif i>=121 && i<=140
        set(title5,'Fontsize',200-0.5*(i-140)^2)
        set(title5,'Position',[950-5*i 900-5*i 300-0.5*(i-140)^2 300-0.5*(i-140)^2])
    elseif i>=141 && i<=150
        set(title5,'Fontsize',200-1.5*(i-140)^2)
        set(title5,'Position',[44*i-5910 30*i-3950 300-2*(i-140)^2 300-2*(i-140)^2])
    end
        pause(0.01)
end
    pause(0.05)
    axes('Parent',mainwindow,...
         'Units','pixel',...
         'Position',[50,47,500,500]);

    lscoretext=uicontrol('Parent',mainwindow,...
                         'Style','text',...
                         'String','0',...
                         'FontSize',30,...
                         'FontWeight','bold',...
                         'HorizontalAlignment','center',...
                         'BackgroundColor',[0,0.8,0.2],...
                         'Units','pixels',...
                         'Position',[599,480,85,51]);
    rscoretext=uicontrol('Parent',mainwindow,...
                         'Style','text',...
                         'String','0',...
                         'FontSize',30,...
                         'FontWeight','bold',...
                         'HorizontalAlignment','center',...
                         'BackgroundColor',[0.2,0.6,1],...
                         'Units','pixels',...
                         'Position',[693,480,84,51]);
    arenapopup=uicontrol('Parent',mainwindow,...
                         'Style','popup',...
                         'FontName','標楷體',...
                         'FontSize',14,...
                         'String',{'   無 　 限',...
                                   '   方    框',...
                                   '   限    制',...
                                   '   交    叉'},...
                         'BackgroundColor',[0.678,0.922,1],...
                         'ForegroundColor',[1,0,0],...
                         'Units','pixels',...
                         'Position',[606,246,165,37],...
                         'Callback',@selectarenapopupfcn);
    speedslider=uicontrol('Parent',mainwindow,...
                          'Style','slider',...
                          'Value',1,...
                          'Min',1,...
                          'Max',10,...
                          'SliderStep',[1/9,2/9],...
                          'BackgroundColor',[0.992,0.918,0.7796],...
                          'Units','pixels',...
                          'Position',[606 206 165 20],...
                          'Callback',@movespeedsliderfcn);
    speedtext=uicontrol('Parent',mainwindow,...
                        'Style','text',...
                        'String','1',...
                        'FontSize',15,...
                        'HorizontalAlignment','center',...
                        'BackgroundColor',[1,0.2,0.2],...
                        'ForegroundColor',[1,1,1],...
                        'Units','pixels',...
                        'Position',[693,178,49,27]);
              uicontrol('Parent',mainwindow,...
                        'Style','text',...
                        'String','速度 :',...
                        'FontSize',15,...
                        'FontName','標楷體',...
                        'HorizontalAlignment','center',...
                        'BackgroundColor',[1,0.2,0.2],...
                        'ForegroundColor',[1,1,1],...
                        'Units','pixels',...
                        'Position',[635,178,67,27]);
    startbutton=uicontrol('Parent',mainwindow,...
                          'Style','pushbutton',...
                          'String','開  始  遊  戲',...
                          'Visible','on',...
                          'FontSize',14,...
                          'FontWeight','bold',...
                          'FontName','微軟正黑體',...
                          'BackgroundColor',[0.8,1,0.8],...
                          'ForegroundColor',[1,0,0],...
                          'Units','pixels',...
                          'Position',[606 114 165 30],...
                          'Callback',@startgamefcn);
    stopbutton=uicontrol('Parent',mainwindow,...
                         'Style','pushbutton',...
                         'String','停  止  遊  戲',...
                         'Visible','off',...
                         'FontSize',14,...
                         'FontWeight','bold',...
                         'FontName','微軟正黑體',...
                         'BackgroundColor',[0.8,1,0.8],...
                         'ForegroundColor',[1,0,0],...
                         'Units','pixels',...
                         'Position',[606 114 165 30],...
                         'Callback',@stopgamefcn);
    uicontrol('Parent',mainwindow,...
              'Style','pushbutton',...
              'String','關  閉  遊  戲',...
              'FontSize',14,...
              'FontWeight','bold',...
              'FontName','微軟正黑體',...
              'BackgroundColor',[1,0.694,0.392],...
              'ForegroundColor',[0.039,0.141,0.416],...
              'Units','pixels',...
              'Position',[606,67,165,30],...
              'Callback',@closegamefcn);
    instructionbox=uicontrol('Parent',mainwindow,...
                             'Style','text',...
                             'String','按  下  開  始  遊  戲',...
                             'FontSize',14,...
                             'FontName','微軟正黑體',...
                             'BackgroundColor',[0.8,0.8,0.8],...
                             'ForegroundColor',[1,0,0],...
                             'Units','pixels',...
                             'Position',[81,9,640,24]);
           uicontrol('Parent',mainwindow,...
                        'Style','text',...
                        'String',['              遊戲說明：',10,...
                        ' 綠色玩家：用WSAD控制',10,...
                        ' 藍色玩家：用方向鍵控制',10,...
                        ' 調整速度： +/- ',10,...
                        ' 開始遊戲：ENTER',10,...
                        '   暫    停  ：p',10,...
                        '「先獲得20分者勝利！」'],...
                        'FontSize',11,...
                        'FontName','微軟正黑體',...
                        'FontWeight','bold',...
                        'HorizontalAlignment','left',...
                        'BackgroundColor',[0.941,0.941,0.941],...
                        'Units','pixels',...
                        'Position',[599 309 178 146]);
win1=uicontrol('Parent',mainwindow,...
                        'Style','text',...
                        'String','綠色蛇蛇~獲勝！！',...
                        'FontSize',50,...
                        'FontName','微軟正黑體',...
                        'Visible','off',...
                        'FontWeight','bold',...
                        'HorizontalAlignment','center',...
                        'BackgroundColor',[0.6 1 0.6],...
                        'ForegroundColor',[0,0.5,0],...
                        'Units','pixels',...
                        'Position',[125,200,350,180]);
win2=uicontrol('Parent',mainwindow,...
                        'Style','text',...
                        'String','藍色蛇蛇~獲勝！！',...
                        'FontSize',50,...
                        'FontName','微軟正黑體',...
                        'Visible','off',...
                        'FontWeight','bold',...
                        'HorizontalAlignment','center',...
                        'BackgroundColor',[0.729 0.831 0.957],...
                        'ForegroundColor',[0,0,1],...
                        'Units','pixels',...
                        'Position',[125,200,350,180]);
tie=uicontrol('Parent',mainwindow,...
                        'Style','text',...
                        'String','平手！',...
                        'FontSize',50,...
                        'FontName','微軟正黑體',...
                        'Visible','off',...
                        'FontWeight','bold',...
                        'HorizontalAlignment','center',...
                        'BackgroundColor',[0.855 0.702 1],...
                        'ForegroundColor',[0.847,0.161,0],...
                        'Units','pixels',...
                        'Position',[170,275,222,93]);

%Inititiating graphics
    field=generatefieldarray(deffield,snakepos1,snakepos2,foodpos);
    drawfield(field)

%Declaring LocalFunction
    %Start of generatefieldarray
    function field=generatefieldarray(deffield,snakepos1,snakepos2,foodpos)
        field=deffield{arenaindex};
        for count=1:length(snakepos1)
            if ~((snakepos1(count,1)==0)||(snakepos1(count,2)==0))
                field(snakepos1(count,1),snakepos1(count,2))=1;
                if count==1
                    field(snakepos1(1,1),snakepos1(1,2))=2;
                end
            end
        end
        for count=1:length(snakepos2)
            if ~((snakepos2(count,1)==0)||(snakepos2(count,2)==0))
                field(snakepos2(count,1),snakepos2(count,2))=3;
                if count==1
                    field(snakepos2(1,1),snakepos2(1,2))=4;
                end
            end
        end
        for count=1:length(foodpos)
            if ~((foodpos(count,1)==0)||(foodpos(count,2)==0))
                field(foodpos(count,1),foodpos(count,2))=5;
            end
        end
    end
    %End of generatefieldarray
    %Start of drawfield
    function drawfield(field)
        %Preparing array for field graphic
        graphics=uint8(zeros(500,500,3));
        %Calculating field graphic array
        for row=1:50
        for col=1:50
            %Drawing wall
            if field(row,col)==9
                graphics(((row-1)*10)+1:((row-1)*10)+10,...
                         ((col-1)*10)+1:((col-1)*10)+10,1)=0;
                graphics(((row-1)*10)+1:((row-1)*10)+10,...
                         ((col-1)*10)+1:((col-1)*10)+10,2)=0;
                graphics(((row-1)*10)+1:((row-1)*10)+10,...
                         ((col-1)*10)+1:((col-1)*10)+10,3)=0;
            end
            %Drawing snake  GREEN
            if field(row,col)==1
                graphics(((row-1)*10)+1:((row-1)*10)+10,...
                         ((col-1)*10)+1:((col-1)*10)+10,1)=0;
                graphics(((row-1)*10)+1:((row-1)*10)+10,...
                         ((col-1)*10)+1:((col-1)*10)+10,2)=204;
                graphics(((row-1)*10)+1:((row-1)*10)+10,...
                         ((col-1)*10)+1:((col-1)*10)+10,3)=51;
            end
            %Drawing snake's head GREEN
            if field(row,col)==2
                graphics(((row-1)*10)+1:((row-1)*10)+10,...
                         ((col-1)*10)+1:((col-1)*10)+10,1)=0;
                graphics(((row-1)*10)+1:((row-1)*10)+10,...
                         ((col-1)*10)+1:((col-1)*10)+10,2)=127;
                graphics(((row-1)*10)+1:((row-1)*10)+10,...
                         ((col-1)*10)+1:((col-1)*10)+10,3)=0;
            end
            %Drawing snake 2 BLUE
            if field(row,col)==3
                graphics(((row-1)*10)+1:((row-1)*10)+10,...
                         ((col-1)*10)+1:((col-1)*10)+10,1)=51;
                graphics(((row-1)*10)+1:((row-1)*10)+10,...
                         ((col-1)*10)+1:((col-1)*10)+10,2)=153;
                graphics(((row-1)*10)+1:((row-1)*10)+10,...
                         ((col-1)*10)+1:((col-1)*10)+10,3)=255;
            end
            %Drawing snake's head 2 BLUE
            if field(row,col)==4
                graphics(((row-1)*10)+1:((row-1)*10)+10,...
                         ((col-1)*10)+1:((col-1)*10)+10,1)=0;
                graphics(((row-1)*10)+1:((row-1)*10)+10,...
                         ((col-1)*10)+1:((col-1)*10)+10,2)=0;
                graphics(((row-1)*10)+1:((row-1)*10)+10,...
                         ((col-1)*10)+1:((col-1)*10)+10,3)=255;
            end
            %Drawing food
            if field(row,col)==5
                graphics(((row-1)*10)+1:((row-1)*10)+10,...
                         ((col-1)*10)+1:((col-1)*10)+10,1)=255;
                graphics(((row-1)*10)+1:((row-1)*10)+10,...
                         ((col-1)*10)+1:((col-1)*10)+10,2)=0;
                graphics(((row-1)*10)+1:((row-1)*10)+10,...
                         ((col-1)*10)+1:((col-1)*10)+10,3)=0;
            end
            %Drawing ground
            if field(row,col)==0
                graphics(((row-1)*10)+1:((row-1)*10)+10,...
                         ((col-1)*10)+1:((col-1)*10)+10,1)=255;
                graphics(((row-1)*10)+1:((row-1)*10)+10,...
                         ((col-1)*10)+1:((col-1)*10)+10,2)=255;
                graphics(((row-1)*10)+1:((row-1)*10)+10,...
                         ((col-1)*10)+1:((col-1)*10)+10,3)=102;
            end
        end
        end
        %Drawing graphic
        imshow(graphics)
    end
    %End of drawfield
%Declaring CallbackFunction
    %Start of pressfcn
    function pressfcn(~,event)
        switch event.Key
            case 'w'
                if ~strcmpi(truedir1,'down')
                    snakedir1='up';
                end
            case 'uparrow'
                if ~strcmpi(truedir2,'down')
                    snakedir2='up';
                end
            case 's'
                if ~strcmpi(truedir1,'up')
                    snakedir1='down';
                end
            case 'downarrow'
                if ~strcmpi(truedir2,'up')
                    snakedir2='down';
                end
            case 'a'
                if ~strcmpi(truedir1,'right')
                    snakedir1='left';
                end
            case 'leftarrow'
                if ~strcmpi(truedir2,'right')
                    snakedir2='left';
                end
            case 'd'
                if ~strcmpi(truedir1,'left')
                    snakedir1='right';
                end
            case 'rightarrow'
                if ~strcmpi(truedir2,'left')
                    snakedir2='right';
                end
            case 'return'
                startgamefcn;
            case 'escape'
                closegamefcn;
            case 'add'
                if get(speedslider,'value')<10
                    snakevel=snakevel+1;
                   set(speedslider,'value',snakevel);
                   set(speedtext,'String',snakevel);
                   set(instructionbox,'String',['蛇蛇速度被設定為： ',...
                                     num2str(snakevel)])
                end
            case 'subtract'
                if get(speedslider,'value')>1
                    snakevel=snakevel-1;
                   set(speedslider,'value',snakevel);
                   set(speedtext,'String',snakevel);
                   set(instructionbox,'String',['蛇蛇速度被設定為： ',...
                                     num2str(snakevel)])
                end
            case 'p'
                pausestat=1-pausestat;
        end
    end
    %End of pressfcn
    %Start of selectarenapopup
    function selectarenapopupfcn(~,~)
        arenaindex=get(arenapopup,'Value');
        field=generatefieldarray(deffield,snakepos1,snakepos2,foodpos);
        drawfield(field)
        set(instructionbox,'String',['你選擇了地圖： ',...
                                     num2str(arenaindex)])
    end
    %End of selectarenapopup
    %Start of speedsliderfcn
    function movespeedsliderfcn(~,~)
        snakevel=get(speedslider,'Value');
        snakevel=round(snakevel);
        set(speedtext,'String',num2str(snakevel))
        set(instructionbox,'String',['蛇蛇速度被設定為： ',...
                                     num2str(snakevel)])
    end
    %End of speedsliderfcn
    %Start of startgamefcn
    function startgamefcn(~,~)
        %Locking user interface
        set(startbutton,'Visible','off')
        set(stopbutton,'Visible','on')
        set(arenapopup,'Enable','off')
        set(speedslider,'Enable','off')
        set(instructionbox,'foregroundcolor',[1 0 0])
        set(win1,'Visible','off')
        set(win2,'Visible','off')
        set(tie,'Visible','off')
        %Resetting variables
        playstat=1;
        snakepos1=zeros(15,2);
        snakepos1(:,1)=21;
        snakepos1(:,2)=22:-1:8;
        snakepos2=zeros(15,2);
        snakepos2(:,1)=30;
        snakepos2(:,2)=22:-1:8;
        snakevel=get(speedslider,'Value');
        snakedir1='right';
        snakedir2='right';
        snakescore1=0;
        snakescore2=0;
        %Initiating graphics
        field=generatefieldarray(deffield,snakepos1,snakepos2,foodpos);
        drawfield(field)
        %Placing initial food
        count=1;
        while count<4
            foodpos(count,1)=1+round(49*rand);
            foodpos(count,2)=1+round(49*rand);
            if field(foodpos(count,1),foodpos(count,2))==0
                count=count+1;
            end
        end
        %Redrawing graphics
        field=generatefieldarray(deffield,snakepos1,snakepos2,foodpos);
        drawfield(field)
        %Performing loop for the game
        while playstat==1
            %Creating loop for game pause
            while pausestat
                pause(0.01)
                set(instructionbox,'String','遊戲暫停！')
            end
            %Calculating snake's forward movement
            %%%%%%%  SNAKE 1  %%%%%%%%%
            if strcmpi(snakedir1,'left')
                nextmovepos1=[snakepos1(1,1),snakepos1(1,2)-1];
                truedir1='left';
                if nextmovepos1(2)==0
                    nextmovepos1(2)=50;
                end
            elseif strcmpi(snakedir1,'right')
                nextmovepos1=[snakepos1(1,1),snakepos1(1,2)+1];
                truedir1='right';
                if nextmovepos1(2)==51
                    nextmovepos1(2)=1;
                end
            elseif strcmpi(snakedir1,'up')
                nextmovepos1=[snakepos1(1,1)-1,snakepos1(1,2)];
                truedir1='up';
                if nextmovepos1(1)==0
                    nextmovepos1(1)=50;
                end
            elseif strcmpi(snakedir1,'down')
                nextmovepos1=[snakepos1(1,1)+1,snakepos1(1,2)];
                truedir1='down';
                if nextmovepos1(1)==51
                    nextmovepos1(1)=1;
                end
            end
            
            %%%%%%%%%  SNAKE 2  %%%%%%%%%
            
            if strcmpi(snakedir2,'left')
                nextmovepos2=[snakepos2(1,1),snakepos2(1,2)-1];
                truedir2='left';
                if nextmovepos2(2)==0
                    nextmovepos2(2)=50;
                end
            elseif strcmpi(snakedir2,'right')
                nextmovepos2=[snakepos2(1,1),snakepos2(1,2)+1];
                truedir2='right';
                if nextmovepos2(2)==51
                    nextmovepos2(2)=1;
                end
            elseif strcmpi(snakedir2,'up')
                nextmovepos2=[snakepos2(1,1)-1,snakepos2(1,2)];
                truedir2='up';
                if nextmovepos2(1)==0
                    nextmovepos2(1)=50;
                end
            elseif strcmpi(snakedir2,'down')
                nextmovepos2=[snakepos2(1,1)+1,snakepos2(1,2)];
                truedir2='down';
                if nextmovepos2(1)==51
                    nextmovepos2(1)=1;
                end
            end
            %Checking snake's forward movement position for food
            %%%%%%snake1
            if field(nextmovepos1(1),nextmovepos1(2))==5
                growstat1=1;
                %Deleting eaten food
                for count=1:3
                    if isequal(nextmovepos1,foodpos(count,:))
                        foodpos(count,:)=[];
                        break
                    end
                end
                %Adding new food
                addstat=1;
                while addstat==1
                    foodpos(3,1)=1+round(49*rand);
                    foodpos(3,2)=1+round(49*rand);
                    if field(foodpos(3,1),foodpos(3,2))==0
                        addstat=0;
                    end
                end
            else
                growstat1=0;
            end
            %%%%%snake 2
            if field(nextmovepos2(1),nextmovepos2(2))==5
                growstat2=1;
                %Deleting eaten food
                for count=1:3
                    if isequal(nextmovepos2,foodpos(count,:))
                        foodpos(count,:)=[];
                        break
                    end
                end
                %Adding new food
                addstat=1;
                while addstat==1
                    foodpos(3,1)=1+round(49*rand);
                    foodpos(3,2)=1+round(49*rand);
                    if field(foodpos(3,1),foodpos(3,2))==0
                        addstat=0;
                    end
                end
            else
                growstat2=0;
            end
            %Checking snake's forward movement for wall
            if (field(nextmovepos1(1),nextmovepos1(2))==1)||...
               (field(nextmovepos1(1),nextmovepos1(2))==3)||...
               (field(nextmovepos1(1),nextmovepos1(2))==9)
                set(instructionbox,'String','綠色蛇蛇撞死啦~~恭喜藍色獲勝！！',...
                    'ForegroundColor',[0,0,1])
                set(win2,'Visible','on')
                playstat=0;
                break
            elseif field(nextmovepos1(1),nextmovepos1(2))==4
                set(instructionbox,'String','兩隻蛇蛇的頭互撞了~平手！再比一次吧！',...
                    'ForegroundColor',[1,0,0])
                set(tie,'Visible','on')
                playstat=0;
                break
            end
            if (field(nextmovepos2(1),nextmovepos2(2))==1)||...
               (field(nextmovepos2(1),nextmovepos2(2))==3)||...
               (field(nextmovepos2(1),nextmovepos2(2))==9)
                set(instructionbox,'String','藍色蛇蛇撞死啦~~恭喜綠色獲勝！！',...
                    'ForegroundColor',[0,1,0])
                set(win1,'Visible','on')
                playstat=0;
                break
            elseif field(nextmovepos2(1),nextmovepos2(2))==2
                set(instructionbox,'String','兩隻蛇蛇的頭互撞了~平手！再比一次吧！',...
                    'ForegroundColor',[1,0,0])
                set(tie,'Visible','on')
                playstat=0;
                break
            end
            %Moving snake forward
            if growstat1==1
                snakepos1=[nextmovepos1;snakepos1(1:length(snakepos1),:)];
                snakescore1=snakescore1+1;
                set(instructionbox,'String','綠色蛇蛇：好吃好吃！')
            else
                snakepos1=[nextmovepos1;snakepos1(1:length(snakepos1)-1,:)];
                set(instructionbox,'String','遊戲進行中  加油~加油~衝啊~~！！')
            end
            if growstat2==1
                snakepos2=[nextmovepos2;snakepos2(1:length(snakepos2),:)];
                snakescore2=snakescore2+1;
                set(instructionbox,'String','藍色蛇蛇：好吃好吃！')
            else
                snakepos2=[nextmovepos2;snakepos2(1:length(snakepos2)-1,:)];
                set(instructionbox,'String','遊戲進行中  加油~加油~衝啊~~！！')
            end
            %Updating graphics
            field=generatefieldarray(deffield,snakepos1,snakepos2,foodpos);
            drawfield(field)
            %Performing delay
            set(lscoretext,'String',num2str(snakescore1))
            set(rscoretext,'String',num2str(snakescore2))
            if snakescore1>=20
                playstat=0;
                set(win1,'Visible','on')
                set(instructionbox,'String','綠色蛇蛇搶先獲得了20分~恭喜勝利！！',...
                    'foregroundcolor',[0 1 0])
            elseif snakescore2>=20
                playstat=0;
                set(win2,'Visible','on')
                set(instructionbox,'String','藍色蛇蛇搶先獲得了20分~恭喜勝利！！',...
                    'foregroundcolor',[0 0 1])
            end
            pause(0.11-snakevel*0.01)
        end
        %Unlocking user interface
        if quitstat==0
            set(startbutton,'Visible','on')
            set(stopbutton,'Visible','off')
            set(arenapopup,'Enable','on')
            set(speedslider,'Enable','on')
        end
    end
    %End of startgamefcn
    %Start of stopgamefcn
    function stopgamefcn(~,~)
        %Stopping game loop
        playstat=0;
        %Displaying instruction
        set(instructionbox,...
            'String','遊 戲 結 束！ 按下 「開始遊戲」 開始新遊戲')
    end
    %End of stopgamefcn
    %Start of closegamefcn
    function closegamefcn(~,~)
        %Stopping game loop
        playstat=0;
        quitstat=1;
        pause(0.5)
        %Closing all windows
        delete(mainwindow)
    end
    %End of closegamefcn
%CodeEnd-----------------------------------------------------------------

end