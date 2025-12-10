// W25Q16JV

{$readUID} // Read Unique ID
begin
  if not SPIEnterProgMode(_SPI_SPEED_MAX) then LogPrint('Error setting SPI speed');

  SPIWrite(0, 5, $4B, 0,0,0,0);
  SPIReadToEditor(1, 8);

  SPIExitProgMode();
end

{$readSFDP} // Read SFDP Register
begin
  if not SPIEnterProgMode(_SPI_SPEED_MAX) then LogPrint('Error setting SPI speed');

  SPIWrite(0, 5, $5A, 0,0,0,0);
  SPIReadToEditor(1, 256);

  SPIExitProgMode();
end

{$readSS} // Read Security Sector
begin
  if not SPIEnterProgMode(_SPI_SPEED_MAX) then LogPrint('Error setting SPI speed');

  for i:=1 to 3 do
  begin
    SPIWrite(0, 5, $48, 0,(i SHL 4),0,0);
    SPIReadToEditor(1, 256);
  end;

  SPIExitProgMode();
end

{$eraseSS} // Erase Security Sector
begin
  if not SPIEnterProgMode(_SPI_SPEED_MAX) then LogPrint('Error setting SPI speed');

  for i:=1 to 3 do
  begin
    SPIWrite(1, 1, $06); // Write Enable
    SPIWrite(1, 4, $44, 0,(i SHL 4),0);

    //Busy?
    sreg := 0;
    repeat
      SPIWrite(0, 1, $05);
      SPIRead(1, 1, sreg);
    until((sreg and 1) <> 1);
  end;

  SPIExitProgMode();
end

{$writeSS} // Write Security Sector
begin
  if not SPIEnterProgMode(_SPI_SPEED_MAX) then LogPrint('Error setting SPI speed');

  for i:=1 to 3 do
  begin
    SPIWrite(1, 1, $06); // Write Enable
    SPIWrite(0, 4, $42, 0,(i SHL 4),0);
    SPIWriteFromEditor(1, 256, (i-1) * 256); // Write Data

    //Busy?
    sreg := 0;
    repeat
      SPIWrite(0, 1, $05);
      SPIRead(1, 1, sreg);
    until((sreg and 1) <> 1);
  end;

  SPIExitProgMode();
end

{$readSS_RTL837X} // Read Security Sector for RTL837X
begin
  if not SPIEnterProgMode(_SPI_SPEED_MAX) then LogPrint('Error setting SPI speed');

  SPIWrite(0, 5, $48, 0,0,0,0);
  SPIReadToEditor(1, 256);

  SPIExitProgMode();
end

{$eraseSS_RTL837X} // Erase Security Sector for RTL837X
begin
  if not SPIEnterProgMode(_SPI_SPEED_MAX) then LogPrint('Error setting SPI speed');

  SPIWrite(1, 1, $06); // Write Enable
  SPIWrite(1, 4, $44, 0,0,0);

  //Busy?
  sreg := 0;
  repeat
    SPIWrite(0, 1, $05);
    SPIRead(1, 1, sreg);
  until((sreg and 1) <> 1);

  SPIExitProgMode();
end

{$writeSS_RTL837X} // Write Security Sector for RTL837X
begin
  if not SPIEnterProgMode(_SPI_SPEED_MAX) then LogPrint('Error setting SPI speed');

  SPIWrite(1, 1, $06); // Write Enable
  SPIWrite(0, 4, $42, 0,0,0);
  SPIWriteFromEditor(1, 256, 0); // Write Data

  //Busy?
  sreg := 0;
  repeat
    SPIWrite(0, 1, $05);
    SPIRead(1, 1, sreg);
  until((sreg and 1) <> 1);

  SPIExitProgMode();
end
