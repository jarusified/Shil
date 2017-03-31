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

#### Interface


### MPI
MPI is an interface designed for message passing model of parallel programming. 

A communicator is a group of processes that have the ability to communicate with each other. The communication is based on the unique rank assigned for each process. 

Paper starts with a critical question of whether animations are needed provide accurate visualizations. 

### Parallel execution trace analysis
 
#### What to show

* Trace - data output from MPE after application run
* Event - an instance in MPI function call
* Process - initiator of MPI function calls
* Time 


## Links found: 
[Out of core visualisation](http://www.sci.utah.edu/~abe/massive06/course_notes-wagner_correa.pdf)

[MPI tutorial](http://mpitutorial.com/tutorials/mpi-introduction/~)

[Time Tunnel](http://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=1521058)

