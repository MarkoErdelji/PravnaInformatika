import React, { useState } from 'react';
import { Box, Stack, Typography, Divider, Paper, Tooltip, Link } from '@mui/material';
import { useNavigate } from 'react-router-dom';

interface JudgmentViewerProps {
  xmlString: string;
}

export default function JudgmentViewer({ xmlString }: JudgmentViewerProps) {
  const navigate = useNavigate();
  const parser = new DOMParser();
  const xmlDoc = parser.parseFromString(xmlString, 'application/xml');

  const [expandedSections, setExpandedSections] = useState<{ [key: string]: boolean }>({});

  const toggleSection = (key: string) => {
    setExpandedSections(prev => ({ ...prev, [key]: !prev[key] }));
  };

  const handleRefClick = (href: string) => {
    navigate(`/laws/${href.replace('/', '')}`);
  };

  const renderText = (html: string) => {
    // Convert <ref> into clickable links
    html = html.replace(/<ref href="([^"]+)">([^<]+)<\/ref>/g, (_m, href, text) => {
      return `<span class="akn-ref" data-href="${href}">${text}</span>`;
    });
    // Bold parties and organizations
    html = html.replace(/<party[^>]*>([^<]+)<\/party>/g, (_m, text) => `<strong>${text}</strong>`);
    html = html.replace(/<organization[^>]*>([^<]+)<\/organization>/g, (_m, text) => `<strong>${text}</strong>`);
    // Italicize dates
    html = html.replace(/<date date="([^"]+)">([^<]+)<\/date>/g, (_m, _date, text) => `<em>${text}</em>`);
    // Bold amounts
    html = html.replace(/<amount[^>]*value="([^"]+)">([^<]+)<\/amount>/g, (_m, _val, text) => `<strong>${text}</strong>`);
    return html;
  };

  const handleClick = (e: React.MouseEvent<HTMLDivElement>) => {
    const target = e.target as HTMLElement;
    if (target.classList.contains('akn-ref') && target.dataset.href) {
      handleRefClick(target.dataset.href);
    }
  };

  // Extract paragraphs and list items
  const paragraphs = Array.from(xmlDoc.getElementsByTagName('p'));
  const listItems = Array.from(xmlDoc.getElementsByTagName('item'));

  // Helper to render sections with optional heading
  const renderSection = (title: string | null, content: JSX.Element | JSX.Element[]) => {
    return (
      <Box mb={3}>
        {title && (
          <Typography variant="h6" fontWeight="bold" mb={1}>
            {title}
          </Typography>
        )}
        {content}
      </Box>
    );
  };

  return (
    <Box onClick={handleClick} sx={{ lineHeight: 1.7 }}>
      <Stack spacing={2}>
        {/* Main Title */}
        <Typography variant="h4" fontWeight="bold" mb={2}>
          Judgment
        </Typography>
        <Divider sx={{ mb: 2 }} />

        {/* Metadata / Introduction */}
        {renderSection(null, paragraphs
          .filter(p => p.innerHTML.includes('OSNOVNI SUD') || p.innerHTML.includes('po optužnom predlogu'))
          .map((p, i) => (
            <Typography key={i} paragraph dangerouslySetInnerHTML={{ __html: renderText(p.innerHTML) }} />
          ))
        )}

        {/* Presuda / Verdict Heading */}
        {renderSection(null, paragraphs
          .filter(p => p.innerHTML.includes('PRESUDU'))
          .map((p, i) => (
            <Typography key={i} variant="h5" fontWeight="bold" paragraph dangerouslySetInnerHTML={{ __html: renderText(p.innerHTML) }} />
          ))
        )}

        {/* Defendant Info */}
        {renderSection('Defendant Information', paragraphs
          .filter(p => p.innerHTML.includes('Okrivljeni:'))
          .map((p, i) => (
            <Typography key={i} paragraph dangerouslySetInnerHTML={{ __html: renderText(p.innerHTML) }} />
          ))
        )}

        {/* Charges / Facts */}
        {renderSection('Facts & Charges', paragraphs
          .filter(p => !p.innerHTML.includes('OSNOVNI SUD') && !p.innerHTML.includes('PRESUDU') && !p.innerHTML.includes('Okrivljeni:'))
          .map((p, i) => (
            <Typography key={i} paragraph dangerouslySetInnerHTML={{ __html: renderText(p.innerHTML) }} />
          ))
        )}

        {/* Ordered list of decisions */}
        {listItems.length > 0 && renderSection('Court Decision', 
          <Box component="ol" sx={{ pl: 4 }}>
            {listItems.map((item, i) => {
              const p = item.querySelector('p');
              if (!p) return null;
              return (
                <Typography
                  component="li"
                  key={i}
                  paragraph
                  dangerouslySetInnerHTML={{ __html: renderText(p.innerHTML) }}
                />
              );
            })}
          </Box>
        )}
      </Stack>
    </Box>
  );
}
