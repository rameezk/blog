---
title: "Extracting, Transcribing, and Summarising Audio from Vimeo"
date: 2026-02-10
draft: false
tags: ["nix"]
author: "Rameez Khan"
showToc: true
TocOpen: false
hidemeta: false
disableShare: false
disableHLJS: false
hideSummary: false
searchHidden: false
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
ShowRssButtonInSectionTermList: true
UseHugoToc: true
series: []
---

In a previous [Nix](https://rameezkhan.me/tags/nix/) [post]({{< ref "2021-05-10--once-off-commands-with-nix" >}})
I mentioned how you can run once-off commands with Nix without polluting your system environment.

First, the why. My community group hosts regular townhall meetings that I often can't attend in person. Fortunately, recordings get posted to Vimeo afterwards. Rather than watching hour-long videos, I wanted a faster way to stay informed - hence this workflow.

In this post, I want to demonstrate how you can extract audio from a Vimeo video, transcribe it to text, and generate a summary - all using `nix run`.

## Prerequisites

- Nix package manager with flakes enabled

## Step 1: Extract Audio from Vimeo

Use `yt-dlp` to download and extract audio from a Vimeo video.

```bash
nix run nixpkgs#yt-dlp -- -x --audio-format mp3 "https://vimeo.com/VIDEO_ID/HASH"
```

**Flags:**
- `-x` or `--extract-audio`: Extract audio only
- `--audio-format mp3`: Convert to MP3 format

**Optional flags:**
- `--extractor-retries 5`: Retry on transient errors (e.g., 502 Bad Gateway)

This will create an MP3 file named after the video title.

## Step 2: Check Audio Duration (Optional)

To verify the audio file and check its runtime, you can use `ffmpeg`.

```bash
nix run nixpkgs#ffmpeg -- -i "your-audio-file.mp3" 2>&1 | grep Duration
```

## Step 3: Transcribe Audio

Use OpenAI's Whisper model. This runs locally, so no API key is required.

```bash
nix run nixpkgs#openai-whisper -- --model tiny --output_format txt "your-audio-file.mp3"
```

**Model options (speed vs accuracy trade-off):**
- `tiny` - Fastest, least accurate (~1GB)
- `base` - Good balance (~1GB)
- `small` - Better accuracy (~2GB)
- `medium` - High accuracy (~5GB)
- `large` - Best accuracy, slowest (~10GB)

**Other output formats:**
- `txt` - Plain text
- `srt` - Subtitles with timestamps
- `vtt` - WebVTT subtitles
- `json` - Detailed JSON with word-level timestamps

The transcription will be saved alongside the audio file with the corresponding extension.

## Step 4: Summarise

Once you have the text transcription, you can:

1. Read and summarise manually
2. Use an LLM (like Claude) to generate a summary
3. Use any text summarisation tool of your choice

## Example Workflow

```bash
# 1. Extract audio
nix run nixpkgs#yt-dlp -- -x --audio-format mp3 "https://vimeo.com/1162513409/cd293376cf"

# 2. Check duration
nix run nixpkgs#ffmpeg -- -i "VIDEO_TITLE.mp3" 2>&1 | grep Duration

# 3. Transcribe (using tiny model for speed)
nix run nixpkgs#openai-whisper -- --model tiny --output_format txt "VIDEO_TITLE.mp3"

# 4. View transcription
cat "VIDEO_TITLE.txt"
```

## Notes

- First run will download the required Nix packages (cached for subsequent runs)
- Whisper will download the model on first use (one-time download)
- For longer audio files (30+ minutes), consider using the `tiny` or `base` model to reduce processing time
- Whisper runs entirely locally - no internet connection or API keys required for transcription

## Conclusion

The Nix ecosystem makes it trivial to chain together tools like `yt-dlp`, `ffmpeg`, and `whisper` without polluting your system environment.

Till next time.
