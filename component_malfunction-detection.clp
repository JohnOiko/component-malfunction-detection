; The goal flow of the program is the following:
;	1. initial-fact
;	2. goal set-max-clock
;	3. goal start-next-cycle
;	4. goal calc-output
;	5. goal find-discrepancies
;	6. goal make-suspects
;	7. goal exonerate-components
;	8. goal print-suspect (this goal is only asserted if a suspect is found)
;	9. goal retract-facts
;
; Once the goal 9. goal retract-facts is about to change, if the current clock has not reached the max clock yet, the next goal becomes
; 3. goal start-next-cycle and the goals 3 to 9 are repeated until the goal 9. goal retract-facts is about to change and the current clock
; is equal to the max clock at which point all facts are retracted and the program halts execution. 

(defclass systemEntity
	(is-a USER)
	(role abstract)
	(slot suspect
		(type SYMBOL)
		(allowed-values yes no)
		(default no)
		(create-accessor read-write))
	(slot out
		(type INTEGER)
		(range 0 31)
		(create-accessor read-write)
		(visibility public)))

(defclass command
	(is-a systemEntity)
	(role concrete)
	(pattern-match reactive))

(defclass component
	(is-a systemEntity)
	(role abstract))

(defclass sensor
	(is-a component)
	(role concrete)
	(pattern-match reactive)
	(slot theoretical
		(type INTEGER)
		(range 0 31)
		(create-accessor read-write))
	(slot out
		(type INTEGER)
		(range 0 31)
		(create-accessor read-write))
	(slot reading
		(type INTEGER)
		(range 0 31)
		(create-accessor read-write))
	(slot input
		(type INSTANCE)
		(allowed-classes internal-component)
		(create-accessor read-write)))

(defclass internal-component
	(is-a component)
	(role concrete)
	(pattern-match reactive)
	(slot short-out
		(type INTEGER)
		(range 0 0)
		(default 0)
		(create-accessor read-write))
	(multislot output
		(type INSTANCE)
		(allowed-classes component)
		(create-accessor read-write))
	(slot msb-out
		(type INTEGER)
		(range 0 15)
		(create-accessor read-write)
		(visibility public))
	(slot input2
		(type INSTANCE)
		(allowed-classes systemEntity)
		(create-accessor read-write))
	(slot input1
		(type INSTANCE)
		(allowed-classes systemEntity)
		(create-accessor read-write)))

(defclass adder
	(is-a internal-component)
	(role concrete))

(defclass multiplier
	(is-a internal-component)
	(role concrete))

(defclass circuit
	(is-a systemEntity)
	(role concrete)
	(pattern-match reactive)
	(multislot outputs
		(type INSTANCE)
		(allowed-classes sensor)
		(create-accessor read-write))
	(multislot has-components
		(type INSTANCE)
		(allowed-classes component)
		(create-accessor read-write))
	(multislot inputs
		(type INSTANCE)
		(allowed-classes command)
		(create-accessor read-write)))

(defclass data
	(is-a USER)
	(role abstract)
	(slot clock
		(type INTEGER)
		(range 1 ?VARIABLE)
		(create-accessor read-write))
	(slot object
		(type INSTANCE)
		(allowed-classes systemEntity)
		(create-accessor read-write))
	(slot value
		(type INTEGER)
		(create-accessor read-write)))

(defclass command_data
	(is-a data)
	(role concrete)
	(pattern-match reactive)
	(slot object
		(type INSTANCE)
		(allowed-classes command)
		(create-accessor read-write)))

(defclass reading_data
	(is-a data)
	(role concrete)
	(pattern-match reactive)
	(slot object
		(type INSTANCE)
		(allowed-classes sensor)
		(create-accessor read-write)))

