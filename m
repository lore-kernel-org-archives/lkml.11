Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2E6C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 12:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240544AbiBYMJv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 07:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240505AbiBYMJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:09:38 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E0E1DAC6E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:09:06 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z22so7143422edd.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6XJhj8Ihrmjop5X3+642va1C/5EerFs3iFnEeb2jMrk=;
        b=TU/U9yonfzdoh+W/c31bXdpOoW3PUzuJGrYRhaK57eOG2cLFmWMpICy5frtUBhfWx3
         efmruOfnTV0AV3FX0Cevw1bfPHNDRoOsudb5fG+63KY034+uKCTI0iAIPeMo3pVgyIfF
         XsrV4eHOfPMPiPROtmaTF/lxceo4nnGPQtZ5DZA8TJkOKK0m9tynKQfrptpflsDPOBT8
         Qgg+o/N9t/bUzMzgYIB+LUszkQoPql2SNj7BBBqoND7nWtGXiPS2g1H8kAD/RqLpXU2s
         U2sKb53gV1LkglUHtvh0CcxchQlNj5Ev3ZyHvnC5qb46eqesPdf9lqk/8ZTkpjp5ei7S
         mkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6XJhj8Ihrmjop5X3+642va1C/5EerFs3iFnEeb2jMrk=;
        b=Yi1txi/k9SdnctBr+/DTLkYHO57ILu2XNUXYG9iPk21q7lMX0BmF1OeGJ56/NPU2U9
         iCJOizu1k2RplE+dqpbUNK/WX6uvYPspRf+5VjXAQUSKC2aOC/VTQPO7naQPWGoec03d
         iumtHE+Kh3MwKM3vuZGucBquReTK+FtxzbhmsrJmRLdjsTksdZYXlbLqpmxb+rKBgI8R
         B6Xpwo4h+n2jtzgM+FvyBkG9xWYbfd32wKFxtPC08kdssPppofg/kJMVrHiliifAPO4W
         7Ku2ovXOaYZgiMKbbJwOkhTjd5veN4vDqJZuofNnxQOCa078MyWS5mFK/28j83xke19I
         +DuA==
X-Gm-Message-State: AOAM532SEOP3HHWp0YXJyAVgncfe4fYpW1yaIvHc/NcRdeiAcVPNgWdI
        cSWBuyM0q+uBBylfgFaJ2LaGlfJkRYs=
X-Google-Smtp-Source: ABdhPJwW7Yg7ntU+LnpT67TARcf5Ibm+DImGDxt1HBzWYrUUV79XSKrgb13C7bASPEaGZCpnM+OTdA==
X-Received: by 2002:aa7:c0d0:0:b0:410:d576:8808 with SMTP id j16-20020aa7c0d0000000b00410d5768808mr6868476edp.340.1645790944825;
        Fri, 25 Feb 2022 04:09:04 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8d.dynamic.kabel-deutschland.de. [95.90.187.141])
        by smtp.gmail.com with ESMTPSA id y14-20020a50eb8e000000b00410a2e7798dsm1229418edr.38.2022.02.25.04.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 04:09:04 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/4] staging: r8188eu: remove ETH_ALEN from ieee80211.h
Date:   Fri, 25 Feb 2022 13:08:43 +0100
Message-Id: <20220225120843.10674-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225120843.10674-1-straube.linux@gmail.com>
References: <20220225120843.10674-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The definition of ETH_ALEN in ieee80211.h is redundant as it is an
in-kernel constant. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/ieee80211.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index 1793b99feb9f..3a860e132cbd 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -11,7 +11,6 @@
 
 #define MGMT_QUEUE_NUM 5
 
-#define ETH_ALEN	6
 #define ETH_TYPE_LEN		2
 #define PAYLOAD_TYPE_LEN	1
 
-- 
2.35.1

