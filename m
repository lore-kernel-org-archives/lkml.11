Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53854C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 16:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355828AbiDOQ2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 12:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238916AbiDOQ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 12:28:29 -0400
X-Greylist: delayed 26879 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Apr 2022 09:26:00 PDT
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A1C67D3F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 09:26:00 -0700 (PDT)
Received: from localhost.localdomain ([37.4.249.94]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MzyAy-1nu9vu2c1G-00x4PR; Fri, 15 Apr 2022 18:25:48 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 0/2] drm/panel/raspberrypi-touchscreen: Fix minor issues
Date:   Fri, 15 Apr 2022 18:25:11 +0200
Message-Id: <20220415162513.42190-1-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RqDG6XW8CnCTszDGcwr4FlT9cIcXW4pIv+/wZy44wqzqakfrJXR
 Lo+eJnEeNROd7e1QKEfX0KnkcskTJuTrYMIcnVTku2OiPMzu4+MJUOqPthHOxITymAQN96F
 r9t8ReqdVHzN1CimXNlO8B0Ni2T9Ehur/VDEy3BB7pBdkw7pMoyPTZtW+wd9SYJv+fXTkV2
 5ME0AZhiL0D+CyJkjsKmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:76mRmkmr76Q=:Kn1NOJMopeWg2UnETeqso3
 l/9W0SAl5k0WP5v5SGlV4TtnHVWeuLAoBiPGZO9AdajST7Phblbvce426hfbceW57Bp/MYfq1
 kexVhVRUUOkETgi39HTqjdSEdslAu8+2/DYrc//48HeiW1XPlVLccVK1CYmYBJKPiCl072qFU
 iX2dE4UuhRq9RkZiUXRrm9VCguQHtZ/hlLY4WaQOc6+jLzVruj0SA2q4feriMp9xQNk5iKqgf
 rZhvwYMRKmL5crg+1zqeci5NsVs0xq6+JAJGYnetrj/3O2HYrhxmX6sXtFRJWDE69rLklUDTl
 SUyY+i5LzM8c5YF1IW5WLInCuJDRcMONQWBPD8D/BDK7mAK+fnGiZWQDuJcl+rBK0rTlMEquV
 dghPhHHILowqan9yENow2clkzDGaaPRMz8M8Q3wE4uUrAUbX5JF609HN6SSaw4zPE390NLW8e
 +jnKS0szervP4Zi1nPYC162Em+4xN7U3YKSZJQ1lAj8Sdr4ls0m+0VJEE2KOEuaetQsmg8WJm
 jAjITYGF+FMO/txGH3Es5rhPN24+laaIzI3rhnvMz6NOQbo9al3wpjOTbNFmsamIwSSYkFVdd
 AlXID3QGVJUe2SLAMbz4sKHbWGu3Gc3gzZYYulTK4d6vOB6jHBJIsdizwGF52yxQdodIzNQvU
 kwOFDYCD7u8uEfSiGXhpnk8HZ/HB3zW58r6a6f3x+6Z+H3mY/9rQx41KvT4ZAA7iGkCdw4pF+
 Dfl4xLxkioH6NOa0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small patch series tries to upstream 2 minor issues which has been
fixed in the vendor tree by Dave Stevenson.

Dave Stevenson (2):
  drm/panel/raspberrypi-touchscreen: Avoid NULL deref if not initialised
  drm/panel/raspberrypi-touchscreen: Initialise the bridge in prepare

 .../gpu/drm/panel/panel-raspberrypi-touchscreen.c   | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

-- 
2.25.1

