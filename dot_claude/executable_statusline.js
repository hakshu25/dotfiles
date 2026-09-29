#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const { execSync, spawnSync } = require('child_process');
const os = require('os');

const WEATHER_CACHE_FILE = path.join(os.tmpdir(), 'claude_statusline_weather.json');
const WEATHER_CACHE_TTL = 10 * 60 * 1000;

function getWeather() {
  try {
    if (fs.existsSync(WEATHER_CACHE_FILE)) {
      const cache = JSON.parse(fs.readFileSync(WEATHER_CACHE_FILE, 'utf8'));
      if (Date.now() - cache.timestamp < WEATHER_CACHE_TTL) return cache.weather;
    }
  } catch (e) {}

  let weather = '';
  try {
    const r = spawnSync('curl', ['-s', '--max-time', '3', 'wttr.in/?format=%c%t'], { encoding: 'utf8' });
    if (r.status === 0 && r.stdout && r.stdout.trim()) weather = r.stdout.trim();
  } catch (e) {}

  if (!weather) {
    try {
      const r = spawnSync('curl', ['-s', '--max-time', '3', 'wttr.in/Tokyo?format=%c%t'], { encoding: 'utf8' });
      if (r.status === 0 && r.stdout && r.stdout.trim()) weather = r.stdout.trim();
    } catch (e) {}
  }

  try {
    if (weather) fs.writeFileSync(WEATHER_CACHE_FILE, JSON.stringify({ timestamp: Date.now(), weather }));
  } catch (e) {}

  return weather;
}

function formatTime() {
  const now = new Date();
  let h = now.getHours();
  const m = String(now.getMinutes()).padStart(2, '0');
  const ampm = h >= 12 ? 'PM' : 'AM';
  h = h % 12 || 12;
  return `${String(h).padStart(2, '0')}:${m}${ampm}`;
}

function makeBar(pct, width, color) {
  const RESET = '\x1b[0m';
  const filled = Math.min(width, Math.round((pct / 100) * width));
  return `${color}${'█'.repeat(filled)}${'░'.repeat(width - filled)}${RESET}`;
}

let input = '';
process.stdin.on('data', chunk => input += chunk);
process.stdin.on('end', () => {
  try {
    const data = JSON.parse(input);

    const GREEN  = '\x1b[32m';
    const YELLOW = '\x1b[33m';
    const RED    = '\x1b[31m';
    const CYAN   = '\x1b[36m';
    const RESET  = '\x1b[0m';
    const BAR_WIDTH = 6;

    // 1. CWD
    const home = process.env.HOME || '';
    const cwd = data.workspace?.current_dir || data.cwd || '.';
    const cwdDisplay = cwd.startsWith(home) ? '~' + cwd.slice(home.length) : cwd;

    // 2. Git branch + status
    let gitInfo = '';
    try {
      const branch = execSync('git --no-optional-locks branch --show-current 2>/dev/null', {
        cwd, encoding: 'utf-8'
      }).trim();
      if (branch) {
        let dirty = '';
        try {
          const s = execSync('git --no-optional-locks status --porcelain 2>/dev/null', {
            cwd, encoding: 'utf-8'
          }).trim();
          if (s) dirty = '*';
        } catch (e) {}
        gitInfo = ` [${GREEN}${branch}${dirty}${RESET}]`;
      }
    } catch (e) {}

    // 3. Model name
    const model = data.model?.display_name || data.model?.id || '';

    // 4. Extended thinking indicator
    const isThinking = !!(data.thinking?.enabled);
    const thinkingStr = isThinking ? ` [thinking]` : '';

    // 5. Rate limit progress bars
    let bars = '';

    const ctxPct = data.context_window?.used_percentage;
    if (ctxPct !== undefined) {
      const ctxVal = ctxPct ?? 0;
      bars += ` CTX[${makeBar(ctxVal, BAR_WIDTH, GREEN)}]${ctxVal}%`;
    }

    const h5Pct = data.rate_limits?.five_hour?.used_percentage;
    if (h5Pct !== undefined) {
      const h5Val = h5Pct ?? 0;
      bars += ` 5h[${makeBar(h5Val, BAR_WIDTH, YELLOW)}]${h5Val}%`;
    }

    const d7Pct = data.rate_limits?.seven_day?.used_percentage;
    if (d7Pct !== undefined) {
      const d7Val = d7Pct ?? 0;
      bars += ` 7d[${makeBar(d7Val, BAR_WIDTH, RED)}]${d7Val}%`;
    }

    // 6. Weather (cached, 10 min TTL, fallback to Tokyo)
    const weather = getWeather();

    // 7. Time (%I:%M%p format)
    const time = formatTime();

    // Compose status line
    const line = [
      `${CYAN}${cwdDisplay}${RESET}`,
      gitInfo,
      model ? ` ${model}` : '',
      thinkingStr,
      bars,
      weather ? ` ${weather}` : '',
      ` ${time}`
    ].join('');

    console.log(line);
  } catch (e) {
    console.log('[Claude Code]');
  }
});
