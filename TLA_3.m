function [XKA XKDC WI XKR,num1] = TLA_3(VM,ALT,XNC,VM_fin,ALT_fin,XNC_fin,XKA,XKDC,XKR,WI,TA,WZ,XK1,XK3,WACT,ZETAACT,...
    TAUACT,WAF,ZAF,TAU,ZETA,WCR,TF,k,g,handles)
load Airframe.mat

%Estudio paramétrico 
switch g
    case 1 %WACT
        count=0;
E=0.;
ED=0.;
DELDD=0.;
DELD=0;
DEL=0.;
X=0.;
T=0;
H=.0001;
S=0;

%% Funcion buscar
%Nearest/Interpolation
%k=1 es Nearest 
%k=2 es Interpolation

if k==1
    
i=find(VM==VM_fin);
j=find(XNC==XNC_fin);
k=find(ALT==ALT_fin);

XKA=XKA(i,j,k);
XKR=XKR(i,j,k);
XKDC=XKDC(i,j,k);
WI=WI(i,j,k);
WAF=WAF(i,j,k);
ZAF=ZAF(i,j,k);
XK1=XK1(i,j,k);
XK3=XK3(i,j,k);
TA=TA(i,j,k);
WZ=WZ(i,j,k);

elseif k==2
    
XKA=interp3(XNC,VM,ALT,XKA,XNC_fin,VM_fin,ALT_fin);
XKR=interp3(XNC,VM,ALT,XKR,XNC_fin,VM_fin,ALT_fin);
XKDC=interp3(XNC,VM,ALT,XKDC,XNC_fin,VM_fin,ALT_fin);
WI=interp3(XNC,VM,ALT,WI,XNC_fin,VM_fin,ALT_fin);
WAF=interp3(XNC,VM,ALT,WAF,XNC_fin,VM_fin,ALT_fin);
ZAF=interp3(XNC,VM,ALT,ZAF,XNC_fin,VM_fin,ALT_fin);
XK1=interp3(XNC,VM,ALT,XK1,XNC_fin,VM_fin,ALT_fin);
XK3=interp3(XNC,VM,ALT,XK3,XNC_fin,VM_fin,ALT_fin);
TA=interp3(XNC,VM,ALT,TA,XNC_fin,VM_fin,ALT_fin);
WZ=interp3(XNC,VM,ALT,WZ,XNC_fin,VM_fin,ALT_fin);
end

W=(TAU*WCR*(1+2.*ZAF*WAF/WCR)-1)/(2*ZETA*TAU);
W0=W/sqrt(TAU*WCR);
Z0=.5*W0*(2*ZETA/W+TAU-WAF^2/(W0*W0*WCR));
XK0=-W*W/(TAU*WAF*WAF);
XKC=(-W0^2/WZ^2-1.+2.*Z0*W0*TA)/(1.-2.*Z0*W0*TA+W0*W0*TA*TA);
XK=XK0/(XK1*(1+XKC));


m=0;
XNCG=XNC_fin;
WACT_fun(XNCG,XKA,XKDC,XKR,WI,TA,WZ,XK1,XK3,TAUACT,ZETAACT,W0,Z0,XK0,WAF,ZAF,TF,handles,WCR);
num1=0;
    case 2 %Damping
        count=0;
E=0.;
ED=0.;
DELDD=0.;
DELD=0;
DEL=0.;
X=0.;
T=0;
H=.0001;
S=0;

%% Funcion buscar
%Nearest/Interpolation
%k=1 es Nearest 
%k=2 es Interpolation

if k==1
    
i=find(VM==VM_fin);
j=find(XNC==XNC_fin);
k=find(ALT==ALT_fin);

XKA=XKA(i,j,k);
XKR=XKR(i,j,k);
XKDC=XKDC(i,j,k);
WI=WI(i,j,k);
WAF=WAF(i,j,k);
ZAF=ZAF(i,j,k);
XK1=XK1(i,j,k);
XK3=XK3(i,j,k);
TA=TA(i,j,k);
WZ=WZ(i,j,k);

elseif k==2
    
