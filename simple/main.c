#include "hax.h"
#include "compilers.h"

#define map_oi(oi, motor) \
	motor_set(IX_MOTOR(motor), oi_group_get(IX_OI_GROUP(1, oi)))
void telop_loop(void) {
	map_oi(1, 1);
	map_oi(2, 2);
	map_oi(3, 3);
	map_oi(5, 4);
	map_oi(6, 5);

	printf("LOOP\n");
}

__noreturn void main(void) {
	static ctrl_mode_t mode;

	arch_init_1();
	arch_init_2();

	for(;;) {
		mode = ctrl_mode_get();

		/* The "slow loop", executes once every SLOW_US microseconds. */
		if (do_slow_loop()) {
			arch_loop_1();

			switch (mode) {
			case MODE_AUTON:
				break;

			case MODE_TELOP:
				telop_loop();
				break;

			default:
				break;
			}

			arch_loop_2();
		}

		/* Executes as fast as the hardware allows. */
		arch_spin();
	}
}
