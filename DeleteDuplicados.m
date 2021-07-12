
clear all;
Duplicados = dir('*(*)*');
Duplicados = {Duplicados.name};
a = regexp(Duplicados,'.*\(\d\).*');
c = false(size(a));
for i = 1:length(a)
    c(i) = ~isempty(a{i});
end
Duplicados = Duplicados(c);


for i = 1:sum(c)
Duplicados{i}  
% delete(Duplicados{i})
end
