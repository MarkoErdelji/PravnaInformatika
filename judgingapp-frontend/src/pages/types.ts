export interface Verdict {
  id: string | undefined;
  caseId: string;
  court: string;
  verdictNumber: string;
  date: string | null;
  judgeName: string;
  prosecutor: string;
  defendantName: string;
  criminalOffense: string;
  appliedProvisions: string;
  verdict: string | null; // Matches VerdictType enum (PRISON, SUSPENDED, ACQUITTED, DETENTION)
  numDefendants: number;
  previouslyConvicted: boolean;
  awareOfIllegality: boolean;
  victimRelationship: string | null; // Matches VictimRelationship enum (SPOUSE, PARENT, SIBLING, CHILD, OTHER)
  violenceNature: string | null; // Matches ViolenceNature enum (VIOLENCE, THREAT, RECKLESS_BEHAVIOUR, NONE)
  injuryTypes: string | null; // Matches InjuryTypes enum (LIGHT, SEVERE, LIGHT_SEVERE, NONE)
  executionMeans: string | null; // Matches ExecutionMeans enum (HANDS, FEET, WEAPON, TOOL, VERBAL, OTHER)
  protectionMeasureViolation: boolean;
  eventLocation: string;
  eventDate: string | null;
  defendantStatus: string;
  victims: string;
  defendantAge: number | null;
  victimAge: number | null;
  previousIncidents: boolean;
  alcoholOrDrugs: boolean;
  childrenPresent: boolean;
  penalty: string;
  procedureCosts: string;
  useOfWeapon: boolean;
  numberOfVictims: number;
}

export interface CaseDescription {
  caseId: string;
  dbId: string;
  criminalOffense: string;
  verdict: string | null; // Matches VerdictType enum
  numDefendants: number;
  previouslyConvicted: boolean;
  awareOfIllegality: boolean;
  victimRelationship: string | null; // Matches VictimRelationship enum
  violenceNature: string | null; // Matches ViolenceNature enum
  injuryTypes: string | null; // Matches InjuryTypes enum
  executionMeans: string | null; // Matches ExecutionMeans enum
  protectionMeasureViolation: boolean;
  defendantAge: number | null;
  victimAge: number | null;
  previousIncidents: boolean;
  alcoholOrDrugs: boolean;
  childrenPresent: boolean;
  useOfWeapon: boolean;
  numberOfVictims: number;
}

export interface SimilarVerdict {
  caseDescription: CaseDescription;
  similarity: number;
}

export interface ReasonResponse {
  predictedVerdict: string;
  similarCases: SimilarVerdict[];
  caseDescription: CaseDescription;
}