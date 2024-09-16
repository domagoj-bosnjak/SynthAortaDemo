function Mesh3dLinHexaToMSH(Mesh3dHexaLin, OutputFilename, ...
    ElemTags, ElemTagsBdry)

%% The function converts a mesh structure with the fields:
%% Mesh.xx           (NumNodes x 1)
%% Mesh.yy           (NumNodes x 1)
%% Mesh.zz           (NumNodes x 1)
%% Mesh.ConnMat      (NumElems x 8)     % 8 Nodes per hex
%% Mesh.ConnMatBdry  (NumElemsBdry x 4) % 4 Nodes per quad 
%% into the well known .msh format, with the documentation:
%% https://gmsh.info/doc/texinfo/gmsh.html#File-formats 

%% Element and surface(boundary) elements may be assigned arbitrary tags, otherwise
%% ElemTags and ElemTagsBdry can be empty []

%% The mesh is assumed to be linear and hexahedral. Arbitrary element tags
%% can be assigned if necessary, otherwise they can be left empty

%% Check input.
if (~isfield(Mesh3dHexaLin, {'xx'}) || ...
    ~isfield(Mesh3dHexaLin, {'yy'}) || ...
    ~isfield(Mesh3dHexaLin, {'zz'}))
    error ('3d Mesh in 3d space allowed only.')
end
if (size(Mesh3dHexaLin.ConnMat,2) ~= 8)
    error ('Linear Hexa allowed only.')
end
NodeNum = length(Mesh3dHexaLin.xx);
ElemNum = size(Mesh3dHexaLin.ConnMat, 1);
ElemNumBdry = size(Mesh3dHexaLin.ConnMatBdry, 1);

%% Assign tags 1 and 2 if none were prescribed, otherwise take the next
%% available number
if isempty(ElemTags)
    ElemTags = ones(ElemNum, 1);
end
if isempty(ElemTagsBdry)
    if isempty(ElemTags)
        DefNum = 2;
    else
        DefNum = max(ElemTags) + 1;
    end
    ElemTagsBdry = zeros(ElemNumBdry, 1) + DefNum;
end

%% Open output file
fid = fopen (['./', OutputFilename], 'w');

%% Print header
fprintf (fid, '$MeshFormat\n2.2 0 8\n$EndMeshFormat\n');

%% Print nodes.
fprintf(fid, ['$Nodes\n',num2str(NodeNum),'\n']);
for Node = 1 : NodeNum
    fprintf (fid, [num2str(Node),' ',...
             n2s(Mesh3dHexaLin.xx(Node)),' ',...
             n2s(Mesh3dHexaLin.yy(Node)),' ',...
             n2s(Mesh3dHexaLin.zz(Node)),'\n']);
end
fprintf(fid, '$EndNodes\n');

%% Print element header.
fprintf(fid, '$Elements\n');
fprintf(fid, [num2str(ElemNum+ElemNumBdry), '\n']);

%% Print boundary elements.
for BdryElem = 1 : ElemNumBdry
    StrPrint = [num2str(BdryElem), ' 3 2 ',...
            num2str(ElemTagsBdry(BdryElem)), ...
            ' ', ...
            num2str(ElemTagsBdry(BdryElem))];
    for BdryElemNode = 1 : 4 % 4 nodes per surface element
        StrPrint = [StrPrint, ' ', ...
            num2str(Mesh3dHexaLin.ConnMatBdry(BdryElem, BdryElemNode))];
    end
    fprintf (fid, [StrPrint,'\n']);
end

%% Print elements.
for Elem = 1 : ElemNum
    StrPrint = [num2str(BdryElem+Elem),' 5 2 '];
    StrPrint = [StrPrint,num2str(ElemTags (Elem)),' ',num2str(ElemTags (Elem))];
    for ElemNode = 1 : 8 % 8 nodes per element
        StrPrint = [StrPrint,' ',num2str(Mesh3dHexaLin.ConnMat(Elem, ElemNode))];
    end
    fprintf (fid, [StrPrint,'\n']);
end

fprintf(fid, '$EndElements');
fclose (fid);

end

%% Local function to convert numbers to strings with given format.
function [str] = n2s(number)
    str = num2str(number, '%0.12f');
end
