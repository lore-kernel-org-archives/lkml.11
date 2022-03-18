Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E582EC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 10:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbiCRKlJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 06:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbiCRKjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:39:10 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B44A2DB5A1;
        Fri, 18 Mar 2022 03:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zYztUCoDTUf1uYl/OfQSsbxJXkml9Y3jqTqGluxkWe0=;
  b=Y603x6QoNQMT7krPlYko8Y/lAkPNMWlOimMGksfKNmb/+7ZrTYO2CDkn
   bN2+fa8dNJTJsNvnC73v9JQSSf7s9PkVy4OtW0WUSNynUCji1++NUko1F
   WWb/nrcHyXqgHB4vTzOGFt7nhZH+0wneioOxTNx02sWSerK60ajREW1Ss
   8=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="8935659"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:37:38 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ia64: ptrace: fix typos in comments
Date:   Fri, 18 Mar 2022 11:37:18 +0100
Message-Id: <20220318103729.157574-23-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/ia64/kernel/ptrace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
index 6a1439eaa050..32f544baf7ae 100644
--- a/arch/ia64/kernel/ptrace.c
+++ b/arch/ia64/kernel/ptrace.c
@@ -2025,7 +2025,7 @@ static void syscall_get_args_cb(struct unw_frame_info *info, void *data)
 	 * - epsinstruction: cfm is set by br.call
 	 *   locals don't exist.
 	 *
-	 * For both cases argguments are reachable in cfm.sof - cfm.sol.
+	 * For both cases arguments are reachable in cfm.sof - cfm.sol.
 	 * CFM: [ ... | sor: 17..14 | sol : 13..7 | sof : 6..0 ]
 	 */
 	cfm = pt->cr_ifs;

