import React, { useState, useEffect, type JSX } from 'react';
import { Box, Stack, Typography, Divider, Paper, Link as MUILink } from '@mui/material';
import { useNavigate } from 'react-router-dom';

interface JudgmentViewerProps {
  xmlString: string;
}

export default function JudgmentViewer({ xmlString }: JudgmentViewerProps) {
  const navigate = useNavigate();
  const [xmlDoc, setXmlDoc] = useState<Document | null>(null);

  useEffect(() => {
    const parser = new DOMParser();
    const doc = parser.parseFromString(xmlString, 'application/xml');
    setXmlDoc(doc);
  }, [xmlString]);

  const handleRefClick = (href: string, e: React.MouseEvent) => {
    e.preventDefault();
    navigate(`/laws/${href.replace('/', '')}`);
  };

  const renderNode = (node: Node): JSX.Element | string | null => {
    if (node.nodeType === Node.TEXT_NODE) {
      return node.textContent || '';
    }

    if (node.nodeType !== Node.ELEMENT_NODE) {
      return null;
    }

    const elem = node as Element;
    const children = Array.from(elem.childNodes).map(renderNode).filter(Boolean);
    const parentTag = elem.parentElement?.tagName || '';

    switch (elem.tagName) {
      case 'judgmentBody':
        return (
          <Stack spacing={2} sx={{ textAlign: 'left', padding: 2 }}>
            {children}
          </Stack>
        );
      case 'p':
        const boldElem = elem.querySelector('b');
        const hasBold = !!boldElem;
        const isDirectInBody = parentTag === 'judgmentBody';
        return (
          <Typography
            variant={isDirectInBody && hasBold ? 'h4' : 'body1'}
            sx={{
              textTransform: hasBold && isDirectInBody ? 'uppercase' : 'none',
              textAlign: (isDirectInBody && hasBold) ? 'center' : 'left',
              mb: (isDirectInBody && hasBold) ? 3 : 1,
              color: '#4a5568',
              lineHeight: 1.6,
            }}
          >
            {children}
          </Typography>
        );
      case 'b':
        return (
          <Box sx={{ textAlign: 'center', my: 2 }}>
            <Typography component="span" sx={{ fontWeight: 'bold', color: '#2d3748' }}>
              {children}
            </Typography>
          </Box>
        );
      case 'br':
        return <br />;
      case 'ref':
        const href = elem.getAttribute('href') || '';
        return (
          <MUILink
            href={href}
            onClick={(e) => handleRefClick(href, e)}
            sx={{ color: '#3182ce', textDecoration: 'underline', cursor: 'pointer' }}
          >
            {children}
          </MUILink>
        );
      case 'party':
      case 'organization':
        return (
          <Typography component="span" sx={{ fontWeight: 'bold', color: '#2d3748' }}>
            {children}
          </Typography>
        );
      case 'date':
        return (
          <Typography component="span" sx={{ fontStyle: 'italic', color: '#718096' }}>
            {children}
          </Typography>
        );
      case 'amount':
        return (
          <Typography component="span" sx={{ fontWeight: 'bold', color: '#2d3748' }}>
            {children}
          </Typography>
        );
      case 'time':
        return (
          <Typography component="span" sx={{ color: '#718096', fontStyle: 'italic' }}>
            {children}
          </Typography>
        );
      case 'list':
      case 'item':
        return <>{children}</>;
      default:
        return <>{children}</>;
    }
  };

  if (!xmlDoc) {
    return <Typography>Loading...</Typography>;
  }

  const judgment = xmlDoc.querySelector('judgment');
  const meta = judgment?.querySelector('meta');
  const judgmentBody = judgment?.querySelector('judgmentBody');
  const frbrWork = meta?.querySelector('FRBRWork');

  const courtName = frbrWork?.querySelector('FRBRauthor')?.textContent || 'Unknown Court';
  const caseNumber = frbrWork?.querySelector('FRBRtitle')?.textContent || 'Unknown Case';
  const judgmentDate = frbrWork?.querySelector('FRBRdate')?.getAttribute('date') || 'Unknown Date';

  const bodyContent = judgmentBody ? Array.from(judgmentBody.childNodes).map(renderNode).filter(Boolean) : [];

  return (
    <Paper
      elevation={4}
      sx={{
        maxWidth: '1500px',
        marginTop: '20px',
        marginBottom: '20px',
        mx: 'auto',
        p: { xs: 2, md: 4 },
        backgroundColor: '#ffffff',
        borderRadius: 1,
        boxShadow: '0 4px 12px rgba(0, 0, 0, 0.1)',
        border: '1px solid #e2e8f0',
      }}
    >
      <Stack spacing={3}>
        <Typography
          variant="h3"
          align="center"
          sx={{
            fontWeight: 'bold',
            color: '#2d3748',
            textTransform: 'uppercase',
            mb: 2,
            fontSize: { xs: '1.5rem', md: '2rem' },
            letterSpacing: 1,
          }}
        >
          {courtName}
        </Typography>
        <Typography
          variant="h6"
          align="center"
          sx={{
            color: '#718096',
            mb: 3,
            fontSize: { xs: '0.9rem', md: '1rem' },
          }}
        >
          Case No. {caseNumber} | Date: {judgmentDate}
        </Typography>
        <Divider sx={{ borderColor: '#e2e8f0', mb: 3 }} />

        {bodyContent}
      </Stack>
    </Paper>
  );
}