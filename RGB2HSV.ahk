ToBase(n,b){
    return (n < b ? "" : ToBase(n//b,b)) . ((d:=Mod(n,b)) < 10 ? d : Chr(d+55))
}

~LButton::
CoordMode, Pixel, Window
CoordMode, Mouse, Window
loop
{
  if !GetKeyState("LButton", "P")
  {
    break
  }
  MouseGetPos, 取色位置X, 取色位置Y
  PixelGetColor, 取色颜色, 取色位置X, 取色位置Y, RGB
  rgbArray1:="0x"
  rgbArray1.=SubStr(取色颜色, 3, 2)
  rgbArray1:=ToBase(rgbArray1,10)
  
  rgbArray2:="0x"
  rgbArray2.=SubStr(取色颜色, 5, 2)
  rgbArray2:=ToBase(rgbArray2,10)
  
  rgbArray3:="0x"
  rgbArray3.=SubStr(取色颜色, 7, 2)
  rgbArray3:=ToBase(rgbArray3,10)
  
  r :=rgbArray1 / 255
  g :=rgbArray2 / 255
  b :=rgbArray3 / 255
  
  max := Max(r, g, b)
  min := Min(r, g, b)
  delta := max - min
  
  if (delta = 0) {
      h := 0
  } else if (max = r) {
      h := 60 * Mod(((g - b) / delta), 6)
  } else if (max = g) {
      h := 60 * (((b - r) / delta) + 2)
  } else if (max = b) {
      h := 60 * (((r - g) / delta) + 4)
  }
  
  if (h < 0)
  {
      h := 300 + (60 - Abs(h))
  }
  
  if (max = 0) {
      s := 0
  } else {
      s := delta / max
  }
  
  v := max
  
  ToolTip, RGB`(%rgbArray1%`, %rgbArray2%`, %rgbArray3%`) 转换为 HSV`(%h%`, %s%`, %v%`)
}
return