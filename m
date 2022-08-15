Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7988DC00140
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 22:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351562AbiHOWpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 18:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348549AbiHOWkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 18:40:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49166B7EC;
        Mon, 15 Aug 2022 12:51:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0BA7B80EAB;
        Mon, 15 Aug 2022 19:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C385C433C1;
        Mon, 15 Aug 2022 19:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660593116;
        bh=I97Qp1dWAVy3IsQkQEdYvQBwCJj951psvxNp2YnwJ5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f3wVAvQfAZ+8D1hwGlb6myJtiPKeCxvOIP60aULSQv+eybB8MLKwCS2eGVJRLDaFg
         onC3DUMIiq3RfbcjI/GriHsfqD8slngI2HXTOKEYIbFs6Zi1Ly/gd4XoWGrHUqwTup
         TmCovyWMoeZw+wYJArBUC0MJ8oMrDnQLot5k3V+8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 0898/1095] s390/crash: fix incorrect number of bytes to copy to user space
Date:   Mon, 15 Aug 2022 20:04:57 +0200
Message-Id: <20220815180506.451392972@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180429.240518113@linuxfoundation.org>
References: <20220815180429.240518113@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Gordeev <agordeev@linux.ibm.com>

[ Upstream commit f6749da17a34eb08c9665f072ce7c812ff68aad2 ]

The number of bytes in a chunk is correctly calculated, but instead
the total number of bytes is passed to copy_to_user_real() function.

Reported-by: Matthew Wilcox <willy@infradead.org>
Fixes: df9694c7975f ("s390/dump: streamline oldmem copy functions")
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/crash_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index 28124d0fa1d5..f8ebdd70dd31 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -199,7 +199,7 @@ static int copy_oldmem_user(void __user *dst, unsigned long src, size_t count)
 			} else {
 				len = count;
 			}
-			rc = copy_to_user_real(dst, src, count);
+			rc = copy_to_user_real(dst, src, len);
 			if (rc)
 				return rc;
 		}
-- 
2.35.1



