# FIFO(first_in_frist_out)Design
FIFO (First-In First-Out) is a type of buffer memory in which data is written and read in the same order as it arrives. The first data written into the FIFO is the first data read out.

<img width="530" height="229" alt="image" src="https://github.com/user-attachments/assets/abf30dec-d3b3-44eb-b548-734507487b52" />

## Types of FIFO's
  #### Synchronous FIFO:-
         Same clock for read & write operation,Simple design Used inside same block
  #### Asynchronous FIFO
    Different clocks, Means Read & write operations not at same time
    Uses Gray code pointers 
    Used in Clock Domain Crossing (CDC)
## Asynchronous FIFO = Advanced VLSI topic
### Calculating FIFO depth 
    Simple to say, How much it is stored or Hold the data depends on the clock pluses.
#### Different Clock pluses:-
##### Idle clock pluses:-
    Idle clock refers to the inactive or default state of a clock signal when no operation or data transfer is taking place
    The clock does NOT stop (unless explicitly gated).
    “Idle” means nothing useful is happening, not that the clock disappears
##### Duty clock pluses:-
    Duty cycle is the percentage of time a clock signal stays HIGH during one complete clock period.
    🔹 Why Duty Cycle Is Important:-
            Affects setup & hold timing
            Critical for flip-flops
            Impacts power & reliability
            Important in PWM, clock trees

