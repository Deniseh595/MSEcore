printfig = figure('Visible','off');
figaxes=copyobj(handles.axes1,printfig);
set(figaxes,'outerposition',[0 0 1 1])
print(gcf,'axesprint.eps','-depsc2')
saveas(gcf,'axesprint.fig')
close(printfig)