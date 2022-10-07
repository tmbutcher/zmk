# Copyright (c) 2022 The ZMK Contributors
# SPDX-License-Identifier: MIT

# board_runner_args(jlink "--device=nrf52" "--speed=4000")
# board_runner_args(pyocd "--target=nrf52840" "--frequency=4000000")
# board_runner_args(blackmagicprobe "--gdb-serial=/dev/ttyBmpGdb")
# include(${ZEPHYR_BASE}/boards/common/jlink.board.cmake)
# include(${ZEPHYR_BASE}/boards/common/pyocd.board.cmake)
# include(${ZEPHYR_BASE}/boards/common/blackmagicprobe.board.cmake)

board_runner_args(nrfjprog "--nrf-family=NRF52" "--softreset")
include(${ZEPHYR_BASE}/boards/common/blackmagicprobe.board.cmake)
include(${ZEPHYR_BASE}/boards/common/nrfjprog.board.cmake)
