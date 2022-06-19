Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56237C43334
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jun 2022 11:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbiFSLUP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jun 2022 07:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbiFSLUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 07:20:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C64E45
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 04:20:10 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y32so13159537lfa.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 04:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YOIemqa3xLxDPgSIq+6JCIgvmCAUQLVD4NTDCfwUgvg=;
        b=bQdczVTmeCBRRml/qJ3pgDPNKFd5DnupXxnTM4OjaPQgUF2aGS1EStz3yq0iJVSQvM
         sKxzUMyGJssePtKOzMAZzuZxgW/hgM14GyceFu+HJCSd3rtPmAQVffjiY/kwEY8VE6zi
         457qpYlewZzIBwRCff+0if+Qb2umvW+ou0vpwyZiPXi2ISTtCdhUo+sqXM6WehvV+oNl
         t1vDLNNvXYhBVRkRMfblZJjeeQpoSoLcmDr7LCEWzsnodjgsSNev+j0AWggH063pZ8OH
         H2MCqwbl/vr9A81fOhyMLHDfjEWM5gy0strMeERLsB2kRQ/BNUE8PNB3LYCqMWOc3BhE
         MUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YOIemqa3xLxDPgSIq+6JCIgvmCAUQLVD4NTDCfwUgvg=;
        b=XehI6aAHQKYodtEnV5eXJzztrmzC44TfR+vFx9ZWb5+bOEBRni7EZsy0bcLyaBDA0t
         DJbEVJzrh9QH9wD28kN8hy1aGbhfiJwxN9td7Qu3EWGaRSkAm3qbkS6N7Qii96UhMANv
         euz75ZaGM3vvI1TjkpL0rRQQDt5ubp25HCYtF+/+k8EGm6FBsORf8jYxVzAMgKeGSV/f
         tX2SJUw5lG79nEJPzdnHyDarGx+kQjFfBHmwVnpQjThQIR2JiLW1GZ6hKPGdMI9NwWMH
         ZekiQ/G3AHLzV0kuPlAk6tKckHg9ohGqopo8HKacd5E8FdPk2LCushdG22YRzA4IGykB
         +ldg==
X-Gm-Message-State: AJIora/RKNse7/cVZHyRTrrJq81U9gufL901qxhKgBcUMPaz7+JtUAHH
        /DkAluM7JnzV/uhIJ0A2Sqg=
X-Google-Smtp-Source: AGRyM1uuRURbU68lqDoRqXT3mGHNAsxKeG9k4FUUNkHrrrYJI692bLRl/QrmvUtiVDXYNpA6FrCLIA==
X-Received: by 2002:ac2:4e08:0:b0:47d:c408:5565 with SMTP id e8-20020ac24e08000000b0047dc4085565mr10861585lfr.633.1655637608670;
        Sun, 19 Jun 2022 04:20:08 -0700 (PDT)
Received: from ayaneo.lan (79.191.3.219.ipv4.supernova.orange.pl. [79.191.3.219])
        by smtp.gmail.com with ESMTPSA id x21-20020a056512047500b00478f2a09100sm1326311lfd.184.2022.06.19.04.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 04:20:08 -0700 (PDT)
From:   Maccraft123 <maccraft123mc@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm: panel-orientation-quirks: Add quirk for Aya Neo Next
Date:   Sun, 19 Jun 2022 13:19:52 +0200
Message-Id: <20220619111952.8487-1-maccraft123mc@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maya Matuszczyk <maccraft123mc@gmail.com>

The device is identified by "NEXT" in board name, however there are
different versions of it, "Next Advance" and "Next Pro", that have
different DMI board names.
Due to a production error a batch or two have their board names prefixed
by "AYANEO", this makes it 6 different DMI board names. To save some
space in final kernel image DMI_MATCH is used instead of
DMI_EXACT_MATCH.

Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>

---
Changes from v1:
- Changed it to use only one entry, with less exact match, as requested
  by Hans de Goede

---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 4e853acfd1e8..df87ba99a87c 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -152,6 +152,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "AYA NEO 2021"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* AYA NEO NEXT */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+		  DMI_MATCH(DMI_BOARD_NAME, "NEXT"),
+		},
+		.driver_data = (void *)&lcd800x1280_rightside_up,
 	}, {	/* Chuwi HiBook (CWI514) */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
-- 
2.36.1

