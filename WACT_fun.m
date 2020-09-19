function WACT_fun(XNCG,XKA,XKDC,XKR,WI,TA,WZ,XK1,XK3,TAUACT,ZETAACT,W0,Z0,XK0,WAF,ZAF,TF,handles,WCR)
%Añadir handles
m=0;
WACT_vector=linspace(240,400,3);

for WACT=WACT_vector
count=0;
m=m+1;
E=0.;
ED=0.;
DEL=0.;
DELD=0;
DELDD=0.;
THD=0;
DELC=0;

X=0.;
T=0;
H=.0001;
S=0;

while T<=(TF-.00001)
	EOLD=E;
	EDOLD=ED;
	DELOLD=DEL;
    DELDOLD=DELD;
	DELDDOLD=DELDD;
	XOLD=X;
	STEP=1;
	FLAG=0;
	while STEP <=1
		if FLAG==1
			STEP=2;
			E=E+H*ED;
			ED=ED+H*EDD;
			DEL=DEL+H*DELD;
            DELD=DELD+H*DELDD;
			DELDD=DELDD+H*DELDDD;
			X=X+H*XD;
			T=T+H;
		end
		THD=XK3*(E+TA*ED);
 		DELC=XKR*(X+THD);
 		DELDDD=(WACT^2/TAUACT)*(DELC-DEL-(DELD*((2*ZETAACT/WACT)+TAUACT)+DELDD*(...
            (2*ZETAACT*TAUACT/WACT)+1/WACT^2)));
 		EDD=WAF*WAF*(DEL-E-2.*ZAF*ED/WAF);
 		XNL=XK1*(E-EDD/WZ^2);
 		XD=WI*(THD+XKA*(XNL-XNCG*XKDC));
 		FLAG=1;
	end
	FLAG=0;
	E=.5*(EOLD+E+H*ED);
	ED=.5*(EDOLD+ED+H*EDD);
	DEL=.5*(DELOLD+DEL+H*DELD);
    DELD=.5*(DELDOLD+DELD+H*DELDD);
	DELDD=.5*(DELDDOLD+DELDD+H*DELDDD);
	X=.5*(XOLD+X+H*XD);
	S=S+H;
	if S>.0099999
		S=0.;
		count=count+1;
		ArrayT(m,count)=T;
		ArrayXNL(m,count)=XNL;
		ArrayXNCG(m,count)=XNCG;
        ArrayDelta(m,count)=DEL;
	end

end
for I=2:160
 
        W=10^(.025*I-1);
        XMAGTOP=-XK0*sqrt((1.-(W/W0)^2)^2+(2.*Z0*W/W0)^2);
        XMAGACT=1./sqrt((1.-W*W*((2*ZETAACT*TAUACT)/WACT+1/(WACT*WACT)))^2+...
            (2.*ZETAACT*W/WACT+TAUACT*W-(TAUACT*W*W*W)/(WACT*WACT)))^2;
        XMAGBOT=W*sqrt((1.-(W/WAF)^2)^2+(2.*ZAF*W/WAF)^2);
        XMAG=XMAGTOP/XMAGBOT;
       
        PHASETOP=atan2(2.*Z0*W/W0,1.-(W/W0)^2);
        PHASEBOT=atan2(2.*ZAF*W/WAF,1.-(W/WAF)^2);
        PHASEACT=atan2(2.*ZETAACT*W/WACT + TAUACT*W - (TAUACT*W*W*W)/(WACT*WACT),...
            1.-W*W*((2*ZETAACT*TAUACT)/WACT+1/(WACT*WACT)));
                      
        GAIN=20.*log10(XMAG*XMAGACT);
        PHASE=-90.+57.3*(PHASETOP-PHASEBOT-PHASEACT);
        count=count+1;
        ArrayW(m,count)=W;
        ArrayGAIN(m,count)=GAIN;
        ArrayPHASE(m,count)=PHASE;

end
  
end

for i=1:m
    
color=['r' 'b' 'g' 'k'];
axes(handles.axes8)
plot(ArrayT(i,:),ArrayXNL(i,:),color(i),'Linewidth',1.5);grid on
axis tight
grid on
hold on
plot(ArrayT(i,:),ArrayXNCG(i,:),'k','Linewidth',1.5),grid on
xlabel('$\mathbf{Time [rev]}$','interpreter','latex','FontSize',9,'FontName','arial');
ylabel('$\mathbf{n_{L} [G]}$','interpreter','latex','FontSize',9,'FontName','arial');
axis tight
grid on
hold on