(definstances facts

([a1] of  adder

	(input1 [input_1])
	(input2 [input_1])
	(output
		[m1]
		[p1])
	(short-out 0)
	(suspect no))

([a2] of  adder

	(input1 [p1])
	(input2 [p2])
	(output [out1])
	(short-out 0)
	(suspect no))

([circuit_1] of  circuit

	(has-components
		[m1]
		[m2]
		[m3]
		[out1]
		[a1]
		[a2]
		[p1]
		[p2])
	(inputs
		[input_1]
		[input_2]
		[input_3]
		[input_4])
	(outputs [out1])
	(suspect no))

([command_10_inp1] of  command_data

	(clock 10)
	(object [input_1])
	(value 6))

([command_10_inp2] of  command_data

	(clock 10)
	(object [input_2])
	(value 4))

([command_10_inp3] of  command_data

	(clock 10)
	(object [input_3])
	(value 25))

([command_10_inp4] of  command_data

	(clock 10)
	(object [input_4])
	(value 12))

([command_1_inp1] of  command_data

	(clock 1)
	(object [input_1])
	(value 21))

([command_1_inp2] of  command_data

	(clock 1)
	(object [input_2])
	(value 28))

([command_1_inp3] of  command_data

	(clock 1)
	(object [input_3])
	(value 10))

([command_1_inp4] of  command_data

	(clock 1)
	(object [input_4])
	(value 25))

([command_2_inp1] of  command_data

	(clock 2)
	(object [input_1])
	(value 7))

([command_2_inp2] of  command_data

	(clock 2)
	(object [input_2])
	(value 25))

([command_2_inp3] of  command_data

	(clock 2)
	(object [input_3])
	(value 13))

([command_2_inp4] of  command_data

	(clock 2)
	(object [input_4])
	(value 15))

([command_3_inp1] of  command_data

	(clock 3)
	(object [input_1])
	(value 11))

([command_3_inp2] of  command_data

	(clock 3)
	(object [input_2])
	(value 17))

([command_3_inp3] of  command_data

	(clock 3)
	(object [input_3])
	(value 24))

([command_3_inp4] of  command_data

	(clock 3)
	(object [input_4])
	(value 31))

([command_4_inp1] of  command_data

	(clock 4)
	(object [input_1])
	(value 18))

([command_4_inp2] of  command_data

	(clock 4)
	(object [input_2])
	(value 11))

([command_4_inp3] of  command_data

	(clock 4)
	(object [input_3])
	(value 28))

([command_4_inp4] of  command_data

	(clock 4)
	(object [input_4])
	(value 21))

([command_5_inp1] of  command_data

	(clock 5)
	(object [input_1])
	(value 25))

([command_5_inp2] of  command_data

	(clock 5)
	(object [input_2])
	(value 24))

([command_5_inp3] of  command_data

	(clock 5)
	(object [input_3])
	(value 30))

([command_5_inp4] of  command_data

	(clock 5)
	(object [input_4])
	(value 10))

([command_6_inp1] of  command_data

	(clock 6)
	(object [input_1])
	(value 12))

([command_6_inp2] of  command_data

	(clock 6)
	(object [input_2])
	(value 19))

([command_6_inp3] of  command_data

	(clock 6)
	(object [input_3])
	(value 11))

([command_6_inp4] of  command_data

	(clock 6)
	(object [input_4])
	(value 19))

([command_7_inp1] of  command_data

	(clock 7)
	(object [input_1])
	(value 1))

([command_7_inp2] of  command_data

	(clock 7)
	(object [input_2])
	(value 31))

([command_7_inp3] of  command_data

	(clock 7)
	(object [input_3])
	(value 7))

([command_7_inp4] of  command_data

	(clock 7)
	(object [input_4])
	(value 22))

([command_8_inp1] of  command_data

	(clock 8)
	(object [input_1])
	(value 0))

([command_8_inp2] of  command_data

	(clock 8)
	(object [input_2])
	(value 31))

([command_8_inp3] of  command_data

	(clock 8)
	(object [input_3])
	(value 3))

([command_8_inp4] of  command_data

	(clock 8)
	(object [input_4])
	(value 23))

([command_9_inp1] of  command_data

	(clock 9)
	(object [input_1])
	(value 31))

([command_9_inp2] of  command_data

	(clock 9)
	(object [input_2])
	(value 1))

([command_9_inp3] of  command_data

	(clock 9)
	(object [input_3])
	(value 6))

([command_9_inp4] of  command_data

	(clock 9)
	(object [input_4])
	(value 8))

([input_1] of  command

	(suspect no))

([input_2] of  command

	(suspect no))

([input_3] of  command

	(suspect no))

([input_4] of  command

	(suspect no))

([m1] of  sensor

	(input [a1])
	(suspect no))

([m2] of  sensor

	(input [p1])
	(suspect no))

([m3] of  sensor

	(input [p2])
	(suspect no))

([out1] of  sensor

	(input [a2])
	(suspect no))

([p1] of  multiplier

	(input1 [input_2])
	(input2 [a1])
	(output
		[m2]
		[a2])
	(short-out 0)
	(suspect no))

([p2] of  multiplier

	(input1 [input_3])
	(input2 [input_4])
	(output
		[m3]
		[a2])
	(short-out 0)
	(suspect no))

([reading_10_m1] of  reading_data

	(clock 10)
	(object [m1])
	(value 12))

([reading_10_m2] of  reading_data

	(clock 10)
	(object [m2])
	(value 31))

([reading_10_m3] of  reading_data

	(clock 10)
	(object [m3])
	(value 12))

([reading_10_out] of  reading_data

	(clock 10)
	(object [out1])
	(value 28))

([reading_1_m1] of  reading_data

	(clock 1)
	(object [m1])
	(value 10))

([reading_1_m2] of  reading_data

	(clock 1)
	(object [m2])
	(value 24))

([reading_1_m3] of  reading_data

	(clock 1)
	(object [m3])
	(value 26))

([reading_1_out] of  reading_data

	(clock 1)
	(object [out1])
	(value 18))

([reading_2_m1] of  reading_data

	(clock 2)
	(object [m1])
	(value 0))

([reading_2_m2] of  reading_data

	(clock 2)
	(object [m2])
	(value 0))

([reading_2_m3] of  reading_data

	(clock 2)
	(object [m3])
	(value 3))

([reading_2_out] of  reading_data

	(clock 2)
	(object [out1])
	(value 3))

([reading_3_m1] of  reading_data

	(clock 3)
	(object [m1])
	(value 22))

([reading_3_m2] of  reading_data

	(clock 3)
	(object [m2])
	(value 6))

([reading_3_m3] of  reading_data

	(clock 3)
	(object [m3])
	(value 8))

([reading_3_out] of  reading_data

	(clock 3)
	(object [out1])
	(value 14))

([reading_4_m1] of  reading_data

	(clock 4)
	(object [m1])
	(value 4))

([reading_4_m2] of  reading_data

	(clock 4)
	(object [m2])
	(value 12))

([reading_4_m3] of  reading_data

	(clock 4)
	(object [m3])
	(value 12))

([reading_4_out] of  reading_data

	(clock 4)
	(object [out1])
	(value 0))

([reading_5_m1] of  reading_data

	(clock 5)
	(object [m1])
	(value 18))

([reading_5_m2] of  reading_data

	(clock 5)
	(object [m2])
	(value 16))

([reading_5_m3] of  reading_data

	(clock 5)
	(object [m3])
	(value 12))

([reading_5_out] of  reading_data

	(clock 5)
	(object [out1])
	(value 12))

([reading_6_m1] of  reading_data

	(clock 6)
	(object [m1])
	(value 8))

([reading_6_m2] of  reading_data

	(clock 6)
	(object [m2])
	(value 24))

([reading_6_m3] of  reading_data

	(clock 6)
	(object [m3])
	(value 17))

([reading_6_out] of  reading_data

	(clock 6)
	(object [out1])
	(value 9))

([reading_7_m1] of  reading_data

	(clock 7)
	(object [m1])
	(value 2))

([reading_7_m2] of  reading_data

	(clock 7)
	(object [m2])
	(value 0))

([reading_7_m3] of  reading_data

	(clock 7)
	(object [m3])
	(value 26))

([reading_7_out] of  reading_data

	(clock 7)
	(object [out1])
	(value 26))

([reading_8_m1] of  reading_data

	(clock 8)
	(object [m1])
	(value 0))

([reading_8_m2] of  reading_data

	(clock 8)
	(object [m2])
	(value 0))

([reading_8_m3] of  reading_data

	(clock 8)
	(object [m3])
	(value 0))

([reading_8_out] of  reading_data

	(clock 8)
	(object [out1])
	(value 0))

([reading_9_m1] of  reading_data

	(clock 9)
	(object [m1])
	(value 30))

([reading_9_m2] of  reading_data

	(clock 9)
	(object [m2])
	(value 30))

([reading_9_m3] of  reading_data

	(clock 9)
	(object [m3])
	(value 0))

([reading_9_out] of  reading_data

	(clock 9)
	(object [out1])
	(value 30))
	
)

