Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A10FC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 03:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiCRDwF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Mar 2022 23:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiCRDvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 23:51:48 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9142AD08A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 20:50:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bg10so14661880ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 20:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=iq+O3k/FfZ9UjG3SjmgeqRh1gwUPMU+eljMxxt7oEZc=;
        b=lg/VIzE4D9ivFVJ6/5/ProrD5xm9TSTHCbetBabNFK2ZUxvKluPViuE7YIolFCu+cU
         53CnC+s5nvqJJY1bqJPMYjP5qwb7mMHqs5CwKWyJFVTjVbLCEOuxuHGpiiG+9y8hAqW+
         +O+h3D71vvf5RfC0XyuSRrx504uHYHMLJJnwEd0SmYOik8SCTHRSAdsL2/zdhTviZ7GN
         PzxOZO+jEWRx7pYTOyhWTuIuDIYgi4XbKyzopF5Dj6kqO2Alh3vfqgJzAgZGpZkO37rS
         67zOWOUgZCjNxBPuzb7dBjwjqCRUEQrFBB6DFLum8EgP47Ox8R3HEujO0wAmAZbH0vt6
         q+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=iq+O3k/FfZ9UjG3SjmgeqRh1gwUPMU+eljMxxt7oEZc=;
        b=PTW9ek5AIHWV3b6RnG1uRskgRh16BN5BJW8yeo0/DOx49RPX+W/36g6RUB8R6RA5Eu
         EM7KtmovTrQdBofMRQ9FAxNyiZF3KGfc3Yv1iaHbhQLQsY+r5T/i37E5VsI9aVFSXjm2
         hrnKT204bCmn+vSVM3jRTdcopJvRBkYw0FPQStpo0T9JgkYoBlY3XxHM0Q4qKst1RRuT
         ZkVQhQMOu1nufVWrJV5LeJkcc+xkiUuJv2mXBCPfwVh8QO3Kb9xODrPNVLIROLk2+hTn
         2E2AM54Qh8b1XT+7vOGYXDN4p+RkZiSSbRqizFLl9vPs74+AsjmnpL7xI0hJPBDVwJvq
         APdg==
X-Gm-Message-State: AOAM533BgrNiq6zN5SM8ANaqd1VYV/rzrRVy/EMYZOxjdpBsLKBNR6f+
        0Jmm1LHKnpm8kmSNwFN9FZcRIB0/b+zn34xu7CAh0/ouxgo=
X-Google-Smtp-Source: ABdhPJyzSsgDLUKXejs58647B/wPIb1icHFEKcguhtQ/C8QSl1mJIvEUuxp4YgtZNOQIEiLWhBuMmf7FAshGWQc9/68=
X-Received: by 2002:a17:906:3109:b0:6cc:7a1:8db0 with SMTP id
 9-20020a170906310900b006cc07a18db0mr7303848ejx.266.1647575427207; Thu, 17 Mar
 2022 20:50:27 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 18 Mar 2022 13:50:16 +1000
Message-ID: <CAPM=9twzN9ybw1N=n6JWNQgUd9UNXBxis+PguKagt8DSbW=y6Q@mail.gmail.com>
Subject: [git pull] drm fixes for 5.17-final
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A few minor changes to finish things off, one mgag200 regression, imx
fix and couple of panel changes.

Regards,
Dave.

drm-fixes-2022-03-18:
drm fixes for 5.17-rc9/final

imx:
- Don't test bus flags in atomic check

mgag200:
- Fix PLL setup on some models

panel:
- Fix bpp settings on Innolux G070Y2-L01
- Fix DRM_PANEL_EDP Kconfig dependencies
The following changes since commit 09688c0166e76ce2fb85e86b9d99be8b0084cdf9:

  Linux 5.17-rc8 (2022-03-13 13:23:37 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-03-18

for you to fetch changes up to ca5a5761ac542691a6b3520b6c5c047cf63b4b8d:

  Merge tag 'drm-misc-fixes-2022-03-17' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2022-03-18
13:32:54 +1000)

----------------------------------------------------------------
drm fixes for 5.17-rc9/final

imx:
- Don't test bus flags in atomic check

mgag200:
- Fix PLL setup on some models

panel:
- Fix bpp settings on Innolux G070Y2-L01
- Fix DRM_PANEL_EDP Kconfig dependencies

----------------------------------------------------------------
Christoph Niedermaier (1):
      drm/imx: parallel-display: Remove bus flags check in
imx_pd_bridge_atomic_check()

Dave Airlie (1):
      Merge tag 'drm-misc-fixes-2022-03-17' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Jocelyn Falempe (1):
      drm/mgag200: Fix PLL setup for g200wb and g200ew

Marek Vasut (1):
      drm/panel: simple: Fix Innolux G070Y2-L01 BPP settings

Thomas Zimmermann (2):
      Merge drm/drm-fixes into drm-misc-fixes
      drm: Don't make DRM_PANEL_BRIDGE dependent on DRM_KMS_HELPERS

 drivers/gpu/drm/bridge/Kconfig         | 2 +-
 drivers/gpu/drm/imx/parallel-display.c | 8 --------
 drivers/gpu/drm/mgag200/mgag200_pll.c  | 6 +++---
 drivers/gpu/drm/panel/Kconfig          | 1 +
 drivers/gpu/drm/panel/panel-simple.c   | 2 +-
 5 files changed, 6 insertions(+), 13 deletions(-)
