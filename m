Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575F9CCA485
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 11:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiGTLAp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jul 2022 07:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbiGTLAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:00:43 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E42B27CE6;
        Wed, 20 Jul 2022 04:00:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l23so32393623ejr.5;
        Wed, 20 Jul 2022 04:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=U/VJk3xiTJFmLuPsj0qzjQ93oE7pWfHrNWLCEYbjvDg=;
        b=WcG2kQ+C/cIGYX6jixsYc3gLIX1du1R0yJSxyneeyPfSrAbf8+iuxQf3aLq/UjstCS
         uR+oHsJWKhC3m1LJ0A+r0ZELP2A5cwF/kojt5rH40KLSyTmFt455X/hj2sQNanATD8Gc
         ZL5+ons8FkHWU99IaW1arNkAI84VNzQLEk3qrRrxzJTk9pmBqIKpyAQeA0Ht29fL2HmS
         VmBe8x6hKDmvaSW4D0cF7DLRMREoQR+57VVmv3kKin27OiP1MzjgqfUXlyr1vtsLn4nW
         8Aa6TWhc0qMe7G7nyu8/8YWOGps9sa8dpsFJf3hfBoPDgDZ3891pva5psG53K2uO7CCj
         Vikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U/VJk3xiTJFmLuPsj0qzjQ93oE7pWfHrNWLCEYbjvDg=;
        b=qkElqA4HofT1YDTR+gkSKy5cgEWYlaGyP7jNLP9zg05IUTJ9fUUExihCM4v+6lDmFW
         3M4+WNoppa2kKHWjIbyYx2NjNNFkmpsI71YedEI6uQKlCjuHvVuilgjw1QD1uxxf3g6G
         0pxWfq0xi5YoV4G5CA2UWJXaKK4yqicKDuawViTDBwgfzOs/Y7mY+URsr2kozTBdtdzi
         imTYDjh5b13cc+OUXtxpGFwljvfIQ2AQAkts46T4TZvQQ+QNKMFjO6I+qmycI4qirPHn
         qjh3DE1CQ5bD76ov+rs84LPDK40+x+8mgW0ZXmnNv6xopPOJjXGWiNfX7JiuPcdm3v9r
         WHEg==
X-Gm-Message-State: AJIora+1xVa8/hNDxIqwdKSO2bShUBZwaEK805BiZPlbM0EHZW1iBDnz
        BpS3eyLwDz+hb+tuh3p84+auu6U5Gmw=
X-Google-Smtp-Source: AGRyM1utUQRdA/aCctlsBH6LfOpIwJRY5F9OyAFEBaP68KYk+1PdJYEnw8x664ioOtdKq06XEIXX6g==
X-Received: by 2002:a17:907:a0c6:b0:72f:2293:bd04 with SMTP id hw6-20020a170907a0c600b0072f2293bd04mr16210418ejc.123.1658314837576;
        Wed, 20 Jul 2022 04:00:37 -0700 (PDT)
Received: from felia.fritz.box (200116b826a11f008020c2fc6e115b3e.dip.versatel-1u1.de. [2001:16b8:26a1:1f00:8020:c2fc:6e11:5b3e])
        by smtp.gmail.com with ESMTPSA id j4-20020a170906474400b0072aed3b2158sm7825842ejs.45.2022.07.20.04.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 04:00:36 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: add header file to TI DAVINCI SERIES CLOCK DRIVER
Date:   Wed, 20 Jul 2022 13:00:26 +0200
Message-Id: <20220720110026.9173-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While creating a patch submission on the davinci clock drivers, I noticed
that the header file include/linux/clk/davinci.h belongs to the section
TI DAVINCI SERIES CLOCK DRIVER.

Add a file entry for this header file in TI DAVINCI SERIES CLOCK DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 264e7a72afd6..d4e1a6ef552c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20261,6 +20261,7 @@ R:	Sekhar Nori <nsekhar@ti.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/ti/davinci/
 F:	drivers/clk/davinci/
+F:	include/linux/clk/davinci.h
 
 TI DAVINCI SERIES GPIO DRIVER
 M:	Keerthy <j-keerthy@ti.com>
-- 
2.17.1