XKA=interp3(XNC,VM,ALT,XKA,XNC_fin,VM_fin,ALT_fin);
XKR=interp3(XNC,VM,ALT,XKR,XNC_fin,VM_fin,ALT_fin);
XKDC=interp3(XNC,VM,ALT,XKDC,XNC_fin,VM_fin,ALT_fin);
WI=interp3(XNC,VM,ALT,WI,XNC_fin,VM_fin,ALT_fin);
WAF=interp3(XNC,VM,ALT,WAF,XNC_fin,VM_fin,ALT_fin);
ZAF=interp3(XNC,VM,ALT,ZAF,XNC_fin,VM_fin,ALT_fin);
XK1=interp3(XNC,VM,ALT,XK1,XNC_fin,VM_fin,ALT_fin);
XK3=interp3(XNC,VM,ALT,XK3,XNC_fin,VM_fin,ALT_fin);
TA=interp3(XNC,VM,ALT,TA,XNC_fin,VM_fin,ALT_fin);
WZ=interp3(XNC,VM,ALT,WZ,XNC_fin,VM_fin,ALT_fin);
end

W=(TAU*WCR*(1+2.*ZAF*WAF/WCR)-1)/(2*ZETA*TAU);
W0=W/sqrt(TAU*WCR);
Z0=.5*W0*(2*ZETA/W+TAU-WAF^2/(W0*W0*WCR));
XK0=-W*W/(TAU*WAF*WAF);
XKC=(-W0^2/WZ^2-1.+2.*Z0*W0*TA)/(1.-2.*Z0*W0*TA+W0*W0*TA*TA);
XK=XK0/(XK1*(1+XKC));


m=0;
XNCG=XNC_fin;
ZETAACT_fun(XNCG,XKA,XKDC,XKR,WI,TA,WZ,XK1,XK3,WACT,TAUACT,W0,Z0,XK0,WAF,ZAF,TF,handles,WCR);
num1=0;
    case 3 %Delay
        count=0;
E=0.;
ED=0.;
DELDD=0.;
DELD=0;
DEL=0.;
X=0.;
T=0;
H=.0001;
S=0;

%% Funcion buscar
%Nearest/Interpolation
%k=1 es Nearest 
%k=2 es Interpolation

if k==1
    
i=find(VM==VM_fin);
j=find(XNC==XNC_fin);
k=find(ALT==ALT_fin);

XKA=XKA(i,j,k);
XKR=XKR(i,j,k);
XKDC=XKDC(i,j,k);
WI=WI(i,j,k);
WAF=WAF(i,j,k);
ZAF=ZAF(i,j,k);
XK1=XK1(i,j,k);
XK3=XK3(i,j,k);
TA=TA(i,j,k);
WZ=WZ(i,j,k);

elseif k==2
    
XKA=interp3(XNC,VM,ALT,XKA,XNC_fin,VM_fin,ALT_fin);
XKR=interp3(XNC,VM,ALT,XKR,XNC_fin,VM_fin,ALT_fin);
XKDC=interp3(XNC,VM,ALT,XKDC,XNC_fin,VM_fin,ALT_fin);
WI=interp3(XNC,VM,ALT,WI,XNC_fin,VM_fin,ALT_fin);
WAF=interp3(XNC,VM,ALT,WAF,XNC_fin,VM_fin,ALT_fin);
ZAF=interp3(XNC,VM,ALT,ZAF,XNC_fin,VM_fin,ALT_fin);
XK1=interp3(XNC,VM,ALT,XK1,XNC_fin,VM_fin,ALT_fin);
XK3=interp3(XNC,VM,ALT,XK3,XNC_fin,VM_fin,ALT_fin);
TA=interp3(XNC,VM,ALT,TA,XNC_fin,VM_fin,ALT_fin);
WZ=interp3(XNC,VM,ALT,WZ,XNC_fin,VM_fin,ALT_fin);
end

W=(TAU*WCR*(1+2.*ZAF*WAF/WCR)-1)/(2*ZETA*TAU);
W0=W/sqrt(TAU*WCR);
Z0=.5*W0*(2*ZETA/W+TAU-WAF^2/(W0*W0*WCR));
XK0=-W*W/(TAU*WAF*WAF);
XKC=(-W0^2/WZ^2-1.+2.*Z0*W0*TA)/(1.-2.*Z0*W0*TA+W0*W0*TA*TA);
XK=XK0/(XK1*(1+XKC));

