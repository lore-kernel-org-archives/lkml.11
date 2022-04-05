Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93A3C41535
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 08:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241927AbiDEIgG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 04:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiDEH56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:57:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1BE96826;
        Tue,  5 Apr 2022 00:51:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A83BB81BB0;
        Tue,  5 Apr 2022 07:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BCDC36AE3;
        Tue,  5 Apr 2022 07:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649145099;
        bh=9w+H9RvQiAqbnv0t89CVqseGyEem3RzhqIHtFB3UxKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OCuENez1Wj5ERpItfjD93VI+jyDjlJ0/J9QOOPbPbmOsPmlhLUkAGhZgzX0XW+rfw
         +MgNg703yTyScFFKqAOlMNImjsP4jWwHsShHK5KWi1ROQJn7qQwozuG9xzwMWOlwEp
         HVZBM/IHaB0fdpqYrQ1aKkca4gN7IJTd1+0J01T8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sasha Levin <sashal@kernel.org>,
        Mike Marshall <hubcap@omnibond.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH 5.17 0284/1126] iomap: Fix iomap_invalidatepage tracepoint
Date:   Tue,  5 Apr 2022 09:17:11 +0200
Message-Id: <20220405070415.949224018@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox (Oracle) <willy@infradead.org>

[ Upstream commit 1241ebeca3f94b417751cb3ff62454cefdac75bc ]

This tracepoint is defined to take an offset in the file, not an
offset in the folio.

Fixes: 1ac994525b9d ("iomap: Remove pgoff from tracepoints")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Tested-by: Mike Marshall <hubcap@omnibond.com> # orangefs
Tested-by: David Howells <dhowells@redhat.com> # afs
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/buffered-io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6c51a75d0be6..d020a2e81a24 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -480,7 +480,8 @@ EXPORT_SYMBOL_GPL(iomap_releasepage);
 
 void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
 {
-	trace_iomap_invalidatepage(folio->mapping->host, offset, len);
+	trace_iomap_invalidatepage(folio->mapping->host,
+					folio_pos(folio) + offset, len);
 
 	/*
 	 * If we're invalidating the entire folio, clear the dirty state
-- 
2.34.1



