%动画模拟电磁波在导电媒质中的传播衰减特性
%作者：段庆威， 西安电子科技大学 物理学院
%日期：2025年3月
clear; close all   %清零图窗
k2 = 1;          %衰减常数
lamda = 1;       %波长
k = 2*pi/lamda;  %相位常数
a = 1;           %振幅
phi_0 = 0;       %初相位
omega = 1*pi;   %角频率
x = linspace(0, 10, 500);  %传播距离设置
gifname='导电媒质中的传播动画.gif';%动图文件名
figure('Position',[0,0,500,600],'Color','w')  
grid on;        %生成网络线
hold on;        %保持图像
dataY = zeros(size(x));     %初始化数据
hy = plot(x, dataY, 'r-', 'LineWidth',1.8);     
axis([0, max(x), -1, 1])        %坐标轴显示范围
hy_2 = plot(x, a*exp(-k2*x), 'm--', 'LineWidth',1.3);       
hy_2_neg = plot(x, -a*exp(-k2*x), 'm--', 'LineWidth',1.3);  
h3 = plot(x, zeros(size(x)), 'k-', 'LineWidth',0.8);

set(gca,'xtick',0:1:10,'xticklabel',sprintfc('%g',0:1:10)); 
set(gca,'ytick',-1:0.5:1,'yticklabel',{'','','','',''}); 
set(gca,'fontsize',27,'FontName','Times New Roman') %坐标轴颜色、字体及字体大小设置
xlabel('传播深度（米）','fontsize',30,'FontName','宋体');
ylabel('电场','fontsize',30,'FontName','宋体');
% plot(1/k2, 1/exp(1),'Marker','o','MarkerFaceColor','b','MarkerSize',9)  %集肤深度位置
t = 0;  %初始化
dt = 0.1;         %时间步长, 0.1秒
set(gca,'position',[0.11, 0.15, 0.85, 0.84],'Color',[0.16,0.98,0.98])

while t <= 10      %绘制10个周期内的时变特性，周期T=1s
    for i=1:length(x)     
        dataY(i)=a*exp(-k2*x(i)).*cos(omega*t - k*x(i) + phi_0);  %特定t时刻下，y随x的变化
    end
    set(hy,'YData',dataY)       %刷新数据
	drawnow  %修改图形对象后立即查看这次更新
    frame = getframe(gcf);   %捕获坐标区或图窗作为影片帧（结构体）
    RGB = frame2im(frame);   %返回与影片帧关联的图像数据（m×n×3数组，数据类型uint8）
    [imind,cmap] = rgb2ind(RGB, 256);  %由于GIF不支持三维数组，需将RGB图像转换为索引图像
    if t==0
        imwrite(imind,cmap,gifname,'GIF', 'Loopcount',inf,'DelayTime',0.1);     %t=0时刻创建一个gif文件
    else
        imwrite(imind,cmap,gifname,'GIF','WriteMode','append','DelayTime',0.1); %向GIF文件逐步添加一帧帧图像
    end    
    set(gcf, 'nextplot','replacechildren')  %在显示新绘图之前删除现有绘图
    t = t + dt;       %下一个时间点
end
