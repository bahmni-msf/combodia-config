SELECT patient_identifier.identifier AS "Patient ID", concat(person_name.given_name,' ',person_name.family_name) AS "Patient Name", person_attribute.value AS "Phone Number",appointment_service.name AS "Service Type",DATE(patient_appointment.start_date_time) AS "Date Of Appointment"
FROM patient_appointment

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
AND patient_appointment.status='Missed'
AND person_attribute.person_attribute_type_id=13
AND appointment_service.appointment_service_id=patient_appointment.appointment_service_id
