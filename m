Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B24C433FE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 15:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbiCCPU3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 10:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbiCCPUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:20:24 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C856191429
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 07:19:38 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so3434965wmp.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 07:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dOoO/JtORNxVZOuIC5thYYXw8aLAykNtaVPyMe7nNAo=;
        b=QPFImnuoqUI4E0pV+jHg3jjHVeJweVwJ3r4BpMu0rntbk9Vr5VjHIk8AmXRhgQEdGJ
         yJvj3ApG6YJgPydyTJQj3NGBBxjmEHO7voiSA7deudhWIr6rkicUEbS6xjLUIVFuUQCn
         RwLJji6fTL7jBleSg1Uo0GjpHv6bYKZvBdA5eLPW4coURfm7jzZ4I0520scjS8fm0OfB
         x2mZEwInNPY2fSiTDooito+65x7TzEAfbxxtnO7lVzK8svl+p+7Cwaia0mIF0id7Xwnq
         0xyUg+FxI5e/ENMgxNnEacX79exFYXFEDu8f1yyL08qCE0AAk2ITEdzFp64quU+WenX8
         +Qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dOoO/JtORNxVZOuIC5thYYXw8aLAykNtaVPyMe7nNAo=;
        b=De+2VVCC8hWjdlVR9opC40LSkC8V6aWBe2v7O0IQXHvp5VL7id8Ja0Y49Rfq4l3SID
         SI1uarPQDYzBA14akcw/Jn8HXnEsInDKY+/z1a8UUOaw3mOR9HYtJK8FJY25PFA7jZFk
         laP38KPJqELzd8SqpvQF+tBjKsNLhAqcnu3I4cP2udrIxZWDiYFrpnyBYUaONRxaf17s
         bV2hNIi7AC3JR2zI4tPX5Q4mxy9LiVK5Sk9k64qoMPnjWFQRHhTm3TI5J5HJRnIpESgm
         uPVKIVa4Q0Zd7bBnLjwq9FWCt6NhDZWFNaVotKsbT3Ua9ciqNkoHn7FYRCaDf3ujGj55
         2f8A==
X-Gm-Message-State: AOAM531jmReijdrR+EQHUYhGMmTEh/KY4rf9sO9goKqx5Oeb4C/Aeanb
        m9JfPfJzxmuNZ/mE4Gn/Dn2kJQ==
X-Google-Smtp-Source: ABdhPJwBQE32p1eCLLGgpO7z7Um4TrNO2cXOhEvLouHcngoQPm+YylJZz5schSV+hxeHcTutefuExw==
X-Received: by 2002:a7b:c30e:0:b0:37f:a63d:3d1f with SMTP id k14-20020a7bc30e000000b0037fa63d3d1fmr4077819wmj.178.1646320773221;
        Thu, 03 Mar 2022 07:19:33 -0800 (PST)
Received: from joneslee.c.googlers.com.com (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
        by smtp.gmail.com with ESMTPSA id j12-20020a05600c190c00b00380ead5bc65sm2987517wmq.29.2022.03.03.07.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 07:19:32 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, mst@redhat.com, jasowang@redhat.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH 1/1] vhost: Provide a kernel warning if mutex is held whilst clean-up in progress
Date:   Thu,  3 Mar 2022 15:19:29 +0000
Message-Id: <20220303151929.2505822-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All workers/users should be halted before any clean-up should take place.

Suggested-by:  Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/vhost/vhost.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index bbaff6a5e21b8..d935d2506963f 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -693,6 +693,9 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
 	int i;
 
 	for (i = 0; i < dev->nvqs; ++i) {
+		/* Ideally all workers should be stopped prior to clean-up */
+		WARN_ON(mutex_is_locked(&dev->vqs[i]->mutex));
+
 		mutex_lock(&dev->vqs[i]->mutex);
 		if (dev->vqs[i]->error_ctx)
 			eventfd_ctx_put(dev->vqs[i]->error_ctx);
-- 
2.35.1.574.g5d30c73bfb-goog

