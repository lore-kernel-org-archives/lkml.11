Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54B3C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 07:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347029AbiFUHVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 03:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346917AbiFUHVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:21:24 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3758F2253E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:21:24 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id cf14so8327020edb.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C/NKEAt2Er4quLZ5gjnADzbiK7ybSix+76D1rb8z9Fw=;
        b=Aosb52+hrSp+NPKOBpkKo+HEpLAjK6Cy41ZXxhSPtBSqnk3xiW5XK+YkC1wTawZ3PX
         Rg0witFuSx8IGBu5tFPCDFIbRKZWIN6OEc60DpQLjXdIOtPdpZ+9tk1hsR8vmpK9Oqb+
         qzYFblMRhzKHKrgWXx48VO1dgBn7weLem/f+BIetEfiZNBlOfeKAbR560Dw+l8usmNFx
         zDqNU63Wd7veZo9Y0bODMqID/93UPNX7JmMvzuusJvJT5h7SZlV4kAxZ6RChrclrzwUB
         cRk+nJnExHGPX9Ll71IH+4hfgMpqXQ5u5CiTTdepjp1vYvEtV5bR4SfiVgE6u5YpPPdY
         hZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C/NKEAt2Er4quLZ5gjnADzbiK7ybSix+76D1rb8z9Fw=;
        b=vU2eaHeVs0T5e3/m9mqXiKpUaste81++NhSB7B4hZHRHaMyO95vlaMutCOXl5yYRRZ
         bjtlJGiLrfNie0XixP1D+7HORu/G7ol2bpHRinJuvKcNHmShW4AmXSgwVPFrIPJl9O+b
         pEHrEjAneTkyX9K3K7xcNZGCBKPj212OCgcu9SdfG2Xv0HxqCc6nKlxlrx24bN4jDYO2
         z95rEFYtBq5uoyccMXMW/8j4KEyecHQ0tLWek+uxmPX/QLul2UrghzBnC9NzD2RoNyga
         mJ1nV7M91bzt5A1vUFdzSkFaixnZT26k+KTAtsxhOxHEQWshREcdUH+gARpiQiE6r61n
         06+A==
X-Gm-Message-State: AJIora/ES4oe1YCsrXdYdwHDHeVBqF507bm/s465RIaSGWsJEt2eG0LB
        DMQgQWRvpuJ/++UVTeBKYobkVJRVPV0=
X-Google-Smtp-Source: AGRyM1v2Ep/cdmiqnkH6Ncpgbtcv2HEnrlZXGr9tHs+YsIyubDQfduplz2GQ4Wt6a/8Lw+p3B4StFw==
X-Received: by 2002:aa7:d294:0:b0:435:5d12:867f with SMTP id w20-20020aa7d294000000b004355d12867fmr25960856edq.147.1655796082489;
        Tue, 21 Jun 2022 00:21:22 -0700 (PDT)
Received: from localhost.localdomain.info (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id p1-20020a17090653c100b00722e771007fsm50711ejo.37.2022.06.21.00.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 00:21:22 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        etnaviv@lists.freedesktop.org (moderated list:DRM DRIVERS FOR VIVANTE
        GPU IP),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR VIVANTE GPU
        IP)
Subject: [PATCH v2 4/4] drm/etnaviv: export loadavg via perfmon
Date:   Tue, 21 Jun 2022 09:20:50 +0200
Message-Id: <20220621072050.76229-5-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621072050.76229-1-christian.gmeiner@gmail.com>
References: <20220621072050.76229-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it possible to access the sub-GPU component load value from
user space with the perfmon infrastructure.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 79 +++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
index bafdfe49c1d8..d65d9af3a74a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
@@ -120,6 +120,19 @@ static u32 hi_total_idle_cycle_read(struct etnaviv_gpu *gpu,
 	return gpu_read(gpu, reg);
 }
 
+static u32 load_read(struct etnaviv_gpu *gpu,
+	const struct etnaviv_pm_domain *domain,
+	const struct etnaviv_pm_signal *signal)
+{
+	u32 load;
+
+	spin_lock_bh(&gpu->loadavg_spinlock);
+	load = gpu->loadavg_percentage[signal->data];
+	spin_unlock_bh(&gpu->loadavg_spinlock);
+
+	return load;
+}
+
 static const struct etnaviv_pm_domain doms_3d[] = {
 	{
 		.name = "HI",
@@ -419,6 +432,72 @@ static const struct etnaviv_pm_domain doms_3d[] = {
 				&perf_reg_read
 			}
 		}
+	},
+	{
+		.name = "LOAD",
+		.nr_signals = 12,
+		.signal = (const struct etnaviv_pm_signal[]) {
+			{
+				"FE",
+				0,
+				&load_read
+			},
+			{
+				"DE",
+				1,
+				&load_read
+			},
+			{
+				"PE",
+				2,
+				&load_read
+			},
+			{
+				"SH",
+				3,
+				&load_read
+			},
+			{
+				"PA",
+				4,
+				&load_read
+			},
+			{
+				"SE",
+				5,
+				&load_read
+			},
+			{
+				"RA",
+				6,
+				&load_read
+			},
+			{
+				"TX",
+				7,
+				&load_read
+			},
+			{
+				"VG",
+				8,
+				&load_read
+			},
+			{
+				"IM",
+				9,
+				&load_read
+			},
+			{
+				"FP",
+				10,
+				&load_read
+			},
+			{
+				"TS",
+				11,
+				&load_read
+			}
+		}
 	}
 };
 
-- 
2.36.1

