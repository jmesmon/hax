#include <compilers.h>

#include "auton.h"

#include "state.h"

#if defined(ROBOT_KEVIN)

STATE_START(start)
STATE(start,       1,    AUTO_WAIT(),             auto_none_init,     auto_none_loop,     deploy,      deploy, auto_none_isdone)
STATE(deploy,      150,  AUTO_DEPLOY(),           auto_deploy_init,   auto_deploy_loop,   init_ram,    done,   auto_none_isdone)
STATE(init_ram,    9000, AUTO_STRAIGHT(0, 127),   auto_straight_init, auto_straight_loop, init_arm,    done,   auto_straight_isdone)
STATE(init_arm,    2000, AUTO_ARM(0, -127),       auto_arm_init,      auto_arm_loop,      init_dump1,  done,   auto_arm_isdone)
STATE(init_dump1,  2000, AUTO_RAMP(100, 127),     auto_ramp_init,     auto_ramp_loop,     init_dump2,  done,   auto_ramp_isdone) 
STATE(init_dump2,  5000, AUTO_WAIT(),             auto_none_init,     auto_none_loop,     init_dump3,  done,   auto_none_isdone)
STATE(init_dump3,  2000, AUTO_RAMP(0, -127),      auto_ramp_init,     auto_ramp_loop,     coll_drive1, done,   auto_ramp_isdone)
STATE(coll_drive1, 5000, AUTO_STRAIGHT(150, 127), auto_straight_init, auto_straight_loop, coll_turn1,  done,   auto_straight_isdone)
STATE(coll_turn1,  2000, AUTO_TURN(90, 127),      auto_turn_init,     auto_turn_loop,     coll_drive2, done,   auto_turn_isdone)
STATE(coll_drive2, 5000, AUTO_STRAIGHT(480, 127), auto_straight_init, auto_straight_loop, coll_arm1,   done,   auto_straight_isdone)
STATE(coll_arm1,   2000, AUTO_ARM(0, 127),        auto_arm_init,      auto_arm_loop,      coll_arm2,   done,   auto_arm_isdone)
STATE(coll_arm2,   2000, AUTO_ARM(0, -127),       auto_arm_init,      auto_arm_loop,      coll_turn2,  done,   auto_arm_isdone)
STATE(coll_turn2,  2000, AUTO_TURN(90, 127),      auto_turn_init,     auto_turn_loop,     dep_ram,     done,   auto_turn_isdone)
STATE(dep_ram,     9000, AUTO_STRAIGHT(540, 127), auto_straight_init, auto_straight_loop, dep_dump1,   done,   auto_straight_isdone)
STATE(dep_dump1,   2000, AUTO_RAMP(100, 127),     auto_ramp_init,     auto_ramp_loop,     dep_dump2,   done,   auto_ramp_isdone)
STATE(dep_dump2,   5000, AUTO_WAIT(),             auto_none_init,     auto_none_loop,     dep_dump3,   done,   auto_none_isdone)
STATE(dep_dump3,   2000, AUTO_RAMP(0, 127),       auto_ramp_init,     auto_ramp_loop,     done,        done,   auto_ramp_isdone)
STATE(done,        1,    AUTO_WAIT(),             auto_none_init,     auto_none_loop,     done,        done,   auto_none_isdone)
STATE_DONE()

#elif defined(ROBOT_NITISH)

STATE_START(start)
STATE(start,      1,    AUTO_WAIT(),             auto_none_init,     auto_none_loop,     init_ram,   done, auto_none_isdone)
STATE(init_ram,   9000, AUTO_RAM(127),           auto_straight_init, auto_straight_loop, init_arm,   done, auto_ram_isdone)
STATE(init_arm,   5000, AUTO_ARM(0, -127),       auto_arm_init,      auto_arm_loop,      init_back,  done, auto_none_isdone)
STATE(init_back,  1000, AUTO_STRAIGHT(30, -127), auto_straight_init, auto_straight_loop, init_dump1, done, auto_straight_isdone)
STATE(init_dump1, 5000, AUTO_RAMP(100, 127),     auto_ramp_init,     auto_ramp_loop,     init_dump2, done, auto_ramp_isdone) 
STATE(init_dump2, 2000, AUTO_WAIT(),             auto_none_init,     auto_none_loop,     init_jig1,  done, auto_none_isdone)
STATE(init_jig1,  1000, AUTO_TURN(30, -127),     auto_turn_init,     auto_turn_loop,     init_jig2,  done, auto_turn_isdone)
STATE(init_jig2,  2000, AUTO_TURN(60,  127),     auto_turn_init,     auto_turn_loop,     init_jig3,  done, auto_turn_isdone)
STATE(init_jig3,  1000, AUTO_TURN(30, -127),     auto_turn_init,     auto_turn_loop,     init_dump3, done, auto_turn_isdone)
STATE(init_dump3, 5000, AUTO_RAMP(0, -127),      auto_ramp_init,     auto_ramp_loop,     done,       done, auto_ramp_isdone)
STATE(done,       1,    AUTO_WAIT(),             auto_none_init,     auto_none_loop,     done,       done, auto_none_isdone)
STATE_DONE()

#endif