; Message handler that calculates the outputs of an adder based on its two input values ?inp1 and ?inp2.
(defmessage-handler adder calculate-output (?inp1 ?inp2)
	(bind ?self:out (mod (+ ?inp1 ?inp2) 32))
	(bind ?self:msb-out (mod (+ ?inp1 ?inp2) 16))
)

; Message handler that calculates the outputs of a multiplier based on its two input values ?inp1 and ?inp2.
(defmessage-handler multiplier calculate-output (?inp1 ?inp2)
	(bind ?self:out (mod (* ?inp1 ?inp2) 32))
	(bind ?self:msb-out (mod (* ?inp1 ?inp2) 16))
)

; Message handler that calculates the theoretical reading and output of a sensor based on its input value ?inp.
(defmessage-handler sensor calculate-output (?inp)
	(bind ?self:theoretical ?inp)
	(bind ?self:out ?inp)
)

; Initial rule of the program, retracts the initial fact, sets the strategy to mea, sets the clock to 1, initializes the max clock to 0 and sets the goal to setting the max clock.
(defrule start-program
	?x <- (initial-fact)
  =>
	(retract ?x)
	(set-strategy mea)
	(assert (clock 1))
	(assert (max-clock 0))
	(assert (goal set-max-clock))
)

; Rule that sets the max clock to the largest clock of the command data inputs of the circuit circuit1 and changes the goal to starting the next cycle.
(defrule set-max-clock
	?x <- (goal set-max-clock) ; continue if the goal is to set the max clock.
	?y <- (max-clock ?max-clk) ; ?max-clk takes the previous max clock.
	(object (is-a circuit)
		(name [circuit_1])
		(inputs $? ?inp $?)) ; $inp takes the name of each input of the circuit.
	; The following lines find the largest clock ?clk1 of the command data that correspond to the input ?inp of the circuit.
	(object (is-a command_data)
		(clock ?clk1 & :(> ?clk1 ?max-clk)) ; continue if the clock of the command data is larger than the previous max clock.
		(object ?inp)) ; the command data must refer to the input ?inp of the circuit.
	(not (object (is-a command_data)
				(clock ?clk2 & :(> ?clk2 ?clk1)) ; continue if there is no other command data input with a larger than ?clk1 clock that corresponds to the ?inp input of the circuit. 
				(object ?inp))) ; the command data must refer to the input ?inp of the circuit.
  =>
	(retract ?y) ; retract the previous goal fact.
	(retract ?x) ; retract the previous max clock fact.
	(assert (goal start-next-cycle)) ; assert the new start next cycle goal fact.
	(assert (max-clock ?clk1)) ; assert the new max clock fact.
)