axes(handles.axes6)
semilogx(ArrayW(i,:),ArrayGAIN(i,:),color(i),'Linewidth',1.5);
xlabel('$\mathbf{\omega\ [rev]}$','interpreter','latex','FontSize',9,'FontName','arial');
ylabel('$\mathbf{Gain [dB]}$','interpreter','latex','FontSize',9,'FontName','arial');
axis tight
grid on
hold on

axes(handles.axes7)
semilogx(ArrayW(i,:),ArrayPHASE(i,:),color(i),'Linewidth',1.5);
xlabel('$\mathbf{\omega\ [rad/s]}$','interpreter','latex','FontSize',9,'FontName','arial');
ylabel('$\mathbf{\phi\ [^{o}]}$','interpreter','latex','FontSize',9,'FontName','arial');
axis tight
grid on
hold on
end

%% Respuesta nL
    %Definición de la figura:
figure1                   = figure('Position',[10 10 750 500],...
                            'Color',[1 1 1]);

% Definición de los ejes de la figura:      
axes1                    = axes('Parent',figure1,...
                            'Position',[0.15 0.15 0.65 0.75],...
                            'LineWidth',2,...
                            'Layer','top',...
                            'XLim',[0 (ArrayT(end)+2*H)],...
                            'FontSize',17,...
                            'FontName','arial');
hold(axes1,'all'); % Permitir la unión de elementos gráficos.
box on % Mostrar el dominio de graficado como una caja.
grid on

for i=1:m
color=['r' 'b' 'g' 'k'];

% Graficas
plot(ArrayT(i,:),ArrayXNL(i,:),color(i),'Linewidth',1.5);
% hold on
% plot(ArrayT(i,:),ArrayXNCG(i,:),'k','Linewidth',1.5);
 %Definición de ejes
xlabel('$\mathbf{Time [rev]}$','interpreter','latex','FontSize',14,'FontName','arial');
ylabel('$\mathbf{n_{L} [G]}$','interpreter','latex','FontSize',14,'FontName','arial');
hold on
% En esta parte del código se consulta el vector de valores.
end

plot(ArrayT(i,:),ArrayXNCG(i,:),'k','Linewidth',1.5);
hold on;

datastr1=strcat('W act = ',num2str(WACT_vector(1)),'[rad/s]');

datastr2=strcat('W act = ',num2str(WACT_vector(2)),'[rad/s]');

datastr3=strcat('W act = ',num2str(WACT_vector(3)),'[rad/s]');

b1=legend(datastr1,datastr2,datastr3);
set(b1,'FontSize',14);


%% Respuesta GAIN

    % Definición de la figura:
figure2                   = figure('Position',[10 10 750 500],...
                            'Color',[1 1 1]);

% Definición de los ejes de la figura:      
axes2                    = axes('Parent',figure2,...
                            'Position',[0.15 0.15 0.65 0.75],...
                            'LineWidth',2,...
                            'Layer','top',...
                            'XLim',[0 (ArrayT(end)+2*H)],...
                            'FontSize',17,...
                            'FontName','arial');
% hold(axes2,'all'); % Permitir la unión de elementos gráficos.
box on % Mostrar el dominio de graficado como una caja.
grid on

for i=1:m


% Graficas
semilogx(ArrayW(i,:),ArrayGAIN(i,:),color(i),'Linewidth',1.5);
grid on;
 %Definición de ejes
xlabel('$\mathbf{\omega\ [rad/s]}$','interpreter','latex','FontSize',14,'FontName','arial');
ylabel('$\mathbf{Gain [dB]}$','interpreter','latex','FontSize',14,'FontName','arial');
hold on
end
% En esta parte del código se consulta el vector de valores.

datastr1=strcat('W act = ',num2str(WACT_vector(1)),'[rad/s]');

datastr2=strcat('W act = ',num2str(WACT_vector(2)),'[rad/s]');

datastr3=strcat('W act = ',num2str(WACT_vector(3)),'[rad/s]');


b2=legend(datastr1,datastr2,datastr3);
set(b2,'FontSize',14);



for i=1:m
    

