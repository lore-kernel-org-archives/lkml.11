Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C353BC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 01:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbiFHB4M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 21:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1587908AbiFGXxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:53:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE6555481
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 15:52:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC5ECB82461
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 22:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1D3C3411C;
        Tue,  7 Jun 2022 22:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654642321;
        bh=yoAIC34lZ3i1AOammmFEJ2hDOK9WEHGvuE88v1WJFU0=;
        h=From:To:Cc:Subject:Date:From;
        b=Ppf1kPhULkYw+uqjKJae3kLM25vtPlsn+USRS2czl7TMbiRaFp+knDE4Zn9VmgfyP
         pYh3O8Cu+mmkedixIZ37x3Yq/j+4eqBu2/GKoohoLV16AwoV9Cah3OU1A6PepdlIzx
         dxqEmw5vmFbUDbWXGvFC0tPkv8iJe+t1VneNeXQPv0xGVUEBGZkFvVeRx88gSuTXDN
         P/U2SqY0xCMsR+3DOiWyBmtt/SQrx8A2X1QIMpB+0ygrHnc7NhyAZ2eF574k2CVwl1
         WkPZ8KZnO9vWak8I5J0uw0sEtmYKjPCwFoHekXDje9FEl937BogWSJWaqvuCzq36Dj
         eezohDlibB09g==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH RESEND] mailmap: add alias for jarkko@profian.com
Date:   Wed,  8 Jun 2022 01:49:56 +0300
Message-Id: <20220607224957.2509033-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add alias for patches that I contribute on behalf of Profian
(my current employer).

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
wrong to-address, in the previous patch
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 825fae8e6b7b..b2967aab5359 100644
--- a/.mailmap
+++ b/.mailmap
@@ -165,6 +165,7 @@ Jan Glauber <jan.glauber@gmail.com> <jang@de.ibm.com>
 Jan Glauber <jan.glauber@gmail.com> <jang@linux.vnet.ibm.com>
 Jan Glauber <jan.glauber@gmail.com> <jglauber@cavium.com>
 Jarkko Sakkinen <jarkko@kernel.org> <jarkko.sakkinen@linux.intel.com>
+Jarkko Sakkinen <jarkko@kernel.org> <jarkko@profian.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgg@mellanox.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgg@nvidia.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgunthorpe@obsidianresearch.com>
-- 
2.36.1

