%% plot
[FILENAME, PATHNAME, FILTERINDEX] = ...
    uigetfile('*.*', 'select csvs', 'MultiSelect','on');
if FILTERINDEX > 0
    results = [];  % close all;
    if ~iscell(FILENAME)
        FILENAME = {FILENAME};
    end
    for name = sort(FILENAME)
        r = process([PATHNAME, name{1}], false);
        results = [results; r];
    end
    result_table = struct2table([results]);
    [B,I] = sort( mean([result_table.med_d2h, result_table.med_h2d]') );
    result_table_sorted = struct2table(results(flip(I)))
    
    scatter_plot_them_all_2KiB(result_table_sorted);
end

function [ output ] = process( path_in, plot_switch )
[pathstr,name,ext] = fileparts(path_in);
data_raw = csvread(path_in, 1, 0);

H2D = data_raw(2:end,1)'; D2H = data_raw(2:end,2)';
if plot_switch
figure; histogram(H2D, 8); 
    title( ...
            sprintf( ...
                '%s H2D\nmedian=%.2f std=%.2f max=%.2f',  ...
                strrep(name,'_','\_'), median(H2D), std(H2D), max(H2D) ...
            ) ...
        );

    figure; histogram(D2H, 8); 
    title( ...
            sprintf( ...
                '%s D2H\nmedian=%.2f std=%.2f max=%.2f',  ...
                strrep(name,'_','\_'), median(D2H), std(D2H), max(D2H) ...
            ) ...
        );

    figure; plot(H2D, D2H, '.'); grid on;
    xlabel('H2D'); ylabel('D2H'); title(strrep(name,'_','\_'));
end

output = struct; output.data = data_raw; output.name = name;
output.med_h2d = median(H2D); output.med_d2h = median(D2H);

end

function [] = scatter_plot_and_histogram( data, name )
    figure; plot(data(:,1), data(:,2), '.', 'MarkerSize',10);
    title(name);  grid on; xlabel('H2D'); ylabel('D2H'); 
    figure; histogram(data(:), 20); 
    title(name);
end

function [] = scatter_plot_them_all_2KiB( result_table )
    KiB_ind = find(result_table.med_d2h < 0.1);
    KiB_time = 2048e-9 ./ cell2mat(result_table.data(KiB_ind)) .* 1e6;
    h2d_med = []; d2h_med = [];
    figure; hold on;
    for series = KiB_ind'
        KiB_time = 2048e-9 ./ cell2mat(result_table.data(series)) .* 1e6;
        plot(KiB_time(:,1), KiB_time(:,2), '.', 'MarkerSize',10);
        h2d_med(end+1) = median( KiB_time(:,1) );
        d2h_med(end+1) = median( KiB_time(:,2) );
    end
    hold off; title('2 KiB transfer time (micro seconds)'); 
    xlabel('H2D'); ylabel('D2H'); grid on; 
    legend(strrep(result_table.name(KiB_ind),'_','\_'));
    table(result_table.name(KiB_ind), h2d_med', d2h_med', ...
        'VariableNames', {'name','h2d_med','d2h_med'})
    axis([0 300 0 300]);
end
