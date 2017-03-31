# Visualizing large-scale parallel communication traces using a particle animation technique.

## What is it ?
The paper describes an animation technique to visualize communication patterns in a parallel execution environment. 

Individual process : Gantt Charts or kiviat diagrams

## Related work

* KOJAK, Scalasca : Not enough numerical analysis. 
* Paragraph : Graphical representation with [nodes - processes, edges - communication between the processes]
* Jumpshot : Based on gantt charts [rows - function call, arrows - communication between the processes]
* VAMPIR : Similar to Jumpshot [Ability to take snapshots of system]
* TAU : Utility software with gantt chart, communication matrix, call graph views
* Virtue : Real time monitoring, 3D with wide area geographic view, a time tunnel display and interactive call graph.
* [Grid](http://www.inf.ufrgs.br/~schnorr/download/publication/schnorr2008grid-draft.pdf) : 3D visualization based on grid transformations.


* Statistical techniques
  * ParaGraph - bar charts, utilization count
  * Pablo - bar charts, 3D scatter plot
  * Paradyn - histograms
  
* Behavioral Techniques
  * ParaGraph - Gantt chart
  * Vampir - timeline view
  * Jumpshot - space time
  * Virtue - VR with 3D modelling
  * KOJAK - Call graph

* Structural techniques
  * Paragraph - network display
  * Cray apprentice - tree view of imbalances
  
### Time tunnel 
It is a visual analysis tool for time series numerical data as individual charts each of which is displayed on an individual rectangular plane called data-wing in a 3D virtual space. 

#### Michael ogawa's star dust and code_swarm
Code swarm is a project done to visualize the commit history of projects based on the version control. It shows an animation of nodes clustering based on the commiter's history with time. It also has a bar chart. The code is in java using JOGL (Java OpenGL). Whats interesting is that a single animation has two or more components such as a graph and a bar to represent the commit history. 

### Interface

* Trace - data output from MPE after application run
* Event - an instance in MPI function call
* Process - initiator of MPI function calls
* Time 

Tilling : 
	* Animation window 
	* Timeline Window
	* Color legend (accomodate 25 different functions)

#### Static design 

The animation window is split into segments for cluster of processes to be accomodated. The x-axis for a segment are decided randomly to prevent overlap. The processes are distributed into groups according to the process block size based on the [virtual topology](http://wgropp.cs.illinois.edu/courses/cs598-s16/lectures/lecture28.pdf). The animation exhibits a grid background, with horizontal lines signifying event durations and vertical lines for segmenting a particle into a group. The y-axis corresponds to the amount of time that particular event has been in execution. 

#### Dynamic design
The paper uses a sliding time window on the data set moving at a constant speed. The speed variables can be adjusted by the user. The particles travel upwards based on the amount of time they have been alive. When it reaches the maximum event duration, it fades away. It also fades at a 2 sec timer so that the visualisation is prominent for short lived particles. The animation may be paused and the user can hover over particles and obtain the information about the MPI function call. Once the particles fade away, they are still rendered on the screen at a low opacity. The opacity is varied logarithmically. The user is also given an option to clear the faded or background buffer to increase the usability. 

### MPI
MPI is an interface designed for message passing model of parallel programming. 

A communicator is a group of processes that have the ability to communicate with each other. The communication is based on the unique rank assigned for each process. 

Paper starts with a critical question of whether animations are needed provide accurate visualizations. 

### Parallel execution trace analysis:

## Links found: 
[Out of core visualisation](http://www.sci.utah.edu/~abe/massive06/course_notes-wagner_correa.pdf)

[MPI tutorial](http://mpitutorial.com/tutorials/mpi-introduction/~)

[Time Tunnel](http://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=1521058)

