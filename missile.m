function [Sref Sw St SPlan AN AB XCP_Nose XCP_Body XCP_Wing] = missile(L, Xw, Lp, CTT,CTW, CRT, CRW, hw, ht,d,condplot,XHL,XCG)
%Esta función se encarga de obtener las medidas necesarias para plotear
%El misil a partir de las medidas.
%Ej: missile(15,6,2,0.5,1,1.5,3,3,2,2,0,13,7.5)
%Unidades: m

%% Radomo

figure


x_rad1  = 0;
y_rad1  = 0;
x_rad12 = Lp;
y_rad12 = d/2;
x_rad23 = Lp;
y_rad23 = -d/2;

plot([x_rad1,x_rad12],[y_rad1,y_rad12],[x_rad1,x_rad23],[y_rad1,y_rad23],...
    'Color',[0 0 0],'LineWidth',3)

axis([-1 13 -7 7]);
hold on
% axis([-1 L+1 -(hw*1.8+d/2) (hw*1.8+d/2)]);
% box on

% set(gca,'YTick',[])
% set(gca,'XTick',[])

fill([x_rad1,x_rad12,x_rad23],[y_rad1,y_rad12,y_rad23],[1 0 0]);
%%Body 
xb_24=x_rad12;
xb_4=L;
yb_24=d/2;
yb_45=-d/2;
plot([xb_24,xb_4],[yb_24,yb_24],[xb_4,xb_4],[yb_24,yb_45],...
    [xb_4,xb_24],[yb_45,yb_45],[xb_24,xb_24],[yb_45,yb_45],...
    'Color',[0 0 0],'LineWidth',2)

hold on

%% Aleta delantera

x_pa1=Lp+Xw;
x_pa2=Lp+Xw+CRW;
x_pa3=x_pa2-CTW;
y_pa1=d/2;
y_pa2=d/2+hw;

plot([x_pa1,x_pa3],[y_pa1,y_pa2],[x_pa3,x_pa2],[y_pa2,y_pa2],[x_pa2,x_pa2],...
    [y_pa2,y_pa1],[x_pa2,x_pa1],[y_pa1,y_pa1],'Color',[0 0 0],'LineWidth',2.5);
hold on
fill([x_pa1,x_pa3,x_pa2,x_pa2],[y_pa1,y_pa2,y_pa2,y_pa1],[1 0 0]);
hold on
y_na1=-y_pa1;
y_na2=-y_pa2;
plot([x_pa1,x_pa3],[y_na1,y_na2],[x_pa3,x_pa2],[y_na2,y_na2],[x_pa2,x_pa2],...
    [y_na2,y_na1],[x_pa2,x_pa1],[y_na1,y_na1],'Color',[0 0 0],'LineWidth',2.5);
hold on
fill([x_pa1,x_pa3,x_pa2,x_pa2],[y_na1,y_na2,y_na2,y_na1],[1 0 0]);
hold on

%% Aleta Trasera

x_pa1=L-CRT;
x_pa2=L;
x_pa3=L-CTT;
y_pa1=d/2;
y_pa2=d/2+ht;

plot([x_pa1,x_pa3],[y_pa1,y_pa2],[x_pa3,x_pa2],[y_pa2,y_pa2],[x_pa2,x_pa2],...
    [y_pa2,y_pa1],[x_pa2,x_pa1],[y_pa1,y_pa1],'Color',[0 0 0],'LineWidth',2.5);
hold on
fill([x_pa1,x_pa3,x_pa2,x_pa2],[y_pa1,y_pa2,y_pa2,y_pa1],[1 0 0]);
hold on

y_na1=-y_pa1;
y_na2=-y_pa2;
plot([x_pa1,x_pa3],[y_na1,y_na2],[x_pa3,x_pa2],[y_na2,y_na2],[x_pa2,x_pa2],...
    [y_na2,y_na1],[x_pa2,x_pa1],[y_na1,y_na1],'Color',[0 0 0],'LineWidth',2.5);
hold on
fill([x_pa1,x_pa3,x_pa2,x_pa2],[y_na1,y_na2,y_na2,y_na1], [1 0 0]);
hold on