; Rule that sets the values of the inputs to the input values of the current cycle.
(defrule set-input
	(goal start-next-cycle) ; continue if the goal is to start the next cycle.
	(clock ?clk) ; ?clk takes the clock of the current cycle.
	(object (is-a circuit)
		(name [circuit_1])
		(inputs $? ?inp $?)) ; $inp takes the name of each input of the circuit.
	(object (is-a command_data)
		(clock ?clk)
		(object ?inp) ; the command data must refer to the input ?inp of the circuit.
		(value ?inp-val)) ; ?inp-val takes the value of the current cycle's input that corresponds to the circuit's input ?inp.
  =>
	(send ?inp put-out ?inp-val) ; set the output value of the circuit's input ?inp to ?inp-val.
	(assert (calculated ?inp)) ; assert a fact that tells the program the output value of ?inp has been calculated for this cycle.
)

; Rule that sets the readings of the sensors to the readings of the current cycle's sensors.
(defrule set-sensor-reading
	(goal start-next-cycle) ; continue if the goal is to start the next cycle.
	(clock ?clk) ; ?clk takes the clock of the current cycle.
	(object (is-a circuit)
		(name [circuit_1])
		(has-components $? ?sens $?)) ; ?sens takes the name of each sensor of the circuit.
	(object (is-a reading_data)
		(clock ?clk)
		(object ?sens) ; the reading data must refer to the sensor ?sens of the circuit.
		(value ?sens-read)) ; ?sens-read takes the reading of the current cycle's sensor that corresponds to the circuit's sensor ?sens.
  =>
	(send ?sens put-reading ?sens-read) ; set the reading of the circuit's sensor ?sens to ?sens-read.
)

; Rule that changes the goal from starting the next cycle to calculating the circuit's components' outputs. Because of using the strategy mea, this
; is executed once all the set-input and set-sensor-reading rules have finished executing.
(defrule change-goal-to-calc-output
	?x <- (goal start-next-cycle) => (retract ?x) (assert (goal calc-output))
)

; Rule that calculates the output of an internal component of the circuit.
(defrule calc-internal-component-output
	(goal calc-output) ; continue if the goal is to calculate the circuit's components' outputs.
	(calculated ?inp1) ; ?inp1 takes the name of a component whose output has already been calculated for the current cycle.
	(calculated ?inp2) ; ?inp2 takes the name of a component whose output has already been calculated for the current cycle, can be the same as ?inp1.
	(object (is-a circuit)
		(name [circuit_1])
		(has-components $? ?int-comp $?)) ; ?int-comp takes the name of each internal component of the circuit.
	(object (is-a internal-component) ; ?int-comp must be an internal component whose first input is ?inp1 and second input is ?inp2.
			(name ?int-comp)
			(input1 ?inp1)
			(input2 ?inp2))
	(object (is-a systemEntity)
			(name ?inp1)
			(out ?inp1-val)) ; ?inp1-val takes the value of the system entity's ?int-comp first input ?inp1.
	(object (is-a systemEntity)
			(name ?inp2)
			(out ?inp2-val)) ; ?inp2-val takes the value of the system entity's ?int-comp second input ?inp2.
  =>
	(send ?int-comp calculate-output ?inp1-val ?inp2-val) ; send a message to calculate the internal component's ?int-comp output based on its input values ?inp1-val and ?inp2-val.
	(assert (calculated ?int-comp)) ; assert a fact that tells the program the output value of the internal component ?int-comp has been calculated for this cycle.
)

