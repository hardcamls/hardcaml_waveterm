(** A [Display_rules.t] is an ordered list of rules that specifies the order of ports and
    the formatting of signals in a waveform.

    A port is displayed according to the first rule that it matches, using that rule's
    wave format.  Ports matching rules earlier in the list are displayed above ports
    matching rules later in the list. *)

open! Import

type t = Display_rule.t list [@@deriving sexp_of]

val run_rule : Display_rule.t -> Port.t -> (Wave_format.t * Wave_format.alignment) option

(** Construct the port order and formatting from the display rules and ports (derived from
    a testbench simulation object).  Unmatched ports are not shown, unless [Rule.default]
    (or a similar custom rule) is included as the last display rule. *)
val sort_ports_and_formats
  :  t
  -> Port.t list
  -> (Port.t * (Wave_format.t * Wave_format.alignment) option) list

(** Check if a given port is displayed by any of the rules. *)
val is_displayed : t -> Port.t -> bool

(** Check if a given signal (treated as an internal port) is displayed by any of the rules. *)
val is_signal_displayed : t -> Hardcaml.Signal.t -> bool
