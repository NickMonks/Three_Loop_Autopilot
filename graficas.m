function graficas(ArrayT,ArrayXNL,ArrayXNCG,ArrayGAIN,ArrayPHASE,ArrayW,ZETA_vector,WCR_vector,TAU_vector,m)

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


if ZETA_vector(1)~=ZETA_vector(2)
    
datastr1=strcat('ZETA= ',num2str(ZETA_vector(1)),'[-]');

datastr2=strcat('ZETA = ',num2str(ZETA_vector(2)),'[-]');

datastr3=strcat('ZETA = ',num2str(ZETA_vector(3)),'[-]');

b1=legend(datastr1,datastr2,datastr3);
set(b1,'FontSize',14);


elseif WCR_vector(1)~=WCR_vector(2)
    
datastr1=strcat('WCR = ',num2str(WCR_vector(1)),'[rad/s]');

datastr2=strcat('WCR = ',num2str(WCR_vector(2)),'[rad/s]');

datastr3=strcat('WCR = ',num2str(WCR_vector(3)),'[rad/s]');

b1=legend(datastr1,datastr2,datastr3);
set(b1,'FontSize',14);


elseif TAU_vector(1)~=TAU_vector(2)

datastr1=strcat('TAU = ',num2str(TAU_vector(1)),'[s]');

datastr2=strcat('TAU = ',num2str(TAU_vector(2)),'[s]');

datastr3=strcat('TAU = ',num2str(TAU_vector(3)),'[s]');

b1=legend(datastr1,datastr2,datastr3);
set(b1,'FontSize',14);
end

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
hold on;
grid on;


 %Definición de ejes
xlabel('$\mathbf{\omega\ [rad/s]}$','interpreter','latex','FontSize',14,'FontName','arial');
ylabel('$\mathbf{Gain [dB]}$','interpreter','latex','FontSize',14,'FontName','arial');
hold on;
grid on;
end
% En esta parte del código se consulta el vector de valores.

if ZETA_vector(1)~=ZETA_vector(2)
    
 datastr1=strcat('ZETA= ',num2str(ZETA_vector(1)),'[-]');

datastr2=strcat('ZETA = ',num2str(ZETA_vector(2)),'[-]');

datastr3=strcat('ZETA = ',num2str(ZETA_vector(3)),'[-]');

b2=legend(datastr1,datastr2,datastr3);
set(b2,'FontSize',14);


elseif WCR_vector(1)~=WCR_vector(2)
    
datastr1=strcat('WCR = ',num2str(WCR_vector(1)),'[rad/s]');

datastr2=strcat('WCR = ',num2str(WCR_vector(2)),'[rad/s]');

datastr3=strcat('WCR = ',num2str(WCR_vector(3)),'[rad/s]');

b2=legend(datastr1,datastr2,datastr3);
set(b2,'FontSize',14);


elseif TAU_vector(1)~=TAU_vector(2)

datastr1=strcat('TAU = ',num2str(TAU_vector(1)),'[s]');

datastr2=strcat('TAU = ',num2str(TAU_vector(2)),'[s]');

datastr3=strcat('TAU = ',num2str(TAU_vector(3)),'[s]');

b2=legend(datastr1,datastr2,datastr3);
set(b2,'FontSize',14);
end

for i=1:m
    
    %Gain 0 dB (horizontal)
vector_zero=zeros(length(ArrayW(i,:)));
semilogx(ArrayW(i,:),vector_zero,'k','Linewidth',1);
grid on;
hold on;
 %Gain 0 dB (vertical)
pos1=find(ArrayW(i,:)==0,1,'last');
W_0dB(i)=interp1(ArrayGAIN(i,pos1+1:end),ArrayW(i,pos1+1:end),0,'spline');

v_WCR=[];
v_WCR(1:length(ArrayGAIN(i,:)))=W_0dB(i);
semilogx(v_WCR,ArrayGAIN(i,:),'k','Linewidth',1);

%Gain -180º (vertical)
p=1;
W_PHASE=[];
for n=1:length(ArrayPHASE)-1;
   if  (ArrayPHASE(i,n) < -180 && ArrayPHASE(i,n+1) > -180) || (ArrayPHASE(i,n) > -180 && ArrayPHASE(i,n+1) < -180)
       W_PHASE(p)=interp1(ArrayPHASE(i,n:n+1),ArrayW(i,n:n+1),-180);
       p=p+1;
   end
end
if ~ isempty(W_PHASE)
W_phase180(i)=W_PHASE(length(W_PHASE)-1);
pos1=find(ArrayW(i,:)==0,1,'last');

