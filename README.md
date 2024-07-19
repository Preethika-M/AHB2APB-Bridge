AHB to APB Bridge Design
This project focuses on the design and implementation of an AHB to APB bridge, a crucial component within the AMBA protocol that facilitates communication between high-bandwidth AHB peripherals and low-bandwidth APB peripherals.

Abstract
The Advanced Microcontroller Bus Architecture (AMBA) is an open System-on-Chip bus protocol for high performance buses to communicate with low-power devices. In the AMBA High-performance Bus (AHB) a system bus is used to connect a processor, a DSP, and high-performance memory controllers whereas the AMBA Advanced Peripheral Bus (APB) is used to connect (Universal Asynchronous Receiver Transmitter) UART. It also contains a Bridge, which connects the AHB and APB buses.
Bridges are standard bus-to-bus interfaces that allow IPs connected to different buses to communicate with each other in a standardized way. 
In this project, I have developed synthesizable design of AHB2APB bridge and testbench for the functional verification of the same in Verilog HDL. The software tools that I have used are Modelsim(Intel),Xilinx Vivado 2023.1(Open -Source Verilog compiler and simulator design tool) and Quartus Prime (Open-Source Synthesizer tool)


Protocol
Introduction
The AMBA protocol is widely adopted for system-on-chip (SoC) design, supporting high-speed and low-power data transfers. A bridge is necessary for communication between AHB and APB peripherals.

AMBA Versions
AMBA 2.0: Introduced AHB for high-performance and APB for low-power peripherals.
AMBA 3.0: Introduced AXI for higher performance, including burst-based transactions.
AMBA 4.0: Introduced AXI4 for simple control register access and ACE for cache coherency.
AMBA 5.0: Introduced AXI5 with performance and efficiency improvements.
AMBA High-Performance Bus (AHB)

AMBA AHB is an ideal bus interface for high-performance synthesizable systems. It defines the interface between components, including masters, interconnects, and slaves. 
AMBA AHB supports high-performance, high clock frequency systems, including burst transfers. 
•A single clock-edge operation. 
• Non-tristate implementation. 
• Wide data bus options, including 64, 128, 256, 512, and 1024 bits. 
Common AHB slaves include internal memory devices, external memory interfaces, and high-bandwidth peripherals. Low-bandwidth peripherals are often routed to the AMBA Advanced Peripheral Bus (APB) for optimal system performance, rather than the AHB slave bus. An APB bridge, also known as an AHB slave, is used to connect high-performance AHB with APB. 
![image](https://github.com/user-attachments/assets/394c2379-47dd-4654-9a7c-d7b98a6b3a92)

AMBA Advanced Peripheral Bus (APB)
The Advanced Peripheral Bus (APB) is part of the Advanced Microcontroller Bus Architecture (AMBA) protocol family. It defines a low-cost interface that is optimized for minimal power consumption and reduced interface complexity. The APB protocol is not pipelined, use it to connect to low-bandwidth peripherals that do not require the high performance of the AXI protocol. The APB protocol relates a signal transition to the rising edge of the clock, to simplify the integration of APB peripherals into any design flow. Every transfer 
takes at least two cycles. 
The APB can interface with: 
• AMBA Advanced High-performance Bus (AHB) 
• AMBA Advanced High-performance Bus Lite (AHB-Lite) 
• AMBA Advanced Extensible Interface (AXI) 
• AMBA Advanced Extensible Interface Lite (AXI4-Lite) 

AHB to APB Bridge
The AHB to APB bridge serves as a critical component within the AMBA protocol, enabling seamless communication between high-performance AHB and low-power APB peripherals. The block diagram illustrates the bridge's architecture, which consists of a state machine and address decoding logic. The state machine controls the generation of APB and AHB output signals, ensuring accurate data transfer between the two buses. The address decoding logic selects the appropriate APB peripheral based on the current transfer address.
The bridge functions as an AHB slave and APB master, converting AHB read and write transfers into equivalent APB transfers. This involves handling various types of transfers, such as single read/write, burst read/write, and wrap write transfers. The interface incorporates handshaking signals to manage data flow and reduce data loss, providing efficient and reliable communication between high-speed AHB and low-bandwidth APB components. The design ensures that the AHB can accommodate the APB’s non-pipelined, lower-speed operations by introducing wait states during transfers. This integration supports high-performance system design while maintaining low power consumption for peripheral operations.

![image](https://github.com/user-attachments/assets/73c191e4-18e1-454a-b251-5d3259fa1269)

Simulation Waveforms
Simulation waveforms are used to check the bridge's performance for different transfer types, such as single read/write and burst read/write.


Architecture
![image](https://github.com/user-attachments/assets/756aeb66-a4b7-43a0-8cb4-af7a5ce2dbc3)



Synthesis
The Verilog code was synthesized into a hardware schematic, emphasizing the importance of design optimization for efficiency and performance. The bridge was configured with one master and three peripherals, demonstrating its capability to handle multiple peripherals.

Conclusion
This project provided a comprehensive understanding of the AHB to APB bridge, enhancing skills in Verilog coding, simulation, and synthesis. The bridge design supports efficient communication within SoCs, ensuring reliable data transfer between high-bandwidth AHB and low-bandwidth APB peripherals.
