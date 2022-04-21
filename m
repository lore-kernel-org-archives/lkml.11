Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9FBC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Apr 2022 23:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442666AbiDUXpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Apr 2022 19:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442649AbiDUXps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:45:48 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E1EDF94
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:42:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f4e17a5809so15495377b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VxEbzXVRbQ+Pz/eSbOfviKpWgjInXuPB8Qoiqt9n3DU=;
        b=LnZSJzFmYUBfJWSWXQ+ZZRNEC5pGr5mcApLbXWEI5V02ESdFtYRtQendMBBiDsHgfi
         d8UBCo5CqaypQmnP5R2TLzdlUlt3LBhdxwPmBs0cSwqCLScXuxn3zLQ0KaSpgCnk/hVo
         111sURkIlxqMBV9CJ+JrKbpzUXAmAA4wod2na0Ne38a/KnkvgyNCNrYgIsdju2lT52bc
         mE+0suLOOizwzcMFI8Chc5qM5X5qZfTiHXaDXokIx93lgf0KSygV7d7v5swdAjSHMIXu
         F8kUHJ0GF0qgJkOUUx8/ylM/k8WOSU6cLnIXrecuotgEeSuL51DJXLakcl9xoJWqZ5pd
         M/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VxEbzXVRbQ+Pz/eSbOfviKpWgjInXuPB8Qoiqt9n3DU=;
        b=I4XDZTbYKJDP61SIpncEs4kLCbUzb3nWw64fpqtRKlWAS6+cM2FoS2nUG2bSvLXXWH
         aeYIT1i8D0Dt9lNBuJOO2oK4j139uQzrKMT9tmO2IGkM4UPoZ3SHk9jkDoSPL4nScbs/
         19stD38/lCjhmCQPBnrJUkOxwlO+KK/efMXZkET8jiZcsgHdIDjduB/zoEOMIoaiCr9l
         vfyxP08DVocO/0e7CNg3vJ7OihgrZEFGMqJ3SxCbBPbR5iWFTk901gLB8S2DibIvW+Nn
         R6HVgYRMvdW0NVX/0295YvmMuhkO8KeGLKkngqtt6aGUY3HhLVw6kEwGwR5a6mjLpdWQ
         /0vw==
X-Gm-Message-State: AOAM530V0vRogP98+vfhGhJsbBg2zgni3YhN+53VMlsodzW7GJECBOw9
        TMKPh8e/Px5Z8VAz7/rJXIexF+Hc4C1O
X-Google-Smtp-Source: ABdhPJwfv9vIB0NzbKUqSLsnehF+HonN/WKiztk/usKtWvoPVNzmfAoZaSYWnHW8nKDNc1cZ4uuSGpow0DRJ
X-Received: from pigloo.svl.corp.google.com ([2620:15c:2c5:13:fcea:37a0:4467:e04f])
 (user=jmeurin job=sendgmr) by 2002:a25:ad68:0:b0:641:acc5:8d59 with SMTP id
 l40-20020a25ad68000000b00641acc58d59mr2153528ybe.548.1650584576224; Thu, 21
 Apr 2022 16:42:56 -0700 (PDT)
Date:   Thu, 21 Apr 2022 16:42:41 -0700
In-Reply-To: <20220415001321.252848-1-jmeurin@google.com>
Message-Id: <20220421234244.2172003-1-jmeurin@google.com>
Mime-Version: 1.0
References: <20220415001321.252848-1-jmeurin@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v4 0/3] mtd: mtdoops: Add timestamp to the dumped oops header.
From:   Jean-Marc Eurin <jmeurin@google.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jean-Marc Eurin <jmeurin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The current header consists of 2 32-bit values which makes it difficult
and error prone to expand. This creates a structure for the header.

Some oops only have time relative to boot, this adds an absolute timestamp.

Changelog since v3:
  Fix the printk format for sizeof to %zu.

Changelog since v2:
- Add a timestamp to the header.

Changelog since v1:
- Create a header structure to simplify code.
- Patches in series.
- Patch prefix.

Jean-Marc Eurin (3):
  mtd: mtdoops: Fix the size of the header read buffer.
  mtd: mtdoops: Create a header structure for the saved mtdoops.
  mtd: mtdoops: Add a timestamp to the mtdoops header.

 drivers/mtd/mtdoops.c | 61 +++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 25 deletions(-)

-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

