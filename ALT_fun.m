function ALT_fun(VM,ALT,XNC,VM_fin,XNC_fin,WACT,TAUACT,ZETAACT,TAU,WCR,ZETA,WAF,ZAF,TF,k,handles)
%% Funcion buscar
%Nearest/Interpolation
%k=1 es Nearest 
%k=2 es Interpolation
load('schedule.mat');
m=0;
g=k;
XNCG=XNC_fin;
Alt_vector=[ALT(1) ALT(length(ALT)/2) ALT(length(ALT))];

for ALT_fin=[ALT(1) ALT(length(ALT)/2) ALT(length(ALT))]
if g==1
 
i=find(VM==VM_fin);
j=find(XNC==XNC_fin);
k=find(ALT==ALT_fin);

XKA_value=XKA(i,j,k);
XKR_value=XKR(i,j,k);
XKDC_value=XKDC(i,j,k);
WI_value=WI(i,j,k);
WAF_value=WAF(i,j,k);
ZAF_value=ZAF(i,j,k);
XK1_value=XK1(i,j,k);
XK3_value=XK3(i,j,k);
TA_value=TA(i,j,k);
WZ_value=WZ(i,j,k);

elseif g==2
    
XKA_value=interp3(XNC,VM,ALT,XKA,XNC_fin,VM_fin,ALT_fin);
XKR_value=interp3(XNC,VM,ALT,XKR,XNC_fin,VM_fin,ALT_fin);
XKDC_value=interp3(XNC,VM,ALT,XKDC,XNC_fin,VM_fin,ALT_fin);
WI_value=interp3(XNC,VM,ALT,WI,XNC_fin,VM_fin,ALT_fin);
WAF_value=interp3(XNC,VM,ALT,WAF,XNC_fin,VM_fin,ALT_fin);
ZAF_value=interp3(XNC,VM,ALT,ZAF,XNC_fin,VM_fin,ALT_fin);
XK1_value=interp3(XNC,VM,ALT,XK1,XNC_fin,VM_fin,ALT_fin);
XK3_value=interp3(XNC,VM,ALT,XK3,XNC_fin,VM_fin,ALT_fin);
TA_value=interp3(XNC,VM,ALT,TA,XNC_fin,VM_fin,ALT_fin);
WZ_value=interp3(XNC,VM,ALT,WZ,XNC_fin,VM_fin,ALT_fin);

end

W=(TAU*WCR*(1+2.*ZAF_value*WAF_value/WCR)-1)/(2*ZETA*TAU);
W0=W/sqrt(TAU*WCR);
Z0=.5*W0*(2*ZETA/W+TAU-WAF_value^2/(W0*W0*WCR));
XK0=-W*W/(TAU*WAF_value*WAF_value);
XKC=(-W0^2/WZ_value^2-1.+2.*Z0*W0*TA_value)/(1.-2.*Z0*W0*TA_value+W0*W0*TA_value*TA_value);
XK=XK0/(XK1_value*(1+XKC));

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
		THD=XK3_value*(E+TA_value*ED);
 		DELC=XKR_value*(X+THD);
 		DELDDD=(WACT^2/TAUACT)*(DELC-DEL-(DELD*((2*ZETAACT/WACT)+TAUACT)+DELDD*(...
            (2*ZETAACT*TAUACT/WACT)+1/WACT^2)));
 		EDD=WAF_value*WAF_value*(DEL-E-2.*ZAF_value*ED/WAF_value);
 		XNL=XK1_value*(E-EDD/WZ_value^2);
 		XD=WI_value*(THD+XKA_value*(XNL-XNCG*XKDC_value));
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
        XMAGBOT=W*sqrt((1.-(W/WAF_value)^2)^2+(2.*ZAF_value*W/WAF_value)^2);
        XMAG=XMAGTOP/XMAGBOT;
       
        PHASETOP=atan2(2.*Z0*W/W0,1.-(W/W0)^2);
        PHASEBOT=atan2(2.*ZAF_value*W/WAF_value,1.-(W/WAF_value)^2);
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
axes(handles.axes8);
plot(ArrayT(i,:),ArrayXNL(i,:),color(i),'Linewidth',1.5);
axis tight
grid on
hold on
plot(ArrayT(i,:),ArrayXNCG(i,:),'k','Linewidth',1.5),grid on
xlabel('$\mathbf{Time [rev]}$','interpreter','latex','FontSize',9,'FontName','arial');
ylabel('$\mathbf{n_{L} [G]}$','interpreter','latex','FontSize',9,'FontName','arial');
axis tight
grid on
hold on

axes(handles.axes6);
semilogx(ArrayW(i,:),ArrayGAIN(i,:),color(i),'Linewidth',1.5);
xlabel('$\mathbf{\omega\ [rev]}$','interpreter','latex','FontSize',9,'FontName','arial');
ylabel('$\mathbf{Gain [dB]}$','interpreter','latex','FontSize',9,'FontName','arial');
axis tight
grid on
hold on

axes(handles.axes7);
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

datastr1=strcat('Alt = ',num2str(Alt_vector(1)),'[ft]');

datastr2=strcat('Alt = ',num2str(Alt_vector(2)),'[ft]');

datastr3=strcat('Alt = ',num2str(Alt_vector(3)),'[ft]');

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

datastr1=strcat('VM = ',num2str(VM_vector(1)),'[m/s]');

datastr2=strcat('VM = ',num2str(VM_vector(2)),'[m/s]');

datastr3=strcat('VM = ',num2str(VM_vector(3)),'[m/s]');

b2=legend(datastr1,datastr2,datastr3);
set(b2,'FontSize',14);
%% Respuesta PHASE
    % Definición de la figura:
figure3                   = figure('Position',[10 10 750 500],...
                            'Color',[1 1 1]);

% Definición de los ejes de la figura:      
axes3                   = axes('Parent',figure3,...
                            'Position',[0.15 0.15 0.65 0.75],...
                            'LineWidth',2,...
                            'Layer','top',...
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

datastr1=strcat('VM = ',num2str(VM_vector(1)),'[m/s]');

datastr2=strcat('VM = ',num2str(VM_vector(2)),'[m/s]');

datastr3=strcat('VM = ',num2str(VM_vector(3)),'[m/s]');

b3=legend(datastr1,datastr2,datastr3);
set(b3,'FontSize',14);


