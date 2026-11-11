-- Efficient Games Forever 70862 object details, 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae (CC BY 4.0).
-- Objects are placed by their item spells.
CREATE TEMPORARY TABLE everlake_camp_objects LIKE gameobject_template;
INSERT INTO everlake_camp_objects (entry,type,displayId,name,size,Data0,Data1,Data2,Data3,Data4,Data5,Data6,Data7,Data8,Data9,Data10,Data11,Data12,Data13,Data14,Data15,Data16,Data17,Data18,Data19,Data20,Data21,Data22,Data23,Data24,Data25,Data26,Data27,Data28,Data29,Data30,Data31,Data32,Data33,Data34) VALUES
    (651952, 5, 125164, 'Enchanted Lute', 1.5, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (612120, 8, 116322, 'Fermenter', 2.0, 2248, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (612088, 10, 125480, 'Field Guide', 1.5, 43, 0, 0, 3000, 0, 0, 0, 0, 0, 0, 1284017, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 152103, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0),
    (630660, 8, 133684, 'Journeyman Campfire', 1.2, 4, 15, 630674, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (706993, 8, 1287, 'Journeyman Campfire', 0.1, 2341, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO gameobject_template (entry,type,displayId,name,size,Data0,Data1,Data2,Data3,Data4,Data5,Data6,Data7,Data8,Data9,Data10,Data11,Data12,Data13,Data14,Data15,Data16,Data17,Data18,Data19,Data20,Data21,Data22,Data23,Data24,Data25,Data26,Data27,Data28,Data29,Data30,Data31,Data32,Data33,Data34)
SELECT entry,type,displayId,name,size,Data0,Data1,Data2,Data3,Data4,Data5,Data6,Data7,Data8,Data9,Data10,Data11,Data12,Data13,Data14,Data15,Data16,Data17,Data18,Data19,Data20,Data21,Data22,Data23,Data24,Data25,Data26,Data27,Data28,Data29,Data30,Data31,Data32,Data33,Data34 FROM everlake_camp_objects o
WHERE NOT EXISTS (SELECT 1 FROM gameobject_template t WHERE t.entry=o.entry);
DROP TEMPORARY TABLE everlake_camp_objects;
