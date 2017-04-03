## [Understanding the heap by breaking it](http://www.blackhat.com/presentations/bh-usa-07/Ferguson/Whitepaper/bh-usa-07-ferguson-WP.pdf)

The paper focuses on dynamic memory management by ptmalloc2. Heap is a global data structure that provides 'exists until free' scope. 

Difference between ptmalloc and dlmalloc?
* multiple areans or heaps are provided.
* supports multi-threaded applications.

Heap is a section of linear memory that is obtained through sbrk() or mmap(). The memory chunks start from a chunk known as 'top chunk'(The only memory chunk that can grow by requesting more memory from the system). 

Bin : The free list which represents the free memory chunk present in the linked list or doubly linked list. 

The allocated memory have the characteristic that they may not directly border another allocated chunk, (they border the top chunk or the free chunk).

Writing a heap under invalid circumstances can overwrite meta-data in a de-allocated chunk of memory, or a write occurs to a dangling pointer or to an allocated chunk of memory.


	typedef struct_heap_info{
		mstate ar_ptr;
		struct-heap-info *ptr;
		size_t size;
		char pad[]
}


The above structure is pretty straightforward except mstate, it initialises an arena (mstate) with a pointer pointing to the previous arena in the memory. 

Lets look into mstate:


	struct malloc_state{
		mutex_t mutex; // Ensures synchronized access to various data structures used by ptmalloc
		int flags; // represents various characteristics of current arena.
		mfastbinptr fastbins[NFASTBINS]; // used for housing chunks that are allocated and free'd
		long stat_lock_direct, stat_lock_loop, stat_lock_wait;
		mchunkptr top; // special chunk of memory that borders the end of available memory. 
		mchunkptr last_remainder;
		mchunkptr bins[NBINS*2];
		unsigned int binmap[BINMAPSIZE];
		struct malloc_state *next;
		INTERNAL_SIZE_T system_mem;
		INTERNAL_SIZE_T max_system_mem;
	}


There are like 2 bins, Fastbin and mchunkptr bins[]. bins array operates as a list of free chunks of memory. 

### Chunks of memory

The chunks that are allocated by ptmalloc2 are of the same physical structure regardless of whether they are a fast chunk or a normal chunk. However the representation is different depending on the stateof the chunk. 


	struct malloc_chunk {
		INTERNAL_SIZE_T prev_size;
		INTERNAL_SIZE_T size;
		struct malloc_chunk* fd; // pointer to the next chunk 
		struct malloc_chunk* bk; // pointer to the prev chunk
	}


Regardless of how much memory is requested to be allocated, there will be extra bytes allocated for metadata, two variables (prev\_size and size) and two pointers to prev memory and the next memory (which sums up a 16,24 or 32 bytes of overhead per chunk). Also we have alignment issues, a malloc chunk must fall on a boundary of power of two at least as large as 2 times the sizeof(INTERNAL\_SIZE\_T). 



	chunk -> ----------------------------
             Size of previous chunk
			 ----------------------------
			 Size of this chunk |A|M|P
	mem   -> ---------------------------- (mem pointer is returned on malloc() call)
              DATA
		     ----------------------------
			 

A,M,P are used as metadata to determine if the current chunk is in a non-main arena, or it was allocated using mmap(). 


	### A free'd memory chunk
	
	chunk -> ----------------------------
             Size of previous chunk
			 ----------------------------
			 Size of this chunk |A| |P
	mem   -> ---------------------------- (mem pointer is returned on malloc() call)
	         Forward pointer to next chunk
			 Back pointer to previous chunk
			 unused space
		     ----------------------------

A -> chunk in main arena
P -> Previous chunk is in use
M -> Memory mapped 

**Note**

* Free chunks are traversed via circular linked lists.
* Allocated chunks are traversed by determining the size and doing pointer arithmetic.
* Pointer returned to the user by the API starts 8 bytes after beginning of the chunk, which in a free block is the start of metadata used to traverse the linked list.


### Binning

