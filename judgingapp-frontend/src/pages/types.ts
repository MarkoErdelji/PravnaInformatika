export interface Verdict {
  id?: number;
  caseId: string;
  court: string;
  caseNumber: string;
  judge: string;
  clerk: string;
  prosecutor: string;
  defendantNames: string[];
  victim: string;
  shortDescription: string;
  judgment: string | null;
  appliedProvisions: string;
  accusations: string[];
  verdictDate: string | null;
  isMovableProperty: boolean;
  isTaken: boolean;
  intentToAppropriate: boolean;
  valueOfStolenItems: number;
  isCulturalOrNaturalGood: boolean;
  breakingAndEntering: boolean;
  particularlyDangerousOrBrazen: boolean;
  exploitingHelplessness: boolean;
  duringDisaster: boolean;
  numberOfPerpetrators: number;
  isArmed: boolean;
  useOfForceOrThreat: boolean;
  caughtInTheAct: boolean;
  intentForSmallGain: boolean;
  causedSevereInjury: boolean;
  deathCaused: boolean;
  attemptedCrime: boolean;
  xmlFileName: string;
}

export interface CaseDescription {
  dbId?: number;
  caseId: string;
  defendantNames: string[];
  victim: string;
  accusationTypes: string[];
  judgment: string | null;
  isMovableProperty: boolean;
  isTaken: boolean;
  intentToAppropriate: boolean;
  valueOfStolenItems: number;
  isCulturalOrNaturalGood: boolean;
  breakingAndEntering: boolean;
  particularlyDangerousOrBrazen: boolean;
  exploitingHelplessness: boolean;
  duringDisaster: boolean;
  isArmed: boolean;
  useOfForceOrThreat: boolean;
  caughtInTheAct: boolean;
  intentForSmallGain: boolean;
  causedSevereInjury: boolean;
  deathCaused: boolean;
  attemptedCrime: boolean;
  numberOfPerpetrators: number;
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