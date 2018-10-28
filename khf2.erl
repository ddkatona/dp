-module(khf2).
-author('ddkatona@gmail.com').
-vsn('2018-10-28').
-export([tipp_kod/2]).
%-compile(export_all).

tipp_kod(Max, Tipp_S) -> 
	[H|T] = element(1, Tipp_S),
	Plus_one = lists:seq(1,Max,1) ++ [H|T],
	LZS = lista_zsak(Plus_one),
	F = lists:map(fun(X) -> X - 1 end, LZS),
	DUP = lists:duplicate(erlang:length(F),erlang:length([H|T])),
	rek(DUP, F, element(2, Tipp_S)).
	

lista_zsak([]) -> [];
lista_zsak(L) -> [M || E <-lists:usort(L), M <- [count_element(L,E)]].

rekurzio([],[],K) -> 
	case K == 0 of
		true -> [[]];
		false -> []
	end;
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

rek(H, _, K) when K > hd(H) -> [];
rek(H, L, K) when K == hd(H) -> perm(L,1,1);
rek(H, L, K) when K < hd(H) ->
	Zsak = get_lists(lists:sum(L), rekurzio(H,L,K)),
	append_all(Zsak).

append_all([]) -> [];
append_all(O) ->
	perm(hd(O),1,1) ++ append_all(tl(O)).

get_lists(Size, L) -> lists:filter(fun(X) -> lists:sum(X) =:= Size end, L).

% perm([2, 1, 2, 4], 1, 0).
perm([], _, _) -> [[]];
perm([1], N, _) -> [[N]];
perm(L, _, I) when erlang:length(L) < I -> [];
perm(L, N, I) ->
	case hd(L) == 0 of
		true -> 
			perm(tl(L), N+1, 1);
		false ->
			case lists:nth(I,L) == 0 of
				true -> 
					L1 = [],
					L2 = perm(L, N, I+1),
					L1 ++ L2;
				false ->
					{L1a,L1b} = lists:split(I-1,L),
					L1b2 = [hd(L1b)-1|tl(L1b)],		
					L1 = [[N+I-1|T] || T <- perm(L1a ++ L1b2, N, 1)],
					L2 = perm(L, N, I+1),
					L1 ++ L2
			end	
	end.

count_element([],_) -> 0;
count_element(L, E) -> 
	H = hd(L),
	if
		H == E -> R = 1 + count_element(L--[H], E);
	true ->
		R = count_element(L--[H], E)
	end,
	R.
