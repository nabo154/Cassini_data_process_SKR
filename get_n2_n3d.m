function [tvec,fvec,Sm,qm,um,vm,thm,phm,DFm,Pxm,Pwm]=get_n2_n3d(year,doy,hour,hd)

hx=3.06;hu=1.68;hw=1.68/1.2;           % effective length of dipole and monopole in m

Sm = []; qm=[];um=[];vm=[]; thm=[]; phm=[];
tvecm = [];
DFm =[];
Pxm=[];Pwm=[];

load('D:\Cassini_RPWS_Code\f_359','f_359');
fvecm = f_359;

for h=hour:(hour+hd-1)
    fvec=[];tvec=[];
    
    day=doy+floor(h/24);
    hr=mod(h,24);
    data.num = []; data.f=[];data.t97=[];data.autoX=[];data.autoZ=[];
    data.crossR=[];data.crossI=[];data.ant=[]; data.df=[];
    % Read level 2 data
    [d,s]=readn2(year,day,hr);
    
    if s==0;continue;end
    data.num = [data.num;d.num];
    data.f=[data.f;d.f];data.t97=[data.t97;d.t97];data.ant=[data.ant;d.ant];
    data.autoX=[data.autoX;d.autoX];data.autoZ=[data.autoZ;d.autoZ];
    %     data.crossR=[data.crossR;d.crossR];data.crossI=[data.crossI;d.crossI];
    data.ant= [data.ant;d.ant];
    %     data.df=[data.df;d.df];
    
    d3.num=[];d3.S=[];d3.q=[];d3.u=[];
    d3.v=[];d3.th=[];d3.ph=[];
    % Read level 3 data
    [d,s]=readn3d(year,day,hr);
    if s==0;continue;end
    d3.num=[d3.num;d.num];
    d3.S=[d3.S;d.S];d3.q=[d3.q;d.q];
    d3.u=[d3.u;d.u];d3.v=[d3.v;d.v];
    d3.th=[d3.th;d.th];d3.ph=[d3.ph;d.ph];
    
    
    % Arrange the data
    %fvec=[];tvec=[];
    fvec=unique(data.f);                        % set up frequency vector
    tvec=unique(data.t97);                      % set up time vector
    %     if h == hour && 1.1*length(fvecm) < length(fvec)
    %         fvecm = fvec;
    %     end
    S = zeros([length(tvec),359]);
    q = zeros([length(tvec),359]);
    u = zeros([length(tvec),359]);
    v = zeros([length(tvec),359]);
    th = zeros([length(tvec),359]);
    ph = zeros([length(tvec),359]);
    DFmode = zeros([length(tvec),1]);
    Px = zeros([length(tvec),359]);
    Pw = zeros([length(tvec),359]);
    if length(fvec)==length(fvecm)
        for i=1:length(tvec)        % loop over all times
            ind1=find(data.t97==tvec(i));               % indices of this sweep
            if(max(ind1)>length(data.f))
                continue
            end
            for jj=1:length(fvecm)
                ind2=find(data.f(ind1)==fvecm(jj));       % frequencies in this sweep
                ind3=min(ind1(ind2));  % could be 2 freq., choose minimum
                
                if length(ind3) == 0||ind3>length(data.autoX)||ind3>length(data.autoZ)||ind3>length(data.ant)
                    continue
                end
                %             if length(fvec)==length(fvecm)
                %                j = jj;
                %             else
                %               [minvalue, j] = min( abs( fvecm-fvec(jj) ) );
                %             end
                j=jj;
                ind4=find(d3.num == data.num(ind3));
                if length(ind4)==0
                    continue
                end
                
                S(i,j)=d3.S(ind4); q(i,j)=d3.q(ind4); u(i,j)=d3.u(ind4);
                v(i,j)=d3.v(ind4);    %level n3e data
                th(i,j)=d3.th(ind4); ph(i,j)=d3.ph(ind4);
                Px(i,j)=data.autoX(ind3);
                Pw(i,j)=data.autoZ(ind3);
                %             if ph(i,j)<0
                %                 ph(i,j)= ph(i,j)+2*pi;
                %             end
                
                if data.ant(ind3)~=3
                    DFmode(i)=1;
                end
                
                if data.autoZ(ind3)==0  % only 1 antenna, no Stokes parameters
                    q(i,j)=0;u(i,j)=0;v(i,j)=0;
                end
                
            end
        end
    else
        % disp('else')
        for i=1:length(tvec)        % loop over all times
            ind1=find(data.t97==tvec(i));               % indices of this sweep
            if(max(ind1)>length(data.f))
                continue
            end
            for jj=1:length(fvecm)
                ind2=find(abs(data.f(ind1)-fvecm(jj))==min(abs(data.f(ind1)-fvecm(jj))));       % frequencies in this sweep
                ind3=min(ind1(ind2));  % could be 2 freq., choose minimum
                
                if length(ind3) == 0||ind3>length(data.autoX)||ind3>length(data.autoZ)||ind3>length(data.ant)
                    continue
                end
                %             if length(fvec)==length(fvecm)
                %                j = jj;
                %             else
                %               [minvalue, j] = min( abs( fvecm-fvec(jj) ) );
                %             end
                j=jj;
                ind4=find(d3.num == data.num(ind3));
                if length(ind4)==0
                    continue
                end
                
                S(i,j)=d3.S(ind4); q(i,j)=d3.q(ind4); u(i,j)=d3.u(ind4);
                v(i,j)=d3.v(ind4);    %level n3e data
                th(i,j)=d3.th(ind4); ph(i,j)=d3.ph(ind4);
                Px(i,j)=data.autoX(ind3);
                Pw(i,j)=data.autoZ(ind3);
                %             if ph(i,j)<0
                %                 ph(i,j)= ph(i,j)+2*pi;
                %             end
                
                if data.ant(ind3)~=3
                    DFmode(i)=1;
                end
                
                if data.autoZ(ind3)==0  % only 1 antenna, no Stokes parameters
                    q(i,j)=0;u(i,j)=0;v(i,j)=0;
                end
                
            end
        end
    end
        
        Sm = [Sm;S]; qm=[qm;q]; um=[um;u];vm=[vm;v];
        thm= [thm;th];
        phm= [phm;ph];
        tvecm = [tvecm;tvec];
        DFm = [DFm; DFmode];
        Pwm=[Pwm;Pw];
        Pxm=[Pxm;Px];
        
    end
    
    Sm(find(Sm<1e-17))=1e-17;
    tvec = tvecm;
    fvec = fvecm;
    Sm=Sm';
    qm=qm';
    um=um';
    vm=vm';
    Pxm=Pxm';
    Pwm=Pwm';
    thm=thm';
    phm=phm';
end