%% Lineas discontinuas (Fin deflector, eje de simetria)
%% Medidas del misil 
plot([0 L],[0 0],'LineWidth',0.75,'LineStyle','-.','Color',[0 0 0]);
%Hinge Line (XHL)
x_HL=(L-(Lp+Xw+CRW+CRT))+(Lp+Xw+CRW)+(CRT-(L-XHL));
if XHL < L-CTT
    r=CRT-(L-XHL);
    y_phl1=d/2+(ht/(CRT-CTT))*(r);
    y_phl2=d/2;
    
    y_nhl1=-y_phl1;
    y_nhl2=-y_phl2;
plot([x_HL,x_HL],[y_phl1,y_phl2],'LineWidth',1.5,'LineStyle','--','Color',[0 0 0]);
hold on
plot([x_HL,x_HL],[y_nhl1,y_nhl2],'LineWidth',1.5,'LineStyle','--','Color',[0 0 0]);
else
    plot([x_HL,x_HL],[y_pa2,y_na2],'LineWidth',1.5,'LineStyle','--','Color',[0 0 0]);

end

hold on

%% Cotas 
%Longitud total (L)
condplot=334223;
if condplot == 1
plot_arrow(L/2,2*d/2,L,2*d/2,'linewidth',1.5,'color',[1 0 0],...
    'facecolor',[1 0 0], 'edgecolor', [1 0 0]);
plot_arrow(L/2,2*d/2,0,2*d/2,'linewidth',1.5,'color',[1 0 0],...
    'facecolor',[1 0 0], 'edgecolor', [1 0 0]);
hold on

%Lp
elseif condplot == 2
plot_arrow(Lp/2,2*d/2,Lp,2*d/2,'linewidth',1.5,'color',[1 0 0],...
    'facecolor',[1 0 0], 'edgecolor', [1 0 0]);
plot_arrow(Lp/2,2*d/2,0,2*d/2,'linewidth',1.5,'color',[1 0 0],...
    'facecolor',[1 0 0], 'edgecolor', [1 0 0]);
hold on

%d
elseif condplot == 3
plot_arrow(L+0.5,0,L+0.5,d/2,'linewidth',1.5,'color',[1 0 0],...
    'facecolor',[1 0 0], 'edgecolor', [1 0 0]);
plot_arrow(L+0.5,0,L+0.5,-d/2,'linewidth',1.5,'color',[1 0 0],...
    'facecolor',[1 0 0], 'edgecolor', [1 0 0]);
hold on 

%CTW
elseif condplot == 4
    a=Lp+Xw+(CRW-CTW)+CTW/2;
plot_arrow(a,hw*1.3,a+CTW/2,hw*1.3,'linewidth',1.5,'color',[1 0 0],...
    'facecolor',[1 0 0], 'edgecolor', [1 0 0]);
plot_arrow(a,hw*1.3,a-CTW/2,hw*1.3,'linewidth',1.5,'color',[1 0 0],...
    'facecolor',[1 0 0], 'edgecolor', [1 0 0]);
hold on 

%CRW
elseif condplot == 5
    a=Lp+Xw+CRW/2;
plot_arrow(a,1.5*d/2,a+CRW/2,1.5*d/2,'linewidth',1.5,'color',[1 0 0],...
    'facecolor',[1 0 0], 'edgecolor', [1 0 0]);
plot_arrow(a,1.5*d/2,a-CRW/2,1.5*d/2,'linewidth',1.5,'color',[1 0 0],...
    'facecolor',[1 0 0], 'edgecolor', [1 0 0]);
hold on 

%xW
elseif condplot == 6
    a=Lp+Xw/2;
plot_arrow(a,1.5*d/2,a+Xw/2,1.5*d/2,'linewidth',1.5,'color',[1 0 0],...
    'facecolor',[1 0 0], 'edgecolor', [1 0 0]);
plot_arrow(a,1.5*d/2,a-Xw/2,1.5*d/2,'linewidth',1.5,'color',[1 0 0],...
    'facecolor',[1 0 0], 'edgecolor', [1 0 0]);
hold on 
%hW
elseif condplot == 7
    a=d/2+hw/2;
    b=Lp+Xw+CRW;
plot_arrow(b+0.3,a,b+0.3,a+hw/2,'linewidth',1.5,'color',[1 0 0],...
    'facecolor',[1 0 0], 'edgecolor', [1 0 0]);
plot_arrow(b+0.3,a,b+0.3,a-hw/2,'linewidth',1.5,'color',[1 0 0],...
    'facecolor',[1 0 0], 'edgecolor', [1 0 0]);
hold on 
%CTT 
elseif condplot == 8
    a=L-CTT/2;