GAIN_180phase(i)=interp1(ArrayW(i,pos1+1:end),ArrayGAIN(i,pos1+1:end),W_phase180(i),'spline');
GAIN_WCR(i)=interp1(ArrayW(i,pos1+1:end),ArrayGAIN(i,pos1+1:end),WCR_vector(i),'spline');

%1: considerando que coincide con WCR. 2: Considerando que es en 0 db
W_error(i)=(abs(WCR_vector(i))-abs(W_0dB(i)))/max(W_0dB(i),WCR_vector(i));
Gmar_1(i)=abs(abs(GAIN_180phase(i))-abs(GAIN_WCR(i)));
Gmar_2(i)=(abs(GAIN_180phase(i)));
G_error(i)=1-(min(Gmar_1(i),Gmar_2(i))/max(Gmar_1(i),Gmar_2(i)));




v_W180=[];
v_W180(1:length(ArrayGAIN(i,:)))=W_phase180(i);
semilogx(v_W180,ArrayGAIN(i,:),'k','Linewidth',1);

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
                            'FontSize',17,...
                            'FontName','arial');
% hold(axes3,'all'); % Permitir la unión de elementos gráficos.
box on % Mostrar el dominio de graficado como una caja.


for i=1:m


% Graficas
semilogx(ArrayW(i,:),ArrayPHASE(i,:),color(i),'Linewidth',1.5);
grid on;
hold on;




 %Definición de ejes
xlabel('$\mathbf{\omega\ [rad/s]}$','interpreter','latex','FontSize',14,'FontName','arial');
ylabel('$\mathbf{\phi\ [^{o}]}$','interpreter','latex','FontSize',14,'FontName','arial');
hold on
% En esta parte del código se consulta el vector de valores.
end

if ZETA_vector(1)~=ZETA_vector(2)
    
 datastr1=strcat('ZETA= ',num2str(ZETA_vector(1)),'[-]');

datastr2=strcat('ZETA = ',num2str(ZETA_vector(2)),'[-]');

datastr3=strcat('ZETA = ',num2str(ZETA_vector(3)),'[-]');

b3=legend(datastr1,datastr2,datastr3);
set(b3,'FontSize',14);


elseif WCR_vector(1)~=WCR_vector(2)
    
datastr1=strcat('WCR = ',num2str(WCR_vector(1)),'[rad/s]');

datastr2=strcat('WCR = ',num2str(WCR_vector(2)),'[rad/s]');

datastr3=strcat('WCR = ',num2str(WCR_vector(3)),'[rad/s]');

b3=legend(datastr1,datastr2,datastr3);
set(b3,'FontSize',14);


elseif TAU_vector(1)~=TAU_vector(2)

datastr1=strcat('TAU = ',num2str(TAU_vector(1)),'[s]');

datastr2=strcat('TAU = ',num2str(TAU_vector(2)),'[s]');

datastr3=strcat('TAU = ',num2str(TAU_vector(3)),'[s]');

b3=legend(datastr1,datastr2,datastr3);
set(b3,'FontSize',14);
end

if ~isempty(W_PHASE)
for i=1:m
%Phase -180º
vector_phase=[];
vector_phase(1:length(ArrayW(i,:)))=-180;

semilogx(ArrayW(i,:),vector_phase,'k','Linewidth',1.5);
grid on;
hold on;

pos1=find(ArrayW(i,:)==0,1,'last');
W_val=interp1(ArrayGAIN(i,pos1+1:end),ArrayW(i,pos1+1:end),0,'spline')
%WCR

pos1=find(ArrayW(i,:)==0,1,'last');
phase_0dB(i)=interp1(ArrayW(i,pos1+1:end),ArrayPHASE(i,pos1+1:end),W_0dB(i),'spline');
phase_WCR(i)=interp1(ArrayW(i,pos1+1:end),ArrayPHASE(i,pos1+1:end),WCR_vector(i),'spline');

Pmar_1(i)=abs(phase_0dB(i))-abs(180);
Pmar_2(i)=(abs(phase_WCR(i))-180);
p_error(i)=1-(min(abs(Pmar_1(i)),abs(Pmar_2(i)))/max(abs(Pmar_1(i)),abs(Pmar_2(i))));
end
save resultados.mat W_0dB W_phase180 GAIN_180phase GAIN_WCR Gmar_1 Gmar_2 G_error...
    phase_0dB phase_WCR Pmar_1 Pmar_2 p_error W_error 
end
