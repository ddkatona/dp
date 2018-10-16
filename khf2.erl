-module(khf2).
-author('ddkatona@gmail.com').
-vsn('2018-10-15').
-export([tipp_kod/2, lista_zsak/1, rek/3, get_lists/2]).
%-compile(export_all).

tipp_kod(Max, Tipp_S) -> 
	[H|T] = element(1, Tipp_S).
	

lista_zsak([]) -> [];
lista_zsak(L) -> [M || E <-lists:usort(L), M <- [count_element(L,E)]].

rekurzio([],[],K) -> 
	case K == 0 of
		true -> [[]];
		false -> []
	end;
%rekurzio([L],[0],0) -> [[L]];
%rekurzio([H1|[]],[H2g|[]],H3) -> [];
rekurzio(H, L, K) ->
	case hd(H) < 0 of
		true -> [];
		false ->
			case K < 0 of
				true -> [];
				false -> 
					R = rekurzio([hd(H)-1|tl(H)], L, K),
					P = rekurzio(tl(H), tl(L), K-min(hd(H), hd(L))),
					Q = [[hd(H)|S] || S <- P], 
					lists:append(R,Q)
			end
	end.	

rek(H, L, K) ->
	get_lists(lists:sum(L), rekurzio(H,L,K)).

get_lists(Size, L) -> lists:filter(fun(X) -> lists:sum(X) =:= Size end, L).

missing_elements(0, L) -> [];
missing_elements(Max, L) -> 
	case lists:member(Max, L) of 
		false -> R = [Max|missing_elements(Max-1, L)];
		true -> R = missing_elements(Max-1, L)
	end,
	R.	

count_element([],_) -> 0;
count_element(L, E) -> 
	H = hd(L),
	if
		H == E -> R = 1 + count_element(L--[H], E);
	true ->
		R = count_element(L--[H], E)
	end,
	R.