plot_arrow(a,ht+d/2+0.3,a+CTT/2,ht+d/2+0.3,'linewidth',1.5,'color',[1 0 0],...
    'facecolor',[1 0 0], 'edgecolor', [1 0 0]);
plot_arrow(a,ht+d/2+0.3,a-CTT/2,ht+d/2+0.3,'linewidth',1.5,'color',[1 0 0],...
    'facecolor',[1 0 0], 'edgecolor', [1 0 0]);
hold on 
%CRT 
elseif condplot == 9
    a=L-CRT/2;
plot_arrow(a,1.5*d/2,a+CRT/2,1.5*d/2,'linewidth',1.5,'color',[1 0 0],...
    'facecolor',[1 0 0], 'edgecolor', [1 0 0]);
plot_arrow(a,1.5*d/2,a-CRT/2,1.5*d/2,'linewidth',1.5,'color',[1 0 0],...
    'facecolor',[1 0 0], 'edgecolor', [1 0 0]);
hold on 

elseif condplot == 10
    a=d/2+ht/2;
plot_arrow(L+0.3,a,L+0.3,a+ht/2,'linewidth',1.5,'color',[1 0 0],...
    'facecolor',[1 0 0], 'edgecolor', [1 0 0]);
plot_arrow(L+0.3,a,L+0.3,a-ht/2,'linewidth',1.5,'color',[1 0 0],...
    'facecolor',[1 0 0], 'edgecolor', [1 0 0]);
hold on 
%XHL
elseif condplot == 11
    a=XHL/2;
plot_arrow(a,1.5*d/2,a+XHL/2,1.5*d/2,'linewidth',1.5,'color',[1 0 0],...
    'facecolor',[1 0 0], 'edgecolor', [1 0 0]);
plot_arrow(a,1.5*d/2,a-XHL/2,1.5*d/2,'linewidth',1.5,'color',[1 0 0],...
    'facecolor',[1 0 0], 'edgecolor', [1 0 0]);
hold on 
end


%% Definición de parámetros geométricos y aerodinámicos.
%Ojo. expresiones simplificadas. Revisar
Sref= pi*d^2/4;
Sw = (1/2)*hw*(CTW+CRW);
St = (1/2)*ht*(CTT+CRT);
SPlan = (L-Lp)*d + 0.67*Lp*d;
AN= 0.67*Lp*d;
AB = (L-Lp)*d;
XCP_Nose = 0.67*Lp;
XCP_Body = (0.67*AN*Lp+AB*(Lp+0.5*(L-Lp)))/(AN+AB);
XCP_Wing = Lp+Xw+0.7*CRW-0.2*CTW;


%F_Nose, F_Body, F_Wing, F_Tail, W
plot_arrow(XCP_Nose,XCP_Nose*((d/2)/Lp),XCP_Nose,ht,'linewidth',1,'color',[1 0 0],...
    'facecolor',[1 0 0], 'edgecolor', [1 0 0]);
text(XCP_Nose+0.25,ht*0.9,'F Nose','Color',[1 0 0]);

plot_arrow(XCP_Body,d/2,XCP_Body,1.3*hw,'linewidth',1,'color',[1 0.4 0],...
    'facecolor',[1 0.4 0], 'edgecolor',[1 0.4 0]);
text(XCP_Body-1.7,hw,'F Body','Color',[1 0.4 0]);

if XCP_Wing < (Lp+Xw+CRW-CTW)
    lim_W = (hw/(CRW-CTW))*(XCP_Wing-(Lp+Xw))+d/2;
else 
    lim_W = hw+d/2;
end

plot_arrow(XCP_Wing,lim_W,XCP_Wing,1.5*lim_W,'linewidth',1,'color',[0.2 0.6 0],...
    'facecolor',[0.2 0.6 0], 'edgecolor',[0.2 0.6 0]);
text(XCP_Wing+0.25,hw+0.8,'F Wing','Color',[0.2 0.6 0]);

XHL_y=(ht/(CRT-CTT))*(CRT-(L-XHL));
plot_arrow(XHL,d/2+XHL_y,XHL,0.8+XHL_y+d/2,'linewidth',1,'linewidth',1,'color',[0 0 1],...
    'facecolor',[0 0 1], 'edgecolor',[0 0 1])
text(XHL-1.6,ht+d/2,'F Tail','Color',[0 0 1]);

plot_arrow(XCG,0,XCG,-hw-0.5,'linewidth',2);
text(XCG-0.8,-0.9*hw,'W');


end




