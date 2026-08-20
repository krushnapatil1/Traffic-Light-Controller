# 🚦 Traffic Light Controller using Verilog

A digital **Traffic Light Controller (TLC)** designed using **Verilog HDL** and implemented as a **Finite State Machine (FSM)** with a separate timing counter.

This project demonstrates RTL design concepts such as **FSM design, state transitions, counters, sequential logic, combinational logic, reset handling, and waveform-based verification**.

---

## 📌 Project Overview

The Traffic Light Controller controls traffic signals for two directions:

- **North-South (NS)**
- **East-West (EW)**

The controller automatically changes the traffic lights according to a predefined sequence.

The design uses a **4-state Moore FSM** and a separate counter block to control the duration of each traffic-light state.

### Traffic Light Sequence

```text
NS GREEN
    ↓
NS YELLOW
    ↓
EW GREEN
    ↓
EW YELLOW
    ↓
NS GREEN
    ↓
    ...

Objectives
Design a Traffic Light Controller using Verilog HDL
Implement a Moore FSM
Implement a separate counter block
Understand state transitions
Practice sequential and combinational RTL design
Implement asynchronous reset
Create a Verilog testbench
Simulate the design using Icarus Verilog
Analyze waveforms using GTKWave
🧠 Design Architecture

The design is divided into four major blocks:

                 ┌───────────────────┐
                 │   State Register  │
                 │    CLK + RESET    │
                 └─────────┬─────────┘
                           │
                           ↓
                     Current State
                           │
                ┌──────────┴──────────┐
                ↓                     ↓
        ┌───────────────┐     ┌────────────────┐
        │    Counter    │     │  Next-State    │
        │     Block     │────→│     Logic      │
        └───────────────┘     └───────┬────────┘
                                      │
                                      ↓
                                  Next State
                                      │
                                      ↓
                              ┌───────────────┐
                              │ Output Logic  │
                              └───────┬───────┘
                                      │
                                      ↓
                              Traffic Lights
🔄 FSM States

The controller uses four states.

State	Encoding	Description
NS_GREEN	2'b00	North-South Green
NS_YELLOW	2'b01	North-South Yellow
EW_GREEN	2'b10	East-West Green
EW_YELLOW	2'b11	East-West Yellow
🔁 State Transition Diagram
                    timer_done
             ┌────────────────────┐
             │                    ↓
       ┌────────────┐       ┌────────────┐
       │ NS_GREEN   │──────→│ NS_YELLOW  │
       └────────────┘       └─────┬──────┘
                                   │
                                   │ timer_done
                                   ↓
                            ┌────────────┐
                            │ EW_GREEN   │
                            └─────┬──────┘
                                  │
                                  │ timer_done
                                  ↓
                            ┌────────────┐
                            │ EW_YELLOW  │
                            └─────┬──────┘
                                  │
                                  │ timer_done
                                  ↓
                            ┌────────────┐
                            │ NS_GREEN   │
                            └────────────┘

If timer_done = 0, the controller remains in the current state.

🚥 Output Logic
State	NS Green	NS Yellow	NS Red	EW Green	EW Yellow	EW Red
NS_GREEN	1	0	0	0	0	1
NS_YELLOW	0	1	0	0	0	1
EW_GREEN	0	0	1	1	0	0
EW_YELLOW	0	0	1	0	1	0

The controller ensures that both directions do not receive a Green signal at the same time.

⏱️ Counter Design

A separate counter block is used to determine the duration of each state.

Timing Parameters
parameter GREEN_TIME  = 10;
parameter YELLOW_TIME = 3;

Therefore:

Green  → 10 clock cycles
Yellow → 3 clock cycles

The counter generates a timer_done signal when the required number of clock cycles has elapsed.

             Counter
                │
                ↓
       Required count reached?
             /       \
           NO         YES
           ↓           ↓
      Stay in       timer_done
    current state       │
                        ↓
                  Change state
🔌 Inputs
Signal	Description
clk	System clock
reset	Asynchronous reset
💡 Outputs
Signal	Description
ns_green	North-South Green light
ns_yellow	North-South Yellow light
ns_red	North-South Red light
ew_green	East-West Green light
ew_yellow	East-West Yellow light
ew_red	East-West Red light
🛠️ Tools Used
Verilog HDL – RTL design
Icarus Verilog – Simulation
GTKWave – Waveform analysis
Visual Studio Code – Development environment
Git & GitHub – Version control and project hosting
📁 Project Structure
Traffic-Light-Controller/
│
├── traffic_light_controller.v
├── tb_traffic_light_controller.v
├── README.md
├── waveform.png
└── .gitignore

The .vcd waveform file is generated during simulation and does not need to be committed to the repository.

🧪 Simulation
1. Compile the design
iverilog -o traffic_light_sim traffic_light_controller.v tb_traffic_light_controller.v
2. Run the simulation
vvp traffic_light_sim

The simulation generates:

traffic_light_controller.vcd
3. Open the waveform
gtkwave traffic_light_controller.vcd
🔍 Verification

The testbench verifies:

Clock generation
Reset operation
FSM state transitions
Counter operation
Timer completion
Traffic-light output sequence
Continuous operation of the controller

Important signals to observe in GTKWave:

clk
reset
state
next_state
counter
timer_done


ns_green
ns_yellow
ns_red


ew_green
ew_yellow
ew_red
📊 Expected Operation

After reset:

NS Green = ON
EW Red   = ON

After the Green duration:

NS Green  = OFF
NS Yellow = ON
EW Red    = ON

Then:

NS Red   = ON
EW Green = ON

Then:

NS Red    = ON
EW Yellow = ON

Finally:

NS Green = ON
EW Red   = ON

The sequence repeats continuously.

📚 Concepts Learned

Through this project, I practiced:

Verilog HDL
RTL Design
Moore FSM
State Encoding
State Transition Logic
Sequential Logic
Combinational Logic
Counters
Asynchronous Reset
Clock Generation
Testbench Development
$monitor
$dumpfile
$dumpvars
Icarus Verilog
GTKWave
RTL Debugging
🚀 Future Improvements

Possible improvements for future versions:

Add pedestrian crossing control
Add vehicle detection sensors
Add emergency vehicle priority
Add configurable traffic-light timing
Add pedestrian request input
Add countdown timer
Implement using SystemVerilog
Add SystemVerilog assertions
Develop a SystemVerilog/UVM verification environment
Implement the design on an FPGA
👨‍💻 Author
Krushna Patil

This project is part of my journey toward improving my RTL Design and Design Verification skills using Verilog and SystemVerilog.

⭐ Key Takeaway

This project helped me understand how an FSM and counter can work together to implement a practical RTL design.

        FSM
         +
      Counter
         +
     Verilog RTL
         +
      Testbench
         +
     Simulation
         ↓
 Traffic Light Controller

More RTL Design and Design Verification projects coming soon! 🚀



### Recommended GitHub files


For this project, upload:


```text
📁 Traffic-Light-Controller
│
├── 📄 traffic_light_controller.v
├── 📄 tb_traffic_light_controller.v
├── 📄 README.md
├── 🖼️ waveform.png
└── 📄 .gitignore
