-module(khf1).
-author('ddkatona@gmail.com').
-vsn('2018-10-15').
-export([lista_zsak/1]).
%-compile(export_all).

lista_zsak([]) -> [];
lista_zsak(L) -> [{E,M} || E <- lists:usort(L), M <- [count_element(L,E)]].

count_element([],_) -> 0;
count_element(L, E) -> 
	H = hd(L),
	if
		H == E -> R = 1 + count_element(L--[H], E);
	true ->
		R = count_element(L--[H], E)
	end,
	R.