m=0;
XNCG=XNC_fin;
TAUACT_fun(XNCG,XKA,XKDC,XKR,WI,TA,WZ,XK1,XK3,WACT,ZETAACT,W0,Z0,XK0,WAF,ZAF,TF,handles,WCR);
num1=0;
    case 4 %Altitud
ALT_fun(VM,ALT,XNC,VM_fin,XNC_fin,WACT,TAUACT,ZETAACT,TAU,WCR,ZETA,WAF,ZAF,TF,k,handles);
num1=1;

    case 5 %Velocidad VM
VM_fun(VM,ALT,XNC,ALT_fin,XNC_fin,WACT,TAUACT,ZETAACT,TAU,WCR,ZETA,WAF,ZAF,TF,k,handles);
num1=1;

    case 6 %Aceleración nc
NC_fun(VM,ALT,XNC,ALT_fin,VM_fin,WACT,TAUACT,ZETAACT,TAU,WCR,ZETA,WAF,ZAF,TF,k,handles);
num1=1;

    case 0
        
count=0;
E=0.;
ED=0.;
DELDD=0.;
DELD=0;
DEL=0.;
X=0.;
T=0;
H=.0001;
S=0;


WCR_vector=[];
TAU_vector=[];
ZETA_vector=[];
        
        
%% Funcion buscar
%Nearest/Interpolation
%k=1 es Nearest 
%k=2 es Interpolation

if exist('schedule1.mat')==2
    %Si existe el archivo schedule1.mat, entonces entrará aquí y realizará
    %el cálculo. Si no, significa que la función scheduling ha borrado el
    %schedule1,2,3 y por tanto solo se estudia para un solo caso.
 num1=1;
    
     for m=1:3
         
         %Se inicializa un bucle for donde se cargan los tres scheduling's
         %realizados por el programa. Los calculos son exactamente los
         %mismos que los realizados para ALT, VM, NC pero con W,ZETA,TAU
         
        num=strcat('schedule',num2str(m),'.mat');
        load(num);
        
        WCR_vector=[WCR_vector WCR];
        TAU_vector=[TAU_vector TAU];
        ZETA_vector=[ZETA_vector ZETA];
        
        %Se carga los nuevos vectores de VM, ALT, XNC. El número de puntos
        %cambia y por ello, se debe inicializar con estos vectores. 
        
        VM=linspace(VMMIN,VMMAX,points);
        ALT=linspace(ALTMIN,ALTMAX,points);
        XNC=linspace(XNCMIN,XNCMAX,points);
        
        %Se realiza la interpolación y el método nearest. 
        


    
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


W=(TAU*WCR*(1+2.*ZAF_value*WAF_value/WCR)-1)/(2*ZETA*TAU);
W0=W/sqrt(TAU*WCR);
Z0=.5*W0*(2*ZETA/W+TAU-WAF_value^2/(W0*W0*WCR));
XK0=-W*W/(TAU*WAF_value*WAF_value);
XKC=(-W0^2/WZ_value^2-1.+2.*Z0*W0*TA_value)/(1.-2.*Z0*W0*TA_value+W0*W0*TA_value*TA_value);
XK=XK0/(XK1_value*(1+XKC));


% Se inicializan los cálculos a partir de este punto.

count=0;
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
XNCG=XNC_fin;

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
%% Algoritmo gráficas

color=['r' 'b' 'g' 'k'];

axes(handles.axes8);
grid on
box on
plot(ArrayT(i,:),ArrayXNL(i,:),color(i),'Linewidth',1.5);
axis tight
hold on
plot(ArrayT(i,:),ArrayXNCG(i,:),'k','Linewidth',1.5)
grid on
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
box on

axes(handles.axes7);
semilogx(ArrayW(i,:),ArrayPHASE(i,:),color(i),'Linewidth',1.5);
xlabel('$\mathbf{\omega\ [rad/s]}$','interpreter','latex','FontSize',9,'FontName','arial');
ylabel('$\mathbf{\phi\ [^{o}]}$','interpreter','latex','FontSize',9,'FontName','arial');
axis tight
grid on
hold on
box on

   
    
