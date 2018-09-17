function simple_recorder()
%SIMPLE_RECORDER Simple audio recorder.
%   Urban Eriksson 2018 no copyright
    
    hfigtest = findobj( 'Type', 'Figure', 'Name', 'Simple recorder' );
    
    if isempty(hfigtest)
        handles.hfig = figure;
        set(handles.hfig,'Name','Simple recorder','NumberTitle','off');
        handles.hrec = uicontrol('Style','push','string','Recording start/stop','units','normalized','position',[0.2 0.88 0.6 0.1],'fontsize',14,'visible','on','HorizontalAlignment','center');
        handles.hrsc = uicontrol('Style','checkbox','string','Normalize','units','normalized','position',[0.45 0.1 0.2 0.08],'fontsize',12,'visible','on','value',1);
        handles.hrev = uicontrol('Style','checkbox','string','Reverse','units','normalized','position',[0.7 0.1 0.2 0.08],'fontsize',12,'visible','on');
        handles.txt1 = uicontrol('Style','text','string','Rec(Hz)','units','normalized','position',[0.1 0.09 0.15 0.07],'fontsize',12);
        handles.txt2 = uicontrol('Style','text','string','Play(Hz)','units','normalized','position',[0.1 0.01 0.15 0.07],'fontsize',12);
        handles.hsmp1 = uicontrol('Style','edit','string','22050','units','normalized','position',[0.25 0.1 0.15 0.07],'fontsize',12);
        handles.hsmp2 = uicontrol('Style','edit','string','22050','units','normalized','position',[0.25 0.02 0.15 0.07],'fontsize',12);
        handles.hply = uicontrol('Style','push','string','Play','units','normalized','position',[0.45 0.02 0.2 0.07],'fontsize',12,'visible','on');
        handles.hsav = uicontrol('Style','push','string','Save','units','normalized','position',[0.7 0.02 0.2 0.07],'fontsize',12,'visible','on');
        handles.hrec.UserData.isrecording = false;
        handles.hall = [handles.hrsc handles.hrev handles.txt1 handles.txt2];
        set(gca,'position', [0.1300 0.2500 0.7750 0.6000]);
        fs = str2double(get(handles.hsmp1,'string'));
        ar = audiorecorder(fs, 16, 1);
        handles.hrec.UserData.ar = ar;
        set(handles.hrec,'callback',{@record_callback,handles})
        set(handles.hrsc,'callback',{@plot_callback,handles});
        set(handles.hrev,'callback',{@rev_callback,handles});
        set(handles.hply,'callback',{@play_callback,handles});
        set(handles.hsav,'callback',{@save_callback,handles});
        set(handles.hsmp1,'callback',{@sample_callback,handles});
    else
        figure(hfigtest)
    end
    
end

function [t,wave_data,t_min,t_max] = get_transformed_audio(handles)
    ar = handles.hrec.UserData.ar;
    wave_data = getaudiodata(ar);
    normalize = get(handles.hrsc,'value');
    if normalize
        wave_data =  wave_data / max(abs(wave_data));
    end
    fs = get(ar,'SampleRate');
    t = (0:length(wave_data)-1)/fs;
    ax = axis;
    t_min = ax(1);
    t_max = ax(2);
    rev = get(handles.hrev,'value');
    if rev
        wave_data =  wave_data(end:-1:1);
    end
end

function sample_callback(evt,src,handles)
    fsstr = get(handles.hsmp1,'string');
    fs = str2double(fsstr);
    handles.hrec.UserData.ar = audiorecorder(fs, 16, 1);
    disp(get(handles.hrec.UserData.ar,'SampleRate'));
end

function record_callback(evt,src,handles)
    ar = handles.hrec.UserData.ar;
    disp(get(ar,'SampleRate'));
    if ~handles.hrec.UserData.isrecording
        handles.hrec.UserData.isrecording = true;
        set(handles.hfig,'color',[1 0 0]);
        set(handles.hall,'BackgroundColor',[1 0 0]);
        ar.record()
    else
        handles.hrec.UserData.isrecording = false;
        ar.stop();
        set(handles.hfig,'color',[0.9400 0.9400 0.9400])
        set(handles.hall,'BackgroundColor',[0.9400 0.9400 0.9400])
        [t,wave] = get_transformed_audio(handles);
        plot(t,wave)
    end
end

function plot_callback(evt,src,handles)
    figure(handles.hfig)
    [t,wave] = get_transformed_audio(handles);
    hch = get(gca,'children');
    set(hch,'Xdata',t)
    set(hch,'Ydata',wave);
    mabs = max(abs(wave));
    set(gca,'YLim',[-mabs mabs]);
end

function rev_callback(evt,src,handles)
    xlim = get(gca,'XLim');
    [t,wave] = get_transformed_audio(handles);
    hch = get(gca,'children');
    set(hch,'Ydata',wave);
    maxt = max(t);
    set(gca,'XLim',[maxt-xlim(2) maxt-xlim(1)]);
end

function play_callback(evt,src,handles)
    [t,wave,t_min,t_max] = get_transformed_audio(handles);
    ix = t >= t_min & t <= t_max;
    fs = str2double(get(handles.hsmp2,'string'));
    ap = audioplayer(wave(ix),fs);
    ap.playblocking();
end

function save_callback(evt,src,handles)
    [t,wave,t_min,t_max] = get_transformed_audio(handles);
    ix = t >= t_min & t <= t_max;
    lastpath = get_variable('simplerecorder','storepath');
    [fname,fpath] = uiputfile('*.wav','Save clip',lastpath);
    if ~isempty(fname)
        fullfilename = [fpath fname];
        disp([ '- Storing ' fullfilename])
        fs = str2double(get(handles.hsmp2,'string'));
        audiowrite(fullfilename, wave(ix) ,fs)
        set_variable('simplerecorder','storepath',fpath);
    end
end

function value = get_variable(appname,key)
    datapath = [ getenv('appdata') '\MathWorks\MATLAB\PermData\'];
    if exist (datapath,'dir')
        fname = [appname '.mat'];
        if exist([datapath fname],'file')
           load([datapath fname]);
           if isfield(perm_data,key)
               value = perm_data.(key);
           else
               value = [];
           end
        else
            value = [];
        end
    else
        value = [];
    end
end

function set_variable(appname,key,value)
    basepath = [ getenv('appdata') '\MathWorks\MATLAB\'];
    if ~exist([basepath 'PermData'],'dir')
        mkdir(basepath,'PermData');
    end
    datapath = [ basepath '\PermData\'];
    fname = [appname '.mat'];
    if exist([datapath fname],'file')
       load([datapath fname]);
    else
        perm_data = [];
    end
    perm_data.(key) = value;
    save([datapath fname],'perm_data')
end