Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CD3C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 29 May 2022 07:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiE2H0t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 May 2022 03:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiE2H0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 03:26:45 -0400
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E2F4DF43
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 00:26:43 -0700 (PDT)
Received: by mail-pj1-f68.google.com with SMTP id n10so8180714pjh.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 00:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vu4dWIGyiffGhwd6i2g4sM9fvK38UUljjdIsvD/ie+k=;
        b=eOhqRbRWBq7b9snBmQahJtUCnF/Nw2p0M6yivnRg5IrIHT2xOad2YwEUQbfOON8rsG
         okUtTiQMNuwPNl16oqN1PDlrW8FWCnGpt+kNFg2RuFszuelu37idlbxdOcQQ9KzkJgwg
         Z9Eh/16k7t9OhlWvr3be6Bo0fEVyizGDRIPC4qPHRXgCONvUCkR/w29KDQZeKx2NlsHg
         llHkDB0YXmVkzq3EfMChKUojnP/Fjr9D7VL2k8MkQuXYEJydiOf4IYxlYCFt0b1j9IvW
         gIgr2QC5V6n5zzyecZDAVkzIWV+uFFCKrwmD6Dy6cupq0FSE7FOKBAN9WfYtJsaOjQxe
         bd7Q==
X-Gm-Message-State: AOAM530isYRqX+OHWd9lfLga6/kqpj/rLRvyKYZ3NlgrUBfbr6OWzEB8
        XLleoMLFoYb27WiQc49psw==
X-Google-Smtp-Source: ABdhPJzDFqMQ8MoMUp9uXAH6WqII1t+98/oFdCydP9hOJQWN8ccihKXmsmTEqRfLtPSlDiDi98wevg==
X-Received: by 2002:a17:90b:224a:b0:1e2:7afb:3367 with SMTP id hk10-20020a17090b224a00b001e27afb3367mr11946655pjb.37.1653809203357;
        Sun, 29 May 2022 00:26:43 -0700 (PDT)
Received: from localhost.localdomain (ns1003916.ip-51-81-154.us. [51.81.154.37])
        by smtp.gmail.com with ESMTPSA id h24-20020aa796d8000000b0050df474e4d2sm6448333pfq.218.2022.05.29.00.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 00:26:42 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     alexander.deucher@amd.com, hristian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        Hawking.Zhang@amd.com, mike@fireburn.co.uk, Xiaojian.Du@amd.com,
        evan.quan@amd.com
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, sunliming@kylinos.cn,
        kelulanainsley@gmail.com, kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amdgpu: fix a missing break in gfx_v11_0_handle_priv_fault
Date:   Sun, 29 May 2022 15:26:31 +0800
Message-Id: <20220529072631.307922-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following w1 warning:

drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:5873:2: warning: unannotated
fall-through between switch labels [-Wimplicit-fallthrough].

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index cb581cfc7464..628d3536938e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6028,6 +6028,7 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
 		break;
 	default:
 		BUG();
+		break;
 	}
 }
 
-- 
2.25.1

