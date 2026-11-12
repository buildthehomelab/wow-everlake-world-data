-- Efficient Games Forever beta object capture, 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae (CC BY 4.0).
-- Apothecary Vials item 279395 places this object via spell 1306700.
INSERT INTO gameobject_template (entry, type, displayId, name, size, Data0, Data1, Data2, Data3, Data4, Data5, Data6, Data7, Data8, Data9, Data10, Data11, Data12, Data13, Data14, Data15, Data16, Data17, Data18, Data19, Data20, Data21, Data22, Data23, Data24, Data25, Data26, Data27, Data28, Data29, Data30, Data31, Data32, Data33, Data34)
SELECT 670473, 5, 129510, 'Vial', 1.0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
WHERE NOT EXISTS (SELECT 1 FROM gameobject_template WHERE entry = 670473);
