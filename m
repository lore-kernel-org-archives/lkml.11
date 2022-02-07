Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E92EC4707E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 11:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386304AbiBGLeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 06:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383838AbiBGLXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:23:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D468C0401D2;
        Mon,  7 Feb 2022 03:23:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E905FB80EC3;
        Mon,  7 Feb 2022 11:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0A8C004E1;
        Mon,  7 Feb 2022 11:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644233018;
        bh=ea+hcjM0+kOavuGX3yikwa9yDCSL8uxSQ/4hJSNZOyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N62zlb3BhWCUjssygwtYgYsqCLk8pFpyeswgC2FOenLLRUIQgKH87bEgazAacIKV5
         emXla4kQ9IXmovnx1QDY/L25HRSwn6QFVSGwM3MMpCG6zSr/Y2r+WzR11F2dJN6Q8w
         SkLRMTT6P4wFhOevz5RZ1ZCoCF9YxfzLPdYgU9V0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Borislav Petkov <bp@suse.de>, Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 5.10 65/74] EDAC/altera: Fix deferred probing
Date:   Mon,  7 Feb 2022 12:07:03 +0100
Message-Id: <20220207103759.362697287@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207103757.232676988@linuxfoundation.org>
References: <20220207103757.232676988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergey Shtylyov <s.shtylyov@omp.ru>

commit 279eb8575fdaa92c314a54c0d583c65e26229107 upstream.

The driver overrides the error codes returned by platform_get_irq() to
-ENODEV for some strange reason, so if it returns -EPROBE_DEFER, the
driver will fail the probe permanently instead of the deferred probing.
Switch to propagating the proper error codes to platform driver code
upwards.

  [ bp: Massage commit message. ]

Fixes: 71bcada88b0f ("edac: altera: Add Altera SDRAM EDAC support")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dinh Nguyen <dinguyen@kernel.org>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20220124185503.6720-2-s.shtylyov@omp.ru
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/edac/altera_edac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -349,7 +349,7 @@ static int altr_sdram_probe(struct platf
 	if (irq < 0) {
 		edac_printk(KERN_ERR, EDAC_MC,
 			    "No irq %d in DT\n", irq);
-		return -ENODEV;
+		return irq;
 	}
 
 	/* Arria10 has a 2nd IRQ */