; Rule that calculates the real and theoretical outputs of a sensor of the circuit.
(defrule calc-sensor-output
	(goal calc-output) ; continue if the goal is to calculate the circuit's components' outputs.
	(calculated ?inp) ; ?inp takes the name of a component whose output has already been calculated for the current cycle.
	(object (is-a circuit)
		(name [circuit_1])
		(has-components $? ?sens $?)) ; ?sens takes the name of each sensor of the circuit.
	(object (is-a sensor) ; ?sens must be a sensor whose input is ?inp.
			(name ?sens)
			(input ?inp))
	(object (is-a component)
			(name ?inp)
			(out ?inp-val)) ; ?inp1-val takes the value of the sensor's ?sens input ?inp.
  =>
	(send ?sens calculate-output ?inp-val) ; send a message to calculate the sensor's ?sens real and theoretical outputs based on its input value ?inp-val.
)

; Rule that changes the goal from calculating the circuit's components' outputs to finding discrepancies between theoretical and real sensor readings. Because of using the strategy mea, this
; is executed once all the circuit's components' outputs have been calculated.
(defrule change-goal-to-find-discrepancies
	?x <- (goal calc-output) => (retract ?x) (assert (goal find-discrepancies))
)

; Rule that finds a discrepancy between a sensor's theoretical and real reading.
(defrule find-discrepancy
	(goal find-discrepancies) ; continue if the goal is to find discrepancies between theoretical and real sensor readings.
	(clock ?clk) ; ?clk takes the clock of the current cycle.
	(object (is-a circuit)
		(name [circuit_1])
		(has-components $? ?sens $?)) ; ?sens takes the name of each sensor of the circuit.
	(object (is-a sensor) ; ?sens must be a sensor.
			(name ?sens))
	(test (<> (send ?sens get-theoretical) (send ?sens get-reading))) ; continue if the theoretical reading of the sensor ?sens is different than its real reading provided by the corresponding reading_data instance.
  =>
	(assert (discrepancy ?sens)) ; assert a fact that tells the program there is a discrepancy in this sensor's ?sens theoretical and real reading for the current cycle.
)

; Rule that changes the goal from finding discrepancies between theoretical and real sensor readings to making suspects. Because of using the strategy mea, this
; is executed once all the sensor discrepancies have been found.
(defrule change-goal-to-make-suspects
	?x <- (goal find-discrepancies) => (retract ?x) (assert (goal make-suspects))
)

; Rule that initializes the suspects by marking as suspect each sensor with a discrepancy that isn't already a suspect.
(defrule init-suspect
	(goal make-suspects) ; continue if the goal is to make suspects.
	(discrepancy ?sens) ; ?sens takes the name of each sensor that shows a discrepancy in its theoretical and real reading for the current cycle.
	(object (is-a circuit)
		(name [circuit_1])
		(has-components $? ?sens $?)) ; continue if the sensor ?sens that shows a discrepancy in its theoretical and real reading for the current cycle is a component of the circuit.
	(object (is-a sensor)
			(name ?sens)
			(suspect no)) ; continue if the sensor ?sens with the discrepancy is not already a suspect.
  =>
	(modify-instance ?sens (suspect yes)) ; mark the sensor ?sens with the discrepancy as a suspect.
)

; Rule that marks as suspects internal components that are not already suspects and are inputs to suspect sensors.
(defrule propagate-suspect-from-sensor
	(goal make-suspects) ; continue if the goal is to make suspects.
	(object (is-a circuit)
		(name [circuit_1])
		(has-components $? ?sens $?)) ; ?sens takes the name of each sensor of the circuit.
	(object (is-a circuit)
		(name [circuit_1])
		(has-components $? ?int-comp $?)) ; ?int-comp takes the name of each internal component of the circuit.
	(object (is-a sensor)
			(name ?sens)
			(input ?int-comp) ; continue if the internal component ?int-comp is the sensor's ?sens input.
			(suspect yes)) ; continue if the sensor ?sens is a suspect.
	(object (is-a internal-component)
			(name ?int-comp)
			(suspect no)) ; continue if the internal component ?int-comp is not a suspect.
  =>
	(modify-instance ?int-comp (suspect yes)) ; mark the internal component ?int-comp which is a suspect sensor's ?sens input as suspect.
)

