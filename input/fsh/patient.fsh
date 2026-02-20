// This is a simple example of a FSH file.
// This file can be renamed, and additional FSH files can be added.
// SUSHI will look for definitions in any file using the .fsh ending.
Profile: MyPatient
Parent: Patient
Description: "An example profile of the Patient resource."
* name 1..* MS
* obeys PatientResolve

Invariant: PatientResolve
Description: "Validation logic for the patient value element."
Severity: #error
Expression: "Patient.link.other.exists() implies Patient.link.other.resolve()"

Instance: PatientExample
InstanceOf: MyPatient
Description: "An example of a patient with a license to krill."
* name
  * given[0] = "James"
  * family = "Pond"
* telecom[0].extension.url = "http://hl7.org/fhir/StructureDefinition/elementSource"
* telecom[=].extension.valueUri = "http://some.local.system"
* telecom[=].system = #email
* telecom[=].value = "example@testfactory.xyz"


Profile: SomeGroup
Parent: Group


Extension: SomeGroupExtension
Context: SomeGroup
* ^status = #active
* ^experimental = false
* value[x] only Reference(MyPatient)

Extension: SomeExtension
Context: SomeGroupExtension
* ^status = #active
* ^experimental = false
* value[x] only string

Profile: ExampleSchedule
Parent: Schedule
Title: "Example Schedule"
Description: "Example base profile for Schedules."

* extension contains http://hl7.org/fhir/5.0/StructureDefinition/extension-Schedule.name named name 0..1

Instance: exampleSchedule
InstanceOf: ExampleSchedule
Usage: #example
* identifier.use = #usual
* identifier.system = "http://example.org/scheduleid"
* identifier.value = "45"
* active = true
* serviceCategory = #17 "General Practice"
* serviceType = #57 "Immunization"
* specialty = #408480009 "Clinical immunology"
* actor = Reference(Location/138803) "Burgers UMC, South Wing, second floor"
* planningHorizon.start = "2013-12-25T09:15:00Z"
* planningHorizon.end = "2013-12-25T09:30:00Z"
* comment = "The slots attached to this schedule should be specialized to cover immunizations within the clinic"
* extension.url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-Schedule.name"
* extension.valueString = "Example Name"

Profile: ExampleObservationDefinition
Title: "Example Observation Definition"
Parent: ObservationDefinition
Description: "Core Observation Definition for Observation Templates in the Example"
* code 1..
* permittedDataType 0..1
* extension contains
    http://hl7.org/fhir/5.0/StructureDefinition/extension-ObservationDefinition.title named title 0..1
//     and
//     http://hl7.org/fhir/5.0/StructureDefinition/extension-ObservationDefinition.component named component 0..
* modifierExtension contains
    http://hl7.org/fhir/5.0/StructureDefinition/extension-ObservationDefinition.status named status 0..1 ?!
* modifierExtension[http://hl7.org/fhir/5.0/StructureDefinition/extension-ObservationDefinition.status] ^isModifierReason = "Status change is modifying the meaning"

Profile: SampleBinary
Parent: Binary
Id: sample-binary
Title: "Sample Binary"
Description: "This profile is intended to be used to represent the Binary."
* ^status = #active
* ^experimental = false
* securityContext 1..1


Instance: KaenelEmergencyNormalAccess
InstanceOf: PpqmConsentTemplate202
Usage: #example
Title: "Consent policy (202) for Kaenel"
* meta.profile = "http://fhir.ch/ig/ch-epr-fhir/StructureDefinition/PpqmConsentTemplate202"
* identifier[policySetId].type = http://fhir.ch/ig/ch-epr-fhir/CodeSystem/PpqmConsentIdentifierType#policySetId
* identifier[policySetId].value = "urn:uuid:c8e1bca5-6f30-4824-8241-ef1e7a59309d"
* identifier[templateId].type   = http://fhir.ch/ig/ch-epr-fhir/CodeSystem/PpqmConsentIdentifierType#templateId
* identifier[templateId].value  = "202"
* status = #active
* scope  = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* category = http://terminology.hl7.org/CodeSystem/v3-ActCode#INFA
* patient.identifier.system = "urn:oid:2.16.756.5.30.1.127.3.10.3"
* patient.identifier.value  = "761337614042587767"
* patient = Reference(PatientExample) //removed until https://github.com/ehealthsuisse/ch-epr-fhir/issues/251 is sorted out
* policyRule = urn:ietf:rfc:3986#urn:e-health-suisse:2015:policies:access-level:normal
* provision.actor.role = urn:oid:2.16.756.5.30.1.127.3.10.6#HCP
* provision.actor.reference.display = "all"
* provision.purpose = urn:oid:2.16.756.5.30.1.127.3.10.5#EMER