Once a memory block has been free'd, it is stored in a linked list called bin,(sorted by size to allow quick access). Bins are an array of pointers to linked list. 

Two types of bin:
	* Fastbin
	* Normal bin.
	
FastBIN:
* Chunks of memory are small (default : 60 bytes, max: 80 bytes)
* Not coalesced with sorrounding chunks on free()
* not sorted
* have singular linked lists (instead of doubly linked lists)
* Data structure is same as normal bin but the representation differs.
* Removed in LIFO in contrast to traditional FIFO.
* Because the chunks aren't consolidated, their access is quicker than normal chunk.

The paper says there will be 10 fastbins, to hold the chunks ranging from 0 to 80 bytes. (No idea how????).

1st bin -> unsorted bin (chunks recently free'd)

Small chunks(<512 bytes) are not sorted as all chunks in a given bin are of the same size. 

Large chunks(>512 bytes && < 128kb) are sorted by size in the descending order and are allocated in FIFO order

**Note**
Top\_chunk and last\_reminder chunk would never be placed in the bin. 

### Top chunk (aka wilderness)

* The chunk that borders the end of available memory. 
* Used when no adequate chunks are in the bin. (when even the last_reminder wont fit)
* The top chunk can grow and shrink.
* has specified place in memory
* P is always set
* Last resort to memory allocation, when the requested memory exceeds beyond the available memory for the top chunk, it extends using sbrk().


### Last_remainder chunk

* Last remainder chunk is the result of allocation requests for small chunks that have no exact fit in any of the bins. 

```

	if requested_mem > last_remainder && requested_mem < bin_mem :
		chunk is split again
		one part is handed out from the allocation
		other becomes the last_remainder chunk
```

### Heap initialisation

MALLOC\_PREACTION and MALLOC\_POSTACTION return 0 on success and non zero on failure. MALLOC\_POSTACTION is always 0 because there are no failures possible. This is used or needed for locking. 


	public_malloc() -> __malloc_hook -> malloc_hook_ini()
	
	malloc_hook_ini(): // hooks.c
		__malloc_hook() -> NULL
		call ptmalloc_init() 
		
	ptmalloc_init(): // arena.c
		__malloc__ = 0 // if it hasnt been initialised
		__pthread_initialize() // initialise POSIX thread interface
		mutex_init() //to initialise a mutex.
		
		
### Creation of Heap

arena\_get() acquires an arena and locks the corresponding mutex. First, try the one last locked successfully by this thread.(This is the common case and handled with a macro for speed.)  Then, loop once over the circularly linked list of arenas.  If no arena is readily available, create a new one.  In this latter case, `size' is just a hint as to how much memory will be required immediately in the new arena.
	
	arena_get(ar_ptr, bytes) // macro function 
		ptr = (mstate)tsd_getspecific(arena_key, vptr); \\gets thread specific data for the arena_key
		
If it fails to create a lock on the mutex, it would call array\_get2 which creates a new arena.
	
	arena_get2(ar_ptr):
		if(ar_ptr == NULL) 
			return ptr to main arena.
		else:
			will attempt to lock all the mutexes in the circularly linked list.
		fail_safe:
			lock te list_lock mutex
		fail_fail_safe:
			blocking call to the mutex_lock() is made 
		fail_fail_fail_safe:
			call _int_new_arena()
		
	_int_new_arena():
		new_heap()
	
	new_heap():
		allocate the size of allocation + size of the heap_info structure + size of malloc_state structure + size of MALLOC_ALLIGNMENT
		performs sanity checks too 
		calls to mmap are made
		mprotect is called to make the section read and write only. 
		fail_safe:
			return NULL
			
### Allocate a block
Once arena is set, the program proceeds to call \_int\_malloc passing the size of request and the arena pointer. There are three scenarios which can tend to happen:

	* Fit into the fastbin 
	* Small normal bin
	* Large normal bin 
	* Neither of them
	
	_int_malloc seems to be the main important function which allocates the memory. 
	
#### Fastbin chunk
	
	fastbin_allocation():
		fastbin_ptr 
		
