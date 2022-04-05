Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F88C4332F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 20:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392057AbiDEUGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 16:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345131AbiDEKkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:40:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80032DD64;
        Tue,  5 Apr 2022 03:26:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84F9E6141D;
        Tue,  5 Apr 2022 10:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96867C385A1;
        Tue,  5 Apr 2022 10:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649154361;
        bh=8pB0J7RuG+0VRdERB0M6sy0avVjZh9WeAccoMSSevQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xbYtaQyVEhGFO1nJZn81yrIAETQyR9tO+NxDP6tQQRFtWFTPKyq+/Yei62TFQxYdv
         r1aGpHWnR1ket4t0SwGYGe2atac4DQoEA7EQH2aEO1NfDPqnvAlWxRZpkvox8Dp//F
         KTohWCEX2T+dE0cLQ/jgN4byjDK8kVzkM+WrPX1U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 5.10 552/599] XArray: Update the LRU list in xas_split()
Date:   Tue,  5 Apr 2022 09:34:06 +0200
Message-Id: <20220405070315.267256065@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070258.802373272@linuxfoundation.org>
References: <20220405070258.802373272@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox (Oracle) <willy@infradead.org>

commit 3ed4bb77156da0bc732847c8c9df92454c1fbeea upstream.

When splitting a value entry, we may need to add the new nodes to the LRU
list and remove the parent node from the LRU list.  The WARN_ON checks
in shadow_lru_isolate() catch this oversight.  This bug was latent
until we stopped splitting folios in shrink_page_list() with commit
820c4e2e6f51 ("mm/vmscan: Free non-shmem folios without splitting them").
That allows the creation of large shadow entries, and subsequently when
trying to page in a small page, we will split the large shadow entry
in __filemap_add_folio().

Fixes: 8fc75643c5e1 ("XArray: add xas_split")
Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/xarray.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1080,6 +1080,7 @@ void xas_split(struct xa_state *xas, voi
 					xa_mk_node(child));
 			if (xa_is_value(curr))
 				values--;
+			xas_update(xas, child);
 		} else {
 			unsigned int canon = offset - xas->xa_sibs;
 
@@ -1094,6 +1095,7 @@ void xas_split(struct xa_state *xas, voi
 	} while (offset-- > xas->xa_offset);
 
 	node->nr_values += values;
+	xas_update(xas, node);
 }
 EXPORT_SYMBOL_GPL(xas_split);
 #endif


