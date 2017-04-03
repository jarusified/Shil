# Combining the communication hairball : Visualizing Parallel execution Traces using Logical time.

Trace visualizations provides event history browsing. Traces are sequence of events or time series of metric values that represent system behavior and performance over time. LagAnalyzer provides latency trace visualization by sape labs.

	Trace alignment enables reasoning across traces of performance metris collected in multiple executions. They are used in analyzing the performace of computer systems. It overcomes time dilation between two traces by aligning the traces along their time axes. eg : [Aligment exploer](http://sape.inf.usi.ch/alignment-explorer)
	
[Time Interpolation](http://sape.inf.usi.ch/publications/micro07) - Paper on how trace alignment is important to visualise time series data. 

Trace analysis such as critical execution path help in finding out the performance problems. Currently there are two types of visualization tools:
	* Tools which show all the data with little pre-processing
	* Statistical tools - which process too much. 
	
### Proposed design goals:

* Preserve and highlight event patterns and dependencies. 
* Scalability
* Provide multiple levels of detail

The paper introduces logical time, which is different from the physical time. It has two main advantages:
	* Logical time corresponds more closer to code structure. 
	* Discrete nature of the logical time allows us to cluster and summarize chains of events across processes.
	
The authors introduce a tool called Ravel, to provide multiple linked and coordinated views of large scale traces at different levels of abstraction. The tool is based on logical time, a convention introduced to remove the interntwining of lines denoting the communication. The tool also denotes the real time by using color codes.  

	 The recorded actions include entering and exiting functions, as well as sending and receiving messages. Events are timestamped. In parallel programs, the process in which each event occurs is also recorded. We combine matching function entry and exit actions and deem the time spent in a function an event. We also associate messages with the functions that send and receive them. We call these send events and receive events. 
	 
General convention:

* Functions are represented as bars that span their lifetime along time axis. -Gantt charts
* Single process trace are represented using a similar arrangement as icicle plot. 
* Communication is generally represented as lines between the communicating process timelines. 
* Opacity is used to visualise the overlapping processes. 

## Logical Timelines.
The paper also introduces a factor called "Lateness" to denote the delay each event experiences relative to its logical assignment. 

	A logical clock is a mechanism for capturing chronological and causal relationships in a distributed system. Distributed systems may have no physically synchronous global clock, so a logical clock allows global ordering on events from different processes in such systems. 
	Logical clock systems each process has two data structures: 
		* logical local time - Used by the process to mark its own events 
		* logical global time - Local information about the global time. 

### Clock scheme 	
* Happened before relation between phases. If p -> q then C(p) < C(q) for all p and q. 
* The send events have the same value always instead of the least possible assignment. 
	
### Lateness 
* Greater the discontinuity in color between an event and its predecessor, greater the duration of event. Lateness is defined as the difference in the exit time between the event and earliest event sharing its timestamp. 
	
### Clustering 
* The processes are clustered according to the metric of interest, by default lateness. The distance vector for clustering is based on the discrete logical timestamps, considering the phase's span of steps as a vector of values. The tool employs a two stage clustering, they generate a moderate number of clusters using CLARA ( Clustering for Large applications ). The second is to create a navigable cluster hierarchy of the CLARA clusters using single linkage hierarchichal clustering, which enables viewing through different clusterings. They calculate per phase rather than entire trace, decreasing clustering costs. 
	
### Modules. 
* They have modelled modules to detect patterns such as exchanges, a prevalent pattern which occurs when every process sends and receives from the same set of other processes. 
	
## Ravel 

### Views
* Logical time view - Based on difference in their exit times.
* Clustered logic view - Clustering algorithms on time view.
* Physical time view - Based on real clock.
* Metric view - Lateness.

#### Logical time view
* Individual process timelines are stacked in rows, ordered by the id in MPI. 
* Horizontal axis - logical time. 
* Each event is equally sized box. 
* Messages are drawn as lines of equal width between their send and recv event. 
* For small number of processes, timestamps are shwon. For larger numbers, the meessage lines, spacing and borders are removed. 
* When the number of processes exceeds the pixel height of the view, overplotting techniques are used so that the sparse logical timestamps are visible. 

#### Clustered logical time view
* The view is split into two sections,
  * Top section : Shows the timelines for a subset of processes.
  * Bottom section : Clustered time view
* Each event in the cluster is represented by a rectangular glyph divided into three sections,
  * Send Processes - colored (light)
  * Inactive Processes - not colored - removed for sparse data. 
  * Receive processes - colored (dark)
* Thickness of the line is deteremined by the portion of the cluster that is sending or receiving.
* [Dendrogram](https://en.wikipedia.org/wiki/Dendrogram) is used to explore the clusters of interest, Highlighting is done to show the processes of user's interest. 
* To avoid lines clustering all over the communication, quarter pies are used to indicate the number of receives that are being handled at the moment. 

#### Physical time view
* This view demonstrate the common visualisation of traces, with process timelines stacked in rows and physical time on the horizontal axis. 
* Width of the bar is proportional to the time. 
* The view also shows non-messaging events with calls made deeper in the tree colored lighter than the parent calls. The main procedure will be the darkest overlaid with other events.

#### Metric view 
* Height of the bars are scaled by the step exhibiting the greatest sum. 

### Case studies

#### Merge trees
The case study is made to eliminate the problem of visualizing file I/O or memory bandwidth. The case study analyses a development version of a massively parallel algorithm to compute merge trees. 

* Merge trees are a topological structure that has been used in large combustion simulations. The algorithm relies on a global gather -scatter approach.
* The case study is done on two sub-cases, 1024 and 16384 processes. 
