Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB14AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 May 2022 14:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345328AbiEaOtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 May 2022 10:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345299AbiEaOtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 10:49:39 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507DDF43
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 07:49:39 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id e24so5253274pjt.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NAOtSJQ0e7lMXAVSUZPZ1qHrCN9pnSWlg6iMnewBSfg=;
        b=cV7Mz+wAIW+PUEe0iYCSMFq+uwxZ91W/LWcYZNEYSILqBIgtLaEyH4um2dlf1uimil
         Hi01/2VYvnNhg5DSMEI7jjDXglilceVlkoiPmjoJ7T37eqTTua6KsZfxs7YJoqo9iVYF
         ZBze3AfYyWmvNzLR0j+MK6mh8wov6wK65LrFma3m1bAzxLgSpHMraTJBX2Bx14ExdN3Q
         p8kWMI3acpRst921i2EBqp2XK8bfYwjbpd4dNcxzRkq0pyMxVqQoxW3Et3XaRFHK9XGT
         2OCdR5DusT0ZqUmE3AGkp7ntPwr7BoFNaUddygiHIKy4/LvF4KgYPvWivit4UnnS58j3
         OWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NAOtSJQ0e7lMXAVSUZPZ1qHrCN9pnSWlg6iMnewBSfg=;
        b=8KR/Pg+gUgrS7Pykg6gdSWsin+p9Qcl4Q48e7g85xoImt6TmJxs2FduBNWzy4B0BSE
         bIVKbf5t506HZmJsh7nK1Tb7vS7hDqeVl18iM0cs885OB5Hqh6Jou+KdWqlRWyGv7zHN
         x0kzPNPdyUXQFBN3okDg0+yj7XoxlfqMGpKlcW2gFYNUxXMlBTrjiQes33T0+4RIkTxP
         81UmL6C3RNvWqY4M4GJToe28oltS7j+OzZT1ogPFunmzsbdGm3vgxxK0CcBrd3uQgboh
         xfZKYo0rmJjEKpCtaJmAfD9kPJCMNp1+ywInQNIQceD46wC5/IRe0piMU1ZXYZpAzRoG
         OPdw==
X-Gm-Message-State: AOAM533dViHQUaqHEhhdIVARKVe6fCLT8UPear7goUyLObXsFT4YdJ7g
        26nowOzMP7oCmsdn4e+9ofs=
X-Google-Smtp-Source: ABdhPJwp7L4klTmbrkke0YpYCLWkj2Vr73IGnj3X69pgKGLK4gcgENFTfpGqAgXHRx3n2vVZJlo34g==
X-Received: by 2002:a17:902:e80c:b0:163:d222:60b7 with SMTP id u12-20020a170902e80c00b00163d22260b7mr12131714plg.54.1654008578559;
        Tue, 31 May 2022 07:49:38 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id d3-20020a17090a8d8300b001e2d4ef6160sm2007215pjo.27.2022.05.31.07.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 07:49:38 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH 1/2] drm/meson: encoder_cvbs: Fix refcount leak in meson_encoder_cvbs_init
Date:   Tue, 31 May 2022 18:48:15 +0400
Message-Id: <20220531144818.26943-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_graph_get_remote_node() returns remote device nodepointer with
refcount incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: 318ba02cd8a8 ("drm/meson: encoder_cvbs: switch to bridge with ATTACH_NO_CONNECTOR")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/meson/meson_encoder_cvbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/meson/meson_encoder_cvbs.c b/drivers/gpu/drm/meson/meson_encoder_cvbs.c
index fd8db97ba8ba..8110a6e39320 100644
--- a/drivers/gpu/drm/meson/meson_encoder_cvbs.c
+++ b/drivers/gpu/drm/meson/meson_encoder_cvbs.c
@@ -238,6 +238,7 @@ int meson_encoder_cvbs_init(struct meson_drm *priv)
 	}
 
 	meson_encoder_cvbs->next_bridge = of_drm_find_bridge(remote);
+	of_node_put(remote);
 	if (!meson_encoder_cvbs->next_bridge) {
 		dev_err(priv->dev, "Failed to find CVBS Connector bridge\n");
 		return -EPROBE_DEFER;
-- 
2.25.1

