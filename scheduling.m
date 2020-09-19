function scheduling (XL, XN, XHL, CTT, CTW, CRT, CRW, HW, HT,DIAM,WGT,XCG,...
    WCR,ZETA,TAU,ALTMIN,ALTMAX,XNCMIN,XNCMAX,VMMIN,VMMAX,...
    SWING,STAIL,SREF,XLP,SPLAN,XCPN,XCPB,XCPW,points,num)
   %New Inputs: WCR,ZETA,TAU; ALT, VM, XNCG
   %scheduling(15,6,0.5,14.5,1,1.5,3,3,2,2,1000,7.5,50,0.7,0.3,0,33000,1,10,500,3000)
clc;
%ALTMIN=0;ALTMAX=100;XNCMIN=1;XNCMAX=20;VMMIN=1;VMMAX=8;
% points=2;
  i=1;j=1;k=1;
for ALT=linspace(ALTMIN,ALTMAX,points)
    for XNCG=linspace(XNCMIN,XNCMAX,points)
        for VM=linspace(VMMIN,VMMAX,points)

%Vel. del sonido
T0=298; 
lambda = -6.5e-3;
T=T0+lambda*ALT;
gamma=1.4;
R=287;
A=sqrt(R*T*gamma); %m/s
A=A*3.28083; %ft/s

if ALT<=30000.
	RHO=.002378*exp(-ALT/30000.);
else
	RHO=.0034*exp(-ALT/22000.);
end

%% Ecuaciones superficie
XACC=XCG;

%% Cálculos aerodinámicos
XMACH=VM/A;
XIYY=WGT*(3*((DIAM/2)^2)+XL*XL)/(12*32.2);
TMP1=(XCG-XCPW)/DIAM;
TMP2=(XCG-XHL)/DIAM;
TMP3=(XCG-XCPB)/DIAM;
TMP4=(XCG-XCPN)/DIAM;
if XMACH>1
    B=sqrt(XMACH^2-1);
else
B=sqrt(1-XMACH^2);
end

Q=.5*RHO*VM*VM;
P1=WGT*XNCG/(Q*SREF);
Y1=2+8*SWING/(B*SREF)+8*STAIL/(B*SREF);
Y2=1.5*SPLAN/SREF;
Y3=8*STAIL/(B*SREF);
Y4=2*TMP4+8*SWING*TMP1/(B*SREF)+8*STAIL*TMP2/(B*SREF);
Y5=1.5*SPLAN*TMP3/SREF;
Y6=8*STAIL*TMP2/(B*SREF);
P2=Y2-Y3*Y5/Y6;
P3=Y1-Y3*Y4/Y6;
ALFTR=(-P3+sqrt(P3*P3+4.*P2*P1))/(2.*P2);
DELTR=-Y4*ALFTR/Y6-Y5*ALFTR*ALFTR/Y6;
CNA=2+1.5*SPLAN*ALFTR/SREF+8*SWING/(B*SREF)+8*STAIL/(B*SREF);
CND=8*STAIL/(B*SREF);
CMAP=2*TMP4+1.5*SPLAN*ALFTR*TMP3/SREF+8*SWING*TMP1/(B*SREF);
CMA=CMAP+8*STAIL*TMP2/(B*SREF);
CMD=8*STAIL*TMP2/(B*SREF);
XMA=Q*SREF*DIAM*CMA/XIYY;
XMD=Q*SREF*DIAM*CMD/XIYY;
ZA=-32.2*Q*SREF*CNA/(WGT*VM);
ZD=-32.2*Q*SREF*CND/(WGT*VM);

%% Otras variables 
%% Otras variables


WZ(i,j,k)=sqrt((XMA*ZD-ZA*XMD)/ZD);
WAF(i,j,k)=sqrt(-XMA);
ZAF(i,j,k)=.5*WAF(i,j,k)*ZA/XMA;
XK1(i,j,k)=-VM*(XMA*ZD-XMD*ZA)/(1845*XMA);
XK2=XK1(i,j,k);
XK3(i,j,k)=1845*XK1(i,j,k)/VM;
TA(i,j,k)=XMD/(XMA*ZD-XMD*ZA);
W=(TAU*WCR*(1+2.*ZAF(i,j,k)*WAF(i,j,k)/WCR)-1)/(2*ZETA*TAU);
W0=W/sqrt(TAU*WCR);
Z0=.5*W0*(2*ZETA/W+TAU-(WAF(i,j,k)*WAF(i,j,k))/(W0*W0*WCR));


%% Almacenamiento

XKC=(-W0^2/(WZ(i,j,k)*WZ(i,j,k))-1.+2.*Z0*W0*TA(i,j,k))/(1.-2.*Z0*W0*TA(i,j,k)+...
    W0*W0*TA(i,j,k)*TA(i,j,k));
XKA(i,j,k)=XK3(i,j,k)/(XK1(i,j,k)*XKC);

%Almacenamiento WI
XK0=-W*W/(TAU*WAF(i,j,k)*WAF(i,j,k));
XK=XK0/(XK1(i,j,k)*(1+XKC));
WI(i,j,k)=XKC*TA(i,j,k)*W0*W0/(1+XKC+(W0^2/(WZ(i,j,k)*WZ(i,j,k))));

%Almacenamiento KR
XKR(i,j,k)=XK/(XKA(i,j,k)*WI(i,j,k));

%Almacenamiento KDC
XKDC(i,j,k)=1.+1845./(XKA(i,j,k)*VM);

i=i+1;
        end
        j=j+1;
        i=1;
    end
    k=k+1;
    i=1;
    j=1;
end

if num==0
    
save schedule.mat XKA WI XKR XKDC ALTMIN ALTMAX XNCMIN XNCMAX VMMIN VMMAX points ...
    XK1 XK3 TA WZ WCR ZETA TAU WAF ZAF ;
delete schedule1.mat;
delete schedule2.mat;
delete schedule3.mat;

elseif num~=0
   
    sch=strcat('schedule',num2str(num));
    save(sch,'XKA','WI','XKR','XKDC','ALTMIN','ALTMAX','XNCMIN','XNCMAX','VMMIN','VMMAX','points','XK1','XK3','TA','WZ','WCR','ZETA','TAU','WAF','ZAF');
end


