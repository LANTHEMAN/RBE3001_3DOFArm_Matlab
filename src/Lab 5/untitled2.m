
model = createpde;
importGeometry(model,'FLATFOOT_StanfordBunny_jmil_HIGH_RES_Smoothed.stl');
h = generateMesh(model,'Hmax',300);
mesh(h,'XData',20);