end


graficas(ArrayT,ArrayXNL,ArrayXNCG,ArrayGAIN,ArrayPHASE,ArrayW,ZETA_vector,WCR_vector,TAU_vector,m)
    


else
    
load schedule.mat
num1=1;

if k==1
i=find(VM==VM_fin);
j=find(XNC==XNC_fin);
k=find(ALT==ALT_fin);

XKA=XKA(i,j,k);
XKR=XKR(i,j,k);
XKDC=XKDC(i,j,k);
WI=WI(i,j,k);
WAF=WAF(i,j,k);
ZAF=ZAF(i,j,k);
XK1=XK1(i,j,k);
XK3=XK3(i,j,k);
TA=TA(i,j,k);
WZ=WZ(i,j,k);

elseif k==2
    
VM=linspace(VMMIN,VMMAX,points);
ALT=linspace(ALTMIN,ALTMAX,points);
XNC=linspace(XNCMIN,XNCMAX,points);
        
XKA=interp3(XNC,VM,ALT,XKA,XNC_fin,VM_fin,ALT_fin);
XKR=interp3(XNC,VM,ALT,XKR,XNC_fin,VM_fin,ALT_fin);
XKDC=interp3(XNC,VM,ALT,XKDC,XNC_fin,VM_fin,ALT_fin);
WI=interp3(XNC,VM,ALT,WI,XNC_fin,VM_fin,ALT_fin);
WAF=interp3(XNC,VM,ALT,WAF,XNC_fin,VM_fin,ALT_fin);
ZAF=interp3(XNC,VM,ALT,ZAF,XNC_fin,VM_fin,ALT_fin);
XK1=interp3(XNC,VM,ALT,XK1,XNC_fin,VM_fin,ALT_fin);
XK3=interp3(XNC,VM,ALT,XK3,XNC_fin,VM_fin,ALT_fin);
TA=interp3(XNC,VM,ALT,TA,XNC_fin,VM_fin,ALT_fin);
WZ=interp3(XNC,VM,ALT,WZ,XNC_fin,VM_fin,ALT_fin);
end

W=(TAU*WCR*(1+2.*ZAF*WAF/WCR)-1)/(2*ZETA*TAU);
W0=W/sqrt(TAU*WCR);
Z0=.5*W0*(2*ZETA/W+TAU-WAF^2/(W0*W0*WCR));
XK0=-W*W/(TAU*WAF*WAF);
XKC=(-W0^2/WZ^2-1.+2.*Z0*W0*TA)/(1.-2.*Z0*W0*TA+W0*W0*TA*TA);
XK=XK0/(XK1*(1+XKC));      
XNCG=XNC_fin;

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
		ArrayT(count)=T;
		ArrayXNL(count)=XNL;
		ArrayXNCG(count)=XNCG;
        ArrayDelta(count)=DEL;
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
        ArrayW(count)=W;
        ArrayGAIN(count)=GAIN;
        ArrayPHASE(count)=PHASE;

end
color=['r' 'b' 'g' 'k'];
axes(handles.axes8);
plot(ArrayT,ArrayXNL,'r','Linewidth',1.5)
axis tight
grid on
hold on

plot(ArrayT,ArrayXNCG,'b','Linewidth',1.5)
xlabel('$\mathbf{Time [rev]}$','interpreter','latex','FontSize',9,'FontName','arial');
ylabel('$\mathbf{n_{L} [G]}$','interpreter','latex','FontSize',9,'FontName','arial');
axis tight
grid on
hold on

axes(handles.axes6);
semilogx(ArrayW,ArrayGAIN,'r','Linewidth',1.5);
xlabel('$\mathbf{\omega\ [rev]}$','interpreter','latex','FontSize',9,'FontName','arial');
ylabel('$\mathbf{Gain [dB]}$','interpreter','latex','FontSize',9,'FontName','arial');
axis tight
% grid on
hold on

axes(handles.axes7);
semilogx(ArrayW,ArrayPHASE,'r','Linewidth',1.5);
xlabel('$\mathbf{\omega\ [rad/s]}$','interpreter','latex','FontSize',9,'FontName','arial');
ylabel('$\mathbf{\phi\ [^{o}]}$','interpreter','latex','FontSize',9,'FontName','arial');
axis tight
grid on
hold on


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
%box on % Mostrar el dominio de graficado como una caja.
grid on


