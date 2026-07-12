open CalendarLib
(*
  The shelter has limited capacity and must decide who can be admitted, 
  who must be placed on a waiting list, and who cannot be accepted.

  Each request contains information about the person, the time they arrived, 
  whether they are accompanied by dependants, whether they have an urgent medical need, 
  and whether they require an accessible bed.

  The shelter has:
- a fixed number of ordinary beds;
- a fixed number of accessible beds;
- a maximum total occupancy;
- a closing time after which ordinary requests are not accepted.
*)

type shelter = {
  ordinary_beds: int;
  accessible_beds: int;
  closing_time: Time.t;
}

type shelter_state = {
  ordinary_beds_occupied: int;
  accessible_beds_occupied: int;
  closed: bool;
}

let maximum_occupancy (s:shelter) = 
  s.accessible_beds + s.ordinary_beds
let current_occupancy (s: shelter_state) = 
  s.accessible_beds_occupied + s.ordinary_beds_occupied

let remaining_ordinary_beds (s : shelter) (st : shelter_state) =
  s.ordinary_beds - st.ordinary_beds_occupied

let remaining_accessible_beds (s : shelter) (st : shelter_state) =
  s.accessible_beds - st.accessible_beds_occupied

let remaining_beds (s : shelter) (st : shelter_state) =
  remaining_ordinary_beds s st + remaining_accessible_beds s st

type admission_decision =
  | Admitted
  | WaitingList
  | Declined

type person = {
  id: string;
  name: string;
  age: int;
  medical_need: bool;
  accessible_bed: bool;
  dependants: string list;    (* this should be a list of person ids *)
}  

type request = {
  request_id: string;
  person_id: string;   (* this has the person id *)
  arrived: Time.t;
  dependants: int;   (* number of dependants *)
  medical: bool;    (* if the person or any of the dependants have a medical need then true *)
  accessible: int;  (* count of how many accessible beds are needed for the person and the dependants *)
}  


