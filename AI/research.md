0# Negative Space of Images

Negative space images are the images with just black and white contours.  Figure/ground organisation or occlusion follows the reasoning over discrete contours or regions. Figure/ground organization is a step of perceptual organization which assigns a contour to one of the two abutting regions. It is commonly thought to follow region segmentation, it is an essential step in forming our perception of surfaces, shapes and objects, as vividly demonstrated by the pictures. Occlusion on the other hand, is the concept that two objects that are spatially separated in the 3D world might interfere with each other in the 2D image plane.

Gibson argues that occlusion boundaries, together with surfaces, are the basis for the perception of the surface layout of a scene

Prof Jianbo shi has done extensive work in the field of negative-space images. There are a lot of papers which discuss the theories of affinities and graph based algorithms which work in the field of detecting features which are helpgul for segmentation of images.

#Previous works:
* [Based on shapememes, Pb algorithm] (https://homes.cs.washington.edu/~xren/publication/xren_eccv06_figureground.pdf)
* [Occlusion cues + CRF model + Pb] (https://www.ri.cmu.edu/pub_files/pub4/hoiem_derek_2007_3/hoiem_derek_2007_3.pdf)
* [Depth ordering] (http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.650.9285&rep=rep1&type=pdf)
* [Convexity + graph cut algorithm] (http://homes.cs.washington.edu/~luyao/iccv11conc.pdf)
* [Graph cut algorithm + code]  (http://cs.brown.edu/~pff/segment/)
* [Object specific figure-ground segregation] (http://www.cs.cmu.edu/afs/cs/user/xingyu/www/papers/yus_object.pdf) - Paper deals with proper figure-ground separation.
* [Affinity CNN] (http://ttic.uchicago.edu/~mmaire/papers/pdf/affinity_cnn_cvpr2016.pdf) - Affinity CNN - First attempt to involve deep nets into Affinities.

##Notes on previous works:
* Markov random field based algorithm is capable of depth ordering. ?? T-junctions were used previously in order to capture the difference between the positions of intersections among objects.
* Depth ordering is related to the boundary ownership which is inturn figure/ground assignment problem.  3rd paper uses binary edge image where the occlusion boundaries are labelled in white. The paper also suggests a method to capture the boundary convexity.
* The 4th paper does a graph cut on the image and segments to 6-8 superpixels. Graph cut algorithm is super fast and efficient. The second step is to perform concave arc detection. They manually classify into three concavity contexts.
      * Preprocessing : compute the segmentation and find the concave arcs.
          * B-spline curve algorithm is used to smooth the contour and reduce the noise.
	  * A minimum enclosing rectangle is drawn for the superpixel and the contour is split into 4 sections.
	  * then they perform hierarchical segmentation on the section to obtain the curvature of the arcs in the section.
      * model construction : Build a weighted graph on the candidate superpixels and find the distance between the vertices
      * clustering : Bi-partition the graph and obtain the salient object.
* 5th paper logic:
      * Detect patches and edges
      * build relational graphs for patches and pixel grouping.
      * They produce pixel grouping, patch grouping , pixel and patch correspondance cues separately and integrate them through an integration model.
      *

#Initial testing:
* Testing is done using Tensorflow on Imagenet dataset.
Lets try to test how well negative space images are being recognised in Imagenet and AlexNet.

Lets take the image of a dog, as they are being the category trained to a maximum.

![Negative-dog] (https://s-media-cache-ak0.pinimg.com/736x/3d/21/6c/3d216cf64b7ffa13a8b93e5d9ba0c597.jpg)
![Graph-cut-dog] (images/graph_cut.ppm?raw=true)

##Results On ImageNet:
* bow tie, bow-tie, bowtie (score = 0.93169)
* sunglasses, dark glasses, shades (score = 0.00528)
* sunglass (score = 0.00244)
* hair slide (score = 0.00132)
* long-horned beetle, longicorn, longicorn beetle (score = 0.00099)

It got it partially wrong. One reason, we can easily see a bow tie and the network attempted to detect the tie[edit]

Lets remove the bow tie from the image by cropping it to 368*161 from 736*552. Lets run.

Results:
* vase (score = 0.25941)
* cuirass (score = 0.04524)
* buckle (score = 0.03209)
* mask (score = 0.03193)
* breastplate, aegis, egis (score = 0.02177)

It comprehended the nose and mouth together to be a vase. Wow. Breastplate seriously? Maybe the eyes :P

## Now we will try to find why is it so?

One reason could be that the network doesnt learn much about white well pixels. Shape is important for an image, curvature. The depth of an image in white is literally nothing.

Lets try some filters to find out which can create such outlines or borders.
[1] - Uses AI to detect boundaries.

## Paper Reviews

Points from [1]:
       High-for-low and low-for-high: Efficient boundary detection from deep object features and its application to high-level vision.

* Predicting boundaries by exploiting object level features from a pretreained object classification network. ...Hmmm.. similar to ours;
* High level object features inform the low level boundary detection.
* Uses trained VGG net.
* Presents improvement on semantic boundary labeling, semantic segmentation and object proposal generation.
* Boundary prediction:
       	* Spectral methods - uses eigenvalue [MCG detector, gPb detector, PMI detector and Normalized cuts]
	* Supervised discriminative - Sketch tokens, Structured edges, and sparse code gradients(SCG)
	* Deep learning - N4 fields (dictionary learning and Nearest neighbor), DeepNet (CNN), DeepEdge (multi-scale bifurcated network to perform contour detection).
* This paper doesnt use the multi-scale bifurcated network. (Can run in real time).
* The paper avoids feature engineering by learning from human annotated data.
* Method and architecture:
	* Extract candidate contour points with a high recall. using SE edge detector. ** This step is done inorder to reduce the computational cost. **
	* Sample up the original image to 1100*1100. ** Done inorder to reduce the loss of information **
	* Uses VGGnet as a model because it has been trained with large number of object classes (1000s). ** To preserve spatial information we use a fully convolutional network. ** Spatial information is crucial for accurate boundary detection.
	* Feature interpolation :
	  	  ^^ After the up-sampled image passes through all the 16 conv layers for a selected candidate contour point, we find its corresponding point in the feature maps. The values are not exact. SO we perform feature interpolation by finding the 4 nearest points and average their activation values.
	* Feature interpolation helps to predict boundaries efficiently.
	* We feed the 5504 dimensional feature vector to funlly connected layers that are optimized to human agreement criterion. Whaaat.
	* It aims at mimicking the judgement of human labelers.
	* finally fed into two fully connected layers.
* To learn the weights in the two fc layers, we train our model to optimize the least square error of the regression.
k* BSDS500 dataset involves "orphan boundaries", these are the boundaries marked by only one or two human annotators.


Points from [2]:
       Semantic Segmentation with Boundary Neural Fields

Points from [4]:
       Affinity CNN: Learning Pixel-Centric Pairwise Relations for Figure/Ground Embedding

* From an affinity matrix describing pairwise relationships between pixels. The paper trains a CNN to directly predict the pairwise relationships that define this affinity matrix. This is later used for figure/ground organisation.
* Better than Conditional Random field- based globalisation methods on deep neural networks ??? Eg:???
* Networks dont focus on image segmentation as much as they do for edge detection.
* Previously CRFs were used in semantic segmentation with deep convnets. This paper involves a technique called angular embedding. They claim it to be a more natural inference algorithm XS


Points from [6]:
* Affinity functions traditionally use image intensity, spatial derivatives, texture, or color to estimate the degree to which the nodes correspond to the same segment. This paper aims at handling and creating affinity functions convolutionally.
* The performance of graph based algorithms sometimes can be hampered by poor choice of affinity functions.
* The network contains 4 layers of convolutions with 6 feature maps and three output images.
* Features im an image are detected using the feature maps or filters of the Wab factor.
* The nodes of the graph represent image voxels, which form a three dimensional cubic lattice. The affinity graph is considered to be three different images, each representing the affinities of the edges of a particular direction.
* The graph partitioning algorithms accomplish image segmentation by cutting the affinity graph into discrete objects.
* The network comprises of 3 hidden layers, each containing 6 feature maps. All the filters are of the size 5\*5\*5. CN contians 4 convoltions between the input and output, so a single output voxel is 17***3.

## Notes of caffe installation:
      Caffe installation is a pain. It can lead to soo many stupid bugs while installation.

* Install numpy using `pip install numpy` and not `apt install python-numpy`.
* Install cython before the `pip install -r requirements.txt`
* Install scikit-image (This requires cython)
* dont cmake before all the requirements are done. This can mainly lead to python wrapper not getting installed.
* If there is a problem, feel free to delete the build directory. No harm.
* Dont forget to set $PYTHON_PATH and CAFFE_ROOT.
* `make all` fails in mac osx. No clue why. have to find out.

 Errors:

* Import _caffe failed: Meaning pycaffe wasnt compiled due to some modules from pip not installed.
* Import skiimage.io failed: scikit-image not installed; Check if cython is installed.

## Spectral clustering and Affinities

  ``` Why I think I am reading on spectral clustering????
      The black and white pixels tend to form clusters in the image naturally in a negative space image. It could be possibility that we can use this clustering to detect shapes and contours. Who knows?
      ```

It is different from K-means clustering. Spectral clustering is about connectivity between the points in the space. Affinity is a metric that determines how close two points are in the space. [3] states that spectral clustering is more efficient than K-means.

Spectral clustering method deals with similarity graphs which are undirected weighted graphs [ Wij = Wji ]. Degree is defined to be sum of all the weights of the edges. Degree matrix is the diagonal matrix with values d1,d2,....dn. One of the aims while constructing similarity graphs is to model the local neighborhood relationships between the data points.

Ai,j = exp(-a ||Xi - Xj||^2)

Ai,j ~= 1 => the points are close to each other
Ai,j ~= 0 => the points are far apart

Q: What happens if points are far apart just because they belong to different clusters?
A: ?? Maybe keep a distance factor separately. Not sure if this is a good method though.

* e-neighborhood graph : We connect all points whose pairwise distances are smaller than e.
* k-nearest neighborhood : Connect if Vi is among the k-nearest neighbors of Vj.
* fully connected graph : connect all points with positive similarity with each other. Eg: Gaussian similarity function. the sigma controls the width of the neighborhood.

Graph laplacians:
* Simple laplacian L = D - A
* Normalized Laplacian Ln = D^-0.5LD^-0.5
* Generalized Laplacian Lg = D^-1L
* Relaxed Laplacian Lp = L - aD
* Ng, Jorndan and weiss Laplacian Lnjw = D^-.5AD^-.5 where Ai,i = 0

Spectral clustering does a low dimension embedding of the affinity matrix between samples followed by K means on the low dimensional space. A spectral algorithm typically begins with an “affinity matrix” of pairwise relationships between the samples or the variates, and derives a more useful representation of the data from its eigenvalue decomposition (EVD), often using just one or a few eigenvectors (a truncated eigenbasis). [4] uses the spectral embedding as a method of solving perceptual organization problem, mainly image segmentation and figure/ground organization.

K-means only works well for data that are grouped in elliptically shaped, whereas spectral clustering can theoretically work well for any group.

Procedure:
* 100 data points implies 100*100 matrix, where rth row and cth column is the similary between rth data point and cth data point.
* Similarity is defined based on the way you want. eg: Euclidean distance, a kernel function of the euclidean distance or a K nearest neighbors approach.
* We create a Laplacian matrix.
* We calculate eigenvectors or eigenvalues of the laplacian matrix.
* Use K-means algorithm on the eigenvalues corresponding to k smallest eigenvectors.

Now the similarity function can be based on contrast of the pixels, or anything else. But in the case of negative images, all we have black and white pixels.

BSDS have images of size 481*321 = 154401 pizels. The similarity matrix would be huge. 154401*154401 = 23839668801.

Kernel trick:
       It avoids the explicit mapping that is needed to get linear learning algorithms to learn a non linear function or boundary.

## Interesting occlusion
Seeing through water. There is a work by jiobhi shi on recovering the image from the effect of snell's law of refraction through water. Idea is again based on affinity matrix with clustering and it is by Efros. Lol, he is the prof under whom yong jae lee graduated. Wow. Nice find :P

## Python program to predict the affinity graphs

### Initially followed theory

#### Zahn's method:
 It comprised of breaking the MST edges with large weights. The inadequency of breaking large edges would result in high variability region being split into multiple regions.

#### Urquhart's method:
 It prevents the above shortcoming by normalizing the weight of an edge using the smallest weight incident on the vertices touching that edge.

#### Uniformity method:
 Splitting and merging regions according to how well each region fits some uniformity criterion .....what???

#### Graph cut method:
 The internal difference of a component is taken to be the minimum spanning tree of the component. The difference betweenn the two compnenets to be the minimum weight edge connecting the two components.If there is no edge connecting C1 and C2 then we let dif(C1,C2) to be infinity.
Kruskal's algorithm - Minimum spanning tree - finds an edge of the least possible weight that connects any two trees in a forest. It finds the subset of the edges that form a tree that includes every vertex, where the total weight of all the edges in the tree are minimized.

Aim

* How to find these contours?
* How to color based on these contours?
* How can Affinity graphs be generated using CNNs?

References:

[1] https://arxiv.org/pdf/1504.06201v3.pdf - High-for-low and low-for-high: Efficient boundary detection from deep object features and its application to high-level vision.

[2] https://arxiv.org/pdf/1511.02674v1.pdf - Semantic Segmentation with Boundary Neural Fields

[3] http://www.kyb.mpg.de/fileadmin/user_upload/files/publications/attachments/Luxburg07_tutorial_4488%5B0%5D.pdf - A Tutorial on spectral clustering.

[4] http://ttic.uchicago.edu/~mmaire/papers/pdf/affinity_cnn_cvpr2016.pdf - Affinity CNN: Learning Pixel-Centric Pairwise Relations for Figure/Ground Embedding

[5] https://pdfs.semanticscholar.org/33d1/080b0ce36350d75bda8a065190e5aefaa3fb.pdf - A unifying theorem for spectral embedding and clustering

[6] http://www.mitpressjournals.org/doi/pdf/10.1162/neco.2009.10-08-881 - Convolutional networks can learn to generate affinity graphs for image segmentation.


## Interesting finds:

   	       This section is for fun reads apart from the main topic.

* [Architecture 2030] (http://arch2030.cs.washington.edu/)
* [100 Quadrillion Live Pixels] (https://www.youtube.com/watch?v=XS7kuod1vSQ&t=14m50s). It would be interesting to speculate on ideas from various fields which would exist 15-20 years ahead. [slides](http://www.cs.cmu.edu/~kayvonf/misc/kayvonf_arch2030.pdf)
* [Piotr's computer vision toolbox] (https://pdollar.github.io/toolbox/) - I dont think i will ever use matlab. But still :P & The author of the library is also has worked on MScoco dataset. Three crazy good projects. [Github] (https://github.com/pdollar/edges)

##TO-READ:
* http://vision.cs.utexas.edu/projects/foregroundfocus/foregroundfocus.html
