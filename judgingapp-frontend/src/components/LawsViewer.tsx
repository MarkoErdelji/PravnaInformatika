import React, { useState, useEffect, type JSX } from 'react';
import { useParams, useNavigate, useLocation } from 'react-router-dom';
import { Box, Stack, Typography, Divider, Paper, Link as MUILink } from '@mui/material';
import axios from 'axios';

export default function LawsViewer() {
  const { lawType } = useParams<{ lawType: 'zkp' | 'krivicni' }>();
  const navigate = useNavigate();
  const location = useLocation();
  const [xmlDoc, setXmlDoc] = useState<Document | null>(null);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchLawXml = async () => {
      try {
        const endpoint = lawType === 'zkp' ? '/api/laws/zkp' : '/api/laws/krivicni';
        const response = await axios.get(endpoint, {
          headers: { Accept: 'application/xml' },
        });
        const parser = new DOMParser();
        const doc = parser.parseFromString(response.data, 'application/xml');
        setXmlDoc(doc);
        setError(null);
      } catch (err) {
        setError('Error loading law XML');
        console.error(err);
      }
    };

    if (lawType === 'zkp' || lawType === 'krivicni') {
      fetchLawXml();
    } else {
      setError('Invalid law type');
    }
  }, [lawType]);

  useEffect(() => {
    if (xmlDoc && location.hash) {
      const eId = location.hash.replace('#', '');
      const element = document.getElementById(eId);
      if (element) {
        element.scrollIntoView({ behavior: 'smooth', block: 'center' });
        element.style.backgroundColor = '#e6f3fa';
        setTimeout(() => {
          element.style.backgroundColor = '';
        }, 2000);
      }
    }
  }, [xmlDoc, location.hash]);

  const handleRefClick = (href: string, e: React.MouseEvent) => {
    e.preventDefault();
    const [path, eId] = href.split('#');
    const currentLaw = lawType === 'zkp' ? '/zkp' : '/krivicni';

    if (eId && path === currentLaw) {
      const element = document.getElementById(eId);
      if (element) {
        element.scrollIntoView({ behavior: 'smooth', block: 'center' });
        element.style.backgroundColor = '#e6f3fa';
        setTimeout(() => {
          element.style.backgroundColor = '';
        }, 2000);
      }
    } else {
      navigate(`/laws${href}`);
    }
  };

  const renderNode = (node: Node, level: number = 0): JSX.Element | string | null => {
    if (node.nodeType === Node.TEXT_NODE) {
      return node.textContent?.trim() || '';
    }

    if (node.nodeType !== Node.ELEMENT_NODE) {
      return null;
    }

    const elem = node as Element;
    const children = Array.from(elem.childNodes)
      .map((child) => renderNode(child, level + 1))
      .filter(Boolean);

    switch (elem.tagName.toLowerCase()) {
      case 'body':
        return (
          <Stack spacing={2} sx={{ textAlign: 'left', padding: 2 }}>
            {children}
          </Stack>
        );
      case 'chapter':
        return (
          <Box sx={{ mb: 4 }}>
            {children}
          </Box>
        );
      case 'num':
        if (elem.parentElement?.tagName.toLowerCase() === 'chapter') {
          return (
            <Typography
              variant="h4"
              sx={{
                fontWeight: 'bold',
                color: '#2d3748',
                textTransform: 'uppercase',
                mb: 2,
                mt: 4,
              }}
            >
              {children}
            </Typography>
          );
        }
        return (
          <Typography
            component="span"
            sx={{ fontWeight: 'bold', color: '#2d3748', mr: 1 }}
          >
            {children}
          </Typography>
        );
      case 'article':
        const articleEId = elem.getAttribute('eId') || '';
        return (
          <Box id={articleEId} sx={{ mb: 3, pl: level * 2 }}>
            {children}
          </Box>
        );
      case 'heading':
        return (
          <Typography
            variant="h5"
            sx={{
              fontWeight: 'bold',
              color: '#2d3748',
              mb: 1,
              textAlign: 'left',
            }}
          >
            {children}
          </Typography>
        );
      case 'paragraph':
        const paraEId = elem.getAttribute('eId') || '';
        return (
          <Box id={paraEId} sx={{ mb: 2, pl: level * 2 }}>
            {children}
          </Box>
        );
      case 'content':
        return <>{children}</>;
      case 'p':
        return (
          <Typography
            variant="body1"
            sx={{
              color: '#4a5568',
              lineHeight: 1.6,
              mb: 1,
            }}
          >
            {children}
          </Typography>
        );
      case 'list':
        return (
          <Box component="ul" sx={{ pl: 4, listStyleType: 'decimal' }}>
            {children}
          </Box>
        );
      case 'item':
        const itemEId = elem.getAttribute('eId') || '';
        return (
          <Box id={itemEId} component="li" sx={{ mb: 1 }}>
            {children}
          </Box>
        );
      case 'ref':
        const href = elem.getAttribute('href') || '';
        return (
          <MUILink
            href={href}
            onClick={(e) => handleRefClick(href, e)}
            sx={{
              color: '#3182ce',
              textDecoration: 'underline',
              cursor: 'pointer',
              mx: 0.5, // spacing around ref
            }}
          >
            {children}
          </MUILink>
        );
      default:
        return <>{children}</>;
    }
  };

  if (error) {
    return (
      <Paper
        elevation={4}
        sx={{
          maxWidth: '1500px',
          margin: '20px auto',
          p: { xs: 2, md: 4 },
          backgroundColor: '#ffffff',
          borderRadius: 1,
          boxShadow: '0 4px 12px rgba(0, 0, 0, 0.1)',
          border: '1px solid #e2e8f0',
        }}
      >
        <Typography color="error">{error}</Typography>
      </Paper>
    );
  }

  if (!xmlDoc) {
    return (
      <Paper
        elevation={4}
        sx={{
          maxWidth: '1500px',
          margin: '20px auto',
          p: { xs: 2, md: 4 },
          backgroundColor: '#ffffff',
          borderRadius: 1,
          boxShadow: '0 4px 12px rgba(0, 0, 0, 0.1)',
          border: '1px solid #e2e8f0',
        }}
      >
        <Typography>Loading...</Typography>
      </Paper>
    );
  }

  const act = xmlDoc.querySelector('act');
  const body = act?.querySelector('body');
  const title = lawType === 'zkp' ? 'Zakonik o krivičnom postupku' : 'Krivični zakonik';

  const bodyContent = body
    ? Array.from(body.childNodes)
        .map((node) => renderNode(node, 0))
        .filter(Boolean)
    : [];

  return (
    <Paper
      elevation={4}
      sx={{
        maxWidth: '1500px',
        margin: '20px auto',
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
          {title}
        </Typography>
        <Divider sx={{ borderColor: '#e2e8f0', mb: 3 }} />
        {bodyContent}
      </Stack>
    </Paper>
  );
}
