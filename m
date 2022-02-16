Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7F1C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 03:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344106AbiBPDJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 22:09:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344111AbiBPDJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:09:44 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0D5F65EB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 19:09:22 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id n185so648849qke.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 19:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3GJiORRsTVx+yI2/L1IdZTmJe+M7rTwA6x3mOQDXVmQ=;
        b=SIjbG25UuDR5aWFLNo606A8KF9DC/7h0SWpcFFgf6fkS1OwT65cGA70qwzWHLZncEd
         CKNlFo1bveItVQzjUhNwDqbcVe4rOA5FLW/BtpegisoNtmbFMZvB05jF0F5W7KFJLmqd
         Mxu9sLFetgolC5CmZoneMvEknSK1AjCBGPA5ZmEEP68z0lndpEKeTxyVxfvIAp8vWzQO
         K7xtYZj6gxoR1yt0LviOsLyd5Y87zJu/R3aT/VD7Z4G+AjeV1rF79HFB3i+BYQlVNFP3
         OHXjRdWyuXp9MfU2z/RNMesNcgqyq5bQflChawFX2z6rCQrOCNOVXi3fSrba6EKM1RcN
         9y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3GJiORRsTVx+yI2/L1IdZTmJe+M7rTwA6x3mOQDXVmQ=;
        b=ImPa1EUTxZJX4fxdd6qXupvSEuMJBiU40Dg/Gvls4zS1Era3xAnrTkBRCMSSL/h1YB
         VUEbGnKG/pcRg+4lKzDUtn57EIa6bt09WmpSBil9KDia9MmV3fLpwdVkYYisKDuhIaim
         9yIpWpH6s/wzSLF5Os/s+4NSphu3krVBzlfzxyqHohvpDNcFuJEdPhbeW6ci5sC5qurZ
         PltB6Li3tfRpP9XR9k1ySYnrv2ygX65sO3+pI6wCIFqX+XF6XVAH1hSCRwGgKDMNTSHy
         V7xm5AFkcGNEUA6gqb3fZ2iiilO5GuXFmv+ePb8jL/0BgKuK+ApWEKpQtV0qwF4EWC4q
         KDEg==
X-Gm-Message-State: AOAM532Hi2nZCTI8K7i7DyRmiNZorNDnGvphQLGqeTtOghZ7FR5x6X5J
        6Mxdjd67ktFueTK8OA2zZoA=
X-Google-Smtp-Source: ABdhPJzmmNSnD5rQfwI01b677/YcsxCSxr089THSIYQVmFvMExzZkLYzsGK6DY8AnSAM7vXZeoqnBQ==
X-Received: by 2002:a05:620a:2699:b0:47d:753c:b8ff with SMTP id c25-20020a05620a269900b0047d753cb8ffmr383744qkp.763.1644980961930;
        Tue, 15 Feb 2022 19:09:21 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k20sm20635330qtx.64.2022.02.15.19.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 19:09:21 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     jean-philippe@linaro.org
Cc:     joro@8bytes.org, will@kernel.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drivers/iommu: use struct_size over open coded arithmetic
Date:   Wed, 16 Feb 2022 03:09:16 +0000
Message-Id: <20220216030916.1839742-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>

Replace zero-length array with flexible-array member and make use
of the struct_size() helper in kzalloc(). For example:

struct viommu_request {
	...
	unsigned int			len;
	char				buf[];
};

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/iommu/virtio-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index f2aa34f57454..0996d9c7c358 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -231,7 +231,7 @@ static int __viommu_add_req(struct viommu_dev *viommu, void *buf, size_t len,
 	if (write_offset <= 0)
 		return -EINVAL;
 
-	req = kzalloc(sizeof(*req) + len, GFP_ATOMIC);
+	req = kzalloc(struct_size(req, buf, len), GFP_ATOMIC);
 	if (!req)
 		return -ENOMEM;
 
-- 
2.25.1

