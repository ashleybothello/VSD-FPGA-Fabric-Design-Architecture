# FPGA — Fabric, Design and Architecture

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/ashleybothello/VSD-FPGA-Fabric-Design-Architecture?style=social)](https://github.com/ashleybothello/VSD-FPGA-Fabric-Design-Architecture/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/ashleybothello/VSD-FPGA-Fabric-Design-Architecture?style=social)](https://github.com/ashleybothello/VSD-FPGA-Fabric-Design-Architecture/network/members)

This repository contains the documentation and implementation work undertaken during the **FPGA — Fabric, Design and Architecture** workshop conducted by **VLSI System Design (VSD)**. The workshop covers the complete FPGA design flow using both commercial tools (**Xilinx Vivado**) and open-source tools (**OpenFPGA**, **VPR**, **VTR**, **SOFA**).

**Author:** Ashley Bothello

---

## Table of Contents

- [Introduction To FPGA](#introduction-to-fpga)
- [FPGA vs ASIC Comparison](#fpga-vs-asic-comparison)
- [Tools and Technologies](#tools-and-technologies)
- [Day 1 — RTL Design and Vivado](#day-1--rtl-design-and-vivado)
    - [Vivado Project Setup](#vivado-project-setup)
    - [Counter Design and Source Files](#counter-design-and-source-files)
    - [Counter Simulation](#counter-simulation)
    - [Counter Simulation Waveform](#counter-simulation-waveform)
    - [Elaborated Design Schematic](#elaborated-design-schematic)
    - [I/O Planning](#io-planning)
    - [Implementation — Timing Analysis](#implementation--timing-analysis)
    - [Implementation — Clock Summary](#implementation--clock-summary)
    - [Implementation — Utilization Report](#implementation--utilization-report)
    - [Implementation — Power Report](#implementation--power-report)
    - [Bitstream Generation](#bitstream-generation)
- [Day 2 — VTR-Based FPGA Implementation](#day-2--vtr-based-fpga-implementation)
    - [VTR Flow Execution](#vtr-flow-execution)
    - [VPR Placement and Routing](#vpr-placement-and-routing)
    - [Post-Synthesis Netlist](#post-synthesis-netlist)
    - [Timing Netlist](#timing-netlist)
    - [Setup Timing Analysis](#setup-timing-analysis)
    - [Hold Timing Analysis](#hold-timing-analysis)
    - [Power Analysis](#power-analysis)
- [Day 3 — RISC-V Processor Design on Vivado](#day-3--risc-v-processor-design-on-vivado)
    - [RVMYTH Project Setup](#rvmyth-project-setup)
    - [RISC-V Core Simulation](#risc-v-core-simulation)
    - [RISC-V Simulation Waveform (pc and a0)](#risc-v-simulation-waveform-pc-and-a0)
    - [RISC-V Core RTL Schematic](#risc-v-core-rtl-schematic)
- [Day 4 — SOFA / OpenFPGA Counter Implementation](#day-4--sofa--openfpga-counter-implementation)
    - [SOFA Directory Exploration](#sofa-directory-exploration)
    - [SOFA Counter Area Statistics](#sofa-counter-area-statistics)
    - [SOFA Counter Resource Utilization](#sofa-counter-resource-utilization)
    - [SOFA Counter Netlist](#sofa-counter-netlist)
    - [SOFA Counter Routing and Placement](#sofa-counter-routing-and-placement)
    - [SOFA Counter Setup Timing](#sofa-counter-setup-timing)
    - [SOFA Counter Hold Timing](#sofa-counter-hold-timing)
    - [SOFA Counter Reports](#sofa-counter-reports)
    - [SOFA Counter Power Activity](#sofa-counter-power-activity)
- [Day 5 — RISC-V Core on Custom SOFA Fabric](#day-5--risc-v-core-on-custom-sofa-fabric)
    - [RVMYTH Source and Flow Configuration](#rvmyth-source-and-flow-configuration)
    - [RVMYTH Collaterals and File Listing](#rvmyth-collaterals-and-file-listing)
    - [RVMYTH Task Configuration](#rvmyth-task-configuration)
    - [SOFA RVMYTH Area Statistics](#sofa-rvmyth-area-statistics)
    - [SOFA RVMYTH Netlist](#sofa-rvmyth-netlist)
    - [SOFA RVMYTH Placement and Routing](#sofa-rvmyth-placement-and-routing)
    - [SOFA RVMYTH Setup Timing](#sofa-rvmyth-setup-timing)
    - [SOFA RVMYTH Hold Timing](#sofa-rvmyth-hold-timing)
    - [SOFA RVMYTH Power Activity](#sofa-rvmyth-power-activity)
- [FPGA Design Flow Summary](#fpga-design-flow-summary)
- [References](#references)
- [Acknowledgement](#acknowledgement)

---

## Introduction To FPGA

An **FPGA (Field-Programmable Gate Array)** is a semiconductor device that can be configured by the user after manufacturing. Unlike ASICs, FPGAs can be reprogrammed to implement different digital circuits, making them ideal for prototyping, development, and applications requiring reconfigurability.

Key components of an FPGA include:
- **Configurable Logic Blocks (CLBs):** The fundamental building blocks containing Look-Up Tables (LUTs), flip-flops, and multiplexers
- **Programmable Interconnects:** Routing resources that connect CLBs together
- **I/O Blocks:** Interface between internal logic and external pins
- **Block RAM:** Dedicated memory blocks for data storage
- **DSP Slices:** Dedicated hardware for arithmetic operations

---

## FPGA vs ASIC Comparison

| Feature | FPGA | ASIC |
| :--- | :--- | :--- |
| **Programmability** | Reconfigurable after manufacturing | Hardwired, fixed functionality |
| **Time-to-Market** | Fast — design can be deployed instantly | Slow — requires fabrication |
| **Unit Cost** | Higher at volume | Low at high volume |
| **Performance** | Moderate — limited by routing overhead | High — optimized silicon |
| **Power Consumption** | Higher due to programmable interconnects | Lower — optimized for specific design |
| **NRE Cost** | Low — no fabrication masks needed | Very High — mask and fab costs |
| **Ideal Use Case** | Prototyping, low-volume, reconfigurable | High-volume production |

---

## Tools and Technologies

| Tool / Technology | Application |
| :--- | :--- |
| **Xilinx Vivado** | RTL development, simulation, synthesis, implementation, and bitstream generation |
| **Verilog / SystemVerilog** | Hardware description and digital logic design |
| **Yosys** | Open-source logic synthesis |
| **Verilog-to-Routing (VTR)** | FPGA architecture and implementation experiments |
| **VPR** | Packing, placement, routing, and timing analysis |
| **SOFA / OpenFPGA** | Open-source FPGA implementation-flow exploration |
| **ACE** | Switching-activity analysis for power estimation |
| **Linux and Bash** | Command-line execution and report inspection |
| **Git and GitHub** | Version control and documentation |

---

## Day 1 — RTL Design and Vivado

**Objective:** Explore the complete FPGA design flow using **Xilinx Vivado** with a counter-based digital design on the **Basys3 Artix-7** FPGA board.

### Vivado Project Setup

The Vivado design environment was launched and a new project `counter_day1` was created targeting the **Basys3 (xc7a35tcpg236-1)** FPGA part from the **Artix-7** family.

![Vivado Start Screen](images/Xilinxs.png)

![Vivado Project Manager — counter_day1](images/counter_day1.png)

### Counter Design and Source Files

The counter design consists of a **counter clock divider** module (`counter_clk_div.v`) and its testbench (`tb_counter`). The testbench instantiates the counter module and applies clock and reset stimuli.

![Counter Source Files in Vivado](images/two_files.png)

### Counter Simulation

**Behavioral simulation** was executed for the counter testbench. The simulation ran for 1000ns, verifying the functional behavior of the counter design.

![Counter Simulation — Behavioral](images/run_simulation.png)

### Counter Simulation Waveform

The simulation waveform shows the counter signals including `clk`, `sw[6:0]`, `led[6:0]`, soil classification outputs (`R1`, `G1`, `B1`, `R2`, `G2`, `B2`), `seg[6:0]`, and `an[3:0]` — demonstrating the correct functional behavior of the design.

![Simulation Waveform](images/waveform.png)

### Elaborated Design Schematic

The **RTL elaborated schematic** view shows the top-level architecture with the `soil_classifier (sc)` and `seven_seg_driver (ssd)` modules. The design has 2 cells, 32 I/O ports, and 48 nets.

![Elaborated Design Schematic](images/schematic.png)

### I/O Planning

The **I/O Planning** view shows the pin assignment and package visualization for the **xc7a35tcpg236-1** device. All 32 ports (`an`, `led`, `seg`, `sw`) are mapped to their respective I/O banks with LVCMOS18 standard and 1.800V Vcco.

![I/O Planning and Pin Assignment](images/IOplanning.png)

### Implementation — Timing Analysis

After successful implementation, the **Design Timing Summary** report confirms that all timing constraints are met:

- **Setup:** WNS = 4.713 ns, TNS = 0.000 ns — ✅ No violations
- **Hold:** WHS = 0.059 ns, THS = 0.000 ns — ✅ No violations
- **Pulse Width:** WPWS = 4.500 ns — ✅ No violations

![Design Timing Summary](images/Screenshot%202026-10-13%20184209.png)

### Implementation — Clock Summary

The **Clock Summary** shows the system clock (`sys_clk`) configured with a period of **10.000 ns** (100 MHz frequency).

![Clock Summary](images/Screenshot%202026-10-13%20184329.png)

### Implementation — Utilization Report

The **Utilization Report** shows the resource usage of the implemented design:

- **Slice LUTs:** 778 / 20,800 (4%)
- **Slice Registers:** 508 / 41,600
- **Bonded IOB:** 36 / 106
- **BUFGCTRL:** 1 / 32

![Utilization Report](images/Screenshot%202026-10-13%20184835.png)

### Implementation — Power Report

The **Power Analysis** report shows the total on-chip power consumption:

- **Total On-Chip Power:** 0.101 W
- **Dynamic Power:** 0.029 W (29%)
- **Device Static Power:** 0.072 W (71%)
- **Junction Temperature:** 25.5°C

![Power Report](images/Screenshot%202026-10-13%20184956.png)

### Bitstream Generation

**Bitstream generation** was completed successfully, confirming the design is ready for FPGA programming.

![Bitstream Generation Completed](images/Screenshot%202026-10-13%20185250.png)

---

## Day 2 — VTR-Based FPGA Implementation

**Objective:** Explore the FPGA implementation flow using open-source tools — **VTR (Verilog-to-Routing)** and **VPR (Versatile Place and Route)**.

**Design:** `blink.v`  
**Architecture:** `EArch.xml`

### VTR Flow Execution

The VTR flow was executed using the following command:

```bash
cd ~/day2 && python3 "$VTR_ROOT/vtr_flow/scripts/run_vtr_flow.py" \
  "$VTR_ROOT/doc/src/quickstart/blink.v" \
  "$VTR_ROOT/vtr_flow/arch/timing/EArch.xml" \
  -temp_dir . --route_chan_width 100
```

The flow completed successfully in **0.65 seconds** with an overall memory peak of **32.91 MiB**.

![VTR Flow Execution](images/day2.png)

### VPR Placement and Routing

The **VPR graphical interface** shows the placement result with the `blink` design mapped onto the EArch FPGA fabric. The CLB at position (1,1) is highlighted showing the placed logic block.

![VPR Placement Visualization](images/day2_vpr_run.png)

### Post-Synthesis Netlist

The **post-synthesis netlist** generated by the VTR flow shows the gate-level representation of the blink design after logic synthesis.

![Post-Synthesis Netlist](images/day2_post_synthesis_netlist.png)

### Timing Netlist

The **timing netlist** shows the annotated timing information on the placed and routed design.

![Timing Netlist](images/day2_timing_netlist.png)

### Setup Timing Analysis

The **setup timing report** from VPR shows the critical path analysis with detailed incremental and cumulative path delays through the counter logic (clock → latch → adder chain).

![Setup and Hold Timing Report](images/Screenshot%202026-10-14%20005554.png)

### Hold Timing Analysis

The **hold timing analysis** confirms that hold constraints are met for the blink counter design.

![Hold Timing Report](images/day2_hold_timing.png)

### Power Analysis

The **power analysis** output from the VTR flow provides switching activity and power estimation for the blink design.

![Power Analysis](images/day2_power_analysis.png)

![Power Analysis — Detailed](images/day2_power_analysis2.png)

---

## Day 3 — RISC-V Processor Design on Vivado

**Objective:** Explore a **4-stage RISC-V processor core (RVMYTH)** design and simulate it using Xilinx Vivado.

### RVMYTH Project Setup

A new Vivado project `rvmyth_day3` was created targeting the **Basys3 (xc7a35tcpg236-1)** board. The project contains the RISC-V core source files including `riscv_core.sv`, `riscv_core_gen.sv`, and the testbench `tb_riscv_core.sv`.

![RVMYTH Vivado Project Setup](images/Screenshot%202026-10-14%20000906.png)

### RISC-V Core Simulation

**Behavioral simulation** was run for the RISC-V core testbench (`tb_riscv_core`). The simulation shows the core's primary signals: `clk`, `rst`, `pc[31:0]`, `a0[31:0]`, and `done`.

![RISC-V Core Simulation — Initial State](images/Screenshot%202026-10-14%20002459.png)

### RISC-V Simulation Waveform (pc and a0)

After the core completes execution, the waveform shows:
- **pc[31:0]** = `00000024` — Program counter at final instruction
- **a0[31:0]** = `0000002d` — Output register with computed result (decimal 45)
- **done** = `1` — Core execution complete

![RISC-V Simulation — Final Values](images/Screenshot%202026-10-14%20002929.png)

![RISC-V Waveform — Detailed PC Bits](images/Screenshot%202026-10-14%20003003.png)

![RISC-V Waveform — PC Value 36](images/Screenshot%202026-10-14%20003035.png)

### RISC-V Core RTL Schematic

The **elaborated schematic** shows the top-level RISC-V core architecture with the `RTL_INV` (clock inverter) and the `riscv_core` DUT module with `clk` and `rst` inputs — a clean 2-cell, 2-net design.

![RISC-V Core RTL Schematic](images/Screenshot%202026-10-14%20003518.png)

---

## Day 4 — SOFA / OpenFPGA Counter Implementation

**Objective:** Examine FPGA implementation artifacts generated using the **SOFA (Skywater Opensource FPGAs)** framework with the **OpenFPGA** flow for a counter design on the **QLSOFA_HD** architecture.

### SOFA Directory Exploration

The SOFA FPGA directory structure was explored, showing the available architectures including `QLSOFA_HD_PNR`, `SOFA_PLUS_HD_PNR`, `SOFA_HD_PNR`, and `SOFA_CHD_PNR`.

![SOFA Directory Structure](images/QLSOFA.png)

### SOFA Counter Area Statistics

The **area statistics** report shows the logic block and routing area breakdown for the counter implementation on the QLSOFA_HD fabric.

![SOFA Counter — Area Statistics](images/day4_area_stats.png)

### SOFA Counter Resource Utilization

The **resource utilization** report shows the CLB and I/O usage for the counter design on the SOFA fabric.

![SOFA Counter — Resource Utilization](images/day4_resource_utilization.png)

### SOFA Counter Netlist

The **post-implementation netlist** shows the routing details including node-level SOURCE, OPIN, CHANX, CHANY, IPIN, and SINK information for each net in the counter design.

![SOFA Counter — Netlist Routing Details](images/day4_netlist.png)

### SOFA Counter Routing and Placement

The **routing and placement** output shows the physical mapping of the counter logic on the SOFA FPGA fabric.

![SOFA Counter — Routing and Placement](images/day4_routing_placement.png)

### SOFA Counter Setup Timing

The **setup timing analysis** for the SOFA counter implementation.

![SOFA Counter — Setup Timing](images/day4_setup_timing.png)

### SOFA Counter Hold Timing

The **hold timing analysis** for the SOFA counter implementation.

![SOFA Counter — Hold Timing](images/day4_hold_timing.png)

### SOFA Counter Reports

Overview of available **implementation reports** including log files and generated outputs for the SOFA counter flow.

![SOFA Counter — Reports](images/day4_reports.png)

### SOFA Counter Power Activity

The **ACE switching-activity analysis** output for the SOFA counter design, used for power estimation.

![SOFA Counter — Power Activity](images/day4_power_activity.png)

---

## Day 5 — RISC-V Core on Custom SOFA Fabric

**Objective:** Implement the **RVMYTH RISC-V core** on the custom SOFA FPGA fabric using the OpenFPGA flow, and analyze timing, area, and power results.

### RVMYTH Source and Flow Configuration

The RVMYTH source files and OpenFPGA flow configuration were prepared for the SOFA implementation. The collateral files from the FPGA workshop were organized into `Day1` through `Day5` directories.

![RVMYTH Source and Flow Config](images/Day5_01_Source_and_Flow_Config.png)

![SOFA Log Files and Flow Artifacts](images/Screenshot%202026-10-14%20010910.png)

### RVMYTH Collaterals and File Listing

The RVMYTH collateral files were identified and organized for the SOFA implementation flow.

![RVMYTH Collaterals Listing](images/d5_rvmyth_collaterals_listing.png)

![RVMYTH Files Copied](images/d5_rvmyth_files_copied.png)

![RVMYTH Source Search](images/d5_rvmyth_source_search.png)

### RVMYTH Task Configuration

The **task configuration** was set up for the RVMYTH core on the SOFA fabric.

![RVMYTH Task Config](images/d5_rvmyth_task_config.png)

![RVMYTH Task Prepared](images/d5_rvmyth_task_prepared.png)

![RVMYTH Flow Checks](images/d5_rvmyth_flow_checks.png)

### SOFA RVMYTH Area Statistics

The **area statistics** for the RVMYTH RISC-V core on the SOFA fabric.

![RVMYTH — Area Statistics](images/Day5_Area_Statistics.png)

### SOFA RVMYTH Netlist

The **post-implementation netlist** for the RVMYTH core on the SOFA fabric.

![RVMYTH — Netlist](images/Day5_Netlist.png)

### SOFA RVMYTH Placement and Routing

The **placement and routing** results for the RVMYTH core on the SOFA FPGA fabric.

![RVMYTH — Placement and Routing](images/Day5_Placement_Routing.png)

![RVMYTH — Placement and Routing (Detail)](images/Day5_Placement_Routing2.png)

### SOFA RVMYTH Setup Timing

The **setup timing analysis** for the RVMYTH implementation on SOFA.

![RVMYTH — Setup Timing](images/Day5_Setup_Timing.png)

### SOFA RVMYTH Hold Timing

The **hold timing analysis** for the RVMYTH implementation on SOFA.

![RVMYTH — Hold Timing](images/Day5_Hold_Timing.png)

### SOFA RVMYTH Power Activity

The **ACE switching-activity and power analysis** output for the RVMYTH core on the SOFA fabric.

**Observed ACE output:**
- Network objects: 49
- Primary inputs: 2
- Primary outputs: 8
- Network latches: 8
- Detected clock: `clk`
- ACE execution time: 0.06 seconds

![RVMYTH — Power Activity](images/Day5_Power_Activity.png)

![RVMYTH — Power Activity (2)](images/Day5_Power_Activity2.png)

![RVMYTH — Power Activity (3)](images/Day5_Power_Activity3.png)

![RVMYTH — Power Activity (4)](images/Day5_Power_Activity4.png)

![RVMYTH — Power Activity (5)](images/Day5_Power_Activity5.png)

![Day 5 — Confirmation](images/day5_confirmation.png)

---

## FPGA Design Flow Summary

The general FPGA implementation process explored across all five days can be summarized as:

1. **RTL Design** — Describe the digital logic using Verilog / SystemVerilog
2. **Synthesis** — Translate the RTL into a gate-level netlist
3. **Packing** — Group logic elements into CLBs supported by the FPGA architecture
4. **Placement** — Assign the logic blocks to physical locations on the fabric
5. **Routing** — Establish interconnections between placed blocks
6. **Timing Analysis** — Examine path delays, setup and hold constraints
7. **Activity Analysis** — Examine switching behavior and activity assumptions
8. **Power Estimation** — Estimate power using activity data and technology parameters

---

## References

- [VLSI System Design (VSD)](https://www.vlsisystemdesign.com/)
- [Xilinx Vivado Design Suite](https://www.xilinx.com/products/design-tools/vivado.html)
- [OpenFPGA Framework](https://github.com/lnis-uofu/OpenFPGA)
- [Verilog-to-Routing (VTR)](https://verilogtorouting.org/)
- [VPR — Versatile Place and Route](https://docs.verilogtorouting.org/en/latest/vpr/)
- [SOFA — Skywater Opensource FPGAs](https://github.com/lnis-uofu/SOFA)
- [Skywater PDK](https://github.com/google/skywater-pdk)
- [RISC-V Foundation](https://riscv.org/)

---

## Acknowledgement

- **Kunal Ghosh** — Co-Founder, VSD Corp. Pvt. Ltd.
- **VSD — VLSI System Design** — For conducting the FPGA workshop
- **OpenFPGA / VTR / SOFA** — Open-source FPGA communities
- All the mentors and fellow participants who contributed to the learning experience

---

**Author:** Ashley Bothello  
**Repository:** [VSD-FPGA-Fabric-Design-Architecture](https://github.com/ashleybothello/VSD-FPGA-Fabric-Design-Architecture)

