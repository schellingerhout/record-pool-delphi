# record-pool-delphi
 Dynamic Record Pool with Stable Pointers (Delphi)
 
 Code for blog post https://schellingerhout.github.io/memory%20management/record-pool-delphi/
 

 `New` as defined in `System.pas` can be slow in repeated calls to create records, to speed it up we can use a Pool to allocate new records and return pointers. For instance:
 
 Given these types
 ```pascal
 type
 PMyRec = ^TMyRec;
 TMyRec = Record
 // ... details of record immaterial
 end;
 ```
 
Declare a pool as follows
``` pascal
var
  RecordPool: TPool<TMyRec>;
```

And use `New` on the pool instead to get a pointer instead of the `System.New()` loose function
``` pascal
var
  RecordPtr: PMyRec;
begin
...
   RecordPtr := RecordPool.New();
...
end;
```

As applications require please modify `AddARow` as needed, to potentially grow rows (e.g. 1.5 times the size of the prior row). Alternatively extend this type to accept a custom growth function to determine pool growth.
 

     
