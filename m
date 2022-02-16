Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C4DC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 16:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbiBPQQp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 11:16:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbiBPQQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:16:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B23369CD0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:16:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 406B9B81F72
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 16:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822A8C004E1;
        Wed, 16 Feb 2022 16:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645028187;
        bh=M6i8Ax/c1AB4NHK/oFnPHSNbHeHzsRhTsad/UfRd5wE=;
        h=From:To:Cc:Subject:Date:From;
        b=XM91TmNNTrga/47sbWNW9dE6N3F5SLzSf+TjLmusuEvmEPfWBDN2MSrpsupJ753Ys
         rRd6cRHdyyuql9cjHy5VgZQ9EEilEckGoR/HQ0q1MPjlQsRhh5TKTV2KV1GmAhs+lG
         FlcS8LgFntV4qNBG/Ah2zoalBgkNvkZebXOvmL1Nn/J/EGgisLTs1I2iz0/I+5G5JF
         L11ud3lCjZvwxBio7E392pfRfp9mf5gIXNFNIMKxJhp1TKN4mw+vMjU4jxFl4iqXsm
         RJIoa9jY2FQgZEECwkuCjTbFpp87ZQ7gyvAj3xiD4UsjcNN670c4OyLmbFxJg2yM8h
         /ssGmmFxARSIA==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org
Subject: [PATCH] MAINTAINERS: add a git repo for the Stratix10 Service driver
Date:   Wed, 16 Feb 2022 10:16:20 -0600
Message-Id: <20220216161620.222217-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a git repo entry for the Stratix10 Service driver.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c914384..5752236bea80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9890,6 +9890,7 @@ F:	drivers/firmware/stratix10-rsu.c
 F:	drivers/firmware/stratix10-svc.c
 F:	include/linux/firmware/intel/stratix10-smc.h
 F:	include/linux/firmware/intel/stratix10-svc-client.h
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git
 
 INTEL TELEMETRY DRIVER
 M:	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
-- 
2.25.1

