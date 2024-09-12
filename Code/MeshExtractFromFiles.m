function Mesh = MeshExtractFromFiles(xyzFilename, ...
    ConnMatFilename, ConnMatBdryFilename)

%% Extract a coarse mesh from a file containing the xyz nodes
%% and coarse mesh extraction data.

%% Input: 
%%      xyzFilename    : the file containing xyz nodes of the mesh
%%      ConnMatFilename: the file containing the connectivity of the mesh
%%      ConnMatFilename: the file containing the boundary connectivity of
%%                       the mesh
%% Output:
%%      Mesh: a mesh structure containing the necessary info, ready to be
%%            exported by the function Mesh3dLinHexaToMSH

%% Read input points
xyzMat = readmatrix(xyzFilename); 
ConnMat = readmatrix(ConnMatFilename);
ConnMatBdry = readmatrix(ConnMatBdryFilename);

%% Save the mesh structure
Mesh.xx = xyzMat(:, 1);
Mesh.yy = xyzMat(:, 2);
Mesh.zz = xyzMat(:, 3);
Mesh.ConnMat = ConnMat;
Mesh.ConnMatBdry = ConnMatBdry;
