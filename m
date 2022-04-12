Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5FDC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 08:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380239AbiDLIVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 04:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351823AbiDLHdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:33:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880605047E;
        Tue, 12 Apr 2022 00:08:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9994AB81B4F;
        Tue, 12 Apr 2022 07:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BF8C385A1;
        Tue, 12 Apr 2022 07:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649747317;
        bh=qb7dqHmgbsiv+Ny1LN80N+oGMfAJtZMtoivBEsSk6XI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qaraylGNIbNu3nO+XIEm0WrlTS3cYARaEisi/ieyrkzOcRChP12LQVbMimcdL7One
         qQpQ81UJCar+7ccoPrB9asRtqZCKMAK1kdWvVSdmKw93bp1Lc7FP9ZYJhUxeYQZAwe
         JDTKPbMBUcwYjsHubAVbbEkdIiNT2w67i+auJ4Bc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 036/343] powerpc/xive: Export XIVE IPI information for online-only processors.
Date:   Tue, 12 Apr 2022 08:27:34 +0200
Message-Id: <20220412062952.149337635@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062951.095765152@linuxfoundation.org>
References: <20220412062951.095765152@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sachin Sant <sachinp@linux.ibm.com>

[ Upstream commit 279d1a72c0f8021520f68ddb0a1346ff9ba1ea8c ]

Cédric pointed out that XIVE IPI information exported via sysfs
(debug/powerpc/xive) display empty lines for processors which are
not online.

Switch to using for_each_online_cpu() so that information is
displayed for online-only processors.

Reported-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/164146703333.19039.10920919226094771665.sendpatchset@MacBook-Pro.local
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/sysdev/xive/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 89c86f32aff8..bb5bda6b2357 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1791,7 +1791,7 @@ static int xive_ipi_debug_show(struct seq_file *m, void *private)
 	if (xive_ops->debug_show)
 		xive_ops->debug_show(m, private);
 
-	for_each_possible_cpu(cpu)
+	for_each_online_cpu(cpu)
 		xive_debug_show_ipi(m, cpu);
 	return 0;
 }
-- 
2.35.1



