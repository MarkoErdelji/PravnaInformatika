export interface CaseDescription {
  dbId?: number;
  caseId?: string;
  defendantNames: string[];
  accusationTypes: string[];
  judgment: string | null;
  isMovableProperty: boolean;
  isTaken: boolean;
  intentToAppropriate: boolean;
  valueOfStolenItems: number;
  breakingAndEntering: boolean;
  useOfForceOrThreat: boolean;
  caughtInTheAct: boolean;
  causedSevereInjury: boolean;
  deathCaused: boolean;
  monetaryPenalty: number | null;
  prisonPenalty: number | null;
}

export interface SimilarVerdict {
  caseDescription: CaseDescription;
  similarity: number;
}

export interface ReasonResponse {
  predictedVerdict: string;
  similarCases: SimilarVerdict[];
  drDeviceResults: {
    judgment: string;
    accusation: string;
    penalty: string;
  };
  caseDescription: CaseDescription;
}

export interface Verdict {
  id?: number;
  caseId: string;
  court: string;
  caseNumber: string;
  verdictDate: string | null;
  judge: string;
  clerk: string;
  prosecutor: string;
  defendantNames: string[];
  victim: string;
  shortDescription: string;
  judgment: string | null;
  appliedProvisions: string;
  accusations: string[];
  isMovableProperty: boolean;
  isTaken: boolean;
  intentToAppropriate: boolean;
  valueOfStolenItems: number;
  breakingAndEntering: boolean;
  useOfForceOrThreat: boolean;
  caughtInTheAct: boolean;
  causedSevereInjury: boolean;
  deathCaused: boolean;
  monetaryPenalty: number | null;
  prisonPenalty: number | null;
  xmlFileName?: string;
}

export const verdictTranslations: { [key: string]: string } = {
  NONE: 'Nema presude',
  ACQUITTAL: 'Oslobađajuća',
  SUSPENDED: 'Suspendovan',
  FINE: 'Novčana kazna',
  PRISON: 'Zatvor',
  FINE_AND_PRISON: 'Novčana kazna i zatvor',
};

export const accusationTranslations: { [key: string]: string } = {
  ARTICLE_239_ST_1: 'čl. 239 st. 1',
  ARTICLE_239_ST_2: 'čl. 239 st. 2',
  ARTICLE_240_ST_1: 'čl. 240 st. 1',
  ARTICLE_240_ST_2: 'čl. 240 st. 2',
  ARTICLE_240_ST_3: 'čl. 240 st. 3',
  ARTICLE_241_ST_1: 'čl. 241 st. 1',
  ARTICLE_241_ST_2: 'čl. 241 st. 2',
  ARTICLE_241_ST_3: 'čl. 241 st. 3',
  ARTICLE_241_ST_4: 'čl. 241 st. 4',
  ARTICLE_241_ST_5: 'čl. 241 st. 5',
  ARTICLE_241_ST_6: 'čl. 241 st. 6',
  ARTICLE_241_ST_7: 'čl. 241 st. 7',
  OTHER: 'Ostalo'
};