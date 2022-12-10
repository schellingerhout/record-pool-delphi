unit Pool;

interface


type


TPool<T> = Record
private
const
  RowSize = Trunc(2048/SizeOf(T)); // we allocate rows of about 2KB each

var
  Rows: TArray<TArray<T>>;

  Index: integer;

  procedure AddARow;

public
  function New: Pointer;

  class operator Initialize (out Dest: TPool<T>);   // Initializers added in Delphi 10.4
End;


implementation



{ TPool<T> }

procedure TPool<T>.AddARow;
begin
  SetLength(Rows, Length(Rows) + 1);
  SetLength(Rows[High(Rows)], RowSize);

  Index := 0;
end;


class operator TPool<T>.Initialize(out Dest: TPool<T>);
const
  DefaultRec : TPool<T> = ();
begin
  Dest := DefaultRec;
end;

function TPool<T>.New: Pointer;
begin

  if (Rows = nil) or (Index > High(Rows[High(Rows)])) then
     AddARow;

  result := @Rows[High(Rows)][Index];

  inc(Index);
end;

end.