color=['r' 'b' 'g' 'k'];

% Graficas
plot(ArrayT,ArrayXNL,'r','Linewidth',1.5);
% hold on
% plot(ArrayT(i,:),ArrayXNCG(i,:),'k','Linewidth',1.5);
 %Definición de ejes
xlabel('$\mathbf{Time [s]}$','interpreter','latex','FontSize',14,'FontName','arial');
ylabel('$\mathbf{n_{L} [G]}$','interpreter','latex','FontSize',14,'FontName','arial');
hold on
% En esta parte del código se consulta el vector de valores.


plot(ArrayT,ArrayXNCG,'b','Linewidth',1.5);
hold on;




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




% Graficas
semilogx(ArrayW,ArrayGAIN,'r','Linewidth',1.5);
grid on;
 %Definición de ejes
xlabel('$\mathbf{\omega\ [rad/s]}$','interpreter','latex','FontSize',14,'FontName','arial');
ylabel('$\mathbf{Gain [dB]}$','interpreter','latex','FontSize',14,'FontName','arial');
hold on


%Gain 0 dB (vertical)
pos1=find(ArrayW==0,1,'last');
W_0dB=interp1(real(ArrayGAIN(pos1+1:end)),ArrayW(pos1+1:end),0,'spline');


%Gain -180º (vertical)
p=1;
 W_PHASE=[];
for n=1:length(ArrayPHASE)-1;
   if  (ArrayPHASE(n) < -180 && ArrayPHASE(n+1) > -180) || (ArrayPHASE(n) > -180 && ArrayPHASE(n+1) < -180)
       W_PHASE(p)=interp1(real(ArrayPHASE(n:n+1)),ArrayW(n:n+1),-180);
       p=p+1;
   end
end
if ~isempty(W_PHASE)
W_phase180=W_PHASE(length(W_PHASE)-1);
pos1=find(ArrayW==0,1,'last');

GAIN_180phase=interp1(ArrayW(pos1+1:end),real(ArrayGAIN(pos1+1:end)),W_phase180,'spline');
GAIN_WCR=interp1(ArrayW(pos1+1:end),real(ArrayGAIN(pos1+1:end)),WCR,'spline');

%1: considerando que coincide con WCR. 2: Considerando que es en 0 db
Gmar_1=abs(abs(GAIN_180phase)-abs(GAIN_WCR));
Gmar_2=(abs(GAIN_180phase));
G_error=1-(min(Gmar_1,Gmar_2)/max(Gmar_1,Gmar_2));
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
                            'FontSize',17,...
                            'FontName','arial');
% hold(axes3,'all'); % Permitir la unión de elementos gráficos.
box on % Mostrar el dominio de graficado como una caja.



% Graficas
semilogx(ArrayW,ArrayPHASE,'r','Linewidth',1.5);
grid on;
 %Definición de ejes
xlabel('$\mathbf{\omega\ [rad/s]}$','interpreter','latex','FontSize',14,'FontName','arial');
ylabel('$\mathbf{\phi\ [^{o}]}$','interpreter','latex','FontSize',14,'FontName','arial');
hold on
% En esta parte del código se consulta el vector de valores.

%WCR
if ~isempty(W_PHASE)
pos1=find(ArrayW==0,1,'last');
phase_0dB=interp1(ArrayW(pos1+1:end),real(ArrayPHASE(pos1+1:end)),W_0dB,'spline');
phase_WCR=interp1(ArrayW(pos1+1:end),real(ArrayPHASE(pos1+1:end)),WCR,'spline');

Pmar_1=abs(phase_0dB)-abs(180);
Pmar_2=(abs(phase_WCR)-180);
p_error=1-(min(abs(Pmar_1),abs(Pmar_2))/max(abs(Pmar_1),abs(Pmar_2)));

save resultados.mat W_0dB W_phase180 GAIN_180phase GAIN_WCR Gmar_1 Gmar_2 G_error...
    phase_0dB phase_WCR Pmar_1 Pmar_2 p_error 
 
end
end

end



    
  


