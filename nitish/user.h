#ifndef USER_H_
#define USER_H_

#include <stdbool.h>

/*!
 * Initialize interrupt service routines for encoder counts.
 */
void init(void);

/*!
 * Converts an OI button input into one of three values: -1 (bottom button
 * pressed), 0 (no button pressed), and 1 (top button pressed). Undefined
 * return value if both buttons are pressed.
 *
 * \param io raw IO analog value
 */
int8_t button(int8_t io);

/*!
 * Changes the outputs of all drive motors to move in the desired direction.
 * Omega values of +/-127 indicate no forward movement, whereas a spin value
 * of 0 indicates no rotation.
 *
 * \param x side-to-side translation, where positive values are "right"
 * \param y front-to-back translation, where positive values are "forward"
 * \param z spin value of arbitrary units; zero indicates no rotation
 */
void drive_omni(int8_t x, int8_t y, int8_t z);

/*!
 * Move the arm at the desired rate of speed, where positive values indicate
 * up and negative values indicate down. Does not allow movement outside of a
 * potentiometer-defined range.
 *
 * \param pwr signed motor velocity
 */
bool lift_arm(int8_t pwr);

/*!
 * Raise or lower the basket at the desired rate of speed, where positive
 * values indicate up and negative values indicate down. Does not allow
 * movement outside of a potentiometer-defined range.
 *
 * \param pwr signed motor velocity
 */
bool lift_basket(int8_t pwr);

#endif