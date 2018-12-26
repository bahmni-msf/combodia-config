SELECT 
patient_identifier.identifier AS ID, 
concat(person_name.given_name,' ',person_name.family_name) AS Name, 
person_attribute.value AS PhoneNumber,appointment_service.name AS ServiceType, 
DATE(patient_appointment.start_date_time) AS DateOfAppointment,
(case when pat.patient_appointment_id < patient_appointment.patient_appointment_id  then case when pat.patient_appointment_id < patient_appointment.patient_appointment_id
then pat.status else null end else null end) as "PreviousAppointmentStatus",
(case when pat.patient_appointment_id < patient_appointment.patient_appointment_id  then case when pat.patient_appointment_id < patient_appointment.patient_appointment_id
then date(pat.start_date_time) else null end else null end) as "PreviousAppointmentDate"
FROM patient_appointment
join patient_appointment pat on pat.patient_id=patient_appointment.patient_id
JOIN
patient_identifier ON
patient_identifier.patient_id=patient_appointment.patient_id
JOIN
person_name ON
person_name.person_id=patient_appointment.patient_id
JOIN
appointment_service ON
appointment_service.appointment_service_id=patient_appointment.appointment_service_id
JOIN
person_attribute ON
person_attribute.person_id=patient_appointment.patient_id
WHERE DATE(patient_appointment.start_date_time) BETWEEN DATE('#startDate#') AND DATE('#endDate#')
AND patient_appointment.status='Scheduled'
AND person_attribute.person_attribute_type_id in (select person_attribute_type_id from person_attribute_type where name ='Patient phone number 1')
AND appointment_service.appointment_service_id=patient_appointment.appointment_service_id
group by ID