; Rule that marks as suspects internal components that are not already suspects and are inputs to both a suspect internal component and a suspect sensor.
(defrule propagate-suspect-from-internal-component
	(goal make-suspects) ; continue if the goal is to make suspects.
	(object (is-a circuit)
		(name [circuit_1])
		(has-components $? ?int-comp $?)) ; ?int-comp takes the name of each internal component of the circuit.
	(object (is-a circuit)
		(name [circuit_1])
		(has-components $? ?int-comp $?)) ; ?out takes the name of each internal component of the circuit.
	(object (is-a circuit)
		(name [circuit_1])
		(has-components $? ?sens $?)) ; ?sens takes the name of each sensor of the circuit.
	(object (is-a internal-component)
			(name ?int-comp)
			(output $? ?out $?) ; ?out takes the name of the output of the internal component ?int-comp of the circuit which is not a suspect.
			(suspect no)) ; continue if the internal component ?int-comp is not a suspect.
	(object (is-a internal-component)
			(name ?out)
			(suspect yes)) ; continue if the internal component output ?out of the internal component ?int-comp is a suspect.
	(object (is-a internal-component)
			(name ?int-comp)
			(output $? ?sens $?)) ; ?sens takes the name of the output sensor of the internal component ?int-comp of the circuit which is not a suspect.
	(object (is-a sensor)
			(name ?sens)
			(suspect yes)) ; continue if the output sensor ?sens of the internal component ?int-comp is suspect.
  =>
	(modify-instance ?int-comp (suspect yes)) ; mark the internal component ?int-comp which is the input of the suspect internal component ?out and the suspect sensor ?sens as suspect.
)

; Rule that changes the goal from making suspects to exonerating components. Because of using the strategy mea, this
; is executed once all the sensor suspects have been made.
(defrule change-goal-to-exonerate-components
	?x <- (goal make-suspects) => (retract ?x) (assert (goal exonerate-components))
)

; Rule that exonerates a sensor if both its input internal component and output internal components are suspect or its input internal component is suspect and only outputs to sensors.
(defrule exonerate-sensor
	(declare (salience 2)) ; sets the salience to 2 so that this rule is executed before exonerate-internal-component-from-input and exonerate-internal-component-from-output.
	(goal exonerate-components) ; continue if the goal is to exonerate components.
	(object (is-a circuit)
		(name [circuit_1])
		(has-components $? ?sens $?)) ; ?sens takes the name of each sensor of the circuit.
	(object (is-a circuit)
		(name [circuit_1])
		(has-components $? ?inp $?)) ; ?inp takes the name of each internal component of the circuit.
	(object (is-a sensor)
			(name ?sens) ; ?sens takes the name of the sensor of the circuit that may be exonerated.
			(input ?inp) ; ?inp takes the name of the input internal component of the sensor ?sens of the circuit that may be exonerated.
			(suspect yes)) ; continue if the sensor of the circuit ?sens that may be exonerated is a suspect.
	(object (is-a internal-component)
			(name ?inp)
			(output $? ?out1 $?) ; ?out1 takes the name of the output internal component of the input internal component ?inp of the sensor ?sens of the circuit that may be exonerated.
			(suspect yes)) ; continue if the input internal component ?inp of the sensor ?sens of the circuit that may be exonerated is a suspect.
	(or (and (object (is-a circuit) ; this part of the or condition exonerates the sensor ?sens if its input internal component ?inp and its output internal component ?out1 are both suspects.
				(name [circuit_1])
				(has-components $? ?out1 $?)) ; ?out1 takes the name of each internal component of the circuit.
			(object (is-a internal-component)
				(name ?out1)
				(suspect yes))) ; continue to exonerate the sensor ?sens if the output internal component ?out1 of its suspect input internal component ?inp is suspect.
		(not (and (object (is-a circuit) ; this part of the or condition exonerates the sensor ?sens if there is no internal component ?out2 that uses the sensor's ?sens suspect input internal component ?inp as input.
					(name [circuit_1])
					(has-components $? ?out2 $?)) ; ?out2 takes the name of each internal component of the circuit.
					(or (object (is-a internal-component) ; this activates if there is an internal component ?out2 whose first input is the sensor's ?sens suspect input internal component ?inp, the or condition keeps the opposite result of this because of the not.
							(name ?out2)
							(input1 ?inp))
						(object (is-a internal-component) ; this activates if there is an internal component ?out2 whose second input is the sensor's ?sens suspect input internal component ?inp, the or condition keeps the opposite result of this because of the not.
							(name ?out2)
							(input2 ?inp))))))
  =>
	(modify-instance ?sens (suspect no)) ; exonerate the previously suspect sensor ?sens.
)

