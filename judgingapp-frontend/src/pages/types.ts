export interface Verdict {
  id?: number;
  caseId: string;
  court: string;
  verdictNumber: string;
  date: string | null;
  judgeName: string;
  clerkName: string;
  prosecutor: string;
  defendantName: string;
  criminalOffense: string;
  appliedProvisions: string;
  verdictType: string | null;
  numDefendants: number;
  awareOfIllegality: boolean;
  mainVictimRelationship: string | null;
  violenceNature: string | null;
  injuryTypes: string | null;
  protectionMeasureViolation: boolean;
  eventLocation: string;
  eventDate: string | null;
  defendantStatus: string;
  victims: string;
  mainVictimAge: number;
  alcoholOrDrugs: boolean;
  childrenPresent: boolean;
  penalty: string;
  procedureCosts: string;
  useOfWeapon: boolean;
  numberOfVictims: number;
  xmlFileName: string;
}

export interface CaseDescription {
  dbId: number;
  caseId: string;
  court: string;
  date: string;
  judge: string;
  clerk: string;
  prosecutor: string;
  defendantName: string;
  criminalOffense: string;
  appliedProvisions: string;
  verdictType: string | null;
  numDefendants: number;
  awareOfIllegality: boolean;
  mainVictimRelationship: string | null;
  violenceNature: string | null;
  injuryTypes: string | null;
  protectionMeasureViolation: boolean;
  eventLocation: string;
  eventDate: string;
  defendantStatus: string;
  victims: string;
  mainVictimAge: number;
  alcoholOrDrugs: boolean;
  childrenPresent: boolean;
  penalty: string;
  procedureCosts: string;
  useOfWeapon: boolean;
  numberOfVictims: number;
  xmlFileName: string;
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