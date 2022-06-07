Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267DFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 16:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345157AbiFGQnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 12:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345153AbiFGQnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:43:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62714C0387
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 09:43:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7D526184D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 16:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCC4C34114;
        Tue,  7 Jun 2022 16:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654620223;
        bh=AWJP2oAGEitQC69PvwECJKzR+6cnXlUREglZ4Qx8Ifg=;
        h=From:To:Cc:Subject:Date:From;
        b=d1RwynjVuONbEEHTvojFe2kyP9je5FI+nnjFyo5zCiGwz3za79i2BBrEBBUz08FCP
         +e6A9SP5Mho27xeFNs2/ae1KFA6+nCuOzAH1VtMubzhyx+leJmjfsUz3VKm6aoGIRQ
         f/APfmHD64CkbTOcGfCWBkqS+pyRBUSlXJh9IwCuelUl4BIXKvy6BSnTzTE8gzAdra
         H3kfimzO2BPqUvkhxp4K6q59s3yDPoY+45be/GFu+5Sfdw+O+2ldLbc/aUKSha1c4f
         Nd4Eq3Sjvkbiq3OIxXBC3havGt6+vTPO1PaoMIOtlnXYseG2Tr880IlOGcn6gJ5z75
         GQzCBFHt9tiPw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-kernel@vger.kenrel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Anup Patel <anup@brainfault.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Christian Brauner <brauner@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mailmap: add alias for jarkko@profian.com
Date:   Tue,  7 Jun 2022 19:41:39 +0300
Message-Id: <20220607164140.1230876-1-jarkko@kernel.org>
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

