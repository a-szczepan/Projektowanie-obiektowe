program bubble_sort;

var
  randomNumbers: array[1..100] of integer;
  i, j, k, n, temp: integer;

procedure generateList();
begin
  randomize();
  n := 101;
  writeln('Lista losowych elementów:');
  for i := 1 to n do
  begin
    randomNumbers[i] := random(n);
    writeln(randomNumbers[i]);
  end;
end;

procedure sort();
begin
  writeln(sLineBreak + 'Posortowane elementy:');
  j := n;

  while j > 1 do
  begin
    for i := 1 to n - 1 do
      if randomNumbers[i] > randomNumbers[i + 1] then
      begin
        temp := randomNumbers[i];
        randomNumbers[i] := randomNumbers[i + 1];
        randomNumbers[i + 1] := temp;
      end;
    j := j - 1;
  end;

  for k := 1 to n do
    writeln(randomNumbers[k]);
end;

begin
  generateList();
  sort();
end.