pos1=find(ArrayW(i,:)==0,1,'last');
W_0dB(i)=interp1(real(ArrayGAIN(i,pos1+1:end)),ArrayW(i,pos1+1:end),0,'spline');

%Gain -180º (vertical)
p=1;
W_PHASE=[];
for n=1:length(real(ArrayPHASE))-1;
   if  (real(ArrayPHASE(i,n)) < -180 && real(ArrayPHASE(i,n+1)) > -180) || (real(ArrayPHASE(i,n)) > -180 && real(ArrayPHASE(i,n+1)) < -180)
       W_PHASE(p)=interp1(real(ArrayPHASE(i,n:n+1)),ArrayW(i,n:n+1),-180);
       p=p+1;
   end
end
if ~ isempty(W_PHASE)
W_phase180(i)=W_PHASE(length(W_PHASE)-1);
pos1=find(ArrayW(i,:)==0,1,'last');

GAIN_180phase(i)=interp1(ArrayW(i,pos1+1:end),real(ArrayGAIN(i,pos1+1:end)),W_phase180(i),'spline');
GAIN_WCR(i)=interp1(ArrayW(i,pos1+1:end),real(ArrayGAIN(i,pos1+1:end)),WCR,'spline');

%1: considerando que coincide con WCR. 2: Considerando que es en 0 db
W_error(i)=(abs(WCR)-abs(W_0dB(i)))/max(W_0dB(i),WCR);
Gmar_1(i)=abs(abs(GAIN_180phase(i))-abs(GAIN_WCR(i)));
Gmar_2(i)=(abs(GAIN_180phase(i)));
G_error(i)=1-(min(Gmar_1(i),Gmar_2(i))/max(Gmar_1(i),Gmar_2(i)));


end
end






%% Respuesta PHASE
    % Definición de la figura:
figure3                   = figure('Position',[10 10 750 500],...
                            'Color',[1 1 1]);

% Definición de los ejes de la figura:      
axes3                   = axes('Parent',figure3,...
                            'Position',[0.15 0.15 0.65 0.75],...
                            'LineWidth',2,...
                            'Layer','top',...
                            'XLim',[0 (ArrayT(end)+2*H)],...
                            'FontSize',17,...
                            'FontName','arial');
% hold(axes3,'all'); % Permitir la unión de elementos gráficos.
box on % Mostrar el dominio de graficado como una caja.


for i=1:m


% Graficas
semilogx(ArrayW(i,:),ArrayPHASE(i,:),color(i),'Linewidth',1.5);
grid on;
 %Definición de ejes
xlabel('$\mathbf{\omega\ [rad/s]}$','interpreter','latex','FontSize',14,'FontName','arial');
ylabel('$\mathbf{\phi\ [^{o}]}$','interpreter','latex','FontSize',14,'FontName','arial');
hold on
% En esta parte del código se consulta el vector de valores.
end

datastr1=strcat('W act = ',num2str(WACT_vector(1)),'[rad/s]');

datastr2=strcat('W act = ',num2str(WACT_vector(2)),'[rad/s]');

datastr3=strcat('W act = ',num2str(WACT_vector(3)),'[rad/s]');


b3=legend(datastr1,datastr2,datastr3);
set(b3,'FontSize',14);

if ~isempty(W_PHASE)
for i=1:m
%Phase -180º


pos1=find(ArrayW(i,:)==0,1,'last');
W_val=interp1(real(ArrayGAIN(i,pos1+1:end)),ArrayW(i,pos1+1:end),0,'spline')
%WCR

pos1=find(ArrayW(i,:)==0,1,'last');
phase_0dB(i)=interp1(ArrayW(i,pos1+1:end),real(ArrayPHASE(i,pos1+1:end)),W_0dB(i),'spline');
phase_WCR(i)=interp1(ArrayW(i,pos1+1:end),real(ArrayPHASE(i,pos1+1:end)),WCR,'spline');

Pmar_1(i)=abs(phase_0dB(i))-abs(180);
Pmar_2(i)=(abs(phase_WCR(i))-180);
p_error(i)=1-(min(abs(Pmar_1(i)),abs(Pmar_2(i)))/max(abs(Pmar_1(i)),abs(Pmar_2(i))));
end
save resultadosWACT.mat W_0dB W_phase180 GAIN_180phase GAIN_WCR Gmar_1 Gmar_2 G_error...
    phase_0dB phase_WCR Pmar_1 Pmar_2 p_error W_error 
end