; Rule that exonerates an internal component if one or both of its input internal components are suspect.
(defrule exonerate-internal-component-from-input
	(declare (salience 1)) ; sets the salience to 1 so that this rule is executed after exonerate-sensor. This way the sensors are exonerated before the internal components.
	(goal exonerate-components) ; continue if the goal is to exonerate components.
	(object (is-a circuit)
		(name [circuit_1])
		(has-components $? ?int-comp $?)) ; ?int-comp takes the name of each internal component of the circuit.
	(object (is-a circuit)
		(name [circuit_1])
		(has-components $? ?out $?)) ; ?out takes the name of each internal component of the circuit.
	(object (is-a internal-component)
			(name ?int-comp)
			(output $? ?out $?) ; ?out takes the name of the output internal component of the suspect internal component ?int-comp.
			(suspect yes)) ; continue if ?int-comp is suspect.
	(object (is-a internal-component)
			(name ?out)
			(suspect yes)) ; continue if the output internal component of the suspect internal component ?int-comp is suspect.
  =>
	(modify-instance ?out (suspect no)) ; exonerate the internal component ?out whose input internal component ?int-comp is suspect.
)

; Rule that exonerates an internal component if its output sensor is suspect and the output sensor that corresponds to its output internal component is not suspect.
(defrule exonerate-internal-component-from-output
	(declare (salience 1)) ; sets the salience to 1 so that this rule is executed after exonerate-sensor. This way the sensors are exonerated before the internal components.
	(goal exonerate-components) ; continue if the goal is to exonerate components.
	(object (is-a circuit)
		(name [circuit_1])
		(has-components $? ?int-comp $?)) ; ?int-comp takes the name of each internal component of the circuit.
	(object (is-a circuit)
		(name [circuit_1])
		(has-components $? ?sens1 $?)) ; ?sens1 takes the name of each sensor of the circuit.
	(object (is-a circuit)
		(name [circuit_1])
		(has-components $? ?out $?)) ; ?out takes the name of each internal component of the circuit.
	(object (is-a circuit)
		(name [circuit_1])
		(has-components $? ?sens2 $?)) ; ?sens2 takes the name of each sensor of the circuit.
	(object (is-a internal-component)
			(name ?int-comp)
			(output $? ?out $?) ; ?out takes the name of the output internal component of the suspect internal component ?int-comp.
			(suspect yes))
	(object (is-a internal-component)
			(name ?int-comp)
			(output $? ?sens1 $?)) ; ?sens1 takes the name of the output sensor of the internal component ?int-comp.
	(object (is-a sensor)
			(name ?sens1)
			(suspect yes)) ; continue if the sensor ?sens1 is suspect.
	(object (is-a internal-component)
			(name ?out)
			(output $? ?sens2 $?)) ; ?sens2 takes the name of the output sensor of the output internal component ?out of the internal component ?int-comp.
	(object (is-a sensor)
			(name ?sens2)
			(suspect no)) ; continue if the sensor ?sens2 is not suspect.
  =>
	(modify-instance ?int-comp (suspect no)) ; exonerate the internal component ?int-comp whose output sensor ?sens1 is suspect and whose output sensor ?sens2 that corresponds to its output internal component ?out is not suspect.
)

; Rule that prints the applicable message if all suspects were exonerated and changes the goal to retracting the facts.
(defrule print-no-suspect
	?x <- (goal exonerate-components) ; continue if the goal is to exonerate components, because of using the strategy mea, this is executed once all the suspect components that can be exonerated have been exonerated.
	(clock ?clk) ; ?clk takes the clock of the current cycle.
	(not (and (object (is-a circuit)
				(name [circuit_1])
				(has-components $? ?comp $?)) ; ?comp takes the name of each component of the circuit.
			(object (is-a component)
				(name ?comp)
				(suspect yes)))) ; continue if there is no component of the circuit that is suspect.
  =>
	(printout t "Time: " ?clk " ----> Normal Operation!" crlf) ; print the message that normal application occured in the current cycle.
	(retract ?x) ; retract the previous goal fact.
	(assert (goal retract-facts)) ; assert the new retract facts goal fact.
)

; Rule that changes the goal from exonerating components to printing the suspect. Because of using the strategy mea, this
; is executed once all the components that can be exonerated have been exonerated.
(defrule change-goal-to-print-suspect
	?x <- (goal exonerate-components) => (retract ?x) (assert (goal print-suspect))
)

