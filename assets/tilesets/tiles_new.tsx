<?xml version="1.0" encoding="UTF-8"?>
<tileset name="tiles_new" tilewidth="16" tileheight="16" tilecount="64" columns="8">
 <image source="../textures/tilemap/tm_new1.png" width="128" height="128"/>
 <terraintypes>
  <terrain name="G2" tile="0"/>
 </terraintypes>
 <tile id="0" terrain=",,,0">
  <objectgroup draworder="index">
   <object id="1" x="8" y="8" width="8" height="8"/>
  </objectgroup>
 </tile>
 <tile id="1" terrain=",,0,0">
  <objectgroup draworder="index">
   <object id="1" x="0" y="8" width="16" height="8"/>
  </objectgroup>
 </tile>
 <tile id="2" terrain=",,0,">
  <objectgroup draworder="index">
   <object id="1" x="0" y="8" width="8" height="8"/>
  </objectgroup>
 </tile>
 <tile id="3" terrain="0,0,0,">
  <objectgroup draworder="index">
   <object id="1" x="0" y="0">
    <polyline points="0,0 16,0 16,8 8,8 8,16 0,16 0,0"/>
   </object>
  </objectgroup>
 </tile>
 <tile id="4" terrain="0,0,,0">
  <objectgroup draworder="index">
   <object id="1" x="0" y="0">
    <polyline points="0,0 16,0 16,16 8,16 8,8 0,8 0,0"/>
   </object>
  </objectgroup>
 </tile>
 <tile id="8" terrain=",0,,0">
  <objectgroup draworder="index">
   <object id="1" x="8" y="0" width="8" height="16"/>
  </objectgroup>
 </tile>
 <tile id="9" terrain="0,0,0,0"/>
 <tile id="10" terrain="0,,0,">
  <objectgroup draworder="index">
   <object id="1" x="0" y="0" width="8" height="16"/>
  </objectgroup>
 </tile>
 <tile id="11" terrain="0,,0,0">
  <objectgroup draworder="index">
   <object id="1" x="0" y="0">
    <polyline points="0,0 0,16 16,16 16,8 8,8 8,0 0,0"/>
   </object>
  </objectgroup>
 </tile>
 <tile id="12" terrain=",0,0,0">
  <objectgroup draworder="index">
   <object id="1" x="0" y="8">
    <polyline points="0,0 8,0 8,-8 16,-8 16,8 0,8 0,0"/>
   </object>
  </objectgroup>
 </tile>
 <tile id="16" terrain=",0,,">
  <objectgroup draworder="index">
   <object id="1" x="8" y="0" width="8" height="8"/>
  </objectgroup>
 </tile>
 <tile id="17" terrain="0,0,,">
  <objectgroup draworder="index">
   <object id="1" x="0" y="0" width="16" height="8"/>
  </objectgroup>
 </tile>
 <tile id="18" terrain="0,,,">
  <objectgroup draworder="index">
   <object id="1" x="0" y="0" width="8" height="8"/>
  </objectgroup>
 </tile>
</tileset>
