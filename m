Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31064C43334
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jun 2022 11:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiFYLmv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jun 2022 07:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbiFYLmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 07:42:49 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C511DA62;
        Sat, 25 Jun 2022 04:42:49 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id r1so4249614plo.10;
        Sat, 25 Jun 2022 04:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FVCRMGb+Cx09Uie3dQkwHqVyER5uIEsfwxOzBnP3Djg=;
        b=HbJbB3yiwysOUYx70A9rJ3IyqHJZD53w2ugOLFfWnQL9fE3Xv37YHL88kbqBLF3FDw
         eofdHyDWKzf88V4uam5r09y46d3q9n1n/BER56T0Vc6t7VB19m4x5Qg2eFXGkI+076EA
         bJ8H0caDs25x5ypQBnEwZW114Eq7GlrhHM01ysrGXU2I5UQ+bf4c9+ylQeTtNNQe3SWt
         8zXqgck2CFpTQXozmXFB2csi9SrRkV4NQlnmCTTbQhNdSo4STt+yltK6OZKeC3iQzHyU
         1OnZx4ZEEC293glV6bTb3tS+9t22WnBSJGatcTKVZVtuHVmJYY8mrC9BnDHl7YC7DH9h
         rL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FVCRMGb+Cx09Uie3dQkwHqVyER5uIEsfwxOzBnP3Djg=;
        b=cgokASi3kl9Rnde84Uv94UW5UUVZJkpLDbbpZQyaq8qdp6A4hr/bqnEzG0jxpNkrV6
         ZYw0caycYHmWy6T8U3KmCg73D7dMnnKpnSxoLV6jXTXeKcOXD84XKkMVpjIFYiRF7i1C
         PuyF6eD9iu6qVtwvgJGG5xmzWbKdE5zjKX6NIaKjDHLWdNlkYsANdhMhqNVzmRtM3T5C
         7x8WBLzRuSusvUsgmdBqInnsmbtBWF8LLmNs5q6AJgr5D6xDegrRqsFgADHUjhccPUfL
         gYwvZMuKuU3oD8PgLGhUnqEuCGsekfqsvcFSns2yMi8ZUap8NhQBFUHw0GJo575YcIZr
         eMmg==
X-Gm-Message-State: AJIora/u1bEZ2ZNXxx/qsOkI40DlvyP5pxqHoGw0vfPYJHkgOBvGvBa+
        N9aKHsPGO2PezhMchzJpQ5Q=
X-Google-Smtp-Source: AGRyM1vyPaYnUF9plyh2nRkg7XifFzCevz2lvXaBIKvKXigYwZNXwk1KQRvDNSvPkEe7/xtGx/gdTg==
X-Received: by 2002:a17:90a:34c7:b0:1ec:91a6:f3db with SMTP id m7-20020a17090a34c700b001ec91a6f3dbmr4224398pjf.112.1656157368625;
        Sat, 25 Jun 2022 04:42:48 -0700 (PDT)
Received: from localhost.localdomain ([103.152.221.103])
        by smtp.gmail.com with ESMTPSA id y17-20020a1709027c9100b0016648412514sm3504736pll.188.2022.06.25.04.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 04:42:48 -0700 (PDT)
From:   Liam Ni <zhiguangni01@gmail.com>
To:     alex.williamson@redhat.com, cohuck@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhiguangni01@gmail.com
Subject: [PATCH] vfio: check iommu_group_set_name() return value
Date:   Sat, 25 Jun 2022 19:42:39 +0800
Message-Id: <20220625114239.9301-1-zhiguangni01@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As iommu_group_set_name() can fail,we should check the return value.

Signed-off-by: Liam Ni <zhiguangni01@gmail.com>
---
 drivers/vfio/vfio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 61e71c1154be..ca823eeac237 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -504,7 +504,9 @@ static struct vfio_group *vfio_noiommu_group_alloc(struct device *dev,
 	if (IS_ERR(iommu_group))
 		return ERR_CAST(iommu_group);
 
-	iommu_group_set_name(iommu_group, "vfio-noiommu");
+	ret = iommu_group_set_name(iommu_group, "vfio-noiommu");
+	if (ret)
+		goto out_put_group;
 	ret = iommu_group_add_device(iommu_group, dev);
 	if (ret)
 		goto out_put_group;
-- 
2.25.1

