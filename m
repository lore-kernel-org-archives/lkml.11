Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8287FC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 11:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239747AbiCNLzZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 07:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239695AbiCNLzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:55:14 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8D065BD;
        Mon, 14 Mar 2022 04:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pC+jZYa0N/coy9ndTADCmLZOR5Knf8xSuYTEETm4CuE=;
  b=Xyk8/eKcmpaK4I1WGhzwBy58EONTsXyBXaBvBS/WuPuobHQ8PhsRGe3L
   dWlTg5kPUOeJ2V7TFhpb0eofnEXd9OV4gPpunnMj+XdFl1Qa8JHtVOxp1
   lGyOxCRxngklR4Kax7j7dtbhO9DQWal0N4+k1gQcLCTXz+X2zfkqejfqa
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,180,1643670000"; 
   d="scan'208";a="25997336"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 12:53:59 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/30] kernfs: fix typos in comments
Date:   Mon, 14 Mar 2022 12:53:28 +0100
Message-Id: <20220314115354.144023-5-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220314115354.144023-1-Julia.Lawall@inria.fr>
References: <20220314115354.144023-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 fs/kernfs/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 7aefaca876a0..88423069407c 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -997,7 +997,7 @@ struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
 #endif
 
 	/*
-	 * kn->attr.ops is accesible only while holding active ref.  We
+	 * kn->attr.ops is accessible only while holding active ref.  We
 	 * need to know whether some ops are implemented outside active
 	 * ref.  Cache their existence in flags.
 	 */

