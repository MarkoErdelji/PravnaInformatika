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
  verdict: string;
  numDefendants: number | null;
  previouslyConvicted: boolean;
  awareOfIllegality: boolean;
  victimRelationship: string;
  violenceNature: string;
  injuryTypes: string;
  executionMeans: string;
  protectionMeasureViolation: boolean;
  eventLocation: string;
  eventDate: string | null;
  defendantStatus: string;
  victims: string;
  defendantAge: number | null;
  victimAge: number | null;
  previousIncidents: string;
  alcoholOrDrugs: boolean;
  childrenPresent: boolean;
  penalty: string;
  procedureCosts: string;
  useOfWeapon: boolean;
  numberOfVictims: number | null;
}

export interface CaseDescription {
  dbId: string;
  caseName: string;
  court: string;
  verdictNumber: string;
  date: string | null;
  judgeName: string;
  prosecutor: string;
  defendantName: string;
  criminalOffense: string;
  appliedProvisions: string;
  verdict: string;
  numDefendants: number | null;
  previouslyConvicted: boolean;
  awareOfIllegality: boolean;
  victimRelationship: string;
  violenceNature: string;
  injuryTypes: string;
  executionMeans: string;
  protectionMeasureViolation: boolean;
  eventLocation: string;
  eventDate: string | null;
  defendantStatus: string;
  victims: string;
  defendantAge: number | null;
  victimAge: number | null;
  previousIncidents: string;
  alcoholOrDrugs: boolean;
  childrenPresent: boolean;
  penalty: string;
  procedureCosts: string;
  useOfWeapon: boolean;
  numberOfVictims: number | null;
  idAttribute?: { name: string; declaringClass: string; type: string };
}

export interface SimilarVerdict {
  caseDescription: CaseDescription;
  similarity: number;
}

export interface ReasonResponse {
  predictedVerdict: string;
  similarCases: SimilarVerdict[];
  caseDescription?: Verdict;
}