# [OBSOLETE] 
This repository will soon be removed, as the full dataset has been released at the following link https://repository.tugraz.at/records/0zr9z-tek56 (DOI: 10.3217/0zr9z-tek56); follow the updates at the new repo https://github.com/domagoj-bosnjak/SynthAorta

# SynthAorta Demo
This repository contains the demo dataset for the paper "SynthAorta: A 3D Mesh Dataset of Parametrized Physiological Healthy Aortas".

The final dataset will be made available post-publication, on the repository of the Graz University of Technology.

# Examples
The code currently contains 100 `.txt` examples of meshes, whose connectivity matrix and points are stored separately. This is due to the fact that the same connectivity matrix is used in all examples. Additionally, one `.msh` example of a mesh, which can be viewed with the open source tool [GMSH](https://gmsh.info/). The code below provides a way to extract the 100 examples to MATLAB, or to .msh afterwards.

# Usage
In order to manipulate other meshes, use the two functions provided in the Code folder.

```
Mesh = MeshExtractFromFiles(xyzFilename, ConnMatFilename, ConnMatBdryFilename)
```
where the three filenames should be the paths of the desired example in `Data`, as well as `Data\ConnMat.txt` and `Data\ConnMatBdry.txt`. This will yield a MATLAB structure of the mesh.

Afterwards, the mesh can be exported to OutputFilename (`.msh` type) using
```
Mesh3dLinHexaToMSH(Mesh, OutputFilename, [], []);
```
More functionality as well as significantly more examples will be provided post-publication.

# Paper
If you are using this work, consider citing the original paper, currently available only as a preprint:
[SynthAorta: A 3D Mesh Dataset of Parametrized Physiological Healthy Aortas](https://arxiv.org/abs/2409.08635)

# Authors
[Domagoj Bošnjak](https://scholar.google.com/citations?user=cTvCvggAAAAJ&hl=en)

[Gian Marco Melito](https://scholar.google.at/citations?user=M_ktJ8QAAAAJ&hl=it)