; Rule that checks if the suspect is a sensor and if it is, prints the applicable error message, exonerates the suspect sensor and changes the goal to retracting the facts.
(defrule print-suspect-sensor
	?x <- (goal print-suspect) ; continue if the goal is to print the suspect.
	(clock ?clk) ; ?clk takes the clock of the current cycle.
	(object (is-a circuit)
			(name [circuit_1])
			(has-components $? ?sens $?)) ; ?sens takes the name of each sensor of the circuit.
	(object (is-a sensor)
			(name ?sens)
			(suspect yes)) ; continue if the sensor ?sens is suspect.
  =>
	(printout t "Time: " ?clk " --> sensor " (instance-name-to-symbol ?sens) " error: Short circuit!" crlf) ; print the message that a sensor error occured in the current cycle.
	(modify-instance ?sens (suspect no)) ; exonerate the suspect sensor ?sens.
	(retract ?x) ; retract the previous goal fact.
  	(assert (goal retract-facts)) ; assert the new retract facts goal fact.
)

; Rule that checks if the suspect is an internal component and if it is, prints the applicable error message based on the error type, exonerates the suspect internal component and changes the goal to retracting the facts.
(defrule print-suspect-internal-component
	?x <- (goal print-suspect) ; continue if the goal is to print the suspect.
	(clock ?clk) ; ?clk takes the clock of the current cycle.
	(object (is-a circuit)
			(name [circuit_1])
			(has-components $? ?int-comp $?)) ; ?int-comp takes the name of each internal component of the circuit.
	(object (is-a circuit)
			(name [circuit_1])
			(has-components $? ?sens $?)) ; ?sens takes the name of each sensor of the circuit.
	(object (is-a internal-component)
			(name ?int-comp)
			(suspect yes)) ; continue if the internal component ?int-comp is the suspect.
	(object (is-a sensor)
			(name ?sens)
			(input ?int-comp)) ; continue if the sensor ?sens takes the internal component ?int-comp as its input.
  =>
 	(if (= (send ?int-comp get-msb-out) (send ?sens get-reading)) ; if the msb cutout output of the internal component ?int-comp is equal to the sensor's ?sens real reading, it means the suspect internal component had a msb cutout error.
		then (printout t "Time: " ?clk " --> " (class ?int-comp) " " (instance-name-to-symbol ?int-comp) " error: Most Significant Bit is off!" crlf)) ; print the message that an internal component msb cutout error occured in the current cycle.
	(if (= (send ?int-comp get-short-out) (send ?sens get-reading)) ; if the short out output of the internal component ?int-comp is equal to the sensor's ?sens real reading, it means the suspect internal component had a short circuit error.
		then (printout t "Time: " ?clk " --> " (class ?int-comp) " " (instance-name-to-symbol ?int-comp) " error: Short-circuit!" crlf)) ; print the message that an internal component short circuit error occured in the current cycle.
	(modify-instance ?int-comp (suspect no)) ; exonerate the suspect internal component ?int-comp.
	(retract ?x) ; retract the previous goal fact.
  	(assert (goal retract-facts)) ; assert the new retract facts goal fact.
)

; Rule that retracts all the calculated output facts one at a time if the goal is to retract the facts.
(defrule retract-calculated-output
	(goal retract-facts) ?x <- (calculated ?) => (retract ?x)
)

; Rule that retracts all the discrepancy facts one at a time if the goal is to retract the facts.
(defrule retract-discrepancy
	(goal retract-facts) ?x <- (discrepancy ?) => (retract ?x)
)

; Rule that changes the goal from retracting the facts to starting the next cycle. Because of using the strategy mea, this
; is executed once all the calculated output and discrepancy facts have been retracted.
(defrule change-goal-to-start-next-cycle
	?x <- (goal retract-facts) ; continue if the goal is to retract the facts.
	?y <- (clock ?clk) ; ?clk takes the clock of the current cycle.
	(max-clock ?max-clk) ; ?max-clk takes the max clock.
	(test (< ?clk ?max-clk)) ; continue if the clock of the current cycle is less than the max clock.
  =>
  	(retract ?x) ; retract the previous goal fact.
	(retract ?y) ; retract the previous clock fact.
	(assert (clock (+ ?clk 1))) ; assert the clock of the current cycle fact which is the same as the clock of the previous cycle incremented by one.
  	(assert (goal start-next-cycle)) ; assert the new start next cycle goal fact.
)

; Rule that retracts all the facts and halts the program once the clock reaches its max value.
(defrule exit-program
	(goal retract-facts) ; continue if the goal is to retract the facts.
	(clock ?clk) ; ?clk takes the clock of the current cycle.
	(max-clock ?max-clk) ; ?max-clk takes the max clock.
	(test (= ?clk ?max-clk)) ; continue if the clock of the current cycle is equal to the max clock.
  =>
  	(retract *) ; retract all facts.
	(halt) ; halt the program.
)