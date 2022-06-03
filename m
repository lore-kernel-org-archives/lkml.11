Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8BEC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jun 2022 18:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348481AbiFCSQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346752AbiFCSFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 14:05:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFB4220EB;
        Fri,  3 Jun 2022 10:58:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C19CB82419;
        Fri,  3 Jun 2022 17:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F5AC385A9;
        Fri,  3 Jun 2022 17:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654279042;
        bh=MYuJiGbzxHLG00EokNeFrogd4ykMEO+gtN0yNPcLYSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yrio+d8uWyhJGjb2gWLmScok5oQ1Ss7SEc5//lbdQWjHBPH/aRTc/iT+mIMHbeVLe
         kkzW826TV0P1JIp92rjBaV2YxY6G9zEEfACO0jMBeytyrg/osVgzUrfFLM/KmaGUbg
         bAAAegVkbMO7wHnQSBM2MPXN63d4LebO6ALElTDU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 5.18 33/67] tools/memory-model/README: Update klitmus7 compat table
Date:   Fri,  3 Jun 2022 19:43:34 +0200
Message-Id: <20220603173821.674327165@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603173820.731531504@linuxfoundation.org>
References: <20220603173820.731531504@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akira Yokosawa <akiyks@gmail.com>

commit 5b759db44195bb779828a188bad6b745c18dcd55 upstream.

EXPORT_SYMBOL of do_exec() was removed in v5.17.  Unfortunately,
kernel modules from klitmus7 7.56 have do_exec() at the end of
each kthread.

herdtools7 7.56.1 has addressed the issue.

Update the compatibility table accordingly.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: stable@vger.kernel.org # v5.17+
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/memory-model/README |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -54,7 +54,8 @@ klitmus7 Compatibility Table
 	     -- 4.14  7.48 --
 	4.15 -- 4.19  7.49 --
 	4.20 -- 5.5   7.54 --
-	5.6  --       7.56 --
+	5.6  -- 5.16  7.56 --
+	5.17 --       7.56.1 --
 	============  ==========
 
 